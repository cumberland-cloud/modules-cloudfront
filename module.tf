module "origin" {
    count           = local.conditions.provision_origin_bucket ? 1 : 0
    source          = "https://github.com/cumberland-cloud/modules-s3.git?ref=9a2c821"

    bucket          = {
        name        = "${var.distribution.name}-dist"
        policy      = data.aws_iam_policy_document.this.json
        key         = local.encryption_configuration.arn
    }
}

module "logs" {
    count           = local.conditions.provision_logs_bucket ? 1 :0
    source          = "https://github.com/cumberland-cloud/modules-s3.git?ref=9a2c821"

    bucket          = {
        acl         = "log-delivery-write"
        name        = "${var.distribution.name}-logs"
        policy      = data.aws_iam_policy_document.json
        key         = local.encryption_configuration.arn
    }
}

module "kms" {
    count           = local.conditions.provision_key ? 1 : 0
    source          = "https://github.com/cumberland-cloud/modules-kms.git?ref=8842d57"

    key             = {
        alias       = "${var.distribution.name}-cloudfront"
    }
}