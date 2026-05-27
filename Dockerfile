# 使用官方镜像，确保网络拉取顺利
FROM berriai/litellm:main-latest

# 设置工作目录
WORKDIR /app

# 将配置文件放入指定位置
COPY config.yaml /app/config.yaml

# 暴露端口
EXPOSE 4000

# 直接启动 LiteLLM 代理，明确指定配置文件和端口
# 使用 python -m 模块加载方式比直接运行 litellm 二进制更稳定
CMD ["python", "-m", "litellm.proxy.proxy_server", "--config", "/app/config.yaml", "--port", "4000"]