#!/bin/bash
########################################
## File Name :  ftp_put.sh
## Function  :  upload file to FTP server
## Created by:  Xugang Cao
#######################################

# the file you want to put
put_file=TOP_ALL_0903_decap_modify.gds.tar.gz

# the remote directory you want upload file in 
remote_path=/PKU_VLSI_20200903_1610

start=$(date +%s)

# FTP information
FTP_ADDRESS=ftp.unitedds.com
USER_NAME=CWG0490
PASSWORD=X83j#t6v

ftp -i -v -n <<EOF
open $FTP_ADDRESS
user $USER_NAME $PASSWORD
binary
mkdir $remote_path
cd $remote_path
prompt
put $put_file
bye
EOF
echo "uploading file end . . ."

end=$(date +%s)
take=$(( end - start ))
echo Run time is ${take} seconds.
