# mkdir /opt
# scp -r -P 55323 root@silverado:/mnt/dados/dados/Ti/python/jupyter/halter /opt/
# cd /opt/halter
# ./install_centos6_python_halter.sh

yum -y install gcc openssl-devel bzip2-devel wget
cd /tmp/
wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
tar xzf Python-3.6.6.tgz
cd Python-3.6.6
./configure --enable-optimizations
sudo make altinstall
sudo ln -sfn /usr/local/bin/python3.6 /usr/bin/python3.6
pip3.6 install requests
cd /opt/halter/
sed -i 's/3.11/3.6/g' halter.py
cp -f halter.service.centos6 /etc/init.d/halter
chmod +x /etc/init.d/halter
chkconfig halter on
service halter start
service halter status
