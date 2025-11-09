#!/bin/bash
# Funções utilitárias

source "$(dirname "${BASH_SOURCE[0]}")/constants.sh"

# Verificar se é root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}${MSG_ERROR} Execute como root${NC}"
        exit 1
    fi
}

# Log com timestamp
log_message() {
    local level="$1"
    local message="$2"
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${level} ${message}"
}

# Criar diretório se não existir
ensure_directory() {
    local dir="$1"
    local permissions="${2:-755}"
    
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        chmod "$permissions" "$dir"
        log_message "${GREEN}${MSG_SUCCESS}" "Diretório criado: $dir"
    fi
}

# Aplicar permissões
set_permissions() {
    local path="$1"
    local permissions="$2"
    
    chmod -R "$permissions" "$path"
    chown -R 1000:1000 "$path"
    log_message "${GREEN}${MSG_SUCCESS}" "Permissões aplicadas: $path ($permissions)"
}