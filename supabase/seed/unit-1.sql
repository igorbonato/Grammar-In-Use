-- Seeds "Present and past" / Unit 1 (Present continuous) with the exact
-- content already used as the Marco 1 mock (src/data/units/unit-1.ts),
-- so switching the frontend to real Supabase data is a like-for-like
-- comparison. Safe to re-run: deletes unit-1 first (cascades to all its
-- theory/exercise rows) before re-inserting.
--
-- Run this in the Supabase SQL Editor after 0001_init.sql and
-- 0002_add_unit_intro.sql have both been applied.

delete from units where slug = 'unit-1';

insert into modules (slug, title, order_index)
values ('present-past', 'Present and past', 0)
on conflict (slug) do nothing;

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 1, 'unit-1', 'Present continuous', 'I am doing',
  'The present continuous is formed with the verb be (am/is/are) + the -ing form of the main verb.', 0
from modules where slug = 'present-past';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Actions happening now',
  'We use the present continuous to talk about something that is happening at the moment of speaking — it started before now and will probably finish soon.', 0
from units where slug = 'unit-1';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Temporary situations',
  'We also use the present continuous for situations that are temporary — happening around this time, but not necessarily at this exact moment.', 1
from units where slug = 'unit-1';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Fixed future arrangements',
  'The present continuous can describe a future event that is already planned or arranged. There is usually a time expression.', 2
from units where slug = 'unit-1';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-1'
join (values
  ('A', 'Please don''t make so much noise. I''m trying to work.', 'now', 0),
  ('A', '"Where''s Maria?" "She''s having a bath."', 'at this moment', 1),
  ('A', 'Let''s go out now. It isn''t raining anymore.', 'not now', 2),
  ('B', 'I''m living with some friends until I find a place of my own.', 'temporary', 0),
  ('B', 'You''re working hard today. Yes, I have a lot to do.', 'around now', 1),
  ('B', 'She''s taking a Spanish course this semester.', 'this period', 2),
  ('C', 'I''m meeting James at 8 o''clock tonight.', 'arranged future', 0),
  ('C', 'We''re not going out this evening. We''re staying in.', 'planned', 1),
  ('C', 'Are you coming to the party on Saturday?', 'future plan', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I', 'am', 'working', 0 from units where slug = 'unit-1'
union all
select id, 'positive', 'He / She / It', 'is', 'working', 1 from units where slug = 'unit-1'
union all
select id, 'positive', 'We / You / They', 'are', 'working', 2 from units where slug = 'unit-1'
union all
select id, 'negative', null, null, 'Subject + am/is/are + not + verb-ing', 0 from units where slug = 'unit-1'
union all
select id, 'question', null, null, 'Am/Is/Are + subject + verb-ing?', 0 from units where slug = 'unit-1';

insert into theory_spelling_notes (unit_id, rule, example, order_index)
select id, v.rule, v.example, v.order_index
from units, (values
  ('Most verbs', 'work → working, read → reading', 0),
  ('Ends in silent -e', 'come → coming, write → writing', 1),
  ('Short vowel + consonant', 'run → running, sit → sitting', 2),
  ('Ends in -ie', 'lie → lying, die → dying', 3)
) as v(rule, example, order_index)
where units.slug = 'unit-1';

-- ============================================================
-- Exercises (one main set, sentence 5 has two independently graded blanks)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', 'Exercise 1', 'Put the verb in brackets into the present continuous form.', 0
from units where slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug = 'unit-1'
where es.title = 'Exercise 1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.sentence_number, v.template, v.hint, v.sentence_number - 1
from exercise_sets es, (values
  (1, 'The sun {0} in the west.', 'be + verb-ing'),
  (2, 'Please be quiet. I {0} to concentrate.', 'am/is/are + -ing'),
  (3, 'Let''s go out. It {0} anymore.', 'negative form'),
  (4, 'How is your new job? Not bad. I {0} to enjoy it.', 'double final consonant'),
  (5, '{0} you {1} anything tonight?', 'question form'),
  (6, 'Look! Somebody {0} to break into that car.', 'he/she/it + is'),
  (7, 'She {0} in London at the moment.', 'temporary situation'),
  (8, 'Things {0} better these days.', 'they + are')
) as v(sentence_number, template, hint)
where es.title = 'Exercise 1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Exercise 1'
join (values
  (1, 0, 'is setting'),
  (2, 0, 'am trying'),
  (3, 0, 'isn''t raining'),
  (4, 0, 'am beginning'),
  (5, 0, 'Are'),
  (5, 1, 'doing'),
  (6, 0, 'is trying'),
  (7, 0, 'is staying'),
  (8, 0, 'are getting')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
