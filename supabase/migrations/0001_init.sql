-- GrammarApp Interactive — initial schema (Marco 2)
-- Curriculum (modules/units), theory content, exercises (set -> sentence -> blank),
-- and anonymous-auth user progress. See CLAUDE.md / plan for the business rules
-- this encodes (Additional exercises attach to units via exercise_set_units
-- instead of forming their own menu; exercises support multiple independently
-- graded blanks per sentence).

create extension if not exists pgcrypto;

-- ============================================================
-- Curriculum
-- ============================================================

create table modules (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  order_index int not null default 0
);

create table units (
  id uuid primary key default gen_random_uuid(),
  module_id uuid not null references modules (id) on delete cascade,
  unit_number int not null,
  slug text not null unique,
  title text not null,
  subtitle text,
  order_index int not null default 0
);

create index units_module_id_idx on units (module_id);

-- ============================================================
-- Theory
-- ============================================================

create table theory_sections (
  id uuid primary key default gen_random_uuid(),
  unit_id uuid not null references units (id) on delete cascade,
  label text,
  heading text not null,
  explanation text not null,
  order_index int not null default 0
);

create index theory_sections_unit_id_idx on theory_sections (unit_id);

create table theory_examples (
  id uuid primary key default gen_random_uuid(),
  section_id uuid not null references theory_sections (id) on delete cascade,
  sentence text not null,
  note text,
  order_index int not null default 0
);

create index theory_examples_section_id_idx on theory_examples (section_id);

create table theory_structure_rows (
  id uuid primary key default gen_random_uuid(),
  unit_id uuid not null references units (id) on delete cascade,
  row_type text not null check (row_type in ('positive', 'negative', 'question')),
  subject_label text,
  aux_form text,
  example_text text,
  order_index int not null default 0
);

create index theory_structure_rows_unit_id_idx on theory_structure_rows (unit_id);

create table theory_spelling_notes (
  id uuid primary key default gen_random_uuid(),
  unit_id uuid not null references units (id) on delete cascade,
  rule text not null,
  example text not null,
  order_index int not null default 0
);

create index theory_spelling_notes_unit_id_idx on theory_spelling_notes (unit_id);

create table theory_images (
  id uuid primary key default gen_random_uuid(),
  unit_id uuid not null references units (id) on delete cascade,
  storage_path text not null,
  alt_text text,
  order_index int not null default 0
);

create index theory_images_unit_id_idx on theory_images (unit_id);

-- ============================================================
-- Exercises (set -> sentence -> blank)
-- ============================================================

create table exercise_sets (
  id uuid primary key default gen_random_uuid(),
  unit_id uuid not null references units (id) on delete cascade,
  kind text not null default 'main' check (kind in ('main', 'additional')),
  title text,
  instruction text,
  source_ref text,
  order_index int not null default 0
);

create index exercise_sets_unit_id_idx on exercise_sets (unit_id);

-- Many-to-many: an 'additional' set can cover more than one unit (e.g. a
-- book exercise labelled "Units 1-4"). A 'main' set still gets exactly one
-- row here, matching its own unit_id.
create table exercise_set_units (
  exercise_set_id uuid not null references exercise_sets (id) on delete cascade,
  unit_id uuid not null references units (id) on delete cascade,
  primary key (exercise_set_id, unit_id)
);

create index exercise_set_units_unit_id_idx on exercise_set_units (unit_id);

create table exercise_sentences (
  id uuid primary key default gen_random_uuid(),
  exercise_set_id uuid not null references exercise_sets (id) on delete cascade,
  sentence_number int not null,
  -- indexed placeholders, e.g. 'The sun {0} in the west.'
  template text not null,
  hint text,
  order_index int not null default 0
);

create index exercise_sentences_exercise_set_id_idx on exercise_sentences (exercise_set_id);

create table exercise_blanks (
  id uuid primary key default gen_random_uuid(),
  sentence_id uuid not null references exercise_sentences (id) on delete cascade,
  blank_index int not null,
  correct_answer text not null,
  accepted_alternatives text[] not null default '{}',
  unique (sentence_id, blank_index)
);

-- ============================================================
-- User progress (Supabase anonymous auth — see useAuthStore, Marco 3)
-- ============================================================

create table user_unit_progress (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  unit_id uuid not null references units (id) on delete cascade,
  status text not null default 'not_started' check (status in ('not_started', 'in_progress', 'completed')),
  last_score int,
  last_total int,
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  unique (user_id, unit_id)
);

create index user_unit_progress_user_id_idx on user_unit_progress (user_id);

-- ============================================================
-- Row Level Security
-- ============================================================

-- Content tables: public read, no client-side writes (ingestion scripts use
-- the service_role key, which bypasses RLS).
alter table modules enable row level security;
alter table units enable row level security;
alter table theory_sections enable row level security;
alter table theory_examples enable row level security;
alter table theory_structure_rows enable row level security;
alter table theory_spelling_notes enable row level security;
alter table theory_images enable row level security;
alter table exercise_sets enable row level security;
alter table exercise_set_units enable row level security;
alter table exercise_sentences enable row level security;
alter table exercise_blanks enable row level security;

create policy "modules are publicly readable" on modules for select using (true);
create policy "units are publicly readable" on units for select using (true);
create policy "theory_sections are publicly readable" on theory_sections for select using (true);
create policy "theory_examples are publicly readable" on theory_examples for select using (true);
create policy "theory_structure_rows are publicly readable" on theory_structure_rows for select using (true);
create policy "theory_spelling_notes are publicly readable" on theory_spelling_notes for select using (true);
create policy "theory_images are publicly readable" on theory_images for select using (true);
create policy "exercise_sets are publicly readable" on exercise_sets for select using (true);
create policy "exercise_set_units are publicly readable" on exercise_set_units for select using (true);
create policy "exercise_sentences are publicly readable" on exercise_sentences for select using (true);
create policy "exercise_blanks are publicly readable" on exercise_blanks for select using (true);

-- user_unit_progress: each user (anonymous or not) only sees/writes their own rows.
alter table user_unit_progress enable row level security;

create policy "users can view their own progress" on user_unit_progress
  for select using (auth.uid() = user_id);

create policy "users can insert their own progress" on user_unit_progress
  for insert with check (auth.uid() = user_id);

create policy "users can update their own progress" on user_unit_progress
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
