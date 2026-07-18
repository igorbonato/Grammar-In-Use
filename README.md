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
  - [x] "Reported speech" (units 47-48) — `0009_seed_reported_speech.sql`
  - [x] "Questions and auxiliary verbs" (units 49-52) — `0010_seed_questions_and_auxiliary_verbs.sql`
  - [x] "-ing and to ..." (units 53-68, 1 módulo só, semeado em fatias)
    - [x] Units 53-58 (verb + -ing/to) — `0011_seed_ing_and_to_slice1.sql`
    - [x] Units 59-68 (prefer, used to, preposition + -ing, etc.) — `0012_seed_ing_and_to_slice2.sql`
  - [x] "Articles and nouns" (units 69-81, 1 módulo só, semeado em fatias)
    - [x] Units 69-70 (countable/uncountable) — `0013_seed_articles_and_nouns_slice1.sql`
    - [x] Units 71-73 (a/an and some, a/an and the, the 1) — `0014_seed_articles_and_nouns_slice2.sql`
    - [x] Units 74-76 (the 2/3/4) — `0015_seed_articles_and_nouns_slice3.sql`
    - [x] Units 77-78 (names with/without the) — `0016_seed_articles_and_nouns_slice4.sql`
    - [x] Units 79-81 (singular/plural, noun+noun, -'s and of...) — `0017_seed_articles_and_nouns_slice5.sql`
  - [x] "Pronouns and determiners" (units 82-91, 1 módulo só, semeado em fatias)
    - [x] Units 82-83 (myself/yourself..., on my own / by myself) — `0018_seed_pronouns_and_determiners_slice1.sql`
    - [x] Units 84-85 (there.../it..., some and any) — `0019_seed_pronouns_and_determiners_slice2.sql`
    - [x] Units 86-87 (no/none/any, much/many/little/few/a lot/plenty) — `0020_seed_pronouns_and_determiners_slice3.sql`
    - [x] Units 88-89 (all/all of..., either/either of) — `0021_seed_pronouns_and_determiners_slice4.sql`
    - [x] Units 90-91 (all every whole, each and every) — `0022_seed_pronouns_and_determiners_slice5.sql`
  - [x] "Relative clauses" (units 92-97, 1 módulo só, semeado 1 unit por fatia)
    - [x] Unit 92 (who/that/which 1) — `0023_seed_relative_clauses_slice1.sql`
    - [x] Unit 93 (who/that/which 2) — `0024_seed_relative_clauses_slice2.sql`
    - [x] Unit 94 (whose/whom/where) — `0025_seed_relative_clauses_slice3.sql`
    - [x] Unit 95 (extra information clauses 1) — `0026_seed_relative_clauses_slice4.sql`
    - [x] Unit 96 (extra information clauses 2) — `0027_seed_relative_clauses_slice5.sql`
    - [x] Unit 97 (-ing/-ed clauses, there is + noun + participle) — `0028_seed_relative_clauses_slice6.sql`
  - [x] "Adjectives and adverbs" (units 98-112, 1 módulo só, semeado em fatias)
    - [x] Units 98-99 (-ing/-ed adjectives, adjective order) — `0029_seed_adjectives_and_adverbs_slice1.sql`
    - [x] Units 100-101 (adjectives and adverbs 1/2) — `0030_seed_adjectives_and_adverbs_slice2.sql`
    - [x] Units 102-103 (so/such, enough/too) — `0031_seed_adjectives_and_adverbs_slice3.sql`
    - [x] Unit 104 (quite, pretty, rather, fairly) — `0032_seed_adjectives_and_adverbs_slice4.sql`
    - [x] Units 105-106 (comparative 1/2) — `0033_seed_adjectives_and_adverbs_slice5.sql`
    - [x] Units 107-108 (comparative 3, superlative) — `0034_seed_adjectives_and_adverbs_slice6.sql`
    - [x] Units 109-110 (word order 1/2) — `0035_seed_adjectives_and_adverbs_slice7.sql`
    - [x] Units 111-112 (still/any more/yet/already, even) — `0036_seed_adjectives_and_adverbs_slice8.sql`
  - [x] "Conjunctions and prepositions" (units 113-120, 1 módulo só, semeado em fatias)
    - [x] Units 113-114 (in spite of/despite/although, in case) — `0037_seed_conjunctions_and_prepositions_slice1.sql`
    - [x] Unit 115 (unless) — `0038_seed_conjunctions_and_prepositions_slice2.sql`
    - [x] Unit 116 (as = at the same time as / because) — `0039_seed_conjunctions_and_prepositions_slice3.sql`
    - [x] Unit 117 (like and as) — `0040_seed_conjunctions_and_prepositions_slice4.sql`
    - [x] Unit 118 (like / as if) — `0041_seed_conjunctions_and_prepositions_slice5.sql`
    - [x] Unit 119 (during, for and while) — `0042_seed_conjunctions_and_prepositions_slice6.sql`
    - [x] Unit 120 (by and until, by the time) — `0043_seed_conjunctions_and_prepositions_slice7.sql`
  - [x] "Prepositions" (units 121-136, 1 módulo só, semeado 1 unit por fatia)
    - [x] Unit 121 (at/on/in time) — `0044_seed_prepositions_slice1.sql`
    - [x] Unit 122 (on time/in time, at the end/in the end) — `0045_seed_prepositions_slice2.sql`
    - [x] Unit 123 (in/at/on position 1) — `0046_seed_prepositions_slice3.sql`
    - [x] Unit 124 (in/at/on position 2) — `0047_seed_prepositions_slice4.sql`
    - [x] Unit 125 (in/at/on position 3) — `0048_seed_prepositions_slice5.sql`
    - [x] Unit 126 (to, at, in and into) — `0049_seed_prepositions_slice6.sql`
    - [x] Unit 127 (in/on/at other uses) — `0050_seed_prepositions_slice7.sql`
    - [x] Unit 128 (by) — `0051_seed_prepositions_slice8.sql`
    - [x] Unit 129 (Noun + preposition) — `0052_seed_prepositions_slice9.sql`
    - [x] Unit 130 (Adjective + preposition 1) — `0053_seed_prepositions_slice10.sql`
    - [x] Unit 131 (Adjective + preposition 2) — `0054_seed_prepositions_slice11.sql`
    - [x] Unit 132 (Verb + preposition 1: to/at) — `0055_seed_prepositions_slice12.sql`
    - [x] Unit 133 (Verb + preposition 2: about/for/of/after) — `0056_seed_prepositions_slice13.sql`
    - [x] Unit 134 (Verb + preposition 3: about/of) — `0057_seed_prepositions_slice14.sql`
    - [x] Unit 135 (Verb + preposition 4: of/for/from/on) — `0058_seed_prepositions_slice15.sql`
    - [x] Unit 136 (Verb + preposition 5: in/into/with/to/on) — `0059_seed_prepositions_slice16.sql`
  - [ ] Demais módulos (Phrasal verbs) ainda pendentes

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
