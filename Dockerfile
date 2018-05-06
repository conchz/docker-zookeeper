FROM openjdk:8-jre-alpine3.7

MAINTAINER Zongzhi Bai <dolphineor@gmail.com>

ADD run.sh /opt/run.sh

RUN apk update && apk --no-cache add curl bash ca-certificates tzdata vim && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

RUN curl -C - -o /tmp/zookeeper-3.4.12.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-3.4.12/zookeeper-3.4.12.tar.gz
RUN tar -xzf /tmp/zookeeper-3.4.12.tar.gz -C /opt

RUN mv /opt/zookeeper-3.4.12 /opt/zookeeper \
	&& cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
	&& rm -f /tmp/zookeeper-3.4.12.tar.gz \
    && mkdir -p /tmp/zookeeper \
    && chmod 0777 /opt/run.sh

ENV ZK_HOME   /opt/zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

CMD ["/opt/run.sh"]
