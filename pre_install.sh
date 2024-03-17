# usar o comando abaixo que dispara este script para instalar / atualizar
# source <(curl -s https://raw.githubusercontent.com/ftonioloviemar/halter/main/pre_install.sh)

# para freebsd
mkdir /opt

cd /opt
rm -fdr halter
yum -y install git
pkg install -y git
git clone https://github.com/ftonioloviemar/halter.git
cd halter
chmod +x install.sh
#source install.sh
./install.sh
