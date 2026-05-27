# 注意：LiteLLM 的最新公开规范源应该使用 ghcr.io/berriai/litellm:main-latest
FROM ghcr.io/berriai/litellm:main-latest

# 将本地同目录下的 config.yaml 复制到容器的 /app 目录下
COPY config.yaml /app/config.yaml

# 暴露 4000 端口
EXPOSE 4000

# 启动命令：指定读取刚刚 COPY 进去的配置文件
CMD ["--config", "/app/config.yaml", "--port", "4000", "--host", "0.0.0.0"]