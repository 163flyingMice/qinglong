# 使用国内加速镜像源，避免海外拉取超时
FROM docker.xuanyuan.me/whyour/qinglong:latest

# 修改监听端口为80，时区
ENV QlPort=80
ENV TZ=Asia/Shanghai
ENV QlBaseUrl=/

EXPOSE 80
