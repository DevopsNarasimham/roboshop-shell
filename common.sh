color="\e[31m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presetup(){
  echo -e "${color}Add Application User${nocolor}"
  useradd roboshop &>>${log_file}

  echo -e "${color}Remove Old FileDirectory and create Application Directory${nocolor}"
  rm -rf ${app_path} &>>${log_file}
  mkdir ${app_path} &>>${log_file}

  echo -e "${color}Download Application Content${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}

  echo -e "${color}Extract Application Content${nocolor}"
  cd ${app_path} &>>${log_file}
  unzip /tmp/${component}.zip &>>${log_file}

}

systemd_setup(){
  echo -e "${color}Update SystemD Service${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

  echo -e "${color}Start ${component} Service${nocolor}"
    systemctl daemon-reload &>>${log_file}
    systemctl enable ${component} &>>${log_file}
    systemctl restart ${component} &>>${log_file}
}

nodejs() {
  echo -e "${color}Configuring NodeJS Repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

  echo -e "${color}Installing NodeJS Repos${nocolor}"
  yum install nodejs -y &>>${log_file}

  app_presetup

  echo -e "${color}Install NodeJS Dependencies${nocolor}"
  npm install &>>${log_file}

systemd_setup

}

mongo_shchema_setup() {
  echo -e "${color} Copy MongoDB Repo file ${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

  echo -e "${color} Install MongoDB Client ${nocolor}"
  yum install mongodb-org-shell -y &>>${log_file}

  echo -e "${color} Load Schema ${nocolor}"
  mongo --host mongodb-dev.devpractice.site </app/schema/${component}.js &>>${log_file}
}

mysql_schema_setup(){

  echo -e "${color}Install MySQL Client ${nocolor}"
    yum install mysql -y &>>${log_file}

    echo -e "${color}Load Schema ${nocolor}"
    mysql -h mysql-dev.devpractice.site -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql &>>${log_file}

}
maven() {
  echo -e "${color}Install Maven ${nocolor}"
  yum install maven -y &>>${log_file}

  app_presetup

  echo -e "${color}Download Maven Dependencies ${nocolor}"
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

  mysql_schema_setup

  systemd_setup
}

python(){
  echo -e "${color}Install Python${nocolor}"
  yum install python36 gcc python3-devel -y &>>${log_file}

app_presetup

  echo -e "${color}Install Application Dependencies ${nocolor}"
  cd /${app_path} &>>${log_file}
  pip3.6 install -r requirements.txt &>>${log_file}

  systemd_setup

}