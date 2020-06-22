#! /bin/bash

#|-----------------------------------------------------------------------#------------------------------------------|
#| Program Name: MvnNodeNpm.sh
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script install following softwares and their #required dependencies
#Maven
#|-----------------------------------------------------------------------#------------------------------------------|
#| Description: This script installs maven..
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


LOG_FILE="MavenLogs.txt"
touch $LOG_FILE
exec > >(tee $LOG_FILE) 2>&1

echo "Log Location should be: [ $PWD ]"

echo "This Script Install the following list of softwares"
echo "Maven & Related dependencies"

echo "Updating before installation"
yum -y update
echo "Update Successful"

yum install -y maven
declare -i mavenVar=$?
#-------------------- Check if Installation Is Successfull----------------------------------------------------#
if [ $mavenVar -eq 0 ]
then
    echo "Maven Installation Succeded"
else
    echo "YUM FAILED"
	echo "Trying External Repository"
	TEMPORARY_DIRECTORY="$(mktemp -d)"
	DOWNLOAD_TO="$TEMPORARY_DIRECTORY/maven.tgz"

	echo 'Downloading Maven to: ' "$DOWNLOAD_TO"

	sudo yum install -y wget

	wget -O "$DOWNLOAD_TO" http://apache.mirrors.lucidnetworks.net/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

	echo 'Extracting Maven'
	tar xzf "$DOWNLOAD_TO" -C "$TEMPORARY_DIRECTORY"
	rm "$DOWNLOAD_TO"

	echo 'Configuring Envrionment'

	mv "$TEMPORARY_DIRECTORY"/apache-maven-* /usr/local/maven
	echo -e "export M2_HOME=/usr/local/maven\nexport PATH=${M2_HOME}/bin:${PATH}" > /etc/profile.d/maven.sh
	source /etc/profile.d/maven.sh

	#//If not executable	
	sudo chmod +x /etc/profile.d/maven.sh
	source /etc/profile.d/maven.sh

	#//not sure about how to set the current environment under the sudo
	sudo -u "$SUDO_USER" env  "M2_HOME=/usr/local/maven"
	sudo -u "$SUDO_USER" env "PATH=/usr/local/maven/bin:${PATH}"


	echo 'The maven version: ' "$(mvn -version)" ' has been installed.'
	echo -e '\n\n!! Note you must relogin to get mvn in your path !!'
	echo 'Removing the temporary directory...'
	rm -r "$TEMPORARY_DIRECTORY"
	echo 'Your Maven Installation is Complete.'
	echo 'Removing the temporary directory...'
	rm -r "$TEMPORARY_DIRECTORY"
	yum install -y maven
	$mavenVar = $?
fi

