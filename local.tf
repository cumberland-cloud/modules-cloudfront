locals {
    # Calculations
    conditions                      = {
        provision_bucket            = var.distribution.bucket == null 
        provision_key               = var.distribution.kms_key_arn == null
    }
    # Configurations
    bucket_configuration            = local.conditions.provision_bucket ? (
                                        module.s3[0].bucket
                                    ) : (
                                        var.distribution.bucket
                                    )
    encryption_configuration        = local.conditions.provision_key ? (
                                        module.kms[0].key 
                                    ) : (
                                        var.repository.key
                                    )
}