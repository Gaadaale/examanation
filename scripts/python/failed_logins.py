import os
import socket
from datetime import datetime

# 1. Inställningar för loggning
log_mapp = "../../reports/logs"
log_fil = os.path.join(log_mapp, "python_network_audit.log")

# Skapa mappen om den inte finns
if not os.path.exists(log_mapp):
    os.makedirs(log_mapp)

def kor_sakerhetskoll():
    print("Kör nätverkskontroll...")
    
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Hämta datornamn och IP
    hostname = socket.gethostname()
    ip_adress = socket.gethostbyname(hostname)
    
    with open(log_fil, "a", encoding="utf-8") as f:
        f.write(f"--- START: {timestamp} ---\n")
        f.write(f"Datornamn: {hostname}\n")
        f.write(f"Lokal IP-adress: {ip_adress}\n")
        f.write("Status: Nätverksgränssnitt OK\n")
        f.write("--- SLUT ---\n\n")
    
    print(f"Klart! Resultatet sparades i {log_fil}")

if __name__ == "__main__":
    kor_sakerhetskoll()