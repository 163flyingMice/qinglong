FROM docker.m.daocloud.io/whyour/qinglong:latest
ENV QlPort=80
ENV TZ=Asia/Shanghai
ENV QlBaseUrl=/
ENV ENCRYPTION\_SECRET=QingLong@2026RandomSecret123456
EXPOSE 80