source common.sh

print_head "configure nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
status_check $?

print_head "installing nodejs"
yum install nodejs -y &>>${log_file}
status_check $?
print_head " create roboshop user"
useradd roboshop &>>${log_file}
status_check $?

print_head "making application Directory"
mkdir /app &>>${log_file}
status_check $?

print_head "Removing old content"
rm -rf /app/* &>>${log_file}
status_check $?

print_head "Downloading app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
status_check $?
cd /app

print_head "Exctarcting app content"
unzip /tmp/catalogue.zip &>>${log_file}
status_check $?

print_head "installing nodejs dependencies"
npm install &>>${log_file}
status_check $?

print_head "copying systemd service file of catalogue"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}
status_check $?

print_head "Reloading the systemd service"
systemctl daemon-reload &>>${log_file}
status_check $?
print_head "enable catalogue"
systemctl enable catalogue &>>${log_file}
status_check $?
print_head "start catalogue"
systemctl restart catalogue &>>${log_file}
status_check $?

print_head "copying monogdb repository"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
status_check $?

print_head "installing mongodb client"
yum install mongodb-org-shell -y &>>${log_file}
status_check $?
print_head "Load schema"
mongo --host mongodb.kalluriravidevops71.online</app/schema/catalogue.js &>>${log_file}
status_check $?
