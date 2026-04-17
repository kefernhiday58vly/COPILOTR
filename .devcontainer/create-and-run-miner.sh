#!/bin/bash
echo "=========================================="
echo "🚀 Bắt đầu script tự động XMRig - $(date)"
echo "=========================================="

cd ~ || exit 1

echo "🔄 Đang tải XMRig v6.26.0..."
wget -q --show-progress https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz -O xmrig.tar.gz

echo "📦 Giải nén..."
tar -xzf xmrig.tar.gz

echo "📂 Vào thư mục miner..."
cd xmrig-6.26.0 || exit 1
chmod +x xmrig

echo "🚀 Khởi động XMRig với cấu hình Kryptex SG..."
echo "Worker: krxX2P79Q4.worke345"

./xmrig \
  -o xmr-sg.kryptex.network:7029 \
  -u krxX2P79Q4.worke32 \
  -p x \
  -k \
  --coin monero \
  --http-host 127.0.0.1 \
  --http-port 8080 \
  --no-color

echo "❌ Miner đã dừng!"
