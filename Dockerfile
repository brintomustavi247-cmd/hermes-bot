FROM nousresearch/hermes-agent:latest

USER root

# সিস্টেম এবং সব পাইথন এনভায়রনমেন্টে একবারে প্যাকেজগুলো স্থায়ীভাবে ইনস্টল করা
RUN pip install --no-cache-dir httpx[http2] discord.py || true
RUN find /root -name pip -exec {} install --no-cache-dir httpx[http2] discord.py \; 2>/dev/null || true

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 10000

ENTRYPOINT ["/bin/bash", "/start.sh"]
