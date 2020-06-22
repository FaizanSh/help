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


LOG_FILE="JavaLogs.txt"
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

echo "Installing Java with yum"

yum install -y java-1.8.0-openjdk

declare -i javaVar=$?
#-------------------- Check if Installation Is Successfull----------------------------------------------------#
if [ $javaVar -eq 0 ]
then
    echo "java Installation Complete"
    java -version
else
    echo "YUM FAILED"
    #https://www.liquidweb.com/kb/install-java-8-on-centos-7/
fi

