##!/bin/bash
#set -ex
#
#export HOME=/home/ubuntu
#export NODE_ENV=production
#
#echo "Navigating to app directory..."
#cd /home/ubuntu/app
#
#echo "Installing dependencies..."
#npm install --production
#
#echo "Stopping existing PM2 process..."
#pm2 stop nestjs-app || true
#pm2 delete nestjs-app || true
#
#echo "Starting application..."
#pm2 start dist/main.js --name nestjs-app --watch
#
#echo "Saving PM2 configuration..."
#pm2 save
#
#echo "Setting up startup script..."
#pm2 startup systemd -u ubuntu --hp /home/ubuntu


#!/bin/bash
set -ex

export HOME=/home/ubuntu
export NODE_ENV=production

echo "Navigating to app directory..."
cd /home/ubuntu/app

echo "Downloading latest artifact from S3..."
aws s3 cp s3://seenyor-backend-1-pipeline-bucket/build_output/build_output.zip .

echo "Unpacking artifact..."
unzip -o build_output.zip -d /home/ubuntu/app

echo "Installing dependencies..."
npm install --production

echo "Stopping existing PM2 process..."
pm2 stop nestjs-app || true
pm2 delete nestjs-app || true

echo "Starting application..."
pm2 start dist/main.js --name nestjs-app --watch

echo "Saving PM2 configuration..."
pm2 save

echo "Configuring PM2 to start on boot..."
pm2 startup systemd -u ubuntu --hp /home/ubuntu
