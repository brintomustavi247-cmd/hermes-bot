#!/bin/bash

# Render-এর পোর্ট স্ক্যান তৎক্ষণাৎ সফল করার জন্য ব্যাকগ্রাউন্ডে ওয়েব সার্ভার চালু রাখা
python3 -m http.server ${PORT:-10000} &

# প্রয়োজনীয় লাইব্রেরি ইনস্টল করা
pip install --no-cache-dir "httpx[http2]" discord.py

# গেটওয়ে চালু করা
exec hermes gateway run
