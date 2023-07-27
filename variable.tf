variable "distribution" {
    description             = <<EOT
    Cloudfront Distribution configuration object. 
    
    S3 bucket: If no S3 bucket is specified for the distribution origin, one will be provisioned. If using a pre-existing bucket, the bucket output from the S3 module should be passed in under the `bucket` object. If a pre-existing bucket is passed in, the bucket policy must allow the CloudFront service principal/canonical user access to the S3 bucket contents. 

    KMS key: If no KMS key is specified for the encryption of resources, one will be provisioned. If using a pre-existing bucket, the key output from the KMS module should be passed in under the `key` object.
    EOT

    type                    = object({
        bucket              = optional(object, null)
        key                 = optional(object, null)
    })
}

variable "domain" {
    description             = "Fully qualified domain name."
    type                    = string
}