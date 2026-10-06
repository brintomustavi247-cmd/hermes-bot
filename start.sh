#!/bin/bash

# Render-এর পোর্ট সচল রাখতে ব্যাকগ্রাউন্ড ডামি সার্ভার
python3 -m http.server ${PORT:-10000} &

# Hermes কনফিগ ফোল্ডার তৈরি
mkdir -p /root/.hermes

# Cloudflare Workers AI এর জন্য config.yaml ফাইল জেনারেট করা
cat <<EOF > /root/.hermes/config.yaml
model: @cf/meta/llama-3.1-70b-instruct
provider: custom
base_url: "https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/ai/v1"
api_keys:
  custom: "${CLOUDFLARE_API_TOKEN}"
EOF

# গেটওয়ে রান করা
exec hermes gateway run
