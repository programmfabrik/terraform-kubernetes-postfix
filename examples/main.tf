module "postfix" {
  source = "../"

  name             = "pfx-1"
  namespace        = "postfix"
  create_namespace = true
  wait_for_rollout = true
  replicas         = 1
  image_repository = "docker.fylr.io/services/postfix"
  image_version    = "v1.0.0"
  resources = {
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
  postfix_relayhost                    = "smtp.gmail.com:587"
  postfix_myhostname                   = "mail"
  postfix_mynetworks                   = "127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
  postfix_smtputf8_enable              = "on"
  postfix_smtp_sasl_auth_enable        = "yes"
  postfix_smtp_sasl_password_maps      = "hash:/etc/postfix/sasl_passwd"
  postfix_smtp_sasl_security_options   = ""
  postfix_smtp_tls_security_level      = "encrypt"
  postfix_mydestination                = ""
  postfix_message_size_limit           = "10485760"
  postfix_smtpd_delay_reject           = "yes"
  postfix_smtpd_helo_required          = "yes"
  postfix_smtpd_helo_restrictions      = "permit_mynetworks,reject_invalid_helo_hostname,permit"
  postfix_relay_domains                = ""
  postfix_smtpd_recipient_restrictions = "reject_non_fqdn_recipient,reject_unknown_recipient_domain,reject_unverified_recipient"
  postfix_inet_interfaces              = "all"
  mail_smtp_host                       = "smtp.gmail.com"
  mail_smtp_port                       = 587
  mail_email                           = "emailer@programmfabrik.de"
  mail_password                        = "example-password"
}
