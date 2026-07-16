# GrammarApp Interactive

Versão web interativa do *English Grammar in Use*, focada em alta retenção e zero distrações. A interface recria a experiência de um livro aberto através de um layout Split-Screen: teoria gramatical de um lado, exercícios práticos com feedback imediato do outro.

## Stack

- **Front-end:** React (Vite) + TypeScript, Tailwind CSS
- **Roteamento:** React Router (`/modulo/:moduleId/:unitId`)
- **Back-end / Banco de dados:** Supabase (PostgreSQL) — em modelagem
- **Deploy:** Vercel

## Estrutura do repositório

```
src/              Aplicação front-end (Vite + React + Tailwind) — raiz do projeto
  components/     Componentes de apresentação (layout/, theory/, exercises/)
  data/           Conteúdo mockado por unit (será substituído por dados do Supabase)
  hooks/          Lógica de dados e validação de exercícios
  routes/         Configuração de rotas
  types/          Tipos compartilhados de domínio (Unit, Module, Exercise...)

pdf/              Material bruto original (PDFs do livro), usado como fonte para
                  ingestão de conteúdo. Não versionado no Git — ver abaixo.

supabase/         Migrations do schema do banco (a criar no próximo marco)
tools/ingestion/  Scripts de extração/seed de conteúdo dos PDFs (a criar)
```

## Rodando localmente

```bash
pnpm install
pnpm dev
```

O app sobe em `http://localhost:8443`.

## Sobre os PDFs em `pdf/`

Os PDFs do livro (módulos gramaticais, additional exercises, appendix, etc.) são material de origem para a ingestão de conteúdo, mas **não são versionados no Git** — ficam listados no `.gitignore` por serem conteúdo protegido por direitos autorais e por inflarem desnecessariamente o repositório. Eles precisam existir localmente em `pdf/` para os scripts de ingestão funcionarem, mas cada colaborador deve obtê-los por fora do Git.

## Status do desenvolvimento

- [x] **Marco 1** — Refatoração do front-end em componentes modulares
- [ ] **Marco 2** — Modelagem do banco de dados no Supabase
- [ ] **Marco 3** — Integração de estado (Zustand + TanStack Query) e Supabase Auth anônima
- [ ] **Marco 4** — Ingestão de conteúdo dos PDFs módulo a módulo

Ver `CLAUDE.md` para as regras de negócio e diretrizes de arquitetura completas do projeto.
