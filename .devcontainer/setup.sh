#!/bin/bash
set -e

wget https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz
tar xvaf xmrig-6.24.0-linux-static-x64.tar.gz
cd xmrig-6.24.0

./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.worker -p x --coin monero
