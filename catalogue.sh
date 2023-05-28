 echo -e "\e[31mConfiguring NodeJS Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[32mInstalling NodeJS Repos\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[36mRemove Old FileDirectory and create Application Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34mDownload Application Content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[35mExtract Application Content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[36mInstall NodeJS Dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[31mUpdate SystemD Service\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[32mStart Catalogue Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[33mCopy Mongodb Repo File\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[34mInstall Mongodb \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[35mLoad Mongodb Schema \e[0m"
mongo --host mongodb-dev.devpractice.site </app/schema/catalogue.js &>>/tmp/roboshop.log