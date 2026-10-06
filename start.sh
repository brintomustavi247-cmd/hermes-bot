#!/bin/bash
set -e

# Render keep-alive server
python3 -m http.server ${PORT:-10000} &

# সব সম্ভাব্য হোম/ইউজার ডিরেক্টরি চিহ্নিত করা
export HOME=/root
mkdir -p /root/.hermes
mkdir -p ~/.hermes

API_KEY="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"
MODEL_NAME="meta-llama/llama-3.3-70b-instruct:free"

# 1. ~/.env ফাইলে সেট করা
cat <<EOF > /root/.env
OPENROUTER_API_KEY=${API_KEY}
HERMES_MODEL=${MODEL_NAME}
EOF
cp /root/.env ~/.env 2>/dev/null || true

# 2. config.yaml তৈরি করা
cat <<EOF > /root/.hermes/config.yaml
model: ${MODEL_NAME}
provider: openrouter
max_tokens: 2048
api_keys:
  openrouter: ${API_KEY}
EOF
cp -r /root/.hermes/* ~/.hermes/ 2>/dev/null || true

# 3. এনভায়রনমেন্ট ভ্যারিয়েবল এক্সপোর্ট করা
export OPENROUTER_API_KEY="${API_KEY}"
export HERMES_MODEL="${MODEL_NAME}"

# 4. গেটওয়ে চালু করা
exec hermes gateway run
