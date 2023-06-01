echo -e "\e[31mInstall Maven \e[0m"
yum install maven -y

echo -e "\e[32mAdd Application User \e[0m"
useradd roboshop

echo -e "\e[33mCreate Application Directory \e[0m"
rm -rf /app   &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[34mDownload Application Content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[35mExtract Application Content \e[0m"
cd /app
unzip /tmp/shipping.zip

echo -e "\e[36mDownload Maven Dependencies \e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[31mSetup SystemD File \e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[32mInstall MySQL Client \e[0m"
yum install mysql -y

echo -e "\e[33mLoad Schema \e[0m"
mysql -h mysql-dev.devpractice.site -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[34mStart Shipping Service \e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping