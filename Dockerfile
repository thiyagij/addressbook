FROM tomcat:8
MAINTAINER dilip
ADD /home/jenkins/workspace/ttt/target/addressbook-2.0.war /usr/local/tomcat/webapps
EXPOSE 8080
ENTRYPOINT ["catalina.sh","run"]
