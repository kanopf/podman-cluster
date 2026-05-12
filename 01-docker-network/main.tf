terraform {
  required_version = ">= 1.6.0"

  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.6"
    }
  }
}

provider "kind" {}

resource "kind_cluster" "cluster" {
  name           = var.cluster_name
  node_image     = "kindest/node:${var.k8s_version}"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        <<-EOT
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            system-reserved: "cpu=${var.control_plane_cpu},memory=${var.control_plane_memory}"
        EOT
      ]
    }

    dynamic "node" {
      for_each = range(var.worker_count)
      content {
        role = "worker"

        kubeadm_config_patches = [
          <<-EOT
          kind: JoinConfiguration
          nodeRegistration:
            kubeletExtraArgs:
              system-reserved: "cpu=${var.worker_cpu},memory=${var.worker_memory}"
          EOT
        ]
      }
    }
  }
}
