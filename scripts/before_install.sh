#!/bin/bash
set -e

echo "=== BEFORE_INSTALL SCRIPT: $(date) ==="

# (Optional) Remove old application files
if [ -d "/home/ubuntu/app" ]; then
  rm -rf /home/ubuntu/app/*
fi

echo "=== Old app files removed (if any) ==="
