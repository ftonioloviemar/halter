#git clone https://github.com/ftonioloviemar/halter.git

python3 -m venv .venv_linux
source .venv_linux/bin/activate
pip3 install -r requirements.txt
chmod +x halter.py

nohup ./halter.py > /dev/null 2>&1&
