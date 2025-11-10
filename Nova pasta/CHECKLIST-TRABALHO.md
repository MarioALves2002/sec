# Checklist do Trabalho Final
## Segurança da Informação

### ✅ PARTE TEÓRICA (1 ponto)

#### Relatório de Auditoria
- [ ] **Análise de Vulnerabilidades**
  - [ ] 6 vulnerabilidades identificadas e detalhadas
  - [ ] CVSS Score para cada vulnerabilidade
  - [ ] Evidências de cada vulnerabilidade
  - [ ] Mapeamento de vetores de ataque

- [ ] **Análise Forense Digital**
  - [ ] Metodologia de cadeia de custódia
  - [ ] Análise detalhada de logs
  - [ ] Comandos e ferramentas utilizadas
  - [ ] Timeline dos eventos

- [ ] **Análise de Riscos e Impactos**
  - [ ] Impacto institucional quantificado
  - [ ] Impacto humano analisado
  - [ ] Consequências legais (LGPD)
  - [ ] Matriz de riscos

### ✅ PARTE PRÁTICA (3 pontos)

#### Ambiente de Demonstração
- [ ] **Configuração de VMs**
  - [ ] VM Atacante (Kali Linux) configurada
  - [ ] VM Vítima (Ubuntu) configurada
  - [ ] Rede isolada implementada
  - [ ] Ambiente vulnerável funcional

- [ ] **Demonstração de Vulnerabilidades**
  - [ ] Script de demonstração funcional
  - [ ] Ataque de força bruta SSH
  - [ ] Exploração de privilégios
  - [ ] Coleta de informações
  - [ ] Movimento lateral na rede

- [ ] **Hardening do Sistema**
  - [ ] Script de hardening completo
  - [ ] Configuração segura SSH
  - [ ] Implementação de 2FA
  - [ ] Fail2Ban configurado
  - [ ] Firewall implementado
  - [ ] Monitoramento ativo

#### Políticas e Procedimentos
- [ ] **Política de Uso Aceitável**
  - [ ] Diretrizes claras de acesso
  - [ ] Regras de privilégios administrativos
  - [ ] Proteção de dados definida

- [ ] **Programa de Treinamento**
  - [ ] Módulos para professores
  - [ ] Módulos para alunos
  - [ ] Material didático preparado

### ✅ DESENVOLVIMENTO EM SALA (2 pontos)

#### Preparação da Apresentação
- [ ] **Material de Apresentação**
  - [ ] Slides preparados (8-10 slides)
  - [ ] Roteiro de apresentação
  - [ ] Cronometragem definida (20 min)
  - [ ] Demos testadas e funcionais

- [ ] **Preparação para Arguição**
  - [ ] Perguntas esperadas mapeadas
  - [ ] Respostas técnicas preparadas
  - [ ] Conhecimento distribuído entre dupla
  - [ ] Exemplos práticos prontos

### ✅ DOCUMENTAÇÃO (GitHub)

#### Estrutura do Repositório
- [ ] **README.md principal**
  - [ ] Descrição clara do projeto
  - [ ] Instruções de instalação
  - [ ] Como executar as demos
  - [ ] Estrutura do projeto explicada

- [ ] **Documentação Técnica**
  - [ ] Relatório de auditoria completo
  - [ ] Análise forense detalhada
  - [ ] Políticas de segurança
  - [ ] Diagramas de arquitetura

- [ ] **Scripts e Código**
  - [ ] Scripts comentados adequadamente
  - [ ] Código seguindo padrões
  - [ ] Instruções de uso claras
  - [ ] Tratamento de erros implementado

#### Qualidade da Documentação
- [ ] **Padrões Profissionais**
  - [ ] Markdown bem formatado
  - [ ] Imagens e diagramas incluídos
  - [ ] Links funcionais
  - [ ] Estrutura lógica e navegável

### ✅ CRITÉRIOS ESPECÍFICOS

