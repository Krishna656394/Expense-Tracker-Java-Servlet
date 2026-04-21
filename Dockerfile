# Step 1: Build stage (Ise mat chhedna)
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Runtime stage (Sirf ye line badli hai)
FROM tomcat:10.1-jdk17-openjdk-slim

# Baki sab same rahega
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /target/ExpenseTracker.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
