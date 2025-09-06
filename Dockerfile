
FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0
ENV MODEL=gemma2:2b

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 11434

ENTRYPOINT ["/start.sh"]