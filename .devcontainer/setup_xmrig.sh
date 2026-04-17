#!/bin/bash

# Tạo thư mục tạm thời
mkdir -p /tmp/xmrig
cd /tmp/xmrig

echo "=== BẮT ĐẦU CÀI ĐẶT ==="

# Xóa phiên bản cũ nếu có
rm -rf xmrig-6.26.0
rm -f xmrig-6.26.0-linux-static-x64.tar.gz

# Tải xuống
echo ">>> Đang tải XMRig..."
wget -q https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz

# Giải nén
echo ">>> Đang giải nén..."
tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz
cd xmrig-6.26.0

# Tạo script wrapper để chạy trong screen session
cat > /tmp/start_miner.sh << 'EOF'
#!/bin/bash
cd /tmp/xmrig/xmrig-6.26.0
while true; do
    echo "$(date): Starting XMRig..."
    ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.worke3 -p x --coin monero --donate-level=1 --cpu-priority=5
    echo "$(date): XMRig stopped, restarting in 5 seconds..."
    sleep 5
done
EOF

chmod +x /tmp/start_miner.sh

# Kiểm tra xem đã có screen chưa
if ! command -v screen &> /dev/null; then
    echo ">>> Cài đặt screen..."
    sudo apt-get update -qq && sudo apt-get install -y -qq screen
fi

# KHỞI ĐỘNG TRONG SCREEN SESSION (quan trọng nhất)
echo ">>> Khởi động XMRig trong screen session..."
screen -dmS xmrig_miner /tmp/start_miner.sh

# Đợi 2 giây để miner khởi động
sleep 2

# Kiểm tra xem đã chạy chưa
if screen -list | grep -q "xmrig_miner"; then
    echo "=== THÀNH CÔNG: XMRig đang chạy trong screen session 'xmrig_miner' ==="
    echo "=== Để xem log, chạy: screen -r xmrig_miner ==="
    echo "=== Để thoát khỏi screen (giữ miner chạy): Ctrl+A sau đó D ==="
    
    # Ghi log ra file để kiểm tra sau
    /tmp/xmrig/xmrig-6.26.0/xmrig --version > /tmp/xmrig_version.txt 2>&1
    echo "XMRig installed at: $(date)" > /tmp/xmrig_installed.txt
else
    echo "=== LỖI: Không thể khởi động XMRig ==="
    exit 1
fi

echo "=== HOÀN TẤT ==="
