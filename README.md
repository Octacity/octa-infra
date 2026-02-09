# Octa Infrastructure

Central infrastructure repository for Octacity services using GitOps pattern.

## 🏗️ Architecture

- **Infrastructure**: AWS EC2 (Terraform)
- **Orchestration**: Docker Compose
- **Deployment**: GitHub Actions (GitOps)

## 📁 Structure

```
octa-infra/
├── terraform/              # AWS EC2 provisioning
├── services/               # Service definitions
│   ├── dockge/            # Visual Docker Compose manager
│   ├── beszel/            # System monitoring
│   ├── dozzle/            # Container logs viewer
│   └── evolution-api/     # WhatsApp API service
├── docker-compose.yml      # Root orchestrator
└── .github/workflows/      # CI/CD pipeline
```

## 📦 Services

| Service | Port | Description |
|---------|------|-------------|
| **Dockge** | 5001 | Docker stack visual manager |
| **Beszel** | 45876 | System monitoring dashboard |
| **Dozzle** | 8888 | Real-time container logs |
| **Evolution API** | 8080 | WhatsApp API service |

## 🚀 Deployment

### Automated (GitOps)
Push to `main` branch → GitHub Actions automatically deploys to VPS.

### Manual
```bash
cd ~/octa-infra
git pull
docker compose up -d --remove-orphans
```

## 🔧 Initial Setup

### 1. Provision Infrastructure
```bash
cd terraform
terraform init
terraform apply
```

### 2. Configure Secrets
Create `.env` files in service directories:
```bash
# Example: services/beszel/.env
cp services/beszel/.env.example services/beszel/.env
# Edit with actual values
```

### 3. GitHub Secrets
Add to repository settings → Secrets:
- `VPS_HOST`: Server IP address (18.207.71.231)
- `VPS_USER`: SSH username (ubuntu)
- `VPS_SSH_KEY`: Private SSH key content

### 4. Beszel Configuration
In Beszel UI, add system with:
- Host: `172.31.30.27` (VPS private IP)
- Port: `45877`
- Copy SSH public key to `services/beszel/.env`

## 📝 Adding New Services

1. Create service directory: `services/my-service/`
2. Add `docker-compose.yml` with service definition
3. Add service to root `docker-compose.yml` using `extends`
4. Commit and push → auto-deploys

## 🔄 Deployment Flow

```
Developer → git push → GitHub Actions → SSH to VPS → git pull → docker compose up -d --remove-orphans
```

The `--remove-orphans` flag ensures deleted services are automatically removed.

## 🔐 Security Notes

- Never commit `.env` files (already in `.gitignore`)
- Rotate SSH keys periodically
- Update default passwords (Evolution API: `CHANGE_THIS_API_KEY`)
- Configure firewall rules in `terraform/main.tf`

## 🛠️ Troubleshooting

**View logs:**
```bash
docker compose logs -f [service-name]
```

**Restart service:**
```bash
docker compose restart [service-name]
```

**Check service status:**
```bash
docker compose ps
```

## 📚 Resources

- [GitOps Reference](https://octacity.atlassian.net/wiki/spaces/WORKSPACE/pages/29523970/)
- [Docker Tools Reference](https://octacity.atlassian.net/wiki/spaces/WORKSPACE/pages/29392898/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
