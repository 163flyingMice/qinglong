FROM ccr.ccs.tencentyun.com/xxx/qinglong:latest
ENV QlPort=80
ENV TZ=Asia/Shanghai
ENV QlBaseUrl=/
# 新增关键加密密钥，会话持久化必备（自定义一串随机字符）
ENV ENCRYPTION\_SECRET=QingLong@2026RandomSecret123456
EXPOSE 80