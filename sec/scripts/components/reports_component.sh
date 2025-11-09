#!/bin/bash
# Componente para correção do reports.php

create_reports_structure() {
    log_message "${BLUE}${MSG_INFO}" "Criando estrutura de relatórios..."
    
    ensure_directory "$APP_DIR/app/reports" 755
    
    # Criar arquivos de exemplo
    cat > "$APP_DIR/app/reports/vendas.txt" << 'TXT'
=== RELATÓRIO DE VENDAS - PEGASUS CORP ===
Período: Janeiro - Março 2024

JANEIRO 2024:
- Vendas Totais: R$ 125.450,00
- Produtos Vendidos: 1.247 unidades
- Clientes Atendidos: 89
- Meta Atingida: 104%

FEVEREIRO 2024:
- Vendas Totais: R$ 98.320,00
- Produtos Vendidos: 956 unidades
- Clientes Atendidos: 67
- Meta Atingida: 87%

MARÇO 2024:
- Vendas Totais: R$ 156.780,00
- Produtos Vendidos: 1.589 unidades
- Clientes Atendidos: 112
- Meta Atingida: 125%

TOTAL TRIMESTRE: R$ 380.550,00
Crescimento: +15% vs trimestre anterior
TXT

    cat > "$APP_DIR/app/reports/usuarios.txt" << 'TXT'
=== RELATÓRIO DE USUÁRIOS - PEGASUS CORP ===
Data: $(date +"%d/%m/%Y %H:%M")

USUÁRIOS ATIVOS:
- Administradores: 3
- Usuários Regulares: 147
- Usuários Convidados: 23
- Total Ativos: 173

USUÁRIOS INATIVOS:
- Contas Suspensas: 12
- Contas Expiradas: 8
- Total Inativos: 20

ESTATÍSTICAS DE ACESSO:
- Logins Hoje: 89
- Logins Esta Semana: 456
- Último Login: $(date +"%d/%m/%Y %H:%M")

SEGURANÇA:
- Senhas Fracas Detectadas: 15
- 2FA Habilitado: 67%
- Tentativas de Login Falhadas: 23
TXT

    cat > "$APP_DIR/app/reports/financeiro.txt" << 'TXT'
=== RELATÓRIO FINANCEIRO - CONFIDENCIAL ===
ACESSO RESTRITO - APENAS DIRETORIA

RECEITAS:
- Vendas de Produtos: R$ 2.450.000,00
- Serviços: R$ 890.000,00
- Investimentos: R$ 125.000,00

DESPESAS:
- Folha de Pagamento: R$ 1.200.000,00
- Infraestrutura: R$ 450.000,00
- Marketing: R$ 230.000,00

LUCRO LÍQUIDO: R$ 1.585.000,00
Margem: 48.3%
TXT

    chmod 644 "$APP_DIR/app/reports"/*.txt
    log_message "${GREEN}${MSG_SUCCESS}" "Arquivos de relatório criados"
}

create_reports_php() {
    log_message "${BLUE}${MSG_INFO}" "Corrigindo reports.php..."
    
    cat > "$APP_DIR/app/reports.php" << 'PHP'
<?php
session_start();
$content = '';
$error = '';
$file = isset($_GET['file']) ? trim($_GET['file']) : '';
$reports_dir = 'reports/';

if (!is_dir($reports_dir)) {
    mkdir($reports_dir, 0755, true);
}

if (!empty($file)) {
    $filepath = $reports_dir . $file;
    error_log("[PEGASUS] File access attempt: $file from IP: " . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'));
    
    if (file_exists($filepath) && is_file($filepath)) {
        $content = file_get_contents($filepath);
        if ($content === false) {
            $error = "❌ Erro ao ler o arquivo: $file";
        }
    } else {
        $error = "❌ Arquivo não encontrado: $file";
        $error .= "<br><small>Caminho tentado: $filepath</small>";
    }
}

$available_files = [];
if (is_dir($reports_dir)) {
    $files = scandir($reports_dir);
    foreach ($files as $f) {
        if ($f !== '.' && $f !== '..' && is_file($reports_dir . $f)) {
            $available_files[] = $f;
        }
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Relatórios - Pegasus</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1000px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        .reports-list { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .file-form { background: #fff3cd; padding: 15px; border-radius: 8px; margin: 20px 0; }
        .content-box { background: #f8f9fa; border: 1px solid #dee2e6; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .vuln-info { background: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 8px; margin-top: 20px; }
        .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; padding: 10px; border-radius: 5px; margin: 10px 0; }
        pre { white-space: pre-wrap; word-wrap: break-word; max-height: 500px; overflow-y: auto; font-size: 14px; }
        .file-item { padding: 8px; margin: 5px 0; border: 1px solid #ddd; border-radius: 4px; display: flex; justify-content: space-between; align-items: center; }
    </style>
</head>
<body>
    <div class="container">
        <h2>📊 Sistema de Relatórios Corporativos</h2>
        <p>Acesso aos relatórios gerenciais e operacionais da Pegasus Corp.</p>
        
        <?php if($error): ?>
        <div class="error"><?= $error ?></div>
        <?php endif; ?>
        
        <div class="reports-list">
            <h3>📋 Relatórios Disponíveis</h3>
            <?php if (empty($available_files)): ?>
                <p><em>Nenhum relatório encontrado no diretório.</em></p>
            <?php else: ?>
                <?php foreach($available_files as $report_file): ?>
                <div class="file-item">
                    <span>
                        📄 <a href="?file=<?= urlencode($report_file) ?>" style="text-decoration: none; color: #007bff; font-weight: bold;"><?= htmlspecialchars($report_file) ?></a>
                    </span>
                    <small style="color: #666;">
                        <?= date('d/m/Y H:i', filemtime($reports_dir . $report_file)) ?> | 
                        <?= number_format(filesize($reports_dir . $report_file)) ?> bytes
                    </small>
                </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
        
        <div class="file-form">
            <h3>🔍 Buscar Relatório Específico</h3>
            <form method="get">
                <input name="file" 
                       placeholder="Digite o nome do arquivo (ex: vendas.txt)" 
                       value="<?= htmlspecialchars($file) ?>" 
                       style="width: 70%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                <button type="submit" 
                        style="padding: 8px 15px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; margin-left: 10px;">
                    📂 Visualizar
                </button>
            </form>
            <small>⚠️ Sistema vulnerável - aceita qualquer caminho de arquivo</small>
        </div>
        
        <?php if($content && !$error): ?>
        <div class="content-box">
            <h3>📄 Conteúdo do Arquivo: <?= htmlspecialchars($file) ?></h3>
            <pre><?= htmlspecialchars($content) ?></pre>
        </div>
        <?php endif; ?>
        
        <div class="vuln-info">
            <strong>🎯 VULNERABILIDADE: Directory Traversal (Path Traversal)</strong><br>
            <strong>Risco:</strong> Acesso não autorizado a arquivos do sistema<br>
            <strong>Impacto:</strong> Leitura de arquivos sensíveis, exposição de dados<br>
            <strong>Testes de Penetração:</strong><br>
            • <code>../../../etc/passwd</code> - Ler arquivo de usuários do sistema<br>
            • <code>../../../etc/shadow</code> - Tentar ler senhas hash<br>
            • <code>../app/login.php</code> - Ler código fonte da aplicação<br>
            • <code>../../../var/log/auth.log</code> - Ler logs de autenticação<br>
            • <code>..\..\..\windows\system32\drivers\etc\hosts</code> - Windows<br>
            <strong>CVSS Score:</strong> 7.5 (High)
        </div>
        
        <p style="margin-top: 30px;"><a href="index.php" style="text-decoration: none; color: #007bff;">← Voltar ao Portal</a></p>
    </div>
</body>
</html>
PHP
    
    log_message "${GREEN}${MSG_SUCCESS}" "reports.php corrigido"
}