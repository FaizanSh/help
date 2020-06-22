#! /bin/bash

#|-----------------------------------------------------------------------#------------------------------------------|
#| Program Name: open-jdk-8.sh
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script install java 8 and install its dependencies.
#
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script installs java..
#|        1) Update
#|        2) Upgrade
#|        3) Install Java
#|        4) Logs will be generated in the same folder as script.
#|	  5) Setup home variable
#|
#| Note:
#|        a) This script takes nothing as parameted
#|        b) Run this script with sudo or in SuperUser mode
#|
#|-----------------------------------------------------------------------#------------------------------------------|
#| Author: Faizan Ullah
#| Date: 2020/16/06
#|-----------------------------------------------------------------------#------------------------------------------|
#|Revision History:
#|Date: | Developer Name: | 
#|Description of Change Made:
#|-----------------------------------------------------------------------#------------------------------------------|


LOG_FILE="java.log"
touch $LOG_FILE
exec > >(tee $LOG_FILE) 2>&1

echo "Log Location should be: [ $PWD ]"

echo "This Script Install Java and set JAVA_HOME"

apt update -y

if [ $? -eq 0 ]
then
    echo "Update Successful"
else
    echo "Update Unsuccessful"
fi


apt upgrade

if [ $? -eq 0 ]
then
    echo "Upgrade Successful"
else
    echo "Upgrade Unsuccessful"
fi

apt install openjdk-8-jdk-headless

declare -i javaVar=$?
#-------------------- Check if Installation Is Successfull----------------------------------------------------#
if [ $javaVar -eq 0 ]
then
    echo "Java Installation Succeded"
    echo $JAVA_HOME
    javapath=$(ls -l `which java` | grep -oP "(?<=\-\>\s)(.*)")
    javahome=$(ls -l ${javapath} | grep -oP "(?<=\-\>\s\/)(.*)(?=bin)")
    writeit="export JAVA_HOME=${javahome}"
    echo "$writeit"
    echo "$writeit" >> /home/"${SUDO_USER}"/.bashrc
    source ~/.bashrc
    echo 'JAVA_HOME is set'"${JAVA_HOME}"
else
	echo "Installation Unsuccessful See logs for further errors"
	echo "Trying Reporting the issue to the creater"
fi
