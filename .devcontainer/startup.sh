cat > ~/mine_xmr.sh << 'EOF'
#!/bin/bash

# Script đào XMR trên Kryptex (tự động tải + chạy)
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
