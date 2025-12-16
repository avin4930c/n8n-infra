# N8N Projects

Self-hosted n8n automation platform with production infrastructure and personal workflow collections.

## 📁 Repository Structure

```
n8n-projects/
├── infra/                    # Production infrastructure (Docker Compose stack)
│   ├── docker-compose.yml    # n8n + Postgres + Caddy services
│   ├── Caddyfile             # Reverse proxy & TLS config
│   ├── backup.sh             # Backup script for DB and volumes
│   ├── sample.env            # Environment template
│   └── README.md             # 📖 Infrastructure setup guide
│
├── projects/                 # N8N workflow collections
│   └── [workflow-name]/
│       ├── workflow.json     # Exportable n8n workflow
│       └── README.md         # Workflow-specific documentation
│
└── SECURITY.md               # Security guidelines & checklist
```

## 🚀 Getting Started

### 1. Deploy Infrastructure
See **[infra/README.md](infra/README.md)** for complete deployment instructions including:
- Prerequisites (Docker, DNS setup)
- Configuration (`.env` setup)
- Deployment steps
- Backup procedures
- Troubleshooting

### 2. Import Workflows
Once n8n is running:
1. Browse workflows in `projects/`
2. Read workflow-specific README for requirements
3. Import JSON via n8n UI
4. Configure credentials and update placeholders

## 📋 Available Workflows

### Interview Parser
**Path**: `projects/rbai-interview-parser/`  
**Purpose**: Extract structured data from interview transcripts using LLM  
**Requirements**: Google Sheets OAuth, LLM API (Groq/OpenAI)

## 🔒 Security Reminders

**Before deploying:**
- ✅ Change all default passwords in `.env`
- ✅ Generate strong `N8N_ENCRYPTION_KEY`
- ✅ Configure valid domain and SSL
- ✅ Review [SECURITY.md](SECURITY.md) checklist

See **[SECURITY.md](SECURITY.md)** for complete security policy.

## 📚 Documentation

- **[infra/README.md](infra/README.md)** - Infrastructure deployment & maintenance
- **[SECURITY.md](SECURITY.md)** - Security best practices
- **Individual workflow READMEs** - Setup instructions per workflow
- **[n8n Docs](https://docs.n8n.io/)** - Official n8n documentation

## 💡 Quick Reference

- **N8N Community**: https://community.n8n.io/
- **Troubleshooting**: See [infra/README.md](infra/README.md) troubleshooting section

---