# Projektrapport: Säkerhetsgranskning

## Genomförda uppgifter
Jag har skapat och kört tre olika skript för att granska säkerheten i systemet:
1. **Bash (`security_check.sh`):** Letar efter filer med osäkra rättigheter (world-writable).
2. **PowerShell (`inactive_users.ps1`):** Listar lokala administratörer för att se vem som har hög behörighet.
3. **Python (`failed_logins.py`):** Dokumenterar nätverksstatus och IP-adress.

## Utmaningar och lösningar
* **Rättigheter:** Jag lärde mig att vissa kommandon i PowerShell kräver administratörsbehörighet. Jag löste detta genom att köra terminalen som administratör.
* **Encoding:** Jag fick problem med konstiga tecken (NULL) i loggfilen. Detta löstes genom att tvinga filerna att sparas med `UTF-8` encoding.

## Resultat
Alla loggfiler har samlats i `bilagor/korresultat.txt` och `bilagor/loggutdrag.txt`.