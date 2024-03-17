so=$(uname -a | tr '[:upper:]' '[:lower:]')

cd /opt/halter
chmod +x halter.py

case "$so" in
    *"debian"* )
        echo "debian"
        # presumir que já tem python 3.6 ou superior instalado
        ./config_venv.sh
        ./install_service_systemd.sh
        ;;
    *"truenas"* )
        echo "truenas"
        ./config_venv.sh
        #./install_truenas.sh
        ;;
    *"pfsense"* )
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
        ;;
    *"el6"* )
        echo "el6"
        ./install_el6.sh
        ./config_venv.sh
        ;;
    *"el7"* )
        echo "el7"
        ./install_el789.sh
        ./config_venv.sh
        ./install_service_systemd.sh
        ;;
    *"el8"* )
        echo "el8"
        ./install_el789.sh
        ./config_venv.sh
        ./install_service_systemd.sh
        ;;
    *"el9"* )
        echo "el9"
        ./install_el789.sh
        ./config_venv.sh
        ./install_service_systemd.sh
        ;;
    * )
        echo "Sistema operacional não previsto"
        ;;
esac