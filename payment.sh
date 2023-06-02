echo -e "\e[31mInstall Python\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[32mAdd Application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCreate Application Directory\e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34mDownload Application Content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[35mExtract Application Content \e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[36mInstall Application Dependencies \e[0m"
cd /app &>>/tmp/roboshop.log
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[31mSetup SystemD File \e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[32mStart Payment Serrvice \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log
