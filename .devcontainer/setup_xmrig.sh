#!/bin/bash

# Tạo thư mục làm việc riêng để tránh làm bẩn home directory
WORK_DIR="$HOME/xmrig-worker"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

echo ">>> Đang tải XMRig..."
wget -q --show-progress https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz

echo ">>> Đang giải nén..."
tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz

cd xmrig-6.26.0

echo ">>> Khởi động XMRig..."
# Sử dụng exec để script không bị treo trong container (nếu cần)
./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.worke3 -p x --coin monero
