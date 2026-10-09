@echo off
setlocal

set "WIFI_INTERFACE_NAME=Wi-Fi"
set "status_code="

for /f "delims=" %%A in ('powershell.exe -NoProfile -NonInteractive -Command "$name = $env:WIFI_INTERFACE_NAME; Get-CimInstance Win32_NetworkAdapter | Where-Object { $_.NetConnectionID -eq $name } | Select-Object -ExpandProperty NetConnectionStatus" 2^>nul') do (
    echo Captured=[%%A]
    set "status_code=%%A"
)

echo Final=[%status_code%]
pause