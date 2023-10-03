FROM --platform=linux/amd64 openjdk:17-alpine
COPY ./target/aws-events-service-0.0.1-SNAPSHOT.jar service.jar
EXPOSE 8080
ENV CONFIG_ENV=backup
ENTRYPOINT java -jar -Dspring.profiles.active=${CONFIG_ENV} service.jar