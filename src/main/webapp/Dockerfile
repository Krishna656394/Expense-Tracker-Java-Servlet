# Step 1: Use Tomcat 10 base image
FROM tomcat:10.0-jdk17-openjdk-slim

# Step 2: Purane default apps hata dein (Optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Step 3: Aapka webapp folder copy karein
# Aapki image ke hisaab se path 'src/main/webapp' hai
COPY src/main/webapp /usr/local/tomcat/webapps/ROOT

# Step 4: Tomcat start karein
EXPOSE 8080
CMD ["catalina.sh", "run"]