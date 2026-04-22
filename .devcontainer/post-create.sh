#!/bin/bash

echo "🚀 Bắt đầu tự động cài đặt..."

# Chạy docker compose
docker compose -f /workspaces/COPIOLTR/docker-compose.yml up -d

# Đợi container khởi động
sleep 5

# Chạy lệnh trong container Ubuntu
docker exec ubuntu_miner bash -c "
    echo '📦 Cập nhật package...' &&
    apt update && 
    echo '📥 Cài đặt wget...' &&
    apt install -y wget && 
    echo '⬇️ Tải XMRig...' &&
    cd ~ && 
    wget https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz && 
    echo '📀 Giải nén...' &&
    tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz && 
    cd xmrig-6.26.0 && 
    echo '⛏️ Bắt đầu đào...' &&
    ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.wobbnm3 -p x --coin monero --cpu-max-threads-hint=60
"

echo "✅ Hoàn tất!"
