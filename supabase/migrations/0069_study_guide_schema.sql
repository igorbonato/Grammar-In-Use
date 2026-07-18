-- Study guide feature — schema.
--
-- Adds the "Study guide" self-assessment from the back of the book
-- (pdf/Study guide.pdf, key at pdf/Key to Study guide.pdf): 161
-- multiple-choice questions (some with more than one correct option),
-- grouped into the same 16 module groups as `modules`, each pointing
-- at the book unit(s) to study if you got it wrong.
--
-- study_units stores book unit_number(s) directly (int[], in book
-- order) rather than a join table — every seeded unit's client-side
-- id is `unit-${unit_number}`, so the frontend can resolve these
-- straight from the already-loaded curriculum data with no extra
-- query.

create table study_guide_questions (
  id uuid primary key default gen_random_uuid(),
  module_id uuid not null references modules (id) on delete cascade,
  question_number text not null,
  -- indexed placeholder, e.g. 'At first I didn''t like my job, but {0} to enjoy it now.'
  template text not null,
  study_units int[] not null default '{}',
  order_index int not null default 0
);

create index study_guide_questions_module_id_idx on study_guide_questions (module_id);

create table study_guide_options (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references study_guide_questions (id) on delete cascade,
  letter text not null,
  option_text text not null,
  is_correct boolean not null default false,
  order_index int not null default 0
);

create index study_guide_options_question_id_idx on study_guide_options (question_id);

alter table study_guide_questions enable row level security;
alter table study_guide_options enable row level security;

create policy "study_guide_questions are publicly readable" on study_guide_questions for select using (true);
create policy "study_guide_options are publicly readable" on study_guide_options for select using (true);
