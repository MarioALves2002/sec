#!/bin/bash
# Script principal - Correção completa dos erros PHP do Pegasus
# Versão componentizada para melhor organização

# Carregar configurações e utilitários
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config/constants.sh"
source "$SCRIPT_DIR/config/utils.sh"

# Carregar componentes
source "$SCRIPT_DIR/components/files_component.sh"
source "$SCRIPT_DIR/components/search_component.sh"
source "$SCRIPT_DIR/components/reports_component.sh"
source "$SCRIPT_DIR/components/users_component.sh"
source "$SCRIPT_DIR/components/feedback_component.sh"
source "$SCRIPT_DIR/components/permissions_component.sh"

# Função principal
main() {
    # Verificar privilégios
    check_root
    
    # Header do script
    echo -e "${BLUE}🔧 APLICANDO CORREÇÕES COMPLETAS NO PEGASUS${NC}"
    echo "==========================================="
    echo "📋 Corrigindo warnings PHP e permissões"
    echo "🔧 Melhorando validações de entrada"
    echo "🛡️ Mantendo vulnerabilidades para demonstração"
    echo ""
    
    # Mudar para diretório da aplicação
    cd "$APP_DIR" || {
        log_message "${RED}${MSG_ERROR}" "Diretório $APP_DIR não encontrado"
        exit 1
    }
    
    # Executar correções por componente
    log_message "${BLUE}${MSG_INFO}" "Iniciando correções..."
    
    # 1. Corrigir files.php
    create_files_php
    
    # 2. Corrigir search.php
    create_search_php
    
    # 3. Corrigir reports.php
    create_reports_structure
    create_reports_php
    
    # 4. Melhorar users.php
    create_users_php
    
    # 5. Melhorar feedback.php
    create_feedback_php
    
    # 6. Configurar permissões
    setup_permissions
    
    # 7. Reiniciar containers
    restart_containers
    
    # Relatório final
    show_final_report
}

# Função para mostrar relatório final
show_final_report() {
    echo ""
    echo -e "${GREEN}✅ CORREÇÕES COMPLETAS APLICADAS!${NC}"
    echo "================================="
    echo "🔧 Todas as variáveis PHP validadas"
    echo "📁 Permissões de diretórios corrigidas"
    echo "🎨 Interface melhorada com CSS"
    echo "📊 Logs de auditoria adicionados"
    echo "🛡️ Vulnerabilidades mantidas para demonstração"
    echo "🔄 Containers reiniciados"
    echo ""
    echo -e "${YELLOW}🎯 SISTEMA PRONTO PARA TESTES COM PARROT:${NC}"
    echo "• Burp Suite - Interceptação de requests"
    echo "• SQLMap - Exploração de SQL Injection"
    echo "• Nikto - Scan de vulnerabilidades web"
    echo "• OWASP ZAP - Análise completa de segurança"
    echo "• Manual Testing - Exploração das 6 vulnerabilidades"
    echo ""
    echo -e "${BLUE}📍 Acesse: http://$(hostname -I | awk '{print $1}')/${NC}"
    echo -e "${BLUE}🔑 Credenciais: admin/123, user/password, pegasus/pegasus${NC}"
}

# Executar função principal
main "$@"