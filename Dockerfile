# Step 1: Build stage
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Runtime stage
FROM tomcat:10.1.19-jdk17-openjdk-slim

# Default webapps delete karein
RUN rm -rf /usr/local/tomcat/webapps/*

# Compiled war file ko ROOT.war ke naam se copy karein taaki link direct chale
COPY --from=build /target/ExpenseTracker.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
