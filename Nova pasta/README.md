# Trabalho Final - Segurança da Informação
**Disciplina:** Segurança da Informação  
**Curso:** Bacharelado em Sistemas de Informação  
**Período:** 6º período  

## 📋 Descrição do Projeto

Este projeto apresenta uma análise completa de um incidente de segurança ocorrido em laboratório de informática, incluindo análise forense, identificação de vulnerabilidades e implementação de contramedidas.

## 🎯 Objetivos

- **Parte Teórica (1 ponto):** Relatório de auditoria e análise forense
- **Parte Prática (3 pontos):** Demonstração de vulnerabilidades e hardening
- **Desenvolvimento em Sala (2 pontos):** Apresentação e arguição

## 🏗️ Estrutura do Projeto

```
├── docs/                    # Documentação teórica
│   ├── relatorio-auditoria.md
│   ├── analise-forense.md
│   └── diagramas/
├── pratica/                 # Ambiente prático
│   ├── vulnerabilidades/
│   ├── hardening/
│   └── scripts/
├── apresentacao/           # Material de apresentação
└── evidencias/            # Logs e evidências
```

## 🔧 Configuração do Ambiente

### Pré-requisitos
- VirtualBox ou VMware
- Kali Linux (máquina atacante)
- Ubuntu Server (máquina vítima)
- Wireshark para análise de tráfego

### Instalação
1. Clone o repositório
2. Configure as máquinas virtuais conforme documentação
3. Execute os scripts de configuração

## 🚀 Execução

### Ambiente de Teste
```bash
cd pratica/
./setup-environment.sh
```

### Demonstração de Vulnerabilidades
```bash
cd vulnerabilidades/
./demo-vulnerabilities.sh
```

### Aplicação de Hardening
```bash
cd hardening/
./apply-hardening.sh
```

## 📊 Vulnerabilidades Identificadas

1. **SSH com senhas fracas**
2. **Falta de autenticação de dois fatores**
3. **Privilégios excessivos de usuário**
4. **Logs insuficientes**
5. **Rede sem segmentação**
6. **Sistema desatualizado**

## 🛡️ Contramedidas Implementadas

- Configuração segura do SSH
- Implementação de 2FA
- Princípio do menor privilégio
- Monitoramento e logging
- Segmentação de rede
- Gestão de patches

## 👥 Equipe

- [Nome do Membro 1]
- [Nome do Membro 2]

## 📅 Cronograma

- **Análise Teórica:** [Data]
- **Implementação Prática:** [Data]
- **Apresentação:** 03/11/2025

## 📚 Referências

- NIST Cybersecurity Framework
- OWASP Security Guidelines
- RFC 4253 - SSH Protocol