@echo off
echo ===================================
echo   CONFIGURACAO RAPIDA - WINDOWS
echo ===================================
echo.

echo [1] Baixando VirtualBox...
echo Acesse: https://www.virtualbox.org/wiki/Downloads
echo Baixe: VirtualBox 7.0.x for Windows hosts
echo.

echo [2] Baixando ISOs...
echo Ubuntu Server: https://ubuntu.com/download/server
echo Kali Linux: https://www.kali.org/get-kali/
echo.

echo [3] Criando VMs no VirtualBox...
echo.

echo Criando VM Ubuntu (Vitima)...
echo - Nome: Ubuntu-Victim
echo - Tipo: Linux / Ubuntu (64-bit)
echo - RAM: 2048 MB
echo - Disco: 20 GB (VDI dinamico)
echo - Rede: Rede Interna (labnet)
echo.

echo Criando VM Kali (Atacante)...
echo - Nome: Kali-Attacker  
echo - Tipo: Linux / Debian (64-bit)
echo - RAM: 4096 MB
echo - Disco: 20 GB (VDI dinamico)
echo - Rede: Rede Interna (labnet)
echo.

echo [4] Configuracao de Rede...
echo No VirtualBox: Arquivo > Preferencias > Rede
echo Adicionar rede NAT: labnet (192.168.100.0/24)
echo.

echo [5] Instalacao Ubuntu Server...
echo - IP: 192.168.100.10/24
echo - Usuario: admin / admin123
echo - Instalar OpenSSH Server
echo.

echo [6] Instalacao Kali Linux...
echo - IP: 192.168.100.20/24  
echo - Usuario: kali / kali
echo.

echo [7] Teste de Conectividade...
echo No Kali: ping 192.168.100.10
echo No Kali: ssh admin@192.168.100.10
echo.

echo ===================================
echo   CONFIGURACAO CONCLUIDA!
echo ===================================
pause