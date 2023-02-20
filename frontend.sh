 source common.sh

 print_head "installing nginx"
 yum install nginxx -y &>>${log_file}
 status_check $?


 print_head "Removing old content"
 rm -rf /usr/share/nginx/html/* &>>${log_file}
 status_check $?

 print_head "Downloading frontend content from browser"
 curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
 status_check $?

 print_head "Extracting downloaded Frontend"
 cd /usr/share/nginx/html
 unzip /tmp/frontend.zip &>>${log_file}
 status_check $?

 print_head "Copying nginx config for roboshop"
 cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
 status_check $?

 print_head "Enabling nginx"
 systemctl enable nginx &>>${log_file}
 status_check $?

  print_head "Restarting nginx"
 systemctl restart nginx &>>${log_file}
 status_check $?


 ## if any command is errored or failed , we need to stop the script