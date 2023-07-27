data "aws_iam_policy_document" "this" {
  statement {
    sid                     = "EnableCloudfrontAccess"
    effect                  = "Allow"
    actions                 = [
        "s3:GetObject"
    ]
    resources               = [ 
        local.bucket_configuration.arn,
        "${local.local.bucket_configuration.arn}/*"
    ]

    principals {
      type                  =  "CanonicalUser"
      identifiers           = [
        aws_cloudfront_origin_access_identity.this.s3_canonical_user_id
      ]
    }
  }
}