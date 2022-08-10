variable "kube_config" {
  type        = string
  description = "Path to kube config file"
  default     = "~/.kube/config"
}

variable "kube_context" {
  type        = string
  description = "Kubernetes context"
  default     = "minikube"
}
