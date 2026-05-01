
    # Ändrad version för att spara filen lokalt
$LoggFil = "./powershell_admin_audit.log"

Write-Host "Kollar administratörer..." -ForegroundColor Yellow

try {
    $AdminGrupp = Get-LocalGroup | Where-Object { $_.SID -eq "S-1-5-32-544" }
    $Medlemmar = Get-LocalGroupMember -Group $AdminGrupp.Name

    "--- START: $(Get-Date) ---" | Out-File $LoggFil -Append

    foreach ($Anvandare in $Medlemmar) {
        $Text = "Hittade admin: $($Anvandare.Name)"
        Write-Host $Text
        $Text | Out-File $LoggFil -Append
    }
    Write-Host "KLART! Filen har skapats: $LoggFil" -ForegroundColor Green
}
catch {
    Write-Host "FEL: Kör som administratör!" -ForegroundColor Red
}