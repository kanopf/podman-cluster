output "cluster_name" {
  description = "Nome do cluster criado"
  value       = kind_cluster.cluster.name
}

output "endpoint" {
  description = "Endpoint da API do cluster"
  value       = kind_cluster.cluster.endpoint
}

output "kubeconfig" {
  description = "Kubeconfig para acesso ao cluster"
  value       = kind_cluster.cluster.kubeconfig
  sensitive   = true
}
