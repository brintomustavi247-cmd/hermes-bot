#!/bin/bash

# Render keep-alive
python3 -m http.server ${PORT:-10000} &

# Hermes ডিরেক্টরি সেটআপ
mkdir -p /root/.hermes

# Nous ফ্রি মডেল কনফিগারেশন
cat <<EOF > /root/.hermes/config.yaml
provider: nous
model: hermes-3-llama-3.1-8b
EOF

# গেটওয়ে রান করা
exec hermes gateway run
