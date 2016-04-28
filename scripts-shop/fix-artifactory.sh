ssh hombros "sed 's/Xmx2g/Xmx512m/g' /opt/artifactory-3.5.1/etc/default > /tmp/art;mv /tmp/art /opt/artifactory-3.5.1/etc/default"
ssh hombros "/etc/init.d/artifactory restart"
