#! /bin/bash

#|-----------------------------------------------------------------------#------------------------------------------|
#| Program Name: MvnNodeNpm.sh
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script install following softwares and their #required dependencies
#Maven
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script installs java 1.8..
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



LOG_FILE="MasterLogs.txt"
touch $LOG_FILE
exec > >(tee $LOG_FILE) 2>&1


chmod +x "$PWD/maven.sh"
source "$PWD/maven.sh"


chmod +x "$PWD/node.sh"
source "$PWD/node.sh"


chmod +x "$PWD/npm.sh"
source "$PWD/npm.sh"


chmod +x "$PWD/JDK18.sh"
source "$PWD/JDK18.sh"

