# Configuração do Ambiente de Teste

## 1. REQUISITOS

### Software Necessário
- VirtualBox 7.0+ ou VMware Workstation
- Kali Linux ISO (máquina atacante)
- Ubuntu Server 22.04 LTS ISO (máquina vítima)
- 8GB RAM disponível
- 40GB espaço em disco

## 2. CONFIGURAÇÃO DAS VMs

### VM 1: Ubuntu Server (Vítima)
```
Nome: Ubuntu-Victim
RAM: 2GB
Disco: 20GB
Rede: Rede Interna (nome: labnet)
IP: 192.168.100.10
```

### VM 2: Kali Linux (Atacante)
```
Nome: Kali-Attacker
RAM: 4GB
Disco: 20GB
Rede: Rede Interna (nome: labnet)
IP: 192.168.100.20
```

## 3. INSTALAÇÃO UBUNTU SERVER

1. **Boot da ISO Ubuntu Server**
2. **Configuração de rede:**
   ```
   IP: 192.168.100.10
   Máscara: 255.255.255.0
   Gateway: 192.168.100.1
   DNS: 8.8.8.8
   ```
3. **Usuário inicial:** `admin` / `admin123`
4. **Instalar SSH:** Marcar durante instalação

## 4. CONFIGURAÇÃO INICIAL UBUNTU

```bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar ferramentas básicas
sudo apt install -y curl wget git nano

# Baixar scripts do projeto
git clone [URL_DO_SEU_REPOSITORIO]
cd [NOME_DO_REPOSITORIO]

# Executar configuração vulnerável
sudo chmod +x pratica/scripts/setup-environment.sh
sudo ./pratica/scripts/setup-environment.sh
```

## 5. INSTALAÇÃO KALI LINUX

1. **Boot da ISO Kali Linux**
2. **Configuração de rede:**
   ```
   IP: 192.168.100.20
   Máscara: 255.255.255.0
   Gateway: 192.168.100.1
   DNS: 8.8.8.8
   ```
3. **Usuário:** `kali` / `kali`

## 6. CONFIGURAÇÃO KALI

```bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar ferramentas de teste
sudo apt install -y hydra nmap sshpass

# Testar conectividade
ping 192.168.100.10

# Baixar scripts
git clone [URL_DO_SEU_REPOSITORIO]
cd [NOME_DO_REPOSITORIO]
chmod +x pratica/vulnerabilidades/demo-vulnerabilities.sh
```

## 7. TESTE DE CONECTIVIDADE

### No Kali (Atacante):
```bash
# Testar ping
ping -c 3 192.168.100.10

# Testar SSH
ssh professor@192.168.100.10
# Senha: 123456
```

### No Ubuntu (Vítima):
```bash
# Verificar SSH ativo
sudo systemctl status ssh

# Ver logs em tempo real
sudo tail -f /var/log/auth.log
```

## 8. EXECUÇÃO DAS DEMOS

### Demonstrar Vulnerabilidades:
```bash
# No Kali
cd pratica/vulnerabilidades/
./demo-vulnerabilities.sh
```

### Aplicar Hardening:
```bash
# No Ubuntu
cd pratica/hardening/
sudo ./apply-hardening.sh
```

### Análise Forense:
```bash
# No Ubuntu
cd pratica/scripts/
sudo ./forensic-analysis.sh
```

## 9. TROUBLESHOOTING

### SSH não conecta:
```bash
# Verificar serviço
sudo systemctl status ssh
sudo systemctl restart ssh

# Verificar porta
sudo netstat -tlnp | grep :22
```

### Rede não funciona:
```bash
# Verificar IP
ip addr show
# Reconfigurar se necessário
sudo netplan apply
```

### Scripts não executam:
```bash
# Dar permissão
chmod +x *.sh
# Verificar dependências
which hydra nmap sshpass
```