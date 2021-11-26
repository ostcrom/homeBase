# homeBase

homeBase is a stack of software that I use often, deployed to docker using docker-compose.  
  
Requirements:
Linux OS (tested on Ubuntu 20.04, probably works on others as everything runs in Docker.)  
git  
docker  
docker-compose  
whiptail  

## Included components:
### sslh
sslh is an extremely handy daemon. It listens on port 443 and can accept either SSH or HTTPS connections. This is handy because some networks do block SSH connections on port 22, very few networks block connections to port 443. This implementation uses host networking so when you connect via SSH, it connects you to the SSH port on the host machine. HTTPS connections are forwarded to the nginx reverse proxy.

### nginx reverse proxy
Nginx configured with HTTPS certificates and set up as a reverse proxy for the two applications below.

### transmission
Bittorrent client, accessible at https://HOSTNAME/transmission/web/

### Ubuntu VNC instance
An HTML5 VNC client, that connects to an Ubuntu desktop running in the same container. Not persistent (yet.) Accessible at https://HOSTNAME/vnc/

## Set up.
Download this repository using git:
`git clone https://github.com/ostcrom/homeBase`

Change into that directory and run the set up:  
`cd homeBase`  
`.\setup.sh`  

If HTTPS certificates are not present in the specified keys directory, the openssl keygeneration process will run. 
