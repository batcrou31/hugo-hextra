#!/bin/bash
set -e

# Installer Go (requis par les Hugo Modules, Hextra demande Go >= 1.26)
GO_VERSION=1.26.0
curl -sSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /tmp -xz
export PATH="/tmp/go/bin:$PATH"
export GOTOOLCHAIN=local
go version

# URL de base selon l'environnement
if [ "$VERCEL_ENV" = "production" ]; then
  BASE="https://$VERCEL_PROJECT_PRODUCTION_URL"
else
  BASE="https://$VERCEL_URL"
fi

hugo --gc --minify -b "$BASE"
