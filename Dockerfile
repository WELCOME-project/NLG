FROM tomcat:9.0-jdk11

COPY ./nlg-service/target/nlg-service-0.1.0-SNAPSHOT.war /usr/local/tomcat/webapps/nlg-service.war

EXPOSE 8080
