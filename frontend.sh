 code_dir=$(pwd)
 log_file=/tmp/roboshop.log
 rm -f ${log_file}

print_head(){

  echo -e "\e[36m$1\e[0m"
}

 print_head "installing nginx"
 yum install nginx -y &>>${log_file}

 print_head "Removing old content"
 rm -rf /usr/share/nginx/html/* &>>${log_file}

 print_head "Downloading frontend content from browser"
 curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}

 print_head "Extracting downloaded Frontend"
 cd /usr/share/nginx/html
 unzip /tmp/frontend.zip &>>${log_file}

 print_head "Copying nginx config for roboshop"
 cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

 print_head "Enabling nginx"
 systemctl enable nginx &>>${log_file}
 print_head "Restarting nginx"
 systemctl restart nginx &>>${log_file}


 ## if any command is errored or failed , we need to stop the script