#!/bin/bash
set -ex

echo "Restarting the NestJS application..."

# Change to the application directory
cd /home/ubuntu/app

# Stop the currently running instance (ignore errors if not running)
pm2 stop nestjs-app || true
pm2 delete nestjs-app || true

# Start the new instance using PM2
pm2 start dist/main.js --name nestjs-app --watch

# Save the PM2 process list so that the application restarts on reboot
pm2 save

echo "Application restarted successfully."
