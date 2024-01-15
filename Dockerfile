# Stage 1: Build Maven Dependencies
FROM maven:3.8.4-openjdk-17-slim AS builder

WORKDIR /app
COPY . /app
RUN mvn dependency:go-offline



# Build the application
RUN mvn clean package

# Stage 2: Create Final Image
FROM tomcat:jdk17

# Copy the built artifact from the builder stage
COPY --from=builder /app /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]

WORKDIR /usr/local/tomcat/webapps/target

CMD ["java","-jar","hello-world-0.0.1-SNAPSHOT.war"]


