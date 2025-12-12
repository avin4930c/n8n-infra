#!/usr/bin/env bash
set -euo pipefail
BACKUP_DIR="$(pwd)/backups/$(date +%F)"
mkdir -p "$BACKUP_DIR"

# Dump Postgres
DB_CONTAINER=$(docker compose ps -q db)
docker exec -t "$DB_CONTAINER" pg_dump -U "${POSTGRES_USER:-n8n}" "${POSTGRES_DB:-n8n}" > "$BACKUP_DIR/pg_dump_$(date +%F).sql"

# Backup n8n data volume
docker run --rm -v n8n_data:/data -v "$BACKUP_DIR":/backup ubuntu bash -lc "cd /data && tar czf /backup/n8n_data_$(date +%F).tar.gz ."

echo "Backups saved to $BACKUP_DIR"