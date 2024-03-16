cd /opt
rm -fdr halter
yum -y install git
git clone https://github.com/ftonioloviemar/halter.git
cd halter
source install.sh
