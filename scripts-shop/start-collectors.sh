ssh manos "apt-get -y install collectl;killall collectl;nohup collectl --export graphite,monitor.calavera.biz >/dev/null 2>&1 &"
ssh cara "apt-get -y install collectl;killall collectl;nohup collectl --export graphite,monitor.calavera.biz >/dev/null 2>&1 &"
ssh espina "apt-get -y install collectl;killall collectl;nohup collectl --export graphite,monitor.calavera.biz >/dev/null 2>&1 &"
ssh hombros "apt-get -y install collectl;killall collectl;nohup collectl --export graphite,monitor.calavera.biz >/dev/null 2>&1 &"
ssh cerebro "apt-get -y install collectl;killall collectl;nohup collectl --export graphite,monitor.calavera.biz >/dev/null 2>&1 &"
ssh brazos "apt-get -y install collectl;killall collectl;nohup collectl --export graphite,monitor.calavera.biz >/dev/null 2>&1 &"