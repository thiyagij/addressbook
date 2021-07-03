FROM tomcat
MAINTAINER dilip
ADD target/addressbook-2.0.war /usr/local/tomcat/webapps
EXPOSE 8080
ENTRYPOINT ["catalina.sh","run"]
