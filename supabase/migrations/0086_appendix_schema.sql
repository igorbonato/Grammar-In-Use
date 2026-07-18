-- Appendix feature — schema.
--
-- Adds the book's back-matter Appendix (pdf/Appendix.pdf): 7 numbered
-- reference sections (Regular and irregular verbs, Present and past
-- tenses, The future, Modal verbs, Short forms, Spelling, American
-- English) that summarize grammar across units, unlike exercises.
--
-- appendix_subsections mirrors theory_sections' shape (label, heading,
-- explanation, examples) so the existing GrammarRuleBox/ExampleBox
-- components can render most appendix content unchanged. Two extra
-- shapes cover content that theory_sections never needed:
-- appendix_table_rows (flat reference tables — contractions, British
-- vs American) and irregular_verbs (the ~120-row lookup table).
-- unit_refs stores book unit_number(s) directly (int[]), same
-- convention as study_guide_questions.study_units — no join table
-- needed since the frontend already resolves unit_number -> unit via
-- findUnitByNumber().

create table appendix_sections (
  id uuid primary key default gen_random_uuid(),
  number int not null,
  slug text not null unique,
  title text not null,
  order_index int not null default 0
);

create table appendix_subsections (
  id uuid primary key default gen_random_uuid(),
  appendix_section_id uuid not null references appendix_sections (id) on delete cascade,
  label text,
  heading text not null,
  explanation text,
  column_headers text[],
  unit_refs int[] not null default '{}',
  order_index int not null default 0
);

create index appendix_subsections_section_id_idx on appendix_subsections (appendix_section_id);

create table appendix_examples (
  id uuid primary key default gen_random_uuid(),
  subsection_id uuid not null references appendix_subsections (id) on delete cascade,
  sentence text not null,
  note text,
  order_index int not null default 0
);

create index appendix_examples_subsection_id_idx on appendix_examples (subsection_id);

create table appendix_table_rows (
  id uuid primary key default gen_random_uuid(),
  subsection_id uuid not null references appendix_subsections (id) on delete cascade,
  col_a text not null,
  col_b text not null,
  col_c text,
  unit_refs int[] not null default '{}',
  order_index int not null default 0
);

create index appendix_table_rows_subsection_id_idx on appendix_table_rows (subsection_id);

create table irregular_verbs (
  id uuid primary key default gen_random_uuid(),
  subsection_id uuid not null references appendix_subsections (id) on delete cascade,
  infinitive text not null,
  past_simple text not null,
  past_participle text not null,
  note text,
  order_index int not null default 0
);

create index irregular_verbs_subsection_id_idx on irregular_verbs (subsection_id);

alter table appendix_sections enable row level security;
alter table appendix_subsections enable row level security;
alter table appendix_examples enable row level security;
alter table appendix_table_rows enable row level security;
alter table irregular_verbs enable row level security;

create policy "appendix_sections are publicly readable" on appendix_sections for select using (true);
create policy "appendix_subsections are publicly readable" on appendix_subsections for select using (true);
create policy "appendix_examples are publicly readable" on appendix_examples for select using (true);
create policy "appendix_table_rows are publicly readable" on appendix_table_rows for select using (true);
create policy "irregular_verbs are publicly readable" on irregular_verbs for select using (true);
