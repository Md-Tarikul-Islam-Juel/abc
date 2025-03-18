#!/bin/bash
set -e

echo "=== VALIDATE SCRIPT: $(date) ==="

# Simple check to see if the app is responding on port 3000
# Sleep a few seconds to ensure the app has time to fully start
sleep 5

# Use curl to check the health endpoint (or root, if that returns 200)
if curl -s http://localhost:3000/ | grep -q "Hello"; then
  echo "=== Validation successful! ==="
  exit 0
else
  echo "=== Validation failed! ==="
  exit 1
fi
