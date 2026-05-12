# terraform-labs

Laboratório prático de Terraform com foco em simulação de clusters Kubernetes localmente usando [kind](https://kind.sigs.k8s.io/) e [Podman](https://podman.io/).

## Labs disponíveis

| Lab | Descrição |
|-----|-----------|
| [01-docker-network](./01-docker-network/) | Cluster Kubernetes local com kind + Podman via Terraform |

---

## 01 — Cluster Kubernetes com kind + Podman

Provisiona um cluster Kubernetes completo localmente usando kind (Kubernetes in Docker) com Podman como container runtime. Cada nó do cluster é um container rodando a imagem `kindest/node`.

```
Terraform → kind → Podman containers → Cluster Kubernetes
```

### Pré-requisitos

| Ferramenta | Instalação |
|-----------|-----------|
| Terraform >= 1.6 | `sudo snap install terraform --classic` |
| kubectl | `sudo snap install kubectl --classic` |
| Podman | `sudo apt install podman -y` |
| kind | `curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64 && chmod +x kind && sudo mv kind /usr/local/bin/` |

Ativar o socket do Podman (necessário para o kind se comunicar com o Podman):

```bash
systemctl --user enable --now podman.socket
```

### Deploy rápido

```bash
cd 01-docker-network

make init
make apply
make kubeconfig
make nodes
```

### Variáveis disponíveis

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `CLUSTER_NAME` | `dev-cluster` | Nome do cluster |
| `K8S_VERSION` | `v1.30.0` | Versão do Kubernetes |
| `WORKER_COUNT` | `2` | Número de nós worker |
| `WORKER_CPU` | `100m` | CPU reservada por worker |
| `WORKER_MEMORY` | `128Mi` | Memória reservada por worker |
| `CP_CPU` | `100m` | CPU reservada no control-plane |
| `CP_MEMORY` | `128Mi` | Memória reservada no control-plane |

### Exemplos

```bash
# Cluster com 3 workers e mais recursos por nó
make apply WORKER_COUNT=3 WORKER_CPU=500m WORKER_MEMORY=512Mi

# Verificar nós
make nodes

# Destruir o cluster
make destroy
```

### Estrutura do projeto

```
01-docker-network/
├── main.tf        # Provider kind + recurso do cluster
├── variables.tf   # Variáveis configuráveis
├── outputs.tf     # Nome, endpoint e kubeconfig
└── Makefile       # Atalhos para deploy
```
