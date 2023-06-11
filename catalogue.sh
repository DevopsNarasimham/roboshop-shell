source common.sh
component=catalogue

echo -e "${color}Configuring NodeJS Repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color}Installing NodeJS Repos${nocolor}"
yum install nodejs -y &>>${log_file}

echo -e "${color}Add Application User${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color}Remove Old FileDirectory and create Application Directory${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${color}Download Application Content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path} &>>${log_file}

echo -e "${color}Extract Application Content${nocolor}"
unzip /tmp/${component}.zip &>>${log_file}
cd ${app_path} &>>${log_file}

echo -e "${color}Install NodeJS Dependencies${nocolor}"
npm install &>>${log_file}

echo -e "${color}Update SystemD Service${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

echo -e "${color}Start ${component} Service${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}

echo -e "${color}Copy Mongodb Repo File${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

echo -e "${color}Install Mongodb ${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color}Load Mongodb Schema ${nocolor}"
mongo --host mongodb-dev.devpractice.site <${app_path}/schema/${component}.js &>>${log_file}