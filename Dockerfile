FROM docker.m.daocloud.io/whyour/qinglong:latest
ENV QlPort=80
ENV TZ=Asia/Shanghai
ENV QlBaseUrl=/
ENV ENCRYPTION\_SECRET=QingLong@2026CloudBaseQL123456789abc
ENV QL\_HTTPS\_REVERSE=true

# 构建阶段预先安装常用Python依赖
RUN pip3 install requests aiohttp pycryptodome bs4
# 预先安装常用Node依赖
RUN npm install -g superagent crypto-js jsencrypt

EXPOSE 80