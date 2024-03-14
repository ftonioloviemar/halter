# instalar dependencias
#yum -y install epel-release
#yum -y install openssl-devel bzip2-devel libffi-devel
#yum -y install wget make cmake gcc bzip2-devel libffi-devel zlib-devel
#yum -y install openssl openssl-devel

# baixar, compilar e instalar python3.11
#cd /tmp
#wget https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tgz
#tar xvf Python-3.11.6.tgz
#cd Python-3.11*/
#LDFLAGS="${LDFLAGS} -Wl,-rpath=/usr/local/openssl/lib" ./configure --with-openssl=/usr/local/openssl 
#make
#make altinstall
yum -y install https://repo.ius.io/ius-release-el$(rpm -E '%{rhel}').rpm
#yum -y update
yum -y install python3

pip3 install --upgrade pip

# checar versao
python3 --version
pip3 --version

pip3 install requests
