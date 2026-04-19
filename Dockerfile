FROM tomcat:10.0-jdk17-openjdk-slim

# 1. Tomcat ke default apps ko delete karein
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Poore webapp folder ko ROOT mein copy karein (Isse cssfile, image, META-INF, WEB-INF chale jayenge)
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# 3. JSP files jo 'jspfile' folder ke andar hain, unhe ROOT ke bahar copy karein 
# taaki paths simple ho jayein (index.jsp, login.jsp etc. ab direct khulenge)
RUN cp -r /usr/local/tomcat/webapps/ROOT/jspfile/* /usr/local/tomcat/webapps/ROOT/

# 4. Permissions set karein
RUN chmod -R 777 /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
