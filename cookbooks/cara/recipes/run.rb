# Let that for later
remote_file "/var/lib/tomcat6/webapps/ROOT/WEB-INF/lib/CalaveraMain.jar" do
  source "http://espina:8081/artifactory/simple/ext-release-local/Calavera/target/CalaveraMain.jar"
  mode '0755'
  checksum "3a7dac00b1" # A SHA256 (or portion thereof) of the file.
end

remote_file "/var/lib/tomcat6/webapps/ROOT/WEB-INF/web.xml" do
  source "http://espina:8081/artifactory/simple/ext-release-local/Calavera/target/web.xml"
  mode '0755'
  checksum "3a7dac00b1" # A SHA256 (or portion thereof) of the file.
end

cookbook_file "deploy.sudo" do
  path "/etc/sudoers.d/deploy"
  mode 0755
  user "root"
  group "root"
  action :create
end



service "tomcat6" do
  action :restart
end
