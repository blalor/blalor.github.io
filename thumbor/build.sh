#!/bin/bash
set -e -u -o pipefail

basedir="$( cd "$( dirname "${0}" )" && pwd )"

dist_dir="${basedir}/dist"
mkdir "${dist_dir}"

upstream_dir=$( mktemp -d )
source_dir=${upstream_dir}/source

curl -sfSL 'https://github.com/awslabs/serverless-image-handler/archive/6a30bd785999bea6ba9dfb402bf550b2dd8f2f8f.tar.gz' | \
    tar -xz --strip-components=1 -C "${upstream_dir}"

export VIRTUAL_ENV_DISABLE_PROMPT=true

venv=$( mktemp -d )
virtualenv "${venv}"

# shellcheck disable=SC1090
. "${venv}/bin/activate"
target_dir=$( python -c 'import sys; print(sys.path[-1])' ) # -> ${VIRTUAL_ENV}/lib/python2.7/site-packages

pip_install=(
    pip
    --disable-pip-version-check
    # --quiet
    install
)

## packages that use `from pip.req import …` fail with pip > 9
"${pip_install[@]}" --upgrade 'pip >=9,<10'

"${pip_install[@]}" "${source_dir}/image-handler"
"${pip_install[@]}" -r "${source_dir}/image-handler/requirements.txt"

## replace thumbor config with our own
cp -f "${basedir}/thumbor.conf" "${target_dir}/image_handler/thumbor.conf"

deactivate

pushd "${target_dir}"
zip -qr9 "${dist_dir}/image-handler.zip" .
