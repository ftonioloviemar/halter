# cd /opt
# rm -fdr halter

#if ! command -v git  &> /dev/null
#then
#    echo "precisa instalar git"
#    yum -y install git
#fi

# git clone https://ftonioloviemar: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@github.com/ftonioloviemar/halter.git
# cd halter

if ! command -v python3 &> /dev/null
then
    echo "precisa instalar python3"
    yum -y install gcc openssl-devel bzip2-devel wget
    pushd /tmp/
    wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
    tar xzf Python-3.6.6.tgz
    pushd Python-3.6.6
    ./configure --enable-optimizations
    sudo make altinstall
    sudo ln -sfn /usr/local/bin/python3.6 /usr/bin/python3.6
    sudo ln -sfn /usr/local/bin/python3.6 /usr/bin/python3
    sudo ln -sfn /usr/local/bin/pip3.6 /usr/bin/pip3.6
    sudo ln -sfn /usr/local/bin/pip3.6 /usr/bin/pip3
    pip3 install --upgrade pip
    popd
    popd
fi



# serviço
rm -f /etc/init.d/halter
cp  halter.service.centos6 /etc/init.d/halter
chmod 555 /etc/init.d/halter
chmod +x /etc/init.d/halter
chkconfig halter on
echo halter_enable="YES" >> /etc/rc.conf
service halter start
