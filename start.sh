#!/bin/bash

# Render-এর পোর্ট সক্রিয় রাখতে ব্যাকগ্রাউন্ডে ডামি ওয়েব সার্ভার
python3 -m http.server ${PORT:-10000} &

# হার্মিসের নিজস্ব অভ্যন্তরীণ Python-এ সরাসরি httpx এবং discord.py ইনস্টল করা
HERMES_PIP=$(find /root/.hermes -name pip -type f | head -n 1)
if [ -n "$HERMES_PIP" ]; then
    $HERMES_PIP install --no-cache-dir "httpx[http2]" discord.py
fi

# ডকারের মূল ডিসপ্যাচার দিয়ে গেটওয়ে চালু করা যাতে প্রসেস হ্যাং না হয়
if [ -f "docker/entrypoint-dispatch.sh" ]; then
    exec bash docker/entrypoint-dispatch.sh gateway run
else
    exec hermes gateway run
fi
