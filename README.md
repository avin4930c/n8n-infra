# N8N Workflow Collection

This repository contains a self-hosted n8n automation platform with production infrastructure and a collection of workflow automations for research and data processing tasks.

## About n8n

n8n is an open-source workflow automation tool that allows you to connect various applications and services through a visual interface. It enables the creation of complex data processing pipelines, API integrations, and automated workflows without extensive programming knowledge.

This repository demonstrates production-grade deployment and implementation of n8n workflows for real-world use cases.

## Repository Structure

```
n8n-projects/
├── infra/                          Production infrastructure
│   ├── docker-compose.yml          n8n + PostgreSQL + Caddy
│   ├── Caddyfile                   Reverse proxy configuration
│   ├── backup.sh                   Automated backup script
│   ├── sample.env                  Environment template
│   └── README.md                   Deployment documentation
│
├── projects/                       Workflow collection
│   ├── rbai-interview-parser/      Interview data extraction workflow
│   ├── mileage-tracker/            Odometer tracking workflow
│   └── [future-workflows]/         Additional workflows
│
└── private/                        Development notes (not tracked)
```

## Infrastructure

The `infra/` directory contains production-ready Docker Compose configuration for deploying n8n with:

- **PostgreSQL 15** for persistent data storage
- **Caddy 2** as reverse proxy with automatic HTTPS/TLS
- **Automated backups** for data preservation
- **Environment-based configuration** for secure credential management

Refer to [infra/README.md](infra/README.md) for complete deployment instructions.

## Workflows

The `projects/` directory contains individual n8n workflow implementations. Each workflow is organized in its own subdirectory with:

- **workflow.json** - Importable n8n workflow file
- **README.md** - Workflow documentation, setup instructions, and technical details
- **Additional files** - Configuration guides or supporting documentation

Each workflow is documented independently. Refer to individual project directories for specific implementation details.

## Getting Started

1. **Deploy Infrastructure**: Follow the deployment guide in [infra/README.md](infra/README.md)
2. **Import Workflows**: Access your n8n instance and import workflow JSON files from `projects/`
3. **Configure Credentials**: Set up required API keys and OAuth credentials as specified in each workflow's documentation

## Purpose

This is a personal research workspace demonstrating the application of workflow automation for data collection, processing, and analysis tasks. The repository serves as a reference implementation for production-grade n8n deployments and workflow design patterns.

---

**Note:** Sensitive information (API keys, credentials, personal data) has been sanitized from this repository. Placeholder values must be replaced with actual credentials during deployment.