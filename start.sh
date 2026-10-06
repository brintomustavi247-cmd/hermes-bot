#!/bin/bash

# Render-এর পোর্ট সক্রিয় রাখার জন্য ব্যাকগ্রাউন্ড ওয়েব সার্ভার
python3 -m http.server ${PORT:-10000} &

# Hermes-এর জন্য OpenRouter প্রোভাইডার এবং ফ্রি মডেল স্বয়ংক্রিয়ভাবে কনফিগার করা
if [ -n "$OPENROUTER_API_KEY" ]; then
    echo "Configuring OpenRouter provider..."
    hermes auth add openrouter "$OPENROUTER_API_KEY" || true
    hermes model set meta-llama/llama-3.3-70b-instruct:free --provider openrouter || true
fi

# গেটওয়ে রান করা
exec hermes gateway run
