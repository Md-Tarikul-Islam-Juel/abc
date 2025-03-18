#!/bin/bash
set -ex

echo "Restarting the NestJS application..."

cd /home/ubuntu/app

# Ensure correct permissions
sudo chown -R ubuntu:ubuntu /home/ubuntu/app
sudo chmod -R 755 /home/ubuntu/app

# Stop the currently running instance (ignore errors if not running)
pm2 stop nestjs-app || true
pm2 delete nestjs-app || true

# Start the new instance using PM2
pm2 start dist/main.js --name nestjs-app --watch

# Save the PM2 process list so that the application restarts on reboot
pm2 save
pm2 startup systemd -u ubuntu --hp /home/ubuntu

echo "Application restarted successfully."
