resource "aws_cloudfront_origin_access_identity" "this" {
    comment                             = "${title(var.distribution.name)} Cloudfront Origin Access Identity"
}

resource "aws_cloudfront_distribution" "this" {
    #checkov:skip=CKV2_AWS_47: "Ensure AWS CloudFront attached WAFv2 WebACL is configured with AMR for Log4j Vulnerability"
    #checkov:skip=CKV_AWS_68: "CloudFront Distribution should have WAF enabled"
        # NOTE: WAFs are expensive. If I ever start making money doing this, I will fix this.
    #checkov:skip=CKV_AWS_310: "Ensure CloudFront distributions should have origin failover configured"
        # TODO: use a replica for origin failover

    aliases                             = [ var.domain ]
    default_root_object                 = var.distribution.default_root_object
    enabled                             = true
    http_version                        = var.distribution.http_version
    is_ipv6_enabled                     = true
    price_class                         = var.distribution.price_class

    origin {
        domain_name                     = local.origin_configuration.bucket_regional_domain_name
        origin_id                       = local.origin_id

        s3_origin_config {
            origin_access_identity      = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
        }
    }

    logging_config {
        include_cookies                 = false
        bucket                          = local.logs_configuration.id
        prefix                          = var.distribution.logs_prefix
    }

    default_cache_behavior {
        allowed_methods                 = var.distribution.allowed_methods
        cached_methods                  = var.distribution.cached_methods
        cache_policy_id                 = data.aws_cloudfront_cache_policy.this.id
        response_headers_policy_id      = data.aws_cloudfront_response_headers_policy.this.id
        target_origin_id                = local.origin_id
        viewer_protocol_policy          = var.distribution.viewer_protocol_policy
        min_ttl                         = 0
        default_ttl                     = 3600
        max_ttl                         = 86400
    }

    viewer_certificate {
        acm_certificate_arn             = data.aws_acm_certificate.domain.arn
        cloudfront_default_certificate  = false
        minimum_protocol_version        = var.distribution.ssl_protocol_version
        ssl_support_method              = "sni-only"
    }
}