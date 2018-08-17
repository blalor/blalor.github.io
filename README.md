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

## cloudfront/s3 config choices

When using Cloudfront with the native S3 bucket origin config, the bucket's website configuration is not used.  No redirect rules are honored, default `/` → `/index.html` for sub-directories doesn't work, etc.  Instead I've set up a policy to only allow cloudfront IPs (but _any_ cloudfront distribution) to access the bucket.

## building

1. `gem install bundler`
2. `bundle install`
3. `bundle exec jekyll build`
