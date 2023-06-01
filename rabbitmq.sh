echo -e "\e[31mConfigure Erlang repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[32mConfigure RabbitMQ Repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[33mInstall RabbitMQ Server \e[0m"
yum install rabbitmq-server -y

echo -e "\e[34mStart RabbitMQ Service \e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[35mAdd RabbitMQ Application User\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"