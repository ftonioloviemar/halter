#scp -r -P 55323 root@silverado:/mnt/dados/dados/Ti/python/jupyter/halter /opt/halter

python3 -m venv .venv_linux
source .venv_linux/bin/activate
pip3 install -r requirements.txt
#chmod +x halter.py

rm -f /etc/systemd/system/halter.service
cp /opt/halter/halter.service /etc/systemd/system/
#chmod +x halter.sh
systemctl enable halter
systemctl start halter
