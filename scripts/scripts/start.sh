#!/bin/bash
set -e

echo "=== START SCRIPT: $(date) ==="

# Navigate to the app directory
cd /home/ubuntu/app

# (Optional) Install dependencies if you haven't already
# npm install --production

# Start or restart the application using PM2
pm2 start dist/main.js --name "nestjs-app" --watch

echo "=== Application started ==="
