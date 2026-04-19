FROM tomcat:10.0-jdk17-openjdk-slim

# Default apps hatao
RUN rm -rf /usr/local/tomcat/webapps/*

# Aapke structure ke hisaab se path ye hai
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Permissions sahi karo (Optional but safe)
RUN chmod -R 777 /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
