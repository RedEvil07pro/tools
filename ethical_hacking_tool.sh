#!/bin/bash

# Funzione per mostrare l'help
show_help() {
    echo "Uso del programma:"
    echo ""
    echo "Opzioni disponibili:"
    echo "  --help              Mostra questo messaggio di aiuto."
    echo "  --scan-port         Scansiona le porte di un IP remoto usando Nmap."
    echo "  --nikto-scan        Esegue una scansione delle vulnerabilità HTTP usando Nikto."
    echo "  --bruteforce        Esegue un attacco di forza bruta su un servizio SSH usando Hydra."
    echo "  --netstat           Mostra le connessioni di rete attive."
    echo "  --ssh               Connessione SSH ad un server remoto."
    echo "  --wifi-scan         Scansiona le reti Wi-Fi disponibili."
    echo "  --show-pass         Visualizza la password di una rete Wi-Fi salvata."
    echo "  --speed-test        Esegue un test di velocità della connessione."
    echo "  --ping              Pinga un host per verificarne la connettività."
    echo "  --traceroute        Traccia il percorso di rete verso un host remoto."
    echo "  --system-check      Mostra le informazioni sul sistema."
    echo "  --dns-lookup        Esegui un lookup DNS per un dominio."
    echo "  --ip-location       Mostra la località di un indirizzo IP."
    echo "  --exit              Esce dal programma."
}

# Funzioni aggiuntive
scan_ports() {
    echo "Scansione delle porte per l'indirizzo IP $1..."
    nmap "$1"
}

nikto_scan() {
    echo "Esecuzione della scansione di vulnerabilità HTTP per $1..."
    nikto -h "$1"
}

brute_force_ssh() {
    echo "Esecuzione di un attacco di forza bruta su SSH per l'indirizzo $1..."
    hydra -l "$2" -P "$3" ssh://"$1"
}

show_netstat() {
    echo "Connessioni di rete attive:"
    netstat -tuln
}

connect_ssh() {
    echo "Esecuzione connessione SSH con $1@IP $2..."
    ssh "$1@$2"
}

scan_wifi() {
    echo "Scansione delle reti Wi-Fi disponibili..."
    nmcli dev wifi list
}

show_wifi_password() {
    echo -n "Inserisci il nome (SSID) della rete Wi-Fi: "
    read ssid
    echo "Password per la rete $ssid:"
    sudo nmcli -s -g 802-11-wireless-security.psk connection show "$ssid" 2>/dev/null || echo "Errore: rete non trovata o password non disponibile."
}

speed_test() {
    echo "Eseguendo il test di velocità della connessione..."
    speedtest-cli
}

ping_host() {
    echo -n "Inserisci l'indirizzo IP o dominio da pingare: "
    read host
    echo "Esecuzione di ping su $host..."
    ping -c 4 "$host"
}

trace_route() {
    echo -n "Inserisci l'indirizzo IP o dominio per il traceroute: "
    read host
    echo "Tracciando il percorso verso $host..."
    traceroute "$host"
}

system_check() {
    echo "Riepilogo del sistema:"
    echo "------------------------"
    echo "Utilizzo CPU:"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"% utilizzato"}'
    echo "Utilizzo memoria:"
    free -h | grep Mem | awk '{print $3 "/" $2 " utilizzato"}'
    echo "Spazio disco:"
    df -h | grep "^/dev/" | awk '{print $1 ": " $5 " utilizzato"}'
    echo "------------------------"
}

dns_lookup() {
    echo -n "Inserisci il dominio per il lookup DNS (es. google.com): "
    read domain
    echo "Eseguito lookup DNS per $domain:"
    dig "$domain"
}

ip_location() {
    echo -n "Inserisci l'indirizzo IP per ottenere la località: "
    read ip
    echo "Ottenendo la località per l'IP $ip..."
    curl -s "http://ipinfo.io/$ip/json" | jq '.city, .region, .country'
}

exit_program() {
    echo "Uscita dal programma..."
    exit 0
}

# Verifica se l'utente ha richiesto il comando --help
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Menu principale
while true; do
    echo "Scegli un'operazione:"
    echo "1. Scansione delle porte (Nmap)"
    echo "2. Scansione delle vulnerabilità (Nikto)"
    echo "3. Attacco di forza bruta su SSH (Hydra)"
    echo "4. Mostra connessioni di rete (Netstat)"
    echo "5. Connessione SSH"
    echo "6. Scansione delle reti Wi-Fi"
    echo "7. Visualizza la password di una rete Wi-Fi salvata"
    echo "8. Test di velocità della connessione"
    echo "9. Ping a un host"
    echo "10. Traccia percorso verso un host (Traceroute)"
    echo "11. Verifica dello stato del sistema"
    echo "12. Lookup DNS per un dominio"
    echo "13. Località di un indirizzo IP"
    echo "14. Esci"
    echo -n "Inserisci la tua scelta (1-14): "
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
            scan_wifi
            ;;
        7)
            show_wifi_password
            ;;
        8)
            speed_test
            ;;
        9)
            ping_host
            ;;
        10)
            trace_route
            ;;
        11)
            system_check
            ;;
        12)
            dns_lookup
            ;;
        13)
            ip_location
            ;;
        14)
            exit_program
            ;;
        *)
            echo "Opzione non valida, riprova."
            ;;
    esac
done

