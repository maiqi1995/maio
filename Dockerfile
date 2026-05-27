# 使用官方镜像，确保网络拉取顺利
FROM berriai/litellm:main-latest

# 设置工作目录
WORKDIR /app

# 将配置文件放入指定位置
COPY config.yaml /app/config.yaml

# 暴露端口
EXPOSE 4000

# 启动 LiteLLM 代理
CMD ["--config", "/app/config.yaml", "--port", "4000"]