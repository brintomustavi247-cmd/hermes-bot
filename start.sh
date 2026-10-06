#!/bin/bash

# Render keep-alive server
python3 -m http.server ${PORT:-10000} &

# Purono context clean kora
rm -rf /root/.hermes
mkdir -p /root/.hermes

# Cloudflare Workers AI config (Direct OpenAI compatible format)
cat <<EOF > /root/.hermes/config.yaml
model: @cf/meta/llama-3.1-70b-instruct
provider: custom
base_url: "https://api.cloudflare.com/client/v4/accounts/452d5a6fe120bd0b4eafdc2445b44b16/ai/v1"
api_keys:
  custom: "cfut_ZsB1BWuYssYP5jxv5DsySgjENWoeB4qCymjn8d7Gcb6c66e9"
EOF

# Hermes gateway run
exec hermes gateway run
