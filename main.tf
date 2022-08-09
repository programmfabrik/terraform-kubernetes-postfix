locals {
  labels = {
    "app.kubernetes.io/name" : "${var.name}",
    "app.kubernetes.io/instance" : "${var.name}",
    "app.kubernetes.io/version" : "${var.image_version}",
    "app.kubernetes.io/component" : "mail",
  }
}

resource "kubernetes_namespace" "postfix" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "sasl-config" {
  metadata {
    name      = "postgres-${var.name}-sasl-config"
    namespace = var.namespace
  }

  data = {
    sasl_passwd = templatefile("${path.module}/config/sasl_passwd", {
      smtp_host = var.mail_smtp_host,
      smtp_port = var.mail_smtp_port,
      mail      = var.mail_email,
      password  = var.mail_password,
    })
  }

  type = "Opaque"
}

# postfix deployment
resource "kubernetes_deployment" "postfix" {
  wait_for_rollout = var.wait_for_rollout

  metadata {
    name      = "postfix-${var.postfix}"
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = var.labels
    }

    template {
      metadata {
        labels = var.labels
      }

      spec {
        container {
          image = "${var.image_repository}:${var.image_version}"
          name  = "postfix-${var.name}"

          resources {
            limits = {
              cpu    = var.resources.limits.cpu
              memory = var.resources.limits.memory
            }
            requests = {
              cpu    = var.resources.requests.cpu
              memory = var.resources.requests.memory
            }
          }

          volume_mount {
            name       = "sasl-config"
            read_only  = false
            mount_path = "/postfix/sasl/"
          }

          # must be hardcoded
          # otherwise we don't see any logs on the console
          env {
            name  = "POSTFIX_CFG_maillog_file"
            value = "/dev/stdout"
          }
          env {
            name  = "POSTFIX_CFG_relayhost"
            value = var.postfix_relayhost
          }
          env {
            name  = "POSTFIX_CFG_myhostname"
            value = var.postfix_myhostname
          }
          env {
            name  = "POSTFIX_CFG_mynetworks"
            value = var.postfix_mynetworks
          }
          env {
            name  = "POSTFIX_CFG_smtputf8_enable"
            value = var.postfix_smtputf8_enable
          }
          env {
            name  = "POSTFIX_CFG_smtp_sasl_auth_enable"
            value = var.postfix_smtp_sasl_auth_enable
          }
          env {
            name  = "POSTFIX_CFG_smtp_sasl_password_maps"
            value = var.postfix_smtp_sasl_password_maps
          }
          env {
            name  = "POSTFIX_CFG_smtp_sasl_security_options"
            value = var.postfix_smtp_sasl_security_options
          }
          env {
            name  = "POSTFIX_CFG_smtp_tls_security_level"
            value = var.postfix_smtp_tls_security_level
          }
          env {
            name  = "POSTFIX_CFG_mydestination"
            value = var.postfix_mydestination
          }
          env {
            name  = "POSTFIX_CFG_message_size_limit"
            value = var.postfix_message_size_limit
          }
          env {
            name  = "POSTFIX_CFG_smtpd_delay_reject"
            value = var.postfix_smtpd_delay_reject
          }
          env {
            name  = "POSTFIX_CFG_smtpd_helo_required"
            value = var.postfix_smtpd_helo_required
          }
          env {
            name  = "POSTFIX_CFG_smtpd_helo_restrictions"
            value = var.postfix_smtpd_helo_restrictions
          }
          env {
            name  = "POSTFIX_CFG_relay_domains"
            value = var.postfix_relay_domains
          }
          env {
            name  = "POSTFIX_CFG_smtpd_recipient_restrictions"
            value = var.postfix_smtpd_recipient_restrictions
          }
          env {
            name  = "POSTFIX_CFG_inet_interfaces"
            value = var.postfix_inet_interfaces
          }
        }

        volume {
          name = "sasl-config"
          secret {
            secret_name = kubernetes_secret.sasl-config.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postfix-service" {
  metadata {
    name      = "postfix-${var.postfix}"
    namespace = var.namespace
  }
  spec {
    selector = var.labels

    port {
      port        = 25
      target_port = 25
    }

    type = "ClusterIP"
  }
}
