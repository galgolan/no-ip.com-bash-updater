#!/bin/bash
# No-IP uses emails as passwords, so make sure that you encode the @ as %40
USERNAME=username%40gmail.com
PASSWORD=mypass
HOST=myhost.no-ip.org
LOGFILE=~/noip/noip.log
STOREDIPFILE=~/noip/current_ip
USERAGENT="Simple Bash No-IP Updater/0.4"

if [ ! -e $STOREDIPFILE ]; then 
	touch $STOREDIPFILE
fi

NEWIP=$(curl http://icanhazip.com/)
STOREDIP=$(cat $STOREDIPFILE)

if [ "$NEWIP" != "$STOREDIP" ]; then
	RESULT=$(curl "https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$NEWIP")

	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $RESULT"
	echo $NEWIP > $STOREDIPFILE
else
	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] No IP change"
fi

echo $LOGLINE >> $LOGFILE
exit 0
