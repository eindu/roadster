FROM ubuntu:24.04
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-8.5.100
ENV PATH=$PATH:$TOMCAT_HOME/bin

RUN apt update -y
RUN apt install -y openjdk-17-jdk
RUN apt install -y curl
RUN mkdir -p /u01/middleware
WORKDIR /u01/middleware
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.100/bin/apache-tomcat-8.5.100.tar.gz .
RUN tar -xzvf apache-tomcat-8.5.100.tar.gz
RUN rm apache-tomcat-8.5.100.tar.gz

COPY target/roadster.war apache-tomcat-8.5.100/webapps/
COPY run.sh apache-tomcat-8.5.100/bin/
RUN chmod u+x apache-tomcat-8.5.100/bin/run.sh
EXPOSE 8080
#HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl --fail http://localhost:8080/roadster/actuator/health/liveness || exit 1
ENTRYPOINT [ "apache-tomcat-8.5.100/bin/run.sh" ]


