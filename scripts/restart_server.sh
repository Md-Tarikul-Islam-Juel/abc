#!/bin/bash
cd /home/ubuntu/app
sudo npm install --production
sudo pm2 restart nestjs-app