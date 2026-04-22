#!/bin/bash
set -e

echo "==> Khởi động Ubuntu container..."
docker compose up -d

echo "==> Chờ container sẵn sàng..."
sleep 3

echo "==> Cài đặt wget bên trong Ubuntu..."
docker exec ubuntu_cli bash -c "apt update && apt install -y wget"

echo "==> Hoàn tất! Mở terminal mới để vào Ubuntu."
