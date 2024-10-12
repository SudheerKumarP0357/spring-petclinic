# Build stage
FROM maven:3.8.5-openjdk-17  AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Run stage
#FROM openjdk:17-jdk-slim
FROM gcr.io/distroless/java17-debian12
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
#CMD ["java", "-jar", "/app/app.jar"]

CMD [ "/app/app.jar" ]
