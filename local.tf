locals {
    # Constants
    origin_id                       = "${var.distribution.name}-${local.bucket_configuration.id}-origin"
    # Calculations
    certificate_domain              = var.wildcard_cert ? "*.${local.domain}" : local.domain
    conditions                      = {
        provision_key               = var.distribution.kms_key_arn == null
        provision_logs_bucket       = var.distribution.logs_bucket == null
        provision_origin_bucket     = var.distribution.origin_bucket == null
    }
    # Configurations
    encryption_configuration        = local.conditions.provision_key ? (
                                        module.kms[0].key 
                                    ) : (
                                        var.repository.key
                                    )
    logs_configuration              = local.conditions.provision_logs_bucket ? (
                                        module.logs[0].bucket[0]
                                    ) : (
                                        var.distribution.logs_bucket
                                    )
    origin_configuration            = local.conditions.provision_origin_bucket ? (
                                        module.origin[0].bucket[0]
                                    ) : (
                                        var.distribution.origin_bucket
                                    )
}