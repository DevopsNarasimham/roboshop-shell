echo -e "\e[31mCopy Mongodb Repo File\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32mInstalling Mongodb\e[0m"
yum install mongodb-org -y

# Modify the Config file
echo -e "\e[33mStarting Mongodb Service\e[0m"
systemctl enable mongod
systemctl restrart mongod
