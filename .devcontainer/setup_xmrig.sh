#!/bin/bash

WORK_DIR="$HOME/xmrig-worker"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

echo ">>> Kiểm tra quyền truy cập MSR..."
# Thử load module msr nếu chưa có (cần quyền root)
if ! lsmod | grep -q msr; then
    echo ">>> Đang tải kernel module msr..."
    sudo modprobe msr 2>/dev/null || echo "Cảnh báo: Không thể tải msr module"
fi

echo ">>> Đang tải XMRig..."
if [ ! -f "xmrig-6.26.0/xmrig" ]; then
    wget -q --show-progress https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz
    tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz
fi

cd xmrig-6.26.0

# Cấp quyền thực thi cho các helper scripts
chmod +x xmrig scripts/enable_1gb_pages.sh 2>/dev/null

# Kích hoạt huge pages (cần quyền root)
echo ">>> Cấu hình huge pages..."
sudo sysctl -w vm.nr_hugepages=1280 2>/dev/null || echo "Cần chạy container với --privileged"

# Chạy trực tiếp (không background) để thấy output và giữ tiến trình
echo ">>> Khởi động XMRig..."
# THÊM CÁC FLAG QUAN TRỌNG SAU:
# --cpu-priority=5 : Độ ưu tiên cao nhất
# --randomx-1gb-pages : Bắt buộc dùng 1GB pages
# --cpu-max-threads-hint=100 : Dùng 100% CPU
./xmrig \
    -o xmr-sg.kryptex.network:7029 \
    -u krxX2P79Q4.worke3 \
    -p x \
    --coin monero \
    --cpu-priority=5 \
    --randomx-1gb-pages \
    --cpu-max-threads-hint=100 \
    --donate-level=1
