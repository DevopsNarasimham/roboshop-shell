echo -e "\e[31mConfiguring NodeJS Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[32mInstall NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[34mCreate Application Directory \e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[35mDownload Application Content\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[36mExtract Application Content\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[31mInstall NodeJS Dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[32mSetup SystemD Service  \e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[33mStart User Service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl start user &>>/tmp/roboshop.log

echo -e "\e[34mCopy MongoDB Repo file \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[35mInstall MongoDB Client \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[36mLoad Schema \e[0m"
mongo --host mongo-dev.devpractice.site </app/schema/user.js &>>/tmp/roboshop.log