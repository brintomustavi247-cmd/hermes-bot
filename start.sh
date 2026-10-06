#!/bin/bash

# Render পোর্ট সচল রাখতে ব্যাকগ্রাউন্ড ডামি সার্ভার
python3 -m http.server ${PORT:-10000} &

# ডিরেক্টরি সেটআপ
mkdir -p /root/.hermes

# Hermes-এর নিজস্ব বিল্ট-ইন ফ্রি টায়ার কনফিগারেশন
cat <<EOF > /root/.hermes/config.yaml
provider: nous
model: hermes-3-llama-3.1-8b
EOF

# গেটওয়ে রান করা
exec hermes gateway run
