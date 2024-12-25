# Ethical Hacking Tool

Questo è un tool da riga di comando per eseguire diverse operazioni di hacking etico, tra cui scansioni di porte, attacchi di forza bruta, tracciare il percorso di rete, testare la velocità della connessione, e altro.

## Funzionalità

- Scansione delle porte di un IP remoto (Nmap)
- Scansione delle vulnerabilità HTTP (Nikto)
- Attacco di forza bruta su SSH (Hydra)
- Mostra le connessioni di rete attive (Netstat)
- Connessione SSH a server remoti
- Scansione delle reti Wi-Fi disponibili
- Visualizza la password di una rete Wi-Fi salvata
- Test di velocità della connessione
- Ping a un host per verificarne la connettività
- Traccia il percorso di rete verso un host remoto
- Verifica dello stato del sistema (CPU, Memoria, Disco)
- Ottenere l'IP di un sito web e la località di un indirizzo IP
- Lookup DNS tramite il comando `dig`

## Prerequisiti

- **Sistema operativo**: Ubuntu o una distribuzione basata su Debian.
- **Connessione a Internet**: Necessaria per scaricare le dipendenze.
- **Permessi di superutente**: Lo script di installazione richiede privilegi di root per installare i pacchetti necessari.

## Installazione

### 1. Clonare o scaricare il repository

Se hai `git` installato, puoi clonare direttamente il repository. In alternativa, puoi scaricare manualmente il progetto.

#### Usando Git:

## Prima di eseguire lo script, è necessario renderlo eseguibile. Per farlo, esegui il seguente comando: chmod +x install.sh

### Esegui lo script: ./install.sh

###### Per eseguire il tool basta digitare: ethical

####### Se il comando "ethical" non funziona basta fare il comando: ```bash 
cd /home/(nome_utente)/ethical_hacking_tool```, e poi fare il comando: ```bash 
chmod +x ./ethical_hacking_tool.sh```


```bash
git clone https://github.com/tuo_username/ethical_hacking_tool.git
cd ethical_hacking_tool
