# rm -fdr /opt/halter
# git clone https://ftonioloviemar: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@github.com/ftonioloviemar/halter.git
# cd halter

if ! command -v python3  &> /dev/null
then
    echo "precisa instalar python3"
    yum -y install gcc openssl-devel bzip2-devel wget
    cd /tmp/
    wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
    tar xzf Python-3.6.6.tgz
    cd Python-3.6.6
    ./configure --enable-optimizations
    sudo make altinstall
    sudo ln -sfn /usr/local/bin/python3.6 /usr/bin/python3.6
    sudo ln -sfn /usr/local/bin/python3.6 /usr/bin/python3
    sudo ln -sfn /usr/local/bin/pip3.6 /usr/bin/pip3.6
    sudo ln -sfn /usr/local/bin/pip3.6 /usr/bin/pip3
fi

service halter stop
cd /opt
#mv halter halter_old
rm -fdr halter

if ! command -v git  &> /dev/null
    echo "precisa instalar git"
    yum -y install git
fi

python3 -m venv .venv_linux
source .venv_linux/bin/activate
pip3 install -r requirements.txt
deactivate
chmod +x halter.py

#source ./install_service_rc_centos6.sh
rm -f /etc/init.d/halter
cp -f halter.service.centos6 /etc/init.d/halter
chmod +x /etc/init.d/halter
chkconfig halter on
service halter start
service halter status
#telnet localhost 59090
