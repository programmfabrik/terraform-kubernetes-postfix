provider "kubernetes" {
  config_path    = var.kube_config
  config_context = var.kube_context
}
