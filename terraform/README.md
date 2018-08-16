## cloudfront/s3 config choices

When using Cloudfront with the native S3 bucket origin config, the bucket's website configuration is not used.  No redirect rules are honored, default `/` → `/index.html` for sub-directories doesn't work, etc.  As a workaround, I've configured the Jekyll navigation to explicitly call out `/index.html` on all sub-directories.

It may be possible to set up a bucket policy that only allows cloudfront IPs to access the data. Combined with a sufficiently obscure bucket name, this might provide adequate security.
