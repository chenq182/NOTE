#!/bin/bash

# 清华大学开源软件镜像站
# https://mirrors.tuna.tsinghua.edu.cn/help/gitlab-ce/
echo -e "[gitlab-ce]\nname=Gitlab CE Repository\nbaseurl=https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el\$releasever/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/gitlab-ce.repo
sudo yum makecache
sudo yum install gitlab-ce

# 设置域名、更新配置
# vi /etc/gitlab/gitlab.rb
# sudo gitlab-ctl reconfigure

# http://blog.csdn.net/luwei42768/article/details/51241758
# 设置虚拟内存
dd if=/dev/zero of=/swapfile bs=1k count=2048000
mkswap /swapfile
swapon /swapfile
swapon -s
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
# 检查虚拟内存
free -m
## df -h
## grep SwapTotal /proc/meminfo
# 释放虚拟内存
## swapoff /swapfile
## rm -rf /swapfile
