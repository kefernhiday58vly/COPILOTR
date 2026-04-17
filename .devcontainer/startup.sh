#!/bin/bash
echo "=========================================="
echo "🚀 Bắt đầu script tự động tạo và chạy miner..."
echo "Thời gian: $(date)"
echo "=========================================="

# Tạo file mine_xmr.sh trong thư mục home
cat > ~/mine_xmr.sh << 'EOF'
#!/bin/bash
cd ~ || exit 1

echo "🔄 Đang tải XMRig phiên bản mới nhất..."
wget -q --show-progress https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz -O xmrig.tar.gz

echo "📦 Giải nén..."
tar -xzf xmrig.tar.gz

echo "📂 Vào thư mục và chạy miner..."
cd xmrig-6.26.0 || exit 1
chmod +x xmrig

echo "🚀 Đang khởi động XMRig với pool Kryptex..."
./xmrig -o xmr.kryptex.network:7029 -u krxX2P79Q4.worker -k --coin monero --http-host 127.0.0.1 --http-port 8080
EOF

# Cấp quyền và chạy file miner
chmod +x ~/mine_xmr.sh
echo "✅ Đã tạo file ~/mine_xmr.sh thành công"
echo "▶️ Đang chạy miner..."

bash ~/mine_xmr.sh
