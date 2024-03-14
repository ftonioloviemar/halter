#scp -r -P 55323 root@silverado:/mnt/dados/dados/Ti/python/jupyter/halter /opt/halter

cp /opt/halter/halter.service /etc/systemd/system/
chmod +x halter.sh
systemctl enable halter
systemctl start halter
