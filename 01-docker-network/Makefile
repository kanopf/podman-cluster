CLUSTER_NAME   ?= dev-cluster
K8S_VERSION    ?= v1.30.0
WORKER_COUNT   ?= 2
WORKER_CPU     ?= 100m
WORKER_MEMORY  ?= 128Mi
CP_CPU         ?= 100m
CP_MEMORY      ?= 128Mi

export KIND_EXPERIMENTAL_PROVIDER=podman

.PHONY: help init plan apply destroy kubeconfig nodes

help:
	@echo "Targets disponíveis:"
	@echo "  init        Inicializa o Terraform e baixa providers"
	@echo "  plan        Mostra o que será criado"
	@echo "  apply       Sobe o cluster Kubernetes"
	@echo "  destroy     Destrói o cluster"
	@echo "  kubeconfig  Exporta o kubeconfig para ~/.kube/config"
	@echo "  nodes       Lista os nós do cluster"
	@echo ""
	@echo "Variáveis (sobrescreva com make apply WORKER_COUNT=3):"
	@echo "  CLUSTER_NAME   = $(CLUSTER_NAME)"
	@echo "  K8S_VERSION    = $(K8S_VERSION)"
	@echo "  WORKER_COUNT   = $(WORKER_COUNT)"
	@echo "  WORKER_CPU     = $(WORKER_CPU)"
	@echo "  WORKER_MEMORY  = $(WORKER_MEMORY)"
	@echo "  CP_CPU         = $(CP_CPU)"
	@echo "  CP_MEMORY      = $(CP_MEMORY)"

init:
	terraform init

plan:
	terraform plan \
		-var="cluster_name=$(CLUSTER_NAME)" \
		-var="k8s_version=$(K8S_VERSION)" \
		-var="worker_count=$(WORKER_COUNT)" \
		-var="worker_cpu=$(WORKER_CPU)" \
		-var="worker_memory=$(WORKER_MEMORY)" \
		-var="control_plane_cpu=$(CP_CPU)" \
		-var="control_plane_memory=$(CP_MEMORY)"

apply:
	terraform apply -auto-approve \
		-var="cluster_name=$(CLUSTER_NAME)" \
		-var="k8s_version=$(K8S_VERSION)" \
		-var="worker_count=$(WORKER_COUNT)" \
		-var="worker_cpu=$(WORKER_CPU)" \
		-var="worker_memory=$(WORKER_MEMORY)" \
		-var="control_plane_cpu=$(CP_CPU)" \
		-var="control_plane_memory=$(CP_MEMORY)"

destroy:
	terraform destroy -auto-approve \
		-var="cluster_name=$(CLUSTER_NAME)" \
		-var="k8s_version=$(K8S_VERSION)" \
		-var="worker_count=$(WORKER_COUNT)" \
		-var="worker_cpu=$(WORKER_CPU)" \
		-var="worker_memory=$(WORKER_MEMORY)" \
		-var="control_plane_cpu=$(CP_CPU)" \
		-var="control_plane_memory=$(CP_MEMORY)"

kubeconfig:
	terraform output -raw kubeconfig > ~/.kube/config
	@echo "Kubeconfig exportado para ~/.kube/config"

nodes:
	kubectl get nodes -o wide
