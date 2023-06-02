echo -e "\e[31mInstall GoLang \e[0m"
yum install golang -y

echo -e "\e[32mAdd application User \e[0m"
useradd roboshop

echo -e "\e[33mLets setup an app directory \e[0m"
mkdir /app

echo -e "\e[34mDownload the application code to created app directory \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[35mLets download the dependencies & build the software \e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[36mSetup SystemD Payment Service \e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[31mLoad and start the service \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch