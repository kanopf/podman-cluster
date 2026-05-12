variable "cluster_name" {
  description = "Nome do cluster"
  type        = string
  default     = "dev-cluster"
}

variable "k8s_version" {
  description = "Versão do Kubernetes (imagem kindest/node)"
  type        = string
  default     = "v1.30.0"
}

variable "worker_count" {
  description = "Número de nós worker"
  type        = number
  default     = 2
}

variable "control_plane_cpu" {
  description = "CPU reservada para o sistema no control-plane (ex: 100m, 500m)"
  type        = string
  default     = "100m"
}

variable "control_plane_memory" {
  description = "Memória reservada para o sistema no control-plane (ex: 128Mi, 256Mi)"
  type        = string
  default     = "128Mi"
}

variable "worker_cpu" {
  description = "CPU reservada para o sistema em cada worker (ex: 100m, 500m)"
  type        = string
  default     = "100m"
}

variable "worker_memory" {
  description = "Memória reservada para o sistema em cada worker (ex: 128Mi, 256Mi)"
  type        = string
  default     = "128Mi"
}
