#!/bin/bash

# Script de Hardening do Sistema
# Trabalho Final - Segurança da Informação

echo "=== APLICANDO HARDENING DE SEGURANÇA ==="

# Verificar se está executando como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root" 
   exit 1
fi

# 1. Hardening SSH
echo "[1] Aplicando hardening SSH..."

# Backup da configuração atual
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.vulnerable

# Configuração segura do SSH
cat > /etc/ssh/sshd_config << EOF
# Configuração SSH Segura
Port 2222
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# Autenticação
LoginGraceTime 30
PermitRootLogin no
StrictModes yes
MaxAuthTries 3
MaxSessions 2
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PasswordAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no

# Configurações de rede
X11Forwarding no
AllowTcpForwarding no
GatewayPorts no
PermitTunnel no

# Logging
SyslogFacility AUTHPRIV
LogLevel VERBOSE

# Outros
UsePAM yes
UseDNS no
ClientAliveInterval 300
ClientAliveCountMax 2

# Usuários permitidos
AllowUsers professor
EOF

# 2. Configurar autenticação por chave
echo "[2] Configurando autenticação por chave SSH..."
sudo -u professor mkdir -p /home/professor/.ssh
sudo -u professor chmod 700 /home/professor/.ssh

# Gerar par de chaves (se não existir)
if [ ! -f /home/professor/.ssh/id_rsa ]; then
    sudo -u professor ssh-keygen -t rsa -b 4096 -f /home/professor/.ssh/id_rsa -N ""
    sudo -u professor cp /home/professor/.ssh/id_rsa.pub /home/professor/.ssh/authorized_keys
    sudo -u professor chmod 600 /home/professor/.ssh/authorized_keys
fi

# 3. Configurar Fail2Ban
echo "[3] Configurando Fail2Ban..."
cat > /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3
backend = systemd

[sshd]
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
EOF

# 4. Configurar Firewall
echo "[4] Configurando firewall UFW..."
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow 2222/tcp comment 'SSH'
ufw --force enable

# 5. Configurar auditoria
echo "[5] Configurando auditoria do sistema..."
cat > /etc/audit/rules.d/ssh.rules << EOF
# Monitorar tentativas de login SSH
-w /var/log/auth.log -p wa -k ssh_login
-w /etc/ssh/sshd_config -p wa -k ssh_config
-w /home/professor/.ssh/ -p wa -k ssh_keys
EOF

# 6. Configurar logs detalhados
echo "[6] Configurando logs detalhados..."
cat >> /etc/rsyslog.conf << EOF

# Logs SSH detalhados
auth,authpriv.*                 /var/log/auth.log
daemon.info                     /var/log/daemon.log
EOF

# 7. Remover usuários desnecessários e ajustar privilégios
echo "[7] Ajustando privilégios de usuários..."
# Remover professor do grupo sudo (se necessário para demonstração)
# usermod -G professor professor

# 8. Configurar monitoramento de integridade
echo "[8] Configurando monitoramento de integridade..."
apt install -y aide
aideinit
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# 9. Aplicar patches de segurança
echo "[9] Aplicando patches de segurança..."
apt update && apt upgrade -y
apt autoremove -y

# 10. Configurar banner de aviso
echo "[10] Configurando banner de segurança..."
cat > /etc/issue.net << EOF
***************************************************************************
                            AVISO DE SEGURANÇA
***************************************************************************
Este sistema é para uso autorizado apenas. Todas as atividades são
monitoradas e registradas. O uso não autorizado é proibido e pode
resultar em ação disciplinar e/ou legal.
***************************************************************************
EOF

echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config

# Reiniciar serviços
echo "[+] Reiniciando serviços..."
systemctl restart ssh
systemctl restart fail2ban
systemctl restart auditd
systemctl restart rsyslog

echo ""
echo "=== HARDENING CONCLUÍDO ==="
echo "Configurações aplicadas:"
echo "- SSH movido para porta 2222"
echo "- Autenticação por chave habilitada"
echo "- Fail2Ban configurado"
echo "- Firewall UFW ativo"
echo "- Auditoria habilitada"
echo "- Logs detalhados configurados"
echo ""
echo "IMPORTANTE: Teste a conectividade SSH antes de desconectar!"
echo "Comando: ssh -p 2222 -i /home/professor/.ssh/id_rsa professor@localhost"