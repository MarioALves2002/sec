#!/bin/bash
# Componente para correção do users.php

create_users_php() {
    log_message "${BLUE}${MSG_INFO}" "Melhorando users.php..."
    
    cat > "$APP_DIR/app/users.php" << 'PHP'
<?php
session_start();

try {
    $pdo = new PDO('mysql:host=pegasus-db;dbname=pegasus', 'pegasus', 'pegasus123');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erro de conexão: " . $e->getMessage());
}

$search = isset($_GET['search']) ? trim($_GET['search']) : '';
$users = [];
$error = '';

try {
    if (!empty($search)) {
        $query = "SELECT * FROM users WHERE username LIKE '%$search%' OR email LIKE '%$search%'";
        error_log("[PEGASUS] Search query: $query from IP: " . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'));
        
        $result = $pdo->query($query);
        $users = $result ? $result->fetchAll(PDO::FETCH_ASSOC) : [];
    } else {
        $result = $pdo->query("SELECT * FROM users ORDER BY id");
        $users = $result->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (PDOException $e) {
    $error = "❌ Erro na consulta: " . $e->getMessage();
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Usuários - Pegasus</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1000px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        .search-form { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .users-table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        .users-table th, .users-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .users-table th { background: #f8f9fa; font-weight: bold; }
        .users-table tr:hover { background: #f5f5f5; }
        .vuln-info { background: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 8px; margin-top: 20px; }
        .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; padding: 10px; border-radius: 5px; margin: 10px 0; }
        .stats { background: #d4edda; border: 1px solid #c3e6cb; padding: 15px; border-radius: 8px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h2>👥 Sistema de Gerenciamento de Usuários</h2>
        
        <?php if($error): ?>
        <div class="error"><?= htmlspecialchars($error) ?></div>
        <?php endif; ?>
        
        <div class="search-form">
            <h3>🔍 Buscar Usuários</h3>
            <form method="get">
                <input name="search" 
                       value="<?= htmlspecialchars($search) ?>" 
                       placeholder="Buscar por nome de usuário ou email..." 
                       style="width: 70%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                <button type="submit" 
                        style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; margin-left: 10px;">
                    🔍 Buscar
                </button>
                <?php if($search): ?>
                <a href="users.php" 
                   style="padding: 10px 15px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px; margin-left: 5px; display: inline-block;">
                    🔄 Limpar
                </a>
                <?php endif; ?>
            </form>
        </div>
        
        <?php if(!empty($users)): ?>
        <div class="stats">
            <strong>📊 Resultados:</strong> <?= count($users) ?> usuário(s) encontrado(s)
            <?php if($search): ?>
            para a busca: "<em><?= htmlspecialchars($search) ?></em>"
            <?php endif; ?>
        </div>
        
        <table class="users-table">
            <thead>
                <tr>
                    <th>🆔 ID</th>
                    <th>👤 Usuário</th>
                    <th>📧 Email</th>
                    <th>🎭 Perfil</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach($users as $user): ?>
                <tr>
                    <td><?= htmlspecialchars($user['id']) ?></td>
                    <td><strong><?= htmlspecialchars($user['username']) ?></strong></td>
                    <td><?= htmlspecialchars($user['email']) ?></td>
                    <td>
                        <span style="padding: 4px 8px; background: <?= $user['role'] === 'administrator' ? '#dc3545' : ($user['role'] === 'manager' ? '#ffc107' : '#28a745') ?>; color: white; border-radius: 12px; font-size: 12px;">
                            <?= htmlspecialchars($user['role']) ?>
                        </span>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <?php else: ?>
        <div style="text-align: center; padding: 40px; color: #666;">
            <h3>😕 Nenhum usuário encontrado</h3>
            <?php if($search): ?>
            <p>Tente uma busca diferente ou <a href="users.php">visualize todos os usuários</a>.</p>
            <?php else: ?>
            <p>Não há usuários cadastrados no sistema.</p>
            <?php endif; ?>
        </div>
        <?php endif; ?>
        
        <div class="vuln-info">
            <strong>🎯 VULNERABILIDADE: SQL Injection</strong><br>
            <strong>Risco:</strong> Acesso não autorizado ao banco de dados<br>
            <strong>Impacto:</strong> Leitura, modificação ou exclusão de dados<br>
            <strong>Testes de Penetração:</strong><br>
            • <code>admin' OR '1'='1</code> - Bypass de autenticação<br>
            • <code>admin' UNION SELECT 1,2,3,4-- -</code> - Union-based injection<br>
            • <code>admin'; DROP TABLE users;-- -</code> - Destruição de dados<br>
            • <code>admin' UNION SELECT user(),database(),version(),@@datadir-- -</code> - Info gathering<br>
            <strong>CVSS Score:</strong> 9.8 (Critical)
        </div>
        
        <p style="margin-top: 30px;"><a href="index.php" style="text-decoration: none; color: #007bff;">← Voltar ao Portal</a></p>
    </div>
</body>
</html>
PHP
    
    log_message "${GREEN}${MSG_SUCCESS}" "users.php melhorado"
}