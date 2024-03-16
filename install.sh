so=$(uname -a | tr '[:upper:]' '[:lower:]')

case "$so" in
    *"debian"* )
        echo "debian"
        # presumir que já tem python 3.6 ou superior instalado
        source config_venv.sh
        source install_service_systemd.sh
        ;;
    *"truenas"* )
        echo "truenas"
        source config_venv.sh
        #source install_truenas.sh
        ;;
    *"pfsense"* )
        echo "pfsense"
        source config_venv_pfsense.sh
        source install_service_rc.sh
        ;;
    *"el6"* )
        echo "el6"
        source install_el6.sh
        source config_venv.sh
        ;;
    *"el7"* )
        echo "el7"
        source install_el789.sh
        source config_venv.sh
        source install_service_systemd.sh
        ;;
    *"el8"* )
        echo "el8"
        source install_el789.sh
        source config_venv.sh
        source install_service_systemd.sh
        ;;
    *"el9"* )
        echo "el9"
        source install_el789.sh
        source config_venv.sh
        source install_service_systemd.sh
        ;;
    * )
        echo "Sistema operacional não previsto"
        ;;
esac