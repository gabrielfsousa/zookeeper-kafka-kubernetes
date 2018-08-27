FROM zookeeper:3.4.13

ARG REPO_BASE_URL="http://url.com"
ARG PROMETHEUS_AGENT_VERSION="0.3.1"

 RUN export http_proxy=${http_proxy} \
 && export https_proxy=${http_proxy} \
 && export HTTP_PROXY=${http_proxy} \
 && export HTTPS_PROXY=${http_proxy} \
 && export no_proxy=${no_proxy} \
 && export NO_PROXY=${no_proxy} \
 && mkdir /opt \
 && apk add --no-cache curl bash \
 && curl -o /opt/jmx_prometheus_javaagent-${PROMETHEUS_AGENT_VERSION}.jar ${REPO_BASE_URL}/io/prometheus/jmx/jmx_prometheus_javaagent/${PROMETHEUS_AGENT_VERSION}/jmx_prometheus_javaagent-${PROMETHEUS_AGENT_VERSION}.jar \
 &&	rm -rvf /var/cache/apk/*
 
COPY zoo-jmx.yaml /opt
