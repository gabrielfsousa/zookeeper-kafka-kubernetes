FROM itsqd/alpine-openjdk8:1.0

ARG KAFKA_VERSION="2.0.0"
ARG SCALA_VERSION="2.11"
ARG KAFKA_HOME="/opt/kafka"
ARG KAFKA_BASE_URL="http://mirrors.up.pt/pub/apache/kafka/${KAFKA_VERSION}/"
ARG KAFKA_FILE="kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"

RUN addgroup kafka \
 && adduser -S -G kafka kafka
	  
RUN export http_proxy=${http_proxy} \
 && export https_proxy=${http_proxy} \
 && export HTTP_PROXY=${http_proxy} \
 && export HTTPS_PROXY=${http_proxy} \
 && export no_proxy=${no_proxy} \
 && export NO_PROXY=${no_proxy} \
 && apk update \
 && apk add --no-cache curl bash \
 &&	rm -rvf /var/cache/apk/* \
 && curl -L -o /tmp/${KAFKA_FILE} ${KAFKA_BASE_URL}/${KAFKA_FILE} \
 &&	tar xfz /tmp/${KAFKA_FILE} -C /opt \
 && rm /tmp/${KAFKA_FILE} \
 && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka \
 && chown -R kafka:kafka /opt/

VOLUME /opt/kafka/config

EXPOSE 9092 9093 9094 5555

COPY docker-entrypoint.sh /entrypoint.sh
COPY kafka-jmx.yaml /opt
RUN chmod +x /entrypoint.sh
USER kafka
ENTRYPOINT ["/entrypoint.sh"]

ENV PATH=${PATH}:${KAFKA_HOME}/bin

CMD ["kafka-server-start.sh","/opt/kafka/config/server.properties"]
