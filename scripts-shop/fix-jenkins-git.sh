ssh hombros "apt-get install -y git"
ssh hombros "sed 's/#JAVA_ARGS=\"-Xmx256m\"/JAVA_ARGS=\"-Xmx1g\"/g' /etc/default/jenkins > /tmp/jenkins;mv /tmp/jenkins /etc/default/jenkins"
ssh hombros "/etc/init.d/jenkins restart"
scp /opt/Calavera-chef-provision/scripts-shop/deploy.sh cara:/usr/bin
scp /opt/Calavera-chef-provision/scripts-shop/send-statsd-notification.sh brazos:/usr/local/bin/
scp /opt/Calavera-chef-provision/scripts-shop/download_artifactory.sh brazos:/usr/local/bin/
scp /opt/Calavera-chef-provision/scripts-shop/test_integracion.sh brazos:/usr/local/bin/
scp /opt/Calavera-chef-provision/scripts-shop/stress-test.sh brazos:/usr/local/bin/
ssh brazos "apt-get install jmeter"
