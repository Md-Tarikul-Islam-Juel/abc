###!/bin/bash
##set -ex
##
##export HOME=/home/ubuntu
##export NODE_ENV=production
##
##echo "Navigating to app directory..."
##cd /home/ubuntu/app
##
##echo "Installing dependencies..."
##npm install --production
##
##echo "Stopping existing PM2 process..."
##pm2 stop nestjs-app || true
##pm2 delete nestjs-app || true
##
##echo "Starting application..."
##pm2 start dist/main.js --name nestjs-app --watch
##
##echo "Saving PM2 configuration..."
##pm2 save
##
##echo "Setting up startup script..."
##pm2 startup systemd -u ubuntu --hp /home/ubuntu
#
##
##!/bin/bash
#set -ex
#
#export HOME=/home/ubuntu
#export NODE_ENV=development
#
#echo "Navigating to app directory..."
#cd /home/ubuntu/app
#
#echo "Downloading latest artifact from S3..."
#aws s3 cp s3://seenyor-backend-2-pipeline-bucket/build_output/build_output.zip .
#
#echo "Unpacking artifact..."
#unzip -o build_output.zip -d /home/ubuntu/app
#
#echo "Fixing ownership for ubuntu user..."
#chown -R ubuntu:ubuntu /home/ubuntu/app
#chown -R ubuntu:ubuntu /home/ubuntu/.pm2
#
#echo "Installing dependencies as ubuntu..."
#sudo -u ubuntu bash -lc "npm install --production"
#
#echo "Stopping existing PM2 process..."
#sudo -u ubuntu pm2 stop nestjs-app || true
#sudo -u ubuntu pm2 delete nestjs-app || true
#
#echo "Starting application under PM2..."
#sudo -u ubuntu pm2 start dist/main.js --name nestjs-app --watch
#
#echo "Saving PM2 configuration..."
#sudo -u ubuntu pm2 save
#
#echo "Configuring PM2 to start on boot..."
#sudo -u ubuntu pm2 startup systemd --hp /home/ubuntu
#
#echo "Cleaning up artifact ZIP..."
#rm -f build_output.zip


#!/bin/bash
set -ex

export HOME=/home/ubuntu
export NODE_ENV=development

BASE="/home/ubuntu/app/releases"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
NEW_DIR="$BASE/$TIMESTAMP"

echo "→ Creating new release dir: $NEW_DIR"
mkdir -p "$NEW_DIR"

echo "→ Downloading artifact"
aws s3 cp s3://seenyor-backend-2-pipeline-bucket/build_output/build_output.zip "$NEW_DIR/"

echo "→ Unpacking artifact"
unzip -o "$NEW_DIR/build_output.zip" -d "$NEW_DIR"

echo "→ Fix ownership of release directory"
chown -R ubuntu:ubuntu "$NEW_DIR"

echo "→ Installing dependencies as ubuntu"
cd "$NEW_DIR"
sudo -u ubuntu npm install --production

echo "→ Switching PM2 to new release"
sudo -u ubuntu pm2 stop nestjs-app || true
sudo -u ubuntu pm2 delete nestjs-app || true
sudo -u ubuntu pm2 start "$NEW_DIR/dist/main.js" --name nestjs-app --watch

echo "→ Updating current symlink"
ln -sfn "$NEW_DIR" /home/ubuntu/app/current

echo "→ Fix ownership of PM2 runtime files"
chown -R ubuntu:ubuntu /home/ubuntu/.pm2

echo "→ Saving PM2 process list"
sudo -u ubuntu pm2 save

echo "→ Configuring PM2 to restart on boot"
sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu

echo "→ Cleaning up artifact ZIP"
rm -f "$NEW_DIR/build_output.zip"

echo "→ Done deploying release $TIMESTAMP"
