FROM openjdk:11-jre-slim
COPY ./target/*.jar /app/app.jar
WPRKDIR /app
ENTRYPOINT 'java -jar app.jar'