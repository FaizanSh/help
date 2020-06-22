#! /bin/bash

#|-----------------------------------------------------------------------#------------------------------------------|
#| Program Name: MvnNodeNpm.sh
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script install following softwares and their #required dependencies
#Maven
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script installs NodeJS..
#|        1) Install Software with yum
#|        2) If failed then install package with repository external #links
#|        3) Logs will explain in the end what is installed and what is #the version.
#|        4) Logs will be generated in the same folder as script.
#|
#| Note:
#|        a) This script takes nothing as parameted
#|        b) Run this script with sudo or in SuperUser mode
#|
#|-----------------------------------------------------------------------#------------------------------------------|
#| Author: Faizan Ullah
#| Date: 2020/15/08
#|-----------------------------------------------------------------------#------------------------------------------|
#|Revision History:
#|Date: | Developer Name: | 
#|Description of Change Made:
#|-----------------------------------------------------------------------#------------------------------------------|


LOG_FILE="npmLogs.txt"
touch $LOG_FILE
exec > >(tee $LOG_FILE) 2>&1

echo "Log Location should be: [ $PWD ]"

echo "This Script Install the following list of softwares"
echo "npm & Related dependencies"

echo "Updating before installation"
yum -y update
if [ $? -eq 0 ]
then
	echo "Update Successful"
else
	echo "Update Unsuccessful"
fi

echo "Installing Node with yum"

yum install -y npm

declare -i nodejsVar=$?
#-------------------- Check if Installation Is Successfull----------------------------------------------------#
if [ $nodejsVar -eq 0 ]
then
    echo "nvm Installation Complete"
else
    echo "YUM FAILED"
	echo "Trying External Repository"
	yum install -y gcc-c++ make
	curl -sL https://rpm.nodesource.com/setup_14.x | bash -
	yum install -y nodejs
	nodejsVar = $?
fi

