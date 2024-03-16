#service halter stop
#cd /opt
#mv halter halter_old

#pkg install -y git
#git clone https://ftonioloviemar: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@github.com/ftonioloviemar/halter.git
#cd halter
#source install_pfsense.sh

python3 -m venv .venv_linux
source .venv_linux/bin/activate.csh
pip3 install -r requirements.txt
deactivate
chmod +x halter.py
source ./install_service_rc.sh
#service halter start
#ps -el | grep halter
sleep 1
telnet localhost 59090
