function debian {
    echo "debian"
    # presumir que já tem python 3.6 ou superior instalado
    ./config_venv.sh
    ./install_service_systemd.sh
}

function truenas {
    echo "truenas"
    ./config_venv.sh
    #./install_truenas.sh
}

function pfsense {
    echo "pfsense"

    if command -v python3.8 &> /dev/null
    then
        ln -sf /usr/local/bin/python3.8 /usr/local/bin/python3
    elif command -v python3.11 &> /dev/null
    then
        ln -sf /usr/local/bin/python3.11 /usr/local/bin/python3
    fi

    python3 -m ensurepip

    ./config_venv_pfsense.sh
    #./install_service_rc.sh
    ./install_service_pfsense
}

function el6 {
    echo "el6"
    ./install_el6.sh
    ./config_venv.sh
}

function el789 {
    ./install_el789.sh
    ./config_venv.sh
    ./install_service_systemd.sh
}

so=$(uname -a | tr '[:upper:]' '[:lower:]')

case "$so" in
    *"debian"* )
        debian
        ;;
    *"truenas"* )
        truenas
        ;;
    *"pfsense"* )
        pfsense
        ;;
    *"el6"* )
        el6
        ;;
    *"el7"* )
        echo "el7"
        el789
        ;;
    *"el8"* )
        echo "el8"
        el789
        ;;
    *"el9"* )
        echo "el9"
        el789
        ;;
    * )
        echo "Sistema operacional não previsto"
        ;;
esac