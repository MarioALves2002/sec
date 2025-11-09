#!/bin/bash
# Componente para correção do files.php

create_files_php() {
    log_message "${BLUE}${MSG_INFO}" "Corrigindo files.php..."
    
    cat > "$APP_DIR/app/files.php" << 'PHP'
<?php
session_start();
$msg = '';
$upload_dir = 'uploads/';

if (!is_dir($upload_dir)) {
    mkdir($upload_dir, 0777, true);
}

if (isset($_FILES['file']) && $_FILES['file']['error'] === UPLOAD_ERR_OK) {
    $file = $_FILES['file'];
    $filename = basename($file['name']);
    $target = $upload_dir . $filename;
    
    if (move_uploaded_file($file['tmp_name'], $target)) {
        $msg = "✅ Arquivo $filename enviado com sucesso!";
        $msg .= "<br>📁 Salvo em: " . realpath($target);
        $msg .= "<br>📏 Tamanho: " . filesize($target) . " bytes";
    } else {
        $msg = "❌ Erro no upload do arquivo";
    }
} elseif (isset($_FILES['file']) && $_FILES['file']['error'] !== UPLOAD_ERR_NO_FILE) {
    $error_messages = [
        UPLOAD_ERR_INI_SIZE => 'Arquivo muito grande (limite do servidor)',
        UPLOAD_ERR_FORM_SIZE => 'Arquivo muito grande (limite do formulário)',
        UPLOAD_ERR_PARTIAL => 'Upload incompleto',
        UPLOAD_ERR_NO_TMP_DIR => 'Diretório temporário não encontrado',
        UPLOAD_ERR_CANT_WRITE => 'Erro de escrita no disco',
        UPLOAD_ERR_EXTENSION => 'Upload bloqueado por extensão'
    ];
    $msg = "❌ " . ($error_messages[$_FILES['file']['error']] ?? 'Erro desconhecido no upload');
}

$files = glob($upload_dir . '*') ?: [];
?>
<!DOCTYPE html>
<html>
<head>
    <title>Arquivos - Pegasus</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        .upload-form { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .file-list { background: #fff; border: 1px solid #ddd; border-radius: 8px; padding: 15px; }
        .vuln-info { background: #f8d7da; border: 1px solid #f5c6cb; padding: 15px; border-radius: 8px; margin-top: 20px; }
        .msg { padding: 10px; margin: 10px 0; border-radius: 5px; }
        .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
    </style>
</head>
<body>
    <div class="container">
        <h2>🗂️ Sistema de Upload de Arquivos</h2>
        
        <?php if($msg): ?>
        <div class="msg <?= strpos($msg, '✅') !== false ? 'success' : 'error' ?>"><?= $msg ?></div>
        <?php endif; ?>
        
        <div class="upload-form">
            <h3>📤 Enviar Arquivo</h3>
            <form method="post" enctype="multipart/form-data">
                <input type="file" name="file" required style="padding: 8px; margin: 10px 0; width: 100%;">
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">📤 Fazer Upload</button>
            </form>
            <small>⚠️ Sistema sem validação de tipo - aceita qualquer arquivo</small>
        </div>
        
        <div class="file-list">
            <h3>📋 Arquivos Enviados (<?= count($files) ?>)</h3>
            <?php if (empty($files)): ?>
                <p><em>Nenhum arquivo enviado ainda.</em></p>
            <?php else: ?>
                <ul style="list-style: none; padding: 0;">
                    <?php foreach($files as $file): ?>
                    <li style="padding: 8px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between;">
                        <span>
                            📄 <a href="<?= $file ?>" target="_blank" style="text-decoration: none; color: #007bff;"><?= basename($file) ?></a>
                        </span>
                        <small style="color: #666;"><?= date('d/m/Y H:i', filemtime($file)) ?> | <?= number_format(filesize($file)) ?> bytes</small>
                    </li>
                    <?php endforeach; ?>
                </ul>
            <?php endif; ?>
        </div>
        
        <div class="vuln-info">
            <strong>🎯 VULNERABILIDADE: File Upload Irrestrito</strong><br>
            <strong>Risco:</strong> Execução de código malicioso no servidor<br>
            <strong>Teste:</strong> Faça upload de um arquivo .php com código malicioso<br>
            <strong>Exemplo:</strong> <code>&lt;?php system($_GET['cmd']); ?&gt;</code><br>
            <strong>CVSS Score:</strong> 8.8 (High)
        </div>
        
        <p style="margin-top: 30px;"><a href="index.php" style="text-decoration: none; color: #007bff;">← Voltar ao Portal</a></p>
    </div>
</body>
</html>
PHP
    
    log_message "${GREEN}${MSG_SUCCESS}" "files.php corrigido"
}