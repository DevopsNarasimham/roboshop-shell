echo -e "\e[31mInstall GoLang \e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[32mAdd application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mLets setup an app directory \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34mDownload the application code to created app directory \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[35mLets download the dependencies & build the software \e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[36mSetup SystemD Payment Service \e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[31mLoad and start the service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log