#!/bin/bash
set -ex

echo "Download artifact hook triggered at $(date)"
cd /home/ubuntu/app

# Download the new build artifact from S3
aws s3 cp s3://seenyor-backend-1-pipeline-bucket/build_output/build_output.zip .

# Unzip the artifact into the application directory
unzip -o build_output.zip -d /home/ubuntu/app
