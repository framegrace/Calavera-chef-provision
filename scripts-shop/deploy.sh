#!/bin/bash
cd /var/lib/tomcat6/webapps/ROOT/WEB-INF/lib/
rm CalaveraMain.*
wget "http://espina:8081/artifactory/simple/ext-release-local/Calavera/target/CalaveraMain.jar" -O CalaveraMain.jar
cd /var/lib/tomcat6/webapps/ROOT/WEB-INF/
rm web.xml*
wget "http://espina:8081/artifactory/simple/ext-release-local/Calavera/target/web.xml" -O web.xml
sudo /etc/init.d/tomcat6 restart
