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
