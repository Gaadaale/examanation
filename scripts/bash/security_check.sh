#!/bin/bash
# ==============================================================================
# Titel: Automated Security Auditor v2.0
# Författare: Jaaro (IT-Säkerhet)
# Beskrivning: Robust skript för att hitta osäkra filrättigheter.
# ==============================================================================

# 1. SÄKERHETSINSTÄLLNINGAR
set -u  # Stoppa om en variabel är tom/odefinierad
set -e  # Stoppa om ett kommando misslyckas

# 2. DEFINIERA SÖKVÄGAR (Relativa till var skriptet körs)
# Vi använder $(pwd) för att säkerställa att vi vet var vi är
BASE_DIR="../.."
LOG_DIR="$BASE_DIR/reports/logs"
LOG_FILE="$LOG_DIR/bash_security_report.log"
TARGET_TO_SCAN="$BASE_DIR"  # Vi skannar projektmappen för teständamål

# 3. FÖRBERED MILJÖN
echo "Förbereder loggningsmiljö..."
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
    echo "Skapade mapp: $LOG_DIR"
fi

# 4. LOGGFUNKTION
logga() {
    local meddelande="$1"
    # Citera hela date-kommandot för att undvika mellanslags-fel i Git Bash
    local tidsstampel="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "[$tidsstampel] $meddelande" | tee -a "$LOG_FILE"
}

# 5. HUVUDFUNKTION
kors_kontroll() {
    logga "--- STARTAR SÄKERHETSSKANNING ---"
    logga "Skannar efter world-writable filer i: $TARGET_TO_SCAN"

    # Sök efter filer med rättighet 777 (osäkra)
    # Vi sparar resultatet i en temporär variabel
    local fynd=$(find "$TARGET_TO_SCAN" -type f -perm -0002 -not -path "*/.git/*" 2>/dev/null || true)

    if [ -z "$fynd" ]; then
        logga "RESULTAT: Inga kritiska sårbarheter hittades (Inga world-writable filer)."
    else
        logga "VARNING: Hittade osäkra filer!"
        echo "$fynd" | tee -a "$LOG_FILE"
    fi

    logga "--- SKANNING SLUTFÖRD ---"
    logga "Fullständig rapport finns i: $LOG_FILE"
}

kors_kontroll