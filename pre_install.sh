# usar o comando abaixo que dispara este script para instalar / atualizar
# source <(curl -s https://raw.githubusercontent.com/ftonioloviemar/halter/main/pre_install.sh)

cd /opt
rm -fdr halter
yum -y install git
git clone https://github.com/ftonioloviemar/halter.git
cd halter
source install.sh