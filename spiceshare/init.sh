#!/bin/bash
yum update
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y git python35u python35u-libs python35u-devel python35u-pip

git clone https://github.com/takeshe12/spiceshare.git
cd spiceshare
pip3.5 install -r requirements.txt

yum remove mongodb
cat << EOF > /etc/yum.repos.d/mongodb.repo
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
EOF
yum install -y mongodb-org
systemctl start mongod
python3.5 spiceshare/app.py &