#### Validação de Autenticidade
- [ ] **Código Original**
  - [ ] Implementação própria das funcionalidades
  - [ ] Comentários personalizados
  - [ ] Estilo de código consistente
  - [ ] Referências adequadas quando aplicável

#### Testes de Robustez
- [ ] **Ambiente de Teste**
  - [ ] Demos funcionam consistentemente
  - [ ] Hardening efetivo contra ataques
  - [ ] Logs e monitoramento funcionais
  - [ ] Recuperação de falhas testada

#### Avaliação Cruzada
- [ ] **Preparação para Peer Review**
  - [ ] Rubrica de avaliação estudada
  - [ ] Critérios de qualidade definidos
  - [ ] Feedback construtivo preparado

### ✅ ENTREGÁVEIS FINAIS

#### Arquivos Obrigatórios
- [ ] `README.md` - Documentação principal
- [ ] `docs/relatorio-auditoria.md` - Relatório teórico
- [ ] `docs/politicas-seguranca.md` - Políticas propostas
- [ ] `pratica/scripts/setup-environment.sh` - Configuração ambiente
- [ ] `pratica/vulnerabilidades/demo-vulnerabilities.sh` - Demos de ataque
- [ ] `pratica/hardening/apply-hardening.sh` - Script de hardening
- [ ] `pratica/scripts/forensic-analysis.sh` - Análise forense
- [ ] `apresentacao/roteiro-apresentacao.md` - Roteiro apresentação

#### Verificações Finais
- [ ] **Funcionalidade**
  - [ ] Todos os scripts executam sem erro
  - [ ] Demos reproduzem o cenário
  - [ ] Hardening mitiga vulnerabilidades
  - [ ] Documentação está completa

- [ ] **Qualidade**
  - [ ] Ortografia e gramática revisadas
  - [ ] Formatação consistente
  - [ ] Links e referências funcionais
  - [ ] Código limpo e comentado

### 📋 CRONOGRAMA DE ENTREGA

#### 2 Semanas Antes (Prazo: [Data])
- [ ] Ambiente de VMs configurado
- [ ] Scripts básicos funcionais
- [ ] Estrutura de documentação criada

#### 1 Semana Antes (Prazo: [Data])
- [ ] Documentação teórica completa
- [ ] Demos finalizadas e testadas
- [ ] Material de apresentação pronto

#### 3 Dias Antes (Prazo: [Data])
- [ ] Revisão final de toda documentação
- [ ] Teste completo de todas as demos
- [ ] Ensaio da apresentação

#### Dia da Entrega (03/11/2025)
- [ ] Upload final no GitHub
- [ ] Backup de segurança preparado
- [ ] Material de apresentação testado
- [ ] Dupla preparada para arguição

### 🎯 DICAS DE SUCESSO

1. **Distribuição de Tarefas**
   - Membro 1: Vulnerabilidades 1-3, Análise Forense, Scripts de Ataque
   - Membro 2: Vulnerabilidades 4-6, Hardening, Políticas, Apresentação

2. **Testes Regulares**
   - Testar demos semanalmente
   - Validar scripts em ambiente limpo
   - Verificar documentação com terceiros

3. **Backup e Versionamento**
   - Commits frequentes no GitHub
   - Backup local dos arquivos
   - Versionamento de VMs configuradas

4. **Preparação para Arguição**
   - Cada membro deve conhecer todo o projeto
   - Praticar explicações técnicas
   - Preparar exemplos adicionais

### ⚠️ PONTOS DE ATENÇÃO

- **Plágio:** Código será verificado por MOSS (< 20% similaridade)
- **Conhecimento:** Arguição individual obrigatória
- **Funcionalidade:** Demos devem funcionar no ambiente do professor
- **Documentação:** Padrão profissional obrigatório
- **Tempo:** Apresentação limitada a 20 minutos

---
**Status Atual:** [ ] Em Desenvolvimento [ ] Pronto para Entrega  
**Última Atualização:** [Data]  
**Responsável:** [Nome da Dupla]