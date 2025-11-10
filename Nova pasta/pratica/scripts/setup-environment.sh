#!/bin/bash

# Script de Configuração do Ambiente de Teste
# Trabalho Final - Segurança da Informação

echo "=== Configuração do Ambiente de Teste ==="
echo "Configurando máquinas virtuais para demonstração..."

# Verificar se está executando como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root" 
   exit 1
fi

# Atualizar sistema
echo "[+] Atualizando sistema..."
apt update && apt upgrade -y

# Instalar dependências
echo "[+] Instalando dependências..."
apt install -y openssh-server fail2ban ufw rsyslog auditd

# Configurar SSH vulnerável (para demonstração)
echo "[+] Configurando SSH vulnerável..."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

cat > /etc/ssh/sshd_config << EOF
Port 22
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
UsePrivilegeSeparation yes
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
EOF

# Criar usuário vulnerável
echo "[+] Criando usuário de teste..."
useradd -m -s /bin/bash professor
echo "professor:123456" | chpasswd
usermod -aG sudo professor

# Configurar logs
echo "[+] Configurando sistema de logs..."
systemctl enable rsyslog
systemctl start rsyslog

# Desabilitar firewall (para demonstração)
echo "[+] Desabilitando firewall..."
ufw --force disable

# Reiniciar SSH
echo "[+] Reiniciando SSH..."
systemctl restart ssh

echo "=== Configuração Concluída ==="
echo "Usuário criado: professor"
echo "Senha: 123456"
echo "SSH configurado na porta 22"
echo ""
echo "ATENÇÃO: Esta configuração é VULNERÁVEL e deve ser usada apenas para demonstração!"