# Use a image with Maven and Java installed
# FROM maven:3.8.4-openjdk-11
FROM docker.io/maven:3.9.0-openjdk-11


# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the Maven project
RUN mvn clean package

# Set the entry point for the container
CMD ["java", "-cp", "target/classes", "com.mycompany.app.App"]
