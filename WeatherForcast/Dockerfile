# Use Maven to build
FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

# सिर्फ pom.xml और mvnw copy करो
COPY pom.xml mvnw ./

# Dependencies डाउनलोड करो
RUN ./mvnw dependency:go-offline -B || mvn dependency:go-offline -B

# Source code copy करो
COPY src ./src

# Package बनाओ
RUN ./mvnw clean package -DskipTests || mvn clean package -DskipTests

# Final image
FROM openjdk:17-jdk-slim

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

