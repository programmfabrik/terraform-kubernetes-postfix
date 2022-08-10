variable "name" {
  type        = string
  description = "The name of the Postfix service"
  default     = "postfix"
}

variable "namespace" {
  type        = string
  description = "The namespace to deploy the postfix service in"
  default     = "postfix"
}

variable "create_namespace" {
  type        = bool
  description = "Whether to create the namespace"
  default     = true
}

# postfix deployment settings

variable "wait_for_rollout" {
  description = "Defines whether we should wait for the deployment to complete."
  type        = bool
  default     = false
  sensitive   = false
}

variable "replicas" {
  description = "Defines the number of replicas."
  type        = number
  default     = 1
  sensitive   = false
}

variable "image_repository" {
  type        = string
  description = "The image repository to use"
  default     = "docker.fylr.io/services/postfix"
}

variable "image_version" {
  description = "Defines the image version to use."
  type        = string
  default     = "v1.0.0"
  sensitive   = false
}

variable "image_pull_policy" {
  type        = string
  description = "Defines the image pull policy to use."
  default     = "IfNotPresent"
  validation {
    condition     = var.image_pull_policy == "Always" || var.image_pull_policy == "IfNotPresent" || var.image_pull_policy == "Never"
    error_message = "Invalid image pull policy. Valid values are `Always`, `IfNotPresent` and `Never`."
  }
}

variable "resources" {
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  description = "Defines the resources to use."
  default = {
    limits = {
      cpu    = "0.5"
      memory = "512Mi"
    }
    requests = {
      cpu    = "0.5"
      memory = "512Mi"
    }
  }
}

# postfix settings

variable "postfix_relayhost" {
  type      = string
  default   = ""
  sensitive = false
}

variable "postfix_myhostname" {
  type      = string
  default   = "mail"
  sensitive = false
}

variable "postfix_mynetworks" {
  type      = string
  default   = "127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
  sensitive = false
}

variable "postfix_smtputf8_enable" {
  type        = string
  default     = "no"
  description = "Can be 'yes' or 'no'."
  sensitive   = false
}

variable "postfix_smtp_sasl_auth_enable" {
  type      = string
  default   = "yes"
  sensitive = false
}

variable "postfix_smtp_sasl_password_maps" {
  type      = string
  default   = "texthash:/etc/postfix/sasl_passwd"
  sensitive = false
}

variable "postfix_smtp_sasl_security_options" {
  type      = string
  default   = ""
  sensitive = false
}

variable "postfix_smtp_tls_security_level" {
  type      = string
  default   = "encrypt"
  sensitive = false
}

variable "postfix_mydestination" {
  type      = string
  default   = ""
  sensitive = false
}

variable "postfix_message_size_limit" {
  type      = string
  default   = "10240000"
  sensitive = false
}

variable "postfix_smtpd_delay_reject" {
  type      = string
  default   = "yes"
  sensitive = false
}

variable "postfix_smtpd_helo_required" {
  type      = string
  default   = "yes"
  sensitive = false
}

variable "postfix_smtpd_helo_restrictions" {
  type      = string
  default   = "permit_mynetworks,reject_invalid_helo_hostname,permit"
  sensitive = false
}

variable "postfix_relay_domains" {
  type      = string
  default   = ""
  sensitive = false
}

variable "postfix_smtpd_recipient_restrictions" {
  type      = string
  default   = "reject_non_fqdn_recipient,reject_unknown_recipient_domain,reject_unverified_recipient"
  sensitive = false
}

variable "postfix_inet_interfaces" {
  type      = string
  default   = "all"
  sensitive = false
}

variable "mail_smtp_host" {
  type      = string
  sensitive = false
}

variable "mail_smtp_port" {
  type      = number
  default   = 587
  sensitive = false
}

variable "mail_email" {
  type      = string
  sensitive = false
}

variable "mail_password" {
  type      = string
  sensitive = false
}
