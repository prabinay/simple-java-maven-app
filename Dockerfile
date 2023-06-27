# Use a base image with Java and Maven pre-installed
FROM maven:3.9.0-openjdk-11-slim AS build

# Set the working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the Maven project
RUN mvn package

# Use a lightweight base image for the final image
FROM adoptopenjdk/openjdk11:alpine-jre

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/simple-java-maven-app.jar app.jar

# Set the command to run your application
CMD ["java", "-jar", "app.jar"]
