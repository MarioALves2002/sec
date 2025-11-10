# Configuração Rápida - Seu Ambiente

## ✅ Ambiente Atual
- **Ubuntu Server:** 192.168.3.216
- **Parrot OS:** 192.168.3.217
- **Rede:** 192.168.3.0/24

## 🚀 Passos para Executar

### 1. No Ubuntu Server (192.168.3.216)
```bash
# Baixar projeto
git clone https://github.com/[SEU-REPO]/trabalho-seguranca.git
cd trabalho-seguranca

# Configurar ambiente vulnerável
sudo chmod +x pratica/scripts/setup-environment.sh
sudo ./pratica/scripts/setup-environment.sh

# Verificar se SSH está ativo
sudo systemctl status ssh
```

### 2. No Parrot OS (192.168.3.217)
```bash
# Instalar ferramentas (se não tiver)
sudo apt update
sudo apt install -y hydra nmap sshpass

# Baixar projeto
git clone https://github.com/[SEU-REPO]/trabalho-seguranca.git
cd trabalho-seguranca

# Testar conectividade
ping -c 3 192.168.3.216

# Executar demos de ataque
chmod +x pratica/vulnerabilidades/demo-vulnerabilities.sh
./pratica/vulnerabilidades/demo-vulnerabilities.sh
```

### 3. Aplicar Hardening (Ubuntu Server)
```bash
# Voltar ao Ubuntu Server
cd trabalho-seguranca/pratica/hardening
sudo chmod +x apply-hardening.sh
sudo ./apply-hardening.sh
```

### 4. Análise Forense (Ubuntu Server)
```bash
cd ../scripts
sudo chmod +x forensic-analysis.sh
sudo ./forensic-analysis.sh
```

## ⚡ Teste Rápido
```bash
# No Parrot: tentar SSH com senha fraca
ssh professor@192.168.3.216
# Senha: 123456 (será criada pelo setup)
```

Seu ambiente está perfeito! Só execute os scripts na ordem acima.