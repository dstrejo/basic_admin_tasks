#!/bin/bash

PS3="Your choice:" #This replaces the default value of the variable REPLY

#Menu selector for admin tasks
select ITEM in "Add User" "List All Processes" "Kill Process" "Install Program" "Update System" "Quit"
do

if [[ $REPLY -eq 1 ]] #Confirm "ADD USER" was selected
then
	read -p "Enter the username:" username 
	output="$(grep -w "$username" /etc/passwd)" #Check if the users already exists 
	if [[ -n "$output" ]] #When yes, returns 1
	then 
		echo "The username \"$username\" already exists."
	else
		sudo useradd -m -s /bin/bash "$username"
		if [[ $? -eq 0 ]] #If return variable is 0, then the user was succesfully added.
		then 
			echo "The user \"$username\" was added successfully."
			tail -n 1 /etc/passwd
		else
			echo "There was an error adding the user \"$username\"."
		fi
	fi

elif [[ $REPLY -eq 2 ]]
then
		echo "Listing all processes..."
		sleep 1
		ps -ef

elif [[ $REPLY -eq 3 ]]
then 
	read -p "Enter the process to kill:" process
	pkill "$process"
	if [[ $? -eq 0 ]]
	then
		echo "The process was successfully killed."
	else
		echo "There was an error while killing the process."
	fi

elif [[ $REPLY -eq 4 ]]
then 
	read -p "Enter the program to install:" app
	sudo apt update && sudo apt install "$app" -y 


elif [[ $REPLY -eq 5 ]]
then
	echo "The system will be shortly updated"
	sleep 1
	sudo apt update && sudo apt upgrade -y


elif [[ $REPLY -eq 6 ]]
then
	echo "Quitting..."
	sleep 1
	exit
else
	echo "Invalid menu slection"
fi
done
