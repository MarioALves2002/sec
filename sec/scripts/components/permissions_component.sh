#!/bin/bash
# Componente para configuração de permissões

setup_permissions() {
    log_message "${BLUE}${MSG_INFO}" "Configurando permissões..."
    
    # Permissões básicas da aplicação
    set_permissions "$APP_DIR/app" 755
    
    # Permissões especiais para uploads e reports
    set_permissions "$APP_DIR/app/$UPLOAD_DIR" 777
    set_permissions "$APP_DIR/app/$REPORTS_DIR" 777
    
    log_message "${GREEN}${MSG_SUCCESS}" "Permissões configuradas"
}

restart_containers() {
    log_message "${BLUE}${MSG_INFO}" "Reiniciando containers..."
    
    cd "$APP_DIR"
    docker-compose restart
    sleep 5
    
    log_message "${GREEN}${MSG_SUCCESS}" "Containers reiniciados"
}