Site content for alpha.beta5.org/blalor.github.io

## post-by-email photo flow

1. user sends email to `<account>+<hmac>@<host>`
2. procmail pipes message to [post-by-email](https://github.com/blalor/post-by-email/)
3. post-by-email uploads images to S3
3. post-by-email generates post with [Thumbor](http://thumbor.org/) paths
4. post-by-email commits post
5. post-receive hook on this repository triggers site build

## image rendering flow

Uses my [docker-thumbor](https://github.com/blalor/docker-thumbor/) image.

* `{{ site.static_images_base_url }}/path/to/image` is requested
* if found in S3, image returned
* if not found in S3, redirected to `<thumbor server>/path/to/imagae`
* thumbor generates new image, stores in S3 at original path
* subsequent requests for `{{ site.static_images_base_url }}/path/to/image` served directly from S3
