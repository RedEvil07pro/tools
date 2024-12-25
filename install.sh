#!/bin/bash

# Funzione per mostrare l'help
show_help() {
    echo "Installer per lo strumento di Ethical Hacking"
    echo "Questo script installa tutte le dipendenze necessarie e configura lo strumento."
}

# Funzione per verificare e installare una dipendenza
check_and_install_dependency() {
    local package=$1
    if ! command -v "$package" &> /dev/null; then
        echo "$package non trovato. Installazione in corso..."
        sudo apt-get install -y "$package"
    else
        echo "$package è già installato."
    fi
}

# Funzione per scaricare lo script principale e renderlo eseguibile
install_tool() {
    echo "Download e configurazione dello strumento di Ethical Hacking..."
    TOOL_NAME="ethical_hacking_tool.sh"
    
    # Crea la cartella di installazione
    mkdir -p ~/ethical_hacking_tool
    cd ~/ethical_hacking_tool || exit

    # Scrivi lo script di Ethical Hacking
    cat <<'EOF' > "$TOOL_NAME"
#!/bin/bash

# Funzione per mostrare l'help
show_help() {
    echo "Uso del programma:"
    echo ""
    echo "Opzioni disponibili:"
    echo "  --help          Mostra questo messaggio di aiuto."
    echo "  --scan-port     Scansiona le porte di un IP remoto usando Nmap."
    echo "  --nikto-scan    Esegue una scansione delle vulnerabilità HTTP usando Nikto."
    echo "  --bruteforce    Esegue un attacco di forza bruta su un servizio SSH usando Hydra."
    echo "  --netstat       Mostra le connessioni di rete attive."
    echo "  --ssh           Connessione SSH ad un server remoto."
    echo "  --exit          Esce dal programma."
}

# Funzione per controllare se un comando è disponibile nel sistema
check_dependency() {
    command -v "$1" &>/dev/null
    if [ $? -ne 0 ]; then
        echo "$1 non è installato. Installazione in corso..."
        sudo apt-get install -y "$1"
    else
        echo "$1 è già installato."
    fi
}

# Funzione per eseguire la scansione delle porte con Nmap
scan_ports() {
    echo "Scansione delle porte per l'indirizzo IP $1..."
    nmap "$1"
}

# Funzione per eseguire la scansione delle vulnerabilità HTTP con Nikto
nikto_scan() {
    echo "Esecuzione della scansione di vulnerabilità HTTP per $1..."
    nikto -h "$1"
}

# Funzione per eseguire un attacco di forza bruta su SSH con Hydra
brute_force_ssh() {
    echo "Esecuzione di un attacco di forza bruta su SSH per l'indirizzo $1..."
    hydra -l "$2" -P "$3" ssh://"$1"
}

# Funzione per mostrare le connessioni di rete attive con Netstat
show_netstat() {
    echo "Connessioni di rete attive:"
    netstat -tuln
}

# Funzione per connettersi via SSH
connect_ssh() {
    echo "Esecuzione connessione SSH con $1@IP $2..."
    ssh "$1@$2"
}

# Funzione per uscire dal programma
exit_program() {
    echo "Uscita dal programma..."
    exit 0
}

# Verifica se l'utente ha richiesto il comando --help
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Controlla se le dipendenze necessarie sono installate
check_dependency "nmap"
check_dependency "nikto"
check_dependency "hydra"
check_dependency "netstat"
check_dependency "ssh"

# Menu principale
while true; do
    echo "Scegli un'operazione:"
    echo "1. Scansione delle porte (Nmap)"
    echo "2. Scansione delle vulnerabilità (Nikto)"
    echo "3. Attacco di forza bruta su SSH (Hydra)"
    echo "4. Mostra connessioni di rete (Netstat)"
    echo "5. Connessione SSH"
    echo "6. Esci"
    echo -n "Inserisci la tua scelta (1-6): "
    read choice

    case $choice in
        1)
            echo -n "Inserisci l'indirizzo IP da scansionare: "
            read ip
            scan_ports "$ip"
            ;;
        2)
            echo -n "Inserisci l'URL da scansionare (es. http://example.com): "
            read url
            nikto_scan "$url"
            ;;
        3)
            echo -n "Inserisci l'indirizzo IP di destinazione: "
            read ip
            echo -n "Inserisci il nome utente per l'attacco: "
            read username
            echo -n "Inserisci il percorso al file di password per Hydra: "
            read password_file
            brute_force_ssh "$ip" "$username" "$password_file"
            ;;
        4)
            show_netstat
            ;;
        5)
            echo -n "Inserisci il nome utente SSH: "
            read username
            echo -n "Inserisci l'indirizzo IP del server SSH: "
            read ip
            connect_ssh "$username" "$ip"
            ;;
        6)
            exit_program
            ;;
        *)
            echo "Opzione non valida, riprova."
            ;;
    esac
done
EOF

    # Rendi eseguibile lo script
    chmod +x "$TOOL_NAME"
    echo "Lo strumento è stato installato correttamente."
}

# Installazione delle dipendenze
install_dependencies() {
    echo "Installazione delle dipendenze necessarie..."
    sudo apt-get update

    check_and_install_dependency "nmap"
    check_and_install_dependency "nikto"
    check_and_install_dependency "hydra"
    check_and_install_dependency "net-tools"
    check_and_install_dependency "openssh-client"
}

# Funzione principale di installazione
install() {
    echo "Benvenuto nell'installer per lo strumento di Ethical Hacking."
    echo "Verranno installati tutti gli strumenti necessari per il funzionamento del programma."

    # Installazione delle dipendenze
    install_dependencies

    # Installazione dello strumento
    install_tool

    # Istruzioni finali
    echo ""
    echo "Per eseguire lo strumento, vai alla cartella ~/ethical_hacking_tool e lancia il comando:"
    echo "./ethical_hacking_tool.sh"
    echo "Buon hacking!"
}

# Avvia il processo di installazione
install

