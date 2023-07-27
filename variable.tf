variable "distribution" {
    description             = <<EOT
    Cloudfront Distribution configuration object. 
    
    Origin bucket: If no S3 bucket is specified for the distribution origin, one will be provisioned. If using a pre-existing bucket, the bucket output from the S3 module should be passed in under the `origin_bucket` object. If a pre-existing bucket is passed in, the bucket policy must allow the CloudFront service principal/canonical user access to the S3 bucket contents. 

    Logs bucket: If no S3 bucket is specified for the distribution logs, one will be provisioned. If using a pre-existing bucket, the bucket output from the S3 module should be passed in under the `logs_bucket` object. If a pre-existing bucket is passed in, the bucket policy must allow the CloudFront service principal/canonical user access to the S3 bucket contents. 

    Cache policy: Name of the cache policy to retrieve with `aws_cloudfront_cache_policy` data block. Defaults to a managed policy. If not using a managed policy, the cache policy must exist in the account before deploying this module.

    KMS key: If no KMS key is specified for the encryption of resources, one will be provisioned. If using a pre-existing bucket, the key output from the KMS module should be passed in under the `key` object.
    EOT

    type                        = object({
        name                    = string
        allowed_methods         = optional(list(string), [ 
                                    "GET", 
                                    "HEAD", 
                                    "OPTIONS"
                                ])
        cached_methods          = optional(list(string), [
                                    "GET",
                                    "HEAD"
                                ])
        cache_policy            = optional(string, "Managed-CachingOptimized")

        default_root_object     = optional(string, "index.html")
        http_version            = optional(string, "http2")
        key                     = optional(object, null)
        logs_bucket             = optional(object, null)
        logs_prefix             = optional(string, "dist")
        origin_bucket           = optional(object, null)
        price_class             = optional(string, "PriceClass_100")
        viewer_protocol_policy  = optional(string, "redirect-to-https")
    })
}

variable "domain" {
    description             = "Fully qualified domain name."
    type                    = string
    default                 = "cumberland-cloud.com"   
}

variable "wildcard_cert" {
    description             = "Flag to signal the data query to retrieve ACM SSL certificate should contain a wildcard for the subdomain"
    type                    = bool
    default                 = true       
}