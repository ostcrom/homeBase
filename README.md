# homeBase

homeBase is a stack of software that I use often, deployed to docker using docker-compose.  
  
### Requirements:  
Linux OS (tested on Ubuntu 22.04, should work on any Linux host where you can run docker-compose.)  
git  
docker  
docker-compose  
openssl

##December 2023 updates:
- Simplified install (from a dev standpoint 😏) by getting rid of set up script. Set up now requires manually copying and filling in the example yaml. I'm welcome!
- Got rid of SSLH and Ubuntu VNC services.

## Included components:
### nginx reverse proxy
Nginx configured with HTTPS certificates and set up as a reverse proxy for the two applications below.

### transmission
Bittorrent client, accessible at https://HOMEBASE/transmission/web/

### vaultwarden
A self hosted keyvault, accessible at https://HOMEBASE/vault 

### airsonic
A self hosted music streamer and jukebox accessible at https://homebase/vault

## Set up:
Download this repository using git:  
`git clone https://github.com/ostcrom/homeBase`

1. Copy docker-compose.example.yml to docker-compose.yml.
2. Edit docker-compose.yml and fill the appropriate values for the volume paths. 
3. Use openssl to generate keys:
```
mkdir ./keys
openssl req -newkey rsa:2048 -nodes -keyout ./keys/keys.pem \
	-x509 -days 365 -out ./keys/certificate.pem
```
4. Start the service with docker-compose:
```
docker-compose up -d
```
