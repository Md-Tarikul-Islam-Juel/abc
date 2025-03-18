#!/bin/bash
set -ex

echo "Restarting the NestJS application..."

cd /home/ubuntu/app

# Fix permissions to avoid access issues
sudo chown -R ubuntu:ubuntu /home/ubuntu/app
sudo chmod -R 755 /home/ubuntu/app

# Stop and remove old PM2 process
pm2 stop nestjs-app || true
pm2 delete nestjs-app || true

# Start new application instance
pm2 start dist/main.js --name nestjs-app --watch --time

# Save PM2 process list and configure auto-start on reboot
pm2 save
pm2 startup systemd -u ubuntu --hp /home/ubuntu

echo "Application restarted successfully."
