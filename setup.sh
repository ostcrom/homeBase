#!/bin/bash

function exit_check {
	if [ $? -ne 0 ]; then
		echo "Set up cancelled..."
		exit
	fi
}

V_TRANSMISSION_DOWNLOADS=$(whiptail --inputbox "Specify Transmission download directory:"\
       	8 39 --title "Transmission downloads directory" 3>&1 1>&2 2>&3)
	exit_check
	
V_TRANSMISSION_CONFIG=$(whiptail --inputbox "Specify Transmission config directory:"\
       	8 39 --title "Transmission config directory" 3>&1 1>&2 2>&3)
	exit_check
	
E_UBUNTU_VNC_HTTP_PASSWORD=$(whiptail \
	--inputbox "Specify VNC HTTP password (username is root):" \
	8 39 --title "VNC HTTP password" 3>&1 1>&2 2>&3)
	exit_check
	
O_KEYS_DIRECTORY=$(whiptail --inputbox "Specify SSL keys directory :" \
	8 39 --title "SSL Keys directory" 3>&1 1>&2 2>&3)
	exit_check
	
CONFIG_ARR=("V_TRANSMISSION_DOWNLOADS" "V_TRANSMISSION_CONFIG" \
	"E_UBUNTU_VNC_HTTP_PASSWORD" "O_KEYS_DIRECTORY")

cp ./docker-compose.yml.example ./docker-compose.yml

echo "Generating new docker-compose file from docker-compose.yml.example"
for option in ${CONFIG_ARR[*]}
do
	sed -i "s#\[\[$option\]\]#${!option}#g" docker-compose.yml
done

KEY_PATH=$O_KEYS_DIRECTORY/key.pem
CERT_PATH=$O_KEYS_DIRECTORY/certificate.pem

if [ ! -d $O_KEYS_DIRECTORY ]; then
	echo "Keys dir \"$O_KEYS_DIRECTORY\" does not exist! Attempting to create..."
	mkdir -p $O_KEYS_DIRECTORY

	if [ $? -ne 0 ]; then
		echo "Creating keys directory failed, quitting set up!"
	fi
fi

if [ ! -f $KEY_PATH ] || [ ! -f $CERT_PATH ]; then
	echo "The key and/or cert do not appear to exist, attempting cert generation..."
	openssl req -newkey rsa:2048 -nodes -keyout $KEY_PATH \
		-x509 -days 365 -out $CERT_PATH
	if [ $? -ne 0 ]; then
		echo "Generating SSL certs failed, quitting set up!"
	fi
fi

echo "docker-compose.yml generated successfully!"
echo "Attempting to start services..."
docker-compose up -d
