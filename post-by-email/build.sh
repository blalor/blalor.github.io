#!/bin/bash
set -e -u -o pipefail

basedir="$( cd "$( dirname "${0}" )" && pwd )"

dist_dir="${basedir}/dist"
mkdir "${dist_dir}"

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

"${pip_install[@]}" -r "${basedir}/requirements.txt"

deactivate

pushd "${target_dir}"
zip -qr9 "${dist_dir}/post-by-email.zip" .
