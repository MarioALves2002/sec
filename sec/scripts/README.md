# Sistema Pegasus - Scripts Componentizados

Este diretório contém os scripts organizados em componentes para facilitar a manutenção e reutilização.

## Estrutura

```
scripts/
├── config/
│   ├── constants.sh      # Constantes e configurações globais
│   └── utils.sh          # Funções utilitárias reutilizáveis
├── components/
│   ├── files_component.sh      # Correção do sistema de upload
│   ├── search_component.sh     # Correção do sistema de busca
│   ├── reports_component.sh    # Correção do sistema de relatórios
│   ├── users_component.sh      # Correção do sistema de usuários
│   ├── feedback_component.sh   # Correção do sistema de feedback
│   └── permissions_component.sh # Configuração de permissões
├── main.sh               # Script principal
└── README.md            # Esta documentação
```

## Como usar

### Executar correção completa:
```bash
sudo ./scripts/main.sh
```

### Executar componente específico:
```bash
# Carregar configurações
source scripts/config/constants.sh
source scripts/config/utils.sh

# Carregar e executar componente específico
source scripts/components/files_component.sh
create_files_php
```

## Componentes

### 1. Config
- **constants.sh**: Define todas as constantes usadas no sistema
- **utils.sh**: Funções utilitárias como logging, verificação de root, etc.

### 2. Components
Cada componente é responsável por uma funcionalidade específica:

- **files_component.sh**: Sistema de upload de arquivos
- **search_component.sh**: Sistema de teste de conectividade
- **reports_component.sh**: Sistema de relatórios corporativos
- **users_component.sh**: Sistema de gerenciamento de usuários
- **feedback_component.sh**: Sistema de feedback
- **permissions_component.sh**: Configuração de permissões e containers

## Vantagens da Componentização

1. **Modularidade**: Cada funcionalidade em arquivo separado
2. **Reutilização**: Componentes podem ser usados independentemente
3. **Manutenção**: Mais fácil de manter e debugar
4. **Organização**: Código mais limpo e estruturado
5. **Escalabilidade**: Fácil adicionar novos componentes

## Logs

Todos os componentes usam o sistema de logging centralizado definido em `utils.sh`:
- Timestamps automáticos
- Cores para diferentes tipos de mensagem
- Logs estruturados

## Permissões

Certifique-se de que os scripts tenham permissão de execução:
```bash
chmod +x scripts/main.sh
chmod +x scripts/config/*.sh
chmod +x scripts/components/*.sh
```