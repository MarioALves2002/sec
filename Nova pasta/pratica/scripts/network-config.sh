#!/bin/bash

# Configuração de Rede - Ubuntu Server
# Execute como root

echo "=== CONFIGURAÇÃO DE REDE UBUNTU ==="

# Detectar interface de rede
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
echo "Interface detectada: $INTERFACE"

# Criar configuração netplan
cat > /etc/netplan/01-network.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      dhcp4: false
      addresses:
        - 192.168.100.10/24
      gateway4: 192.168.100.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

# Aplicar configuração
netplan apply

# Verificar configuração
echo "Configuração aplicada:"
ip addr show $INTERFACE
echo ""
echo "Teste de conectividade:"
ping -c 2 8.8.8.8

echo "Configuração de rede concluída!"
echo "IP configurado: 192.168.100.10"