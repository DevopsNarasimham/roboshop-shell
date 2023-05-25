echo -e "\e[31mCopy Mongodb Repo File\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstalling Mongodb\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

# Modify the Config file
echo -e "\e[33mStarting Mongodb Service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restrart mongod &>>/tmp/roboshop.log
