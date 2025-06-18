#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -xe

# Update system packages
yum update -y

# Install Node.js and Git
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git

# Switch to home directory
cd /home/ec2-user

# Clone the Git repo 
git clone https://github.com/poojan010/terraform-ec2-blog-app.git blog-app

# Change to app directory
cd blog-app/blog-app

# Install Node.js dependencies
npm install

# Start the app on port 3000 (runs in background)
nohup node index.js > app.log 2>&1 &
