# Infra — n8n Production Stack

Single-VM production setup for n8n on EC2 using Docker Compose: n8n app, Postgres 15, and Caddy 2 as reverse proxy/TLS.

**Do not commit secrets.** Copy [infra/sample.env](infra/sample.env) to the server as `.env` and populate real values there (or via CI/CD secrets/SSM).

## Contents
- [infra/docker-compose.yml](infra/docker-compose.yml) — services and volumes (no secrets)
- [infra/Caddyfile](infra/Caddyfile) — reverse proxy config (no keys)
- [infra/sample.env](infra/sample.env) — env template to edit on server
- [infra/backup.sh](infra/backup.sh) — dumps Postgres and the n8n data volume

## Prereqs (server)
- Docker Engine + Docker Compose v2
- DNS A/AAAA pointing your domain to the EC2 public IP
- Security Group: 80/443 open; 22 restricted to your IPs

## Deploy (manual)
```bash
# on your laptop
scp infra/sample.env infra/docker-compose.yml infra/Caddyfile infra/backup.sh ubuntu@YOUR_SERVER:~/n8n-prod/

# on server
cd ~/n8n-prod
mv sample.env .env && nano .env  # fill secrets + domain
docker compose pull
docker compose up -d --remove-orphans

# verify
docker compose ps
docker compose logs -f caddy --tail 50
docker compose logs -f n8n --tail 50
```

## Configuration
Key `.env` entries:
- `DOMAIN`, `EMAIL` — domain for TLS/ACME contact
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` — database creds
- `N8N_BASIC_AUTH_USER`, `N8N_BASIC_AUTH_PASSWORD` — HTTP basic auth to guard n8n UI
- `GENERIC_TIMEZONE` — e.g., `Asia/Kolkata`

## Backups
- Run `./backup.sh` on the server; outputs to `./backups/<YYYY-MM-DD>/` containing a Postgres dump and tarball of the n8n data volume.
- Keep copies off the instance and test restores on staging.

## TLS / cert renewal
Caddy handles certificates automatically. If you bind-mount host certs (e.g., `/etc/letsencrypt`), reload after renewal: `docker compose exec caddy caddy reload`.

## Security
- Use strong secrets and rotate DB/basic-auth credentials periodically.
- Keep `.env` off git; prefer SSM/Secrets Manager or repo secrets for CI/CD.
- Restrict SSH; consider fail2ban or a bastion.

## Troubleshooting
- UI says “Lost connection”: `docker compose logs -f caddy` for websocket issues.
- DB connectivity: `docker compose logs -f n8n | grep -i postgres` and `docker compose exec db psql -U $POSTGRES_USER -d $POSTGRES_DB -c "\dt"`.
- TLS fails: verify DNS/port 80 reachability and Caddy ACME logs.