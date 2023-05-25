echo -e "\e[31mInstalling Nginx Server (Robobshop Frontend)\e[0m"
yum install nginx -y

echo -e "\e[32mRemoving Default View of Nginx\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33mCopying RoboShop Frontend Design\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[34mCreating path for roboshop front end\e[om"
cd /usr/share/nginx/html

echo -e "\e[35mUnzipping and Installing the copied roboshop frontend file\e[0m"
unzip /tmp/frontend.zip
# Need to copy roboshop configure file
systemctl enable nginx
systemctl restart nginx