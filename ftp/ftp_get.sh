#!/bin/bash
########################################
## File Name :  ftp_get.sh
## Function  :  download file to FTP server
## Created by:  Xugang Cao
########################################

# the file you want to get
get_file=TOP_ALL_0903_decap_modify.gds.tar.gz

# the remote directory you want download file from 
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
cd $remote_path
prompt
get $get_file download.gds.tar.gz
bye
EOF
echo "downloading file end . . ."

end=$(date +%s)
take=$(( end - start ))
echo Run time is ${take} seconds.
