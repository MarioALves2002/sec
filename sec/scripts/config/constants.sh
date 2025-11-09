#!/bin/bash
# Constantes e configurações globais

# Diretórios
readonly APP_DIR="/opt/pegasus"
readonly UPLOAD_DIR="uploads/"
readonly REPORTS_DIR="reports/"

# Mensagens
readonly MSG_SUCCESS="✅"
readonly MSG_ERROR="❌"
readonly MSG_INFO="🔧"
readonly MSG_WARNING="⚠️"

# Cores para output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configurações do banco
readonly DB_HOST="pegasus-db"
readonly DB_NAME="pegasus"
readonly DB_USER="pegasus"
readonly DB_PASS="pegasus123"