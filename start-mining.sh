#!/bin/bash
# ================================================
# XMRIG MINER FIXED - HashVault Pool (TLS + Fingerprint)
# ================================================

echo "🚀 Đang setup XMRig Monero Miner - HashVault..."

# Cài gói
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y curl wget tar screen > /dev/null 2>&1

# Tạo thư mục
mkdir -p ~/xmrig-miner
cd ~/xmrig-miner

# Tải XMRig
echo "📥 Đang tải XMRig v6.26.0..."
wget -q https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz -O xmrig.tar.gz

tar -xzf xmrig.tar.gz
rm xmrig.tar.gz
cd xmrig-6.26.0-linux-static-x64

chmod +x xmrig

# Tạo config.json theo lệnh bạn đưa
cat > config.json << 'EOF'
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "donate-level": 1,
    "log-file": "miner.log",
    "pools": [
        {
            "algo": "rx/0",
            "coin": "monero",
            "url": "pool.hashvault.pro:443",
            "user": "82tvM9cdwYieKVPKCHx6TJVKbekciy3hSGr54XDEYNYt6atNYkGSeeSS9qrVyjjrufMeyTaiBBTAWFuZG11gdKMc1a31YMG",
            "pass": "x",
            "keepalive": true,
            "tls": true,
            "tls-fingerprint": "420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14"
        }
    ],
    "randomx": {
        "1gb-pages": false,
        "huge-pages": true,
        "mode": "auto",
        "init": -1
    }
}
EOF

# Bật huge pages
echo "🔧 Đang bật Huge Pages..."
sudo sysctl -w vm.nr_hugepages=1280 > /dev/null 2>&1 || echo "⚠️ Không bật được huge pages (container limit)"

# Dừng session cũ
screen -S xmrig -X quit 2>/dev/null || true

# Chạy miner
echo "🔥 Khởi động mining trên HashVault..."
screen -dmS xmrig ./xmrig -c config.json

echo "✅ Mining đã khởi động!"

# Kiểm tra sau 10 giây
sleep 10
if screen -list | grep -q "xmrig"; then
    echo "✅ Miner đang chạy ổn định!"
    echo ""
    echo "📌 CÁCH DÙNG:"
    echo "   • Xem log realtime:          screen -r xmrig"
    echo "   • Thoát log (không tắt miner): Ctrl + A rồi D"
    echo "   • Dừng mining:               screen -S xmrig -X quit"
    echo "   • Xem log file:              cat miner.log | tail -n 30"
else
    echo "❌ Miner không chạy. Paste lại screen -r xmrig và gửi log cho mình."
fi
