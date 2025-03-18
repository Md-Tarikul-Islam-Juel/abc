#!/bin/bash
set -e

echo "=== AFTER_INSTALL SCRIPT: $(date) ==="

cd /home/ubuntu/app

# Install production dependencies
npm install --production

# (Optional) Rebuild the application if needed
# npm run build

echo "=== Dependencies installed, ready to start ==="
