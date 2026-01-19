#!/usr/bin/env bash
set -euo pipefail

# Default project root (sesuaikan jika perlu)
PROJECT_ROOT="${APP_WEBROOT:-/home/IymzDD8rFQXm1KZI/AppGK/public_html}"

echo "Project root: ${PROJECT_ROOT}"
cd "${PROJECT_ROOT}"

if [ ! -f "./package.json" ]; then
  echo "package.json tidak ditemui di ${PROJECT_ROOT}"
  exit 1
fi

# 1) Pasang dependency
npm ci

# 2) Generate Prisma client
npx prisma generate

# 3) Jalankan migrations (deploy)
npx prisma migrate deploy

# 4) Jalankan seed skrip
npm run seed

echo "Selesai: migration & seed."

