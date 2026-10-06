#!/bin/bash

# Render-এর পোর্ট সচল রাখতে ডামি সার্ভার
python3 -m http.server ${PORT:-10000} &

# Hermes কনফিগ ডিরেক্টরি তৈরি
mkdir -p /root/.hermes

# কনফিগ ফাইলে সরাসরি OpenRouter এবং ফ্রি মডেল লিখে দেওয়া
cat <<EOF > /root/.hermes/config.yaml
model: meta-llama/llama-3.3-70b-instruct:free
provider: openrouter
api_keys:
  openrouter: "${OPENROUTER_API_KEY}"
EOF

# গেটওয়ে রান করা
exec hermes gateway run
