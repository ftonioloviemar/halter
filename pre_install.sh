# usar o comando abaixo que dispara este script para instalar / atualizar
# curl -s https://raw.githubusercontent.com/ftonioloviemar/halter/main/pre_install.sh | sh 

# para freebsd
mkdir /opt

cd /opt
service halter stop
rm -fdr halter
yum -y install git
pkg install -y git
git clone https://github.com/ftonioloviemar/halter.git
cd halter
chmod +x *.sh
#source install.sh
./install.sh
