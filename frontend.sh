echo -e "\e[31mInstalling Nginx Server (Robobshop Frontend)\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[32mRemoving Default View of Nginx\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[33mCopying RoboShop Frontend Design\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[34mCreating path for roboshop front end\e[0m"
cd /usr/share/nginx/html &>>/tmp/roboshop.log

echo -e "\e[35mUnzipping and Installing the copied roboshop frontend file\e[0m"
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[33mStarting Nginx Service\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log