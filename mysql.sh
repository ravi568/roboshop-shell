source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ];then  # -z to check whether the variable is empty or not
   echo -e "\e[35m missing mysql root password argument\e[0m"
   exit 1
fi

print_head "disbale Mysql 8 version"
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head "copy mysql repo file"
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
status_check $?

print_head "installing mysql server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "Enabling mysqld systemd service"
systemctl enable mysqld &>>${log_file}
status_check $?


print_head "Starting mysqld systemd service"
systemctl restart mysqld &>>${log_file}
status_check $?


print_head "set root password"
echo show databases | mysql -uroot -p${mysql_root_password} &>>${log_file}
if [ $? -ne 0 ]; then
  mysql_secure_installation --set-root-pass ${mysql_root_password} &>>${log_file}
fi
status_check $?