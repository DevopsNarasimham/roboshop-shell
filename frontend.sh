echo -e "\e[-e31mInstalling Nginx Server (Robobshop Frontend)\e[0m"
yum install nginx -y

echo -e "\e[-e32Removing Default View of Nginx\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[-e33Copying RoboShop Frontend Design\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[-e34Creating path for roboshop front end\e[om"
cd /usr/share/nginx/html

echo -e "\e[-e35Unzipping and Installing the copied roboshop frontend file\e[0m"
unzip /tmp/frontend.zip
# Need to copy roboshop configure file
systemctl enable nginx
systemctl restart nginx