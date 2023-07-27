variable "distribution" {
    description             = "Cloudfront configuration object."
    type                    = object({
    })
}

variable "domain" {
    description             = "Fully qualified domain name."
    type                    = string
}