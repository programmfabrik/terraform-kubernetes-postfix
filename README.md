# terraform-kubernetes-postfix

A terraform module to run postfix in Kubernetes.

## Example

```tf
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

module "postfix" {
  source = "programmfabrik/postfix/kubernetes"
  version = "1.0.0"

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
  postfix_smtputf8_enable              = "yes"
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
  mail_email                           = "my.mail@example.com"
  mail_password                        = "my-password"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment_v1.postfix](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment_v1) | resource |
| [kubernetes_namespace_v1.postfix](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_secret_v1.sasl-config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [kubernetes_service_v1.postfix-service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_v1) | resource |
| [kubernetes_service_v1.postfix-service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service_v1) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create the namespace | `bool` | `true` | no |
| <a name="input_image_pull_policy"></a> [image\_pull\_policy](#input\_image\_pull\_policy) | Defines the image pull policy to use. | `string` | `"Always"` | no |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | The image repository to use | `string` | `"docker.fylr.io/services/postfix"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Defines the image version to use. | `string` | `"v1.0.0"` | no |
| <a name="input_mail_email"></a> [mail\_email](#input\_mail\_email) | n/a | `string` | n/a | yes |
| <a name="input_mail_password"></a> [mail\_password](#input\_mail\_password) | n/a | `string` | n/a | yes |
| <a name="input_mail_smtp_host"></a> [mail\_smtp\_host](#input\_mail\_smtp\_host) | n/a | `string` | n/a | yes |
| <a name="input_mail_smtp_port"></a> [mail\_smtp\_port](#input\_mail\_smtp\_port) | n/a | `number` | `587` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Postfix service | `string` | `"postfix"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy the postfix service in | `string` | `"postfix"` | no |
| <a name="input_postfix_inet_interfaces"></a> [postfix\_inet\_interfaces](#input\_postfix\_inet\_interfaces) | n/a | `string` | `"all"` | no |
| <a name="input_postfix_message_size_limit"></a> [postfix\_message\_size\_limit](#input\_postfix\_message\_size\_limit) | n/a | `string` | `"10240000"` | no |
| <a name="input_postfix_mydestination"></a> [postfix\_mydestination](#input\_postfix\_mydestination) | n/a | `string` | `""` | no |
| <a name="input_postfix_myhostname"></a> [postfix\_myhostname](#input\_postfix\_myhostname) | n/a | `string` | `"mail"` | no |
| <a name="input_postfix_mynetworks"></a> [postfix\_mynetworks](#input\_postfix\_mynetworks) | n/a | `string` | `"127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"` | no |
| <a name="input_postfix_relay_domains"></a> [postfix\_relay\_domains](#input\_postfix\_relay\_domains) | n/a | `string` | `""` | no |
| <a name="input_postfix_relayhost"></a> [postfix\_relayhost](#input\_postfix\_relayhost) | n/a | `string` | `""` | no |
| <a name="input_postfix_smtp_sasl_auth_enable"></a> [postfix\_smtp\_sasl\_auth\_enable](#input\_postfix\_smtp\_sasl\_auth\_enable) | n/a | `string` | `"yes"` | no |
| <a name="input_postfix_smtp_sasl_password_maps"></a> [postfix\_smtp\_sasl\_password\_maps](#input\_postfix\_smtp\_sasl\_password\_maps) | n/a | `string` | `"texthash:/etc/postfix/sasl_passwd"` | no |
| <a name="input_postfix_smtp_sasl_security_options"></a> [postfix\_smtp\_sasl\_security\_options](#input\_postfix\_smtp\_sasl\_security\_options) | n/a | `string` | `""` | no |
| <a name="input_postfix_smtp_tls_security_level"></a> [postfix\_smtp\_tls\_security\_level](#input\_postfix\_smtp\_tls\_security\_level) | n/a | `string` | `"encrypt"` | no |
| <a name="input_postfix_smtpd_delay_reject"></a> [postfix\_smtpd\_delay\_reject](#input\_postfix\_smtpd\_delay\_reject) | n/a | `string` | `"yes"` | no |
| <a name="input_postfix_smtpd_helo_required"></a> [postfix\_smtpd\_helo\_required](#input\_postfix\_smtpd\_helo\_required) | n/a | `string` | `"yes"` | no |
| <a name="input_postfix_smtpd_helo_restrictions"></a> [postfix\_smtpd\_helo\_restrictions](#input\_postfix\_smtpd\_helo\_restrictions) | n/a | `string` | `"permit_mynetworks,reject_invalid_helo_hostname,permit"` | no |
| <a name="input_postfix_smtpd_recipient_restrictions"></a> [postfix\_smtpd\_recipient\_restrictions](#input\_postfix\_smtpd\_recipient\_restrictions) | n/a | `string` | `"reject_non_fqdn_recipient,reject_unknown_recipient_domain,reject_unverified_recipient"` | no |
| <a name="input_postfix_smtputf8_enable"></a> [postfix\_smtputf8\_enable](#input\_postfix\_smtputf8\_enable) | Can be 'yes' or 'no'. | `string` | `"no"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Defines the number of replicas. | `number` | `1` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | Defines the resources to use. | <pre>object({<br>    limits = object({<br>      cpu    = string<br>      memory = string<br>    })<br>    requests = object({<br>      cpu    = string<br>      memory = string<br>    })<br>  })</pre> | <pre>{<br>  "limits": {<br>    "cpu": "0.5",<br>    "memory": "512Mi"<br>  },<br>  "requests": {<br>    "cpu": "0.5",<br>    "memory": "512Mi"<br>  }<br>}</pre> | no |
| <a name="input_wait_for_rollout"></a> [wait\_for\_rollout](#input\_wait\_for\_rollout) | Defines whether we should wait for the deployment to complete. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_dns"></a> [service\_dns](#output\_service\_dns) | The DNS name of the postfix service |
| <a name="output_service_port"></a> [service\_port](#output\_service\_port) | The port of the postfix service |
