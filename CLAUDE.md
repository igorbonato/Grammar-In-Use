# GrammarApp Interactive - Documentação de Contexto (AI Prompt)

## 🎯 Objetivo do Projeto
Desenvolver uma plataforma web de estudos gramaticais focada em alta retenção e zero distrações. O sistema será a versão digital interativa do *English Grammar in Use*. O foco é recriar a experiência de um livro aberto através de uma interface Split-Screen moderna (estilo Notion misturado com Duolingo).

## 🛠️ Stack Tecnológico
* **Front-end:** React (Vite) com TypeScript.
* **Estilização:** Tailwind CSS (Baseado no Figma).
* **Back-end / Banco de Dados:** Supabase (PostgreSQL).
* **Deploy:** Vercel.

## 📂 Estrutura do Material Original & Ingestão de Dados
O material base está dividido em dezenas de PDFs. O processo de desenvolvimento e população do banco de dados ocorrerá **módulo por módulo** (ex: *Present and past*, *Modals*, *Future*, etc.).
* **Regra de Negócio (Additional Exercises):** Os exercícios contidos no arquivo `Additional exercises.pdf` não devem formar um menu isolado. Eles devem ser vinculados às tabelas do banco de dados como exercícios extras das respectivas categorias/módulos que eles testam.
* **Recursos (Resources):** Arquivos como `Appendix`, `Study guide` e `Index` terão visões dedicadas na aplicação futuramente.

## 📐 Regras de Arquitetura e UI
* **Modularidade React:** Gere componentes pequenos, isolados e reutilizáveis (ex: `<SidebarAccordion />`, `<GrammarRuleBox />`, `<InlineInput />`, `<ActionFooter />`).
* **Estilo Visual (Clean):** Fundo majoritariamente branco e cinza muito claro (#F9FAFB) para legibilidade. Paleta baseada em tons de azul da Cambridge. Sem sombras pesadas ou excesso de bordas.
* **Layout Desktop (Split Screen):** A área central é dividida em duas colunas verticais de mesma largura:
  * **Lado Esquerdo (Teoria):** Renderiza o título da Unidade, regras gramaticais e caixas com fundo azul claro contendo exemplos em itálico. Deve suportar placeholders para imagens ilustrativas.
  * **Lado Direito (Prática):** Focado no cabeçalho "Exercises". Formulários dinâmicos com inputs de texto (`<input type="text" />`) integrados no meio das frases.
* **Botão Flutuante/Fixo:** Um footer contendo o botão "Check Answers" que varre o estado dos inputs e fornece feedback visual imediato (Verde para correto, Vermelho para incorreto).

## 📌 Funcionalidades Principais (Core)
1. **Sidebar de Navegação:**
   * Botão "Study Guide" em destaque (Avaliação).
   * Módulos em formato Accordion/Dropdown (ex: Expande "Present and past" para mostrar as unidades de 1 a 6).
   * Links para os Recursos.
   * Barra de progresso global (ex: "4 of 145 units completed").
2. **Sistema de Resolução Interativa:** Inputs devem se auto-ajustar ou ter tamanho padrão. O usuário digita as palavras faltantes e submete.
3. **Gestão de Progresso:** Ao clicar em "Check Answers" e acertar, o Supabase registra a Unidade como concluída e libera a navegação para a "Next unit".
