#!/bin/bash
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/puppetlabs.repo

## A reasonable PATH
#echo "export PATH=$PATH:/usr/local/bin:/opt/puppet/bin" >> /etc/bashrc
yum update -y
yum install puppet -y
yum install git -y

cp /vagrant/puppet/hiera.yaml /etc/puppet
cp /vagrant/puppet/Puppetfile /etc/puppet
cp -r /vagrant/.ssh /root
chmod 600 /root/.ssh/id_rsa*
mkdir /etc/puppet/manifests
cp /vagrant/puppet/site.pp /etc/puppet/manifests
cp /vagrant/puppet/common.json /var/lib/hiera

gem install r10k

PUPPETFILE=/etc/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules r10k puppetfile install --verbose debug2 --color

puppet apply /etc/puppet/manifests/site.pp
