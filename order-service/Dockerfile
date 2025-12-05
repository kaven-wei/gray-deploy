# 使用 Eclipse Temurin JRE 17 Alpine 版本作为基础镜像
# Alpine 版本很小，但需要安装额外的工具
FROM eclipse-temurin:17-jre-alpine

# 安装 curl 和 iputils (包含 ping 命令)
RUN apk add --no-cache curl iputils

# 设置工作目录
WORKDIR /app

# 设置时区为上海
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

# 复制 JAR 文件到容器
# 假设 JAR 文件在 target 目录下
COPY target/order-service-*.jar app.jar

# 暴露服务端口
EXPOSE 8082

# 设置 JVM 参数
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -XX:MaxGCPauseMillis=200"

# 启动应用
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar"]
