#!/bin/bash

# Funzione per verificare e installare un pacchetto
install_package() {
    local package_name=$1
    if ! command -v "$package_name" &>/dev/null; then
        echo "$package_name non trovato. Installazione in corso..."
        sudo apt-get update
        sudo apt-get install -y "$package_name"
        if [ $? -eq 0 ]; then
            echo "$package_name installato con successo."
        else
            echo "Errore durante l'installazione di $package_name."
        fi
    else
        echo "$package_name è già installato."
    fi
}

# Installazione delle dipendenze necessarie
install_package "nmap"           # Per la scansione delle porte
install_package "nikto"          # Per la scansione delle vulnerabilità HTTP
install_package "hydra"          # Per attacchi di forza bruta
install_package "net-tools"      # Per il comando netstat
install_package "ssh"            # Per le connessioni SSH
install_package "network-manager" # Per la gestione Wi-Fi
install_package "speedtest-cli"  # Per il test di velocità
install_package "traceroute"     # Per il traceroute
install_package "curl"           # Per ottenere la località dell'IP
install_package "jq"             # Per analizzare la risposta JSON da ipinfo.io
install_package "dnsutils"       # Per il comando dig (DNS lookup)

# Variabili
USER_HOME="/home/$(whoami)"
INSTALL_DIR="$USER_HOME/ethical_hacking_tool"

# Crea la directory per il tool
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    echo "Creata la cartella per il tool in $INSTALL_DIR"
else
    echo "La cartella $INSTALL_DIR esiste già."
fi

# Copia il file del tool nella directory
cp ./ethical_hacking_tool.sh "$INSTALL_DIR/ethical_hacking_tool.sh"
echo "Il file 'ethical_hacking_tool.sh' è stato copiato in $INSTALL_DIR"

# Aggiungi un alias per il comando 'ethical' (per eseguire il tool facilmente)
if ! grep -q "ethical" "$USER_HOME/.bashrc"; then
    echo "alias ethical='bash $INSTALL_DIR/ethical_hacking_tool.sh'" >> "$USER_HOME/.bashrc"
    echo "Alias 'ethical' aggiunto a .bashrc. Ora puoi eseguire il tool con il comando 'ethical'."
else
    echo "Alias 'ethical' già presente nel file .bashrc."
fi

# Ricarica .bashrc per rendere effettivo l'alias
source "$USER_HOME/.bashrc"

echo "Installazione completata!"

