echo -e "\e[31mInstall Python\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[32mAdd Application User \e[0m"
useradd roboshop

echo -e "\e[33mCreate Application Directory\e[0m"
mkdir /app

echo -e "\e[34mDownload Application Content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[35mExtract Application Content \e[0m"
unzip /tmp/payment.zip

echo -e "\e[36mInstall Application Dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt

echo -e "\e[31mSetup SystemD File \e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[32mStart Payment Serrvice \e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
