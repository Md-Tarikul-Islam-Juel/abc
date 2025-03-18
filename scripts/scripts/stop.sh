#!/bin/bash
set -e

echo "=== STOP SCRIPT: $(date) ==="

# If the app is running under PM2, stop it
if pm2 list | grep -q "nestjs-app"; then
  pm2 stop "nestjs-app"
  pm2 delete "nestjs-app"
fi

echo "=== Application stopped ==="
