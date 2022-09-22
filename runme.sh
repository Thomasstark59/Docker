#!/bin/bash 

function checkingdocker()
{
	if [ $? -eq 0 ]
	then
		echo "docker already installed"
	else
		echo "Starting docker installation..."
		sudo snap install docker
		echo "docker installed"
	fi
}


function start ()
{
	echo "Program starting..."
	echo "Starting docker compose installation..."
	sudo apt install docker-compose && checkingdocker
	echo "docker compose installed"
	echo "checking if docker is installed..."
	echo "building image..."
	docker build -t monimage . 
	echo "image build"
	echo "starting docker compose..."
	docker-compose up
	docker logs docker_exam_monapp_1 >& output_monapp.log && 	docker logs docker_exam_redis_1 >& output_redis.log
	echo "ending"
}

function DisplayUsername()
{
	echo "Hello : " $USERNAME
	sleep 2
}

declare -i password=1234
read -s -p "password :..." PASSWD
echo ""
if [ $PASSWD -eq $password ]
then
	read -s -p "Username :..." USERNAME
	echo ""
	DisplayUsername USERNAME
	start
	
else

	while (( $PASSWD != $password ))
	do
		read -s -p "password :..." PASSWD
		echo ""
		if [ $PASSWD -eq $password ]
		then
			read -s -p "Username :..." USERNAME
			echo ""
			DisplayUsername USERNAME
			start USERNAME
		fi
	done
fi
