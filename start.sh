#!/bin/bash

# Render-এর পোর্ট সক্রিয় রাখতে ডামি সার্ভার
python3 -m http.server ${PORT:-10000} &

# Cloudflare Workers AI প্রোভাইডার কনফিগারেশন
if [ -n "$CLOUDFLARE_API_TOKEN" ] && [ -n "$CLOUDFLARE_ACCOUNT_ID" ]; then
    echo "Configuring Cloudflare Workers AI..."
    hermes auth add cloudflare "$CLOUDFLARE_API_TOKEN" || true
    hermes model set @cf/meta/llama-3.1-70b-instruct --provider cloudflare || true
fi

# গেটওয়ে রান করা
exec hermes gateway run
