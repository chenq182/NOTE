su -
yum install openssh-server
vi /etc/ssh/sshd_config
##### i #####
Port 22
#AddressFamily any
ListenAddress 0.0.0.0
ListenAddress ::

PermitRootLogin no

PasswordAuthentication yes
##### ZZ #####
service sshd start
/bin/systemctl start sshd.service
/bin/systemctl enable sshd.service
