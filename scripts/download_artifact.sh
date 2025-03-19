#!/bin/bash
set -ex

echo "x=x=x=x=x=x=x=x=x=x=x=x=x=x=x=x=x=x"
# Change to your app directory
cd /home/ubuntu/app

# Download the new build artifact from S3
aws s3 cp s3://seenyor-backend-1-pipeline-bucket/build_output/build_output.zip .

# (Optional) You could also unzip it here if needed
unzip -o build_output.zip -d /home/ubuntu/app
