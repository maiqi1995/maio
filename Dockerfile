FROM berriai/litellm:main-latest
COPY config.yaml /app/config.yaml
EXPOSE 4000
CMD ["python", "-m", "litellm", "--config", "/app/config.yaml", "--port", "4000"]