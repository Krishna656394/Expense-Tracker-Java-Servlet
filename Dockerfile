# Step 1: Build the application using Maven
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the application using Tomcat
FROM tomcat:10.1-jdk17-openjdk-slim
# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy the compiled .war file from the build stage to Tomcat
COPY --from=build /target/ExpenseTracker.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
