# Terraform Modules: Cloudfront Distribution

A Terraform module for provisioning an [AWS Cloudfront Distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html).

## Example Usage

```tcl
module "distribution" {
    source                              = "git::https://github.com/cumberland-cloud/modules-cloudfront.git"

    distribution                        = {
        name                            = "my-distribution"
        origin_bucket                   = {
            arn                         = "arn:aws:s3:::my-distribution-bucket"
            bucket_regional_domain_name = "blahblah.com"
        }
    }
    domain                              = "cumberland-cloud.com"
    wildcard_cert                       = true
}

```

## Cache Policy

By default, the distribution will use a [managed cached policy](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) of "Managed-CachingOptimized". A different policy may be specified by passing in the name of the policy. The module will use a [aws_cloudfront_cache_policy data block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy) to retrieve the ARN of the policy. **Note**: if you are not using a managed policy, the policy must exist in the AWS account you are deploying into before calling this module.

## Response Headers Policy

By default, the distribution will use a [managed response headers policy](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-response-headers-policies.html) of "SecurityHeadersPolicy". A different policy may be specified by passing in the name of the policy. The module will use a [aws_cloudfront_response_headers_policy data block])(https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_response_headers_policy) to retrieve the ARN of the policy. **Note**: if you are not using a managed policy, the policy msut exist in the AWS account you are deploying into before calling this module.

## Certificate

TODO

## Conditional Resources

Some of the resources in the module are not provisioned by default. Certain conditions must be met before these resources are provisioned.

### Origin Bucket

If no S3 bucket is specified for the distribution origin, one will be provisioned. If using a pre-existing bucket, the bucket output from the [S3 module](https://github.com/cumberland-cloud/modules-s3.git) should be passed in under the `origin_bucket` object. If a pre-existing bucket is passed in, the bucket policy must allow the CloudFront service principal/canonical user access to the S3 bucket contents. 


### Logs Bucket

If no S3 bucket is specified for the distribution logs, one will be provisioned. If using a pre-existing bucket, the bucket output from the [S3 module](https://github.com/cumberland-cloud/modules-s3.git)should be passed in under the `logs_bucket` object. If a pre-existing bucket is passed in, the bucket policy must allow the CloudFront service principal/canonical user access to the S3 bucket contents. 

### KMS Key

If no KMS key is specified for the encryption of resources, one will be provisioned. If using a pre-existing key, the key output from the [KMS module](https://github.com/cumberland-cloud/modules-kms.git) should be passed in under the `key` object.

<!-- BEGIN_TF_DOCS -->
Terraform Docs Placeholder
<!-- END_TF_DOCS -->  