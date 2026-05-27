# 显式使用 ghcr.io 官方源，这通常不会触发权限拒绝
FROM ghcr.io/berriai/litellm:main-latest

# 将本地配置文件复制进去
COPY config.yaml /app/config.yaml

# 暴露端口
EXPOSE 4000

# 启动命令：这里不需要加 host，Railway 自动管理，越简单越好
CMD ["--config", "/app/config.yaml", "--port", "4000"]