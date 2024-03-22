# Use an official OpenJDK runtime as a parent image
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory to /app
WORKDIR /app

# Copy the JAR file into the container at /app
COPY target/SrpingBootProject-1.0-SNAPSHOT.jar app.jar

# Specify the command to run on container start
CMD ["java", "-jar", "app.jar"]

EXPOSE 8082
