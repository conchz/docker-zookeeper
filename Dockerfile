FROM ubuntu:16.04

MAINTAINER Zongzhi Bai "dolphineor@gmail.com"

ADD jdk-8u101-linux-x64.tar.gz /usr/lib/jvm
ADD zookeeper-3.4.8.tar.gz /opt
ADD run.sh /opt/run.sh

RUN mv /usr/lib/jvm/jdk1.8.0_101 /usr/lib/jvm/oracle-jdk8 \
	&& mv /opt/zookeeper-3.4.8 /opt/zookeeper \
	&& cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
	&& rm -f /tmp/zookeeper-3.4.8.tar.gz \
	&& rm -f /tmp/jdk-8u101-linux-x64.tar.gz \
    && mkdir -p /tmp/zookeeper \
    && chmod 0777 /opt/run.sh

ENV JAVA_HOME /usr/lib/jvm/oracle-jdk8
ENV ZK_HOME   /opt/zookeeper
ENV PATH      $JAVA_HOME/bin:$PATH

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

CMD ["/opt/run.sh"]
