#!/bin/bash

# Render পোর্ট ওপেন রাখা (Render যাতে সার্ভিসকে অফলাইন মনে না করে)
PORT=${PORT:-10000}
python3 -m http.server "$PORT" &

# কনফিগ পাথ ও এনভায়রনমেন্ট ভ্যারিয়েবল ডিক্লেয়ারেশন
API_KEY="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"
MODEL_NAME="meta-llama/llama-3.3-70b-instruct:free"

export OPENROUTER_API_KEY="$API_KEY"
export HERMES_MODEL="$MODEL_NAME"

# রুট ও হোম ডিরেক্টরি কনফিগারেশন
mkdir -p /root/.hermes ~/.hermes

cat <<EOF > /root/.hermes/config.yaml
model: $MODEL_NAME
provider: openrouter
max_tokens: 2048
api_keys:
  openrouter: $API_KEY
EOF

cp /root/.hermes/config.yaml ~/.hermes/config.yaml 2>/dev/null || true

cat <<EOF > /root/.env
OPENROUTER_API_KEY=$API_KEY
HERMES_MODEL=$MODEL_NAME
EOF

cp /root/.env ~/.env 2>/dev/null || true

# ক্র্যাশ প্রতিরোধক লুপ: কোনো কারণে হার্মিস বন্ধ হলে সাথে সাথে আবার চালু হবে
while true; do
  echo "Starting Hermes Gateway..."
  hermes gateway run
  echo "Hermes gateway stopped unexpectedly. Restarting in 5 seconds..."
  sleep 5
done
