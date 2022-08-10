output "service_dns" {
  value       = "${kubernetes_service_v1.postfix-service.metadata[0].name}.${var.namespace}.svc"
  description = "The DNS name of the postfix service"
}

output "service_port" {
  value       = local.service_port
  description = "The port of the postfix service"
}
