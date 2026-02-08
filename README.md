# Octa Infrastructure

Central infrastructure repository following GitOps pattern for managing all Octacity services.

## 🏗️ Architecture

This repository uses the **Central Infrastructure Repo** pattern:
- **Terraform**: Provisions AWS EC2 VPS with Docker pre-installed
- **Docker Compose**: Manages service deployment on the VPS
- **GitOps**: All infrastructure as code, version controlled

## 📁 Structure

```
octa-infra/
├── terraform/              # AWS EC2 provisioning
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── services/               # Service definitions
│   ├── dockge/            # Visual Docker Compose manager
│   ├── beszel/            # Monitoring & alerts
│   ├── dozzle/            # Container log viewer
│   └── evolution-api/     # WhatsApp API service
├── deploy.sh              # Deployment script
└── README.md
```

## 🚀 Getting Started

### 1. Provision Infrastructure

```bash
cd terraform
terraform init
terraform plan -var="key_name=your-ssh-key"
terraform apply -var="key_name=your-ssh-key"
```

Note the output `public_ip` for SSH access.

### 2. Initial Server Setup

SSH into the server and clone this repo:

```bash
ssh ubuntu@<public_ip>
sudo mkdir -p /opt/octa-infra
sudo chown ubuntu:ubuntu /opt/octa-infra
cd /opt
git clone https://github.com/Octacity/octa-infra.git
cd octa-infra
```

### 3. Deploy Services

```bash
chmod +x deploy.sh
./deploy.sh
```

### 4. Set Up Auto-Deploy (Optional)

Create a cron job to auto-pull and deploy on changes:

```bash
crontab -e
```

Add:
```
*/5 * * * * cd /opt/octa-infra && git pull && ./deploy.sh >> /var/log/octa-deploy.log 2>&1
```

## 🔧 Services

| Service | Port | URL | Purpose |
|---------|------|-----|---------|
| Dockge | 5001 | http://ip:5001 | Visual Docker Compose manager |
| Beszel | 45876 | http://ip:45876 | System monitoring & alerts |
| Dozzle | 8888 | http://ip:8888 | Real-time container logs |
| Evolution API | 8080 | http://ip:8080 | WhatsApp API service |

## 📝 Adding New Services

1. Create new folder in `services/`:
   ```bash
   mkdir services/my-new-service
   ```

2. Add `docker-compose.yml`:
   ```yaml
   version: "3.8"
   services:
     my-service:
       image: my-image:latest
       # ... configuration
   ```

3. Update `deploy.sh` to include the new service

4. Commit and push - auto-deploy will handle the rest

## 🔄 Updating Services

Simply update the docker-compose.yml file and commit:

```bash
git add services/evolution-api/docker-compose.yml
git commit -m "Update Evolution API configuration"
git push
```

The cron job will automatically deploy changes within 5 minutes.

## 🔐 Security Notes

- Evolution API default key is `CHANGE_THIS_API_KEY` - update in `services/evolution-api/docker-compose.yml`
- Consider adding Traefik/Nginx proxy with SSL for production
- Restrict security group rules in `terraform/main.tf` as needed

## 🎯 Next Steps

1. Add your Flask API services
2. Add your Next.js/Vite frontend services
3. Configure domain names and SSL certificates
4. Set up backup strategy

## 📚 Resources

- [GitOps Reference](https://octacity.atlassian.net/wiki/spaces/WORKSPACE/pages/29523970/)
- [Docker Tools Reference](https://octacity.atlassian.net/wiki/spaces/WORKSPACE/pages/29392898/)
