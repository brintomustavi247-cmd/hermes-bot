FROM python:3.11-slim

RUN apt-get update && apt-get install -y curl git ca-certificates && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

ENV PATH="/root/.local/bin:${PATH}"

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
