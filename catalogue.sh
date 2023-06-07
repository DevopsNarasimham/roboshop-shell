component=catalogue
color="\e[31m"
nocolor="\e[0m"

echo -e "${color}Configuring NodeJS Repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color}Installing NodeJS Repos${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Add Application User${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}Remove Old FileDirectory and create Application Directory${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log


echo -e "${color}Download Application Content${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "${color}Extract Application Content${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "${color}Install NodeJS Dependencies${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color}Update SystemD Service${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "${color}Start $component Service${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log

echo -e "${color}Copy Mongodb Repo File${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "${color}Install Mongodb ${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color}Load Mongodb Schema ${nocolor}"
mongo --host mongodb-dev.devpractice.site </app/schema/$component.js &>>/tmp/roboshop.log