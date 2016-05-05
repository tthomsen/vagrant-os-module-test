#!/bin/bash
yum update -y
yum install git -y

cp -r /vagrant/.ssh /root
chmod 600 /root/.ssh/id_rsa*

#add ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile

rvm install 2.2.3
rvm use 2.2.3 --default

#install gems
gem install bundle
