#!/bin/bash

# মিসিং ডিপেন্ডেন্সি ইনস্টল করা
pip install --no-cache-dir httpx[http2] discord.py

# পাইপ ব্রোকেন হওয়া ঠেকাতে nohup দিয়ে হার্মিস গেটওয়ে ব্যাকগ্রাউন্ডে রান রাখা
nohup hermes gateway run > hermes.log 2>&1 &

# রেন্ডারের পোর্ট স্ক্যান সন্তুষ্ট রাখার জন্য ওয়েব সার্ভার
python3 -m http.server ${PORT:-10000}
