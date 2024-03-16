#scp -r -P 55323 root@silverado:/mnt/dados/dados/Ti/python/jupyter/halter /opt/

rm -f /etc/rc.d/init.d/halter
cp halter.service.centos6 /etc/rc.d/init.d/halter

chmod 555 /etc/rc.d/init.d/halter
chmod +x /etc/rc.d/init.d/halter
#chmod +x /opt/halter/halter.sh
#chmod +x /opt/halter/halter.py

echo halter_enable="YES" >> /etc/rc.conf
#echo "service halter start" > /etc/rc.local
#sed 's/<\/system>/<\/system>\n\t<shellcmd>service halter start<\/shellcmd>/' /conf/config.xml
#sed -i '' "s@3.11@3@" halter.py

#python3 -m ensurepip
#python3 -m pip install requests

service halter start

#easyrule pass LAN tcp any any 59090
