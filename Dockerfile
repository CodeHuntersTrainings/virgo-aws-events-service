FROM --platform=linux/amd64 openjdk:17-alpine
COPY ???
EXPOSE ???
ENV CONFIG_ENV=backup
ENTRYPOINT java -jar -Dspring.profiles.active=${CONFIG_ENV} service.jar