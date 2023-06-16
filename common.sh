color="\e[31m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

nodejs() {
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
}

mongo_shchema_setup() {
  echo -e "\e[34mCopy MongoDB Repo file \e[0m"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

  echo -e "\e[35mInstall MongoDB Client \e[0m"
  yum install mongodb-org-shell -y &>>/tmp/roboshop.log

  echo -e "\e[36mLoad Schema \e[0m"
  mongo --host mongodb-dev.devpractice.site </app/schema/user.js &>>/tmp/roboshop.log
}