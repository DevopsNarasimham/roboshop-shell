echo -e "\e[31mConfiguring NodeJS Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m Install NodeJS\e[0m"
yum install nodejs -y

echo -e "\e[33m Add Application User\e[0m"
useradd roboshop

echo -e "\e[34m Create Application Directory \e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[35m Download Application Content\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[36m Extract Application Content\e[0m"
unzip /tmp/user.zip
cd /app

echo -e "\e[31m Install NodeJS Dependencies\e[0m"
npm install

echo -e "\e[32m Setup SystemD Service  \e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[33m Start User Service \e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user

echo -e "\e[34m Copy MongoDB Repo file \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[35m Install MongoDB Client \e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m Load Schema \e[0m"
mongo --host mongo-dev.devpractice.site </app/schema/user.js