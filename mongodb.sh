source common.sh

print_head "setup monodb repository"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head " installing mongodb"
yum install mongodb-org -y &>>${log_file}

print_head "Update mongoDB listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>${log_file}

print_head "enable mongodb"
systemctl enable mongod &>>${log_file}

print_head "start mongodb"
systemctl start mongod &>>${log_file}


# Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf