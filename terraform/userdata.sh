#!/bin/bash
yum update -y
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git

cd /home/ec2-user
git clone https://github.com/poojan010/terraform-ec2-blog-app.git blog-app

cd blog-app
npm install
nohup node index.js > app.log 2>&1 &
