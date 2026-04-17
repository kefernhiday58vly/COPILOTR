#!/bin/bash

# Tạo thư mục làm việc riêng để tránh làm bẩn home directory
WORK_DIR="$HOME/xmrig-worker"
LOG_FILE="$HOME/xmrig.log"

mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

echo ">>> Bắt đầu cài đặt XMRig trong nền..."

# Tải xuống nếu chưa có
if [ ! -f "xmrig-6.26.0/xmrig" ]; then
    echo ">>> Đang tải XMRig..."
    wget -q --show-progress https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz
    echo ">>> Đang giải nén..."
    tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz
fi

cd xmrig-6.26.0

echo ">>> Khởi động XMRig ở chế độ nền..."
# Đây là dòng quan trọng nhất:
# `nohup` giúp tiến trình không bị tắt khi script kết thúc.
# `> ... 2>&1` chuyển hướng mọi output ra file log.
# `&` ở cuối dòng lệnh chính là thứ đưa nó vào background.
nohup ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.worke3 -p x --coin monero > "$LOG_FILE" 2>&1 &

echo ">>> XMRig đã được khởi động trong nền."
echo ">>> Bạn có thể xem log tại: $LOG_FILE"
echo ">>> Quá trình thiết lập hoàn tất."
