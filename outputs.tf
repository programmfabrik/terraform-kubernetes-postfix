output "service_ip" {
  value       = kubernetes_service.postfix-service.spec.cluster_ip
  description = "The IP address of the postfix service"
}

output "service_dns" {
  value       = "${kubernetes_service.postfix-service.metadata[0].name}.${var.namespace}.svc"
  description = "The DNS name of the postfix service"
}

output "service_port" {
  value       = kubernetes_service.postfix-service.spec.ports[0].port
  description = "The port of the postfix service"
}
