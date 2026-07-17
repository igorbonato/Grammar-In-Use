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
  migrations/     Migrations do schema do banco (Supabase CLI)
  seed/           Scripts SQL de seed por unit (rodar manualmente no SQL Editor por enquanto)
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

Ver `CLAUDE.md` para as regras de negócio e diretrizes de arquitetura completas do projeto.
