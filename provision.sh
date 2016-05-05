#!/bin/bash
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/puppetlabs.repo

#update and install puppet
yum update -y
yum install puppet -y
yum install git -y

#Copy puppet files
cp /vagrant/puppet/hiera.yaml /etc/puppet
cp /vagrant/puppet/Puppetfile /etc/puppet
cp -r /vagrant/.ssh /root
chmod 600 /root/.ssh/id_rsa*
mkdir /etc/puppet/manifests
cp /vagrant/puppet/site.pp /etc/puppet/manifests
cp /vagrant/puppet/common.json /var/lib/hiera

#add ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile

rvm install 2.2.3
rvm use 2.2.3 --default

#install gems
gem install bundle
