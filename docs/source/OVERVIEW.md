# Terraform Modules: Cloudfront Distribution

A Terraform module for provisioning an [AWS Cloudfront Distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html).


## Cache Policy

By default, the distribution will use a [managed cached policy](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html) of "Managed-CachingOptimized". A different policy may be specified by passing in the name of the block. The module will use a [cloudfront_cache_policy data block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy) to retrieve the ARN of the policy. **Note**: if you are not using a managed policy, the policy must exist in the AWS account before calling this module.

## Conditional Resources

### Origin Bucket

If no S3 bucket is specified for the distribution origin, one will be provisioned. If using a pre-existing bucket, the bucket output from the S3 module should be passed in under the `origin_bucket` object. If a pre-existing bucket is passed in, the bucket policy must allow the CloudFront service principal/canonical user access to the S3 bucket contents. 


### Logs Bucket

If no S3 bucket is specified for the distribution logs, one will be provisioned. If using a pre-existing bucket, the bucket output from the S3 module should be passed in under the `logs_bucket` object. If a pre-existing bucket is passed in, the bucket policy must allow the CloudFront service principal/canonical user access to the S3 bucket contents. 

### KMS Key

If no KMS key is specified for the encryption of resources, one will be provisioned. If using a pre-existing key, the key output from the KMS module should be passed in under the `key` object.