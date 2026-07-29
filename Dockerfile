FROM docker.m.daocloud.io/whyour/qinglong:latest

ENV QlPort=80
ENV TZ=Asia/Shanghai
ENV QlBaseUrl=/
ENV ENCRYPTION_SECRET=QingLong@2026CloudBaseQL123456789abc
ENV QL_HTTPS_REVERSE=true

# 持久化相关（备份目录 / 首启恢复开关，可在云托管环境变量中覆盖）
ENV QL_BACKUP_DIR=/ql/backup
ENV QL_RESTORE_ON_BOOT=false
ENV QL_BACKUP_KEEP=10

COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY backup_qinglong.sh /usr/bin/backup_qinglong.sh

RUN chmod +x /usr/bin/entrypoint.sh /usr/bin/backup_qinglong.sh \
 && pip3 install requests aiohttp pycryptodome bs4 \
 && npm install -g superagent crypto-js jsencrypt

VOLUME ["/ql/data"]
EXPOSE 80
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
