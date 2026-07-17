# GrammarApp Interactive

Versão web interativa do *English Grammar in Use*, focada em alta retenção e zero distrações. A interface recria a experiência de um livro aberto através de um layout Split-Screen: teoria gramatical de um lado, exercícios práticos com feedback imediato do outro.

## Stack

- **Front-end:** React (Vite) + TypeScript, Tailwind CSS
- **Roteamento:** React Router (`/modulo/:moduleId/:unitId`)
- **Back-end / Banco de dados:** Supabase (PostgreSQL)
- **Deploy:** Vercel

## Estrutura do repositório

```
src/              Aplicação front-end (Vite + React + Tailwind) — raiz do projeto
  components/     Componentes de apresentação (layout/, theory/, exercises/)
  data/           Currículo mockado (módulos/units para a sidebar; conteúdo em si já vem do Supabase)
  hooks/          Hooks de dados (TanStack Query) e utilitários de correção de exercícios
  lib/            Cliente Supabase, query client, parsing de template, grading
  store/          Estado global (Zustand): auth anônima, formulário de exercícios
  routes/         Configuração de rotas
  types/          Tipos compartilhados de domínio (Unit, Module, ExerciseSet...)

pdf/              Material bruto original (PDFs do livro), usado como fonte para
                  ingestão de conteúdo. Não versionado no Git — ver abaixo.

supabase/
  migrations/     Migrations do schema do banco + seeds de conteúdo por módulo. O projeto
                  Supabase está linkado ao repositório no GitHub, então tudo aqui é aplicado
                  automaticamente a cada push na main — não precisa rodar nada manualmente.
  seed/           unit-1.sql (seed de referência do Marco 1, ainda rodado manualmente no SQL
                  Editor). Novo conteúdo de módulo vai direto em migrations/, não aqui.
tools/ingestion/  Scripts de extração de conteúdo dos PDFs (a criar)
```

## Rodando localmente

```bash
pnpm install
pnpm dev
```

O app sobe em `http://localhost:8443`. Precisa de um `.env` com `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` (ver `.env.example`).

Progresso do usuário é opcional: o app funciona inteiro sem autenticação (teoria e exercícios são leitura pública). Para persistir progresso é necessário habilitar "Anonymous Sign-Ins" em Authentication → Sign In / Providers no dashboard do Supabase — sem isso, "Check Answers" ainda dá feedback e pontuação, só não grava em `user_unit_progress`.

## Sobre os PDFs em `pdf/`

Os PDFs do livro (módulos gramaticais, additional exercises, appendix, etc.) são material de origem para a ingestão de conteúdo, mas **não são versionados no Git** — ficam listados no `.gitignore` por serem conteúdo protegido por direitos autorais e por inflarem desnecessariamente o repositório. Eles precisam existir localmente em `pdf/` para os scripts de ingestão funcionarem, mas cada colaborador deve obtê-los por fora do Git.

## Status do desenvolvimento

- [x] **Marco 1** — Refatoração do front-end em componentes modulares
- [x] **Marco 2** — Modelagem do banco de dados no Supabase (`supabase/migrations/0001_init.sql`)
- [x] **Marco 3** — Integração de estado (Zustand + TanStack Query), cliente Supabase e auth anônima
- [ ] **Marco 4** — Ingestão de conteúdo dos PDFs módulo a módulo
  - [x] "Present and past" (units 1-6) — `0003_seed_present_and_past.sql`
  - [x] "Present perfect and past" (units 7-18) — `0004_seed_present_perfect_and_past.sql`
  - [x] "Future" (units 19-25) — `0005_seed_future.sql`
  - [x] "Modals" (units 26-37) — `0006_seed_modals.sql`
  - [x] "Conditionals and wish" (units 38-41, do mesmo PDF de Modals) — `0007_seed_conditionals_and_wish.sql`
  - [x] "Passive" (units 42-46) — `0008_seed_passive.sql`
  - [ ] Demais módulos (-ing and to ..., Questions and auxiliary verbs, Reported speech, etc.) ainda pendentes

## Roadmap Futuro: Aba de Fonética

> Ideia registrada em 2026-07-17, para ser desenvolvida depois que a gramática
> estiver toda populada. Nada abaixo foi implementado ainda — nenhum código ou
> JSON foi escrito, apenas a especificação.

### Especificação: Aba de Fonética (Future Scope)

* **Objetivo:** Ensinar fonética através de palavras e frases.
* **Áudio:** Sem arquivos MP3. Uso exclusivo da Web Speech API do JavaScript
  (`window.speechSynthesis`) para ler frases com sotaque americano ('en-US').
* **API de Dados:** Consumo da 'Free Dictionary API' (https://api.dictionaryapi.dev/).
* **Estrutura de Dados Desejada:** Um modelo JSON contendo a palavra, a
  transcrição IPA, uma frase de exemplo, os fonemas-chave e um campo para
  "nota explicativa" (focada em dificuldades de falantes de português) que
  será customizada manualmente.
* **Tarefas pendentes para o momento do desenvolvimento:**
  1. Criar exemplo de estrutura JSON para 3 palavras de dificuldades
     diferentes (ex: 'empty', 'thought', 'schedule').
  2. Criar protótipo funcional em HTML/JS testando a Web Speech API.
  3. Estruturar o código para permitir a injeção da "nota explicativa"
     personalizada após o carregamento da API.
  4. Levantar e documentar as limitações da Web Speech API para fins
     educacionais de pronúncia.

Ver `CLAUDE.md` para as regras de negócio e diretrizes de arquitetura completas do projeto.
