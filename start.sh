#!/bin/bash
# হার্মিস গেটওয়ে ব্যাকগ্রাউন্ডে রান করা
hermes gateway run &

# রেন্ডারের পোর্ট স্ক্যান পাস করানোর জন্য পোর্ট লিসেন করা
python3 -m http.server ${PORT:-10000}
