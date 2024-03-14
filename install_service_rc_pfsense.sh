cp /opt/halter/rc.d_halter /usr/local/etc/rc.d/halter

chmod 555 /usr/local/etc/rc.d/halter
chmod +x /usr/local/etc/rc.d/halter
chmod +x /opt/halter/halter.sh
chmod +x /opt/halter/halter.py

echo halter_enable="YES" >> /etc/rc.conf
echo "service halter start" > /etc/rc.local
sed 's/<\/system>/<\/system>\n\t<shellcmd>service halter start<\/shellcmd>/' /conf/config.xml

python3.11 -m ensurepip
python3.11 -m pip install requests

service halter start

easyrule pass LAN tcp any any 59090
