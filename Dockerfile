FROM tomcat:10.0-jdk17-openjdk-slim

# Purane default apps hatao
RUN rm -rf /usr/local/tomcat/webapps/*

# Step 1: Poora webapp content copy karo (css, images, etc. ke liye)
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Step 2: Kyunki index.jsp 'jspfile' ke andar hai, hum use bahar copy karenge 
# taaki link khulte hi project dikhne lage
RUN cp /usr/local/tomcat/webapps/ROOT/jspfile/index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp

# Permissions fix
RUN chmod -R 777 /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
