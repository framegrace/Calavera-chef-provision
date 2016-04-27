ssh hombros "apt-get install -y git"
scp /opt/Calavera-chef-provision/scripts-shop/deploy.sh cara:/usr/bin
scp /opt/Calavera-chef-provision/scripts-shop/send-statsd-notification.sh brazos:/usr/local/bin/
scp /opt/Calavera-chef-provision/scripts-shop/download_artifactory.sh brazos:/usr/local/bin/
scp /opt/Calavera-chef-provision/scripts-shop/test_integracion.sh brazos:/usr/local/bin/
