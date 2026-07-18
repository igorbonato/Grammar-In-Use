-- Marco 4 (slice 22): seeds the first slice of the "Relative clauses"
-- module — unit 92 (Relative clauses 1: clauses with who/that/which).
--
-- Sourced from pdf/Modulos/Relative clauses.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode, since -layout's 3-column Key pages garble badly, same
-- workaround as every module since Articles and nouns).
--
-- Grepped unit-number headers across the whole file before assuming its
-- range (same check applied to every oversized PDF since Modals.pdf): this
-- file spans units 92-97 (6 units, confirmed no "98" header — Adjectives
-- and adverbs.pdf starts there instead). Following the -ing-and-to /
-- Articles-and-nouns / Pronouns-and-determiners precedent, kept as ONE
-- module (`relative-clauses`), seeded across multiple migration slices.
-- The module row uses `on conflict (slug) do nothing` so later slices can
-- extend it safely. This module is seeded one unit per slice (smaller than
-- the usual two-unit slices) since each unit here has unusually long
-- exercise items.
--
-- 92.1 ("What do these words mean? ... write sentences with who") is a
-- word-bank exercise where item 1 (an architect) is the book's own worked
-- example; renumbered items 1-7 (book's 2-8) each ask for "who + verb
-- phrase" completing a "someone is ..." sentence.
--
-- 92.4 ("Are these sentences right or wrong?") has TWO pre-filled worked
-- examples (one wrong sentence corrected, one already-OK sentence) — same
-- recurring gotcha as unit 52.1/69.2/69.3/77.2/82.3 in earlier modules;
-- confirmed via the Key, which starts numbering at item 3. Since only a
-- single relative pronoun differs between right/wrong versions in every
-- item, isolated just that word as the blank rather than asking for a
-- full-sentence rewrite (consistent with how 0013 isolated just the noun
-- phrase for unit 69's similar "correct where necessary" exercise).
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('relative-clauses', 'Relative clauses', 11)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 92: Relative clauses 1: clauses with who/that/which
-- ============================================================

delete from units where slug = 'unit-92';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 92, 'unit-92', 'Relative clauses 1: clauses with who/that/which', null,
  'A relative clause tells us which person or thing (or what kind of person or thing) the speaker means: the woman who lives next door to me. We use who (or that) for people, and that or which for things — never which for people, and never who/that/which replaced by he/she/they/it. What means "the thing(s) that": Everything that happened was my fault. (not Everything what happened)', 0
from modules where slug = 'relative-clauses';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'who for people',
  'A clause is a part of a sentence. A relative clause tells us which person or thing (or what kind of person or thing) the speaker means: the woman who lives next door to me (''who lives next door to me'' tells us which woman); people who complain all the time (''who complain all the time'' tells us what kind of people). We use who in a relative clause for people (not things): The woman who lives next door to me is a doctor. I don''t like people who complain all the time. An architect is someone who designs buildings. What was the name of the person who called? Do you know anyone who wants to buy a car? We also use that for people, but not which: The woman that lives next door to me is a doctor. (not the woman which) Sometimes you must use who (not that) for people — see Unit 95.', 0
from units where slug = 'unit-92';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'that/which for things',
  'When we are talking about things, we use that or which (not who) in a relative clause: I don''t like stories that have unhappy endings. or ... stories which have unhappy endings. Grace works for a company that makes furniture. or ... a company which makes furniture. The machine that broke down is working again now. or The machine which broke down ... In these examples that is more usual than which, but sometimes you must use which. See Unit 95.', 1
from units where slug = 'unit-92';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'who/that/which, not he/she/they/it',
  'In relative clauses we use who/that/which, not he/she/they/it. Compare: I met a Canadian woman at the party. She is an English teacher. (2 sentences) I met a Canadian woman who is an English teacher. (1 sentence) I can''t find the keys. They were on the table. Where are the keys that were on the table? (not the keys they were)', 2
from units where slug = 'unit-92';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'what = the thing(s) that',
  'Compare what and that: What happened was my fault. (= the thing that happened) but Everything that happened was my fault. (not Everything what happened) The machine that broke down is now working again. (not The machine what broke down)', 3
from units where slug = 'unit-92';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-92'
join (values
  ('A', 'the woman who lives next door to me', '''who lives next door to me'' tells us which woman', 0),
  ('A', 'people who complain all the time', '''who complain all the time'' tells us what kind of people', 1),
  ('A', 'The woman who lives next door to me is a doctor.', null, 2),
  ('A', 'I don''t like people who complain all the time.', null, 3),
  ('A', 'An architect is someone who designs buildings.', null, 4),
  ('A', 'What was the name of the person who called?', null, 5),
  ('A', 'Do you know anyone who wants to buy a car?', null, 6),
  ('A', 'The woman that lives next door to me is a doctor.', 'not the woman which', 7),
  ('B', 'I don''t like stories that have unhappy endings. or ... stories which have unhappy endings.', null, 0),
  ('B', 'Grace works for a company that makes furniture. or ... a company which makes furniture.', null, 1),
  ('B', 'The machine that broke down is working again now. or The machine which broke down ...', null, 2),
  ('C', 'I met a Canadian woman at the party. She is an English teacher.', '2 sentences', 0),
  ('C', 'I met a Canadian woman who is an English teacher.', '1 sentence', 1),
  ('C', 'I can''t find the keys. They were on the table.', null, 2),
  ('C', 'Where are the keys that were on the table?', 'not the keys they were', 3),
  ('D', 'What happened was my fault.', '= the thing that happened', 0),
  ('D', 'Everything that happened was my fault.', 'not Everything what happened', 1),
  ('D', 'The machine that broke down is now working again.', 'not The machine what broke down', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 92.1-92.4; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '92.1', 'What do these words mean? Choose from the box and write sentences with who: steals from a shop, buys something from a shop, designs buildings, pays rent to live somewhere, doesn''t tell the truth, breaks into a house to steal things, is not brave, expects the worst to happen.', 0
from units where slug = 'unit-92';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-92' where es.title = '92.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A customer is someone {0}', null),
  (2, 'A burglar is someone {0}', null),
  (3, 'A coward is someone {0}', null),
  (4, 'A tenant is someone {0}', null),
  (5, 'A shoplifter is someone {0}', null),
  (6, 'A liar is someone {0}', null),
  (7, 'A pessimist is someone {0}', null)
) as v(n, template, hint)
where es.title = '92.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '92.1'
join (values
  (1, 'who buys something from a shop.'),
  (2, 'who breaks into a house to steal things.'),
  (3, 'who is not brave.'),
  (4, 'who pays rent to live somewhere.'),
  (5, 'who steals from a shop.'),
  (6, 'who doesn''t tell the truth.'),
  (7, 'who expects the worst to happen.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '92.2', 'Make one sentence from two. Use who/that/which.', 1
from units where slug = 'unit-92';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-92' where es.title = '92.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A waiter served us. He was impolite and impatient. The {0}', null),
  (2, 'A building was destroyed in the fire. It has now been rebuilt. The {0}', null),
  (3, 'Some people were arrested. They have now been released. The {0}', null),
  (4, 'A bus goes to the airport. It runs every half hour. The {0}', null)
) as v(n, template, hint)
where es.title = '92.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '92.2'
join (values
  (1, 'waiter who served us was impolite and impatient.', array['waiter that served us was impolite and impatient.']::text[]),
  (2, 'building that was destroyed in the fire has now been rebuilt.', array['building which was destroyed in the fire has now been rebuilt.']::text[]),
  (3, 'people who were arrested have now been released.', array['people that were arrested have now been released.']::text[]),
  (4, 'bus that goes to the airport runs every half hour.', array['bus which goes to the airport runs every half hour.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '92.3', 'Complete the sentences. Choose from the box and use who/that/which: happened in the past, runs away from home, cannot be explained, developed the theory of relativity, makes furniture, can support life, has stayed there, were hanging on the wall.', 2
from units where slug = 'unit-92';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-92' where es.title = '92.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The movie is about a girl {0}', null),
  (2, 'What happened to the pictures {0}', null),
  (3, 'A mystery is something {0}', null),
  (4, 'I''ve heard it''s a good hotel, but I don''t know anyone {0}', null),
  (5, 'History is the study of things {0}', null),
  (6, 'Albert Einstein was the scientist {0}', null),
  (7, 'It seems that Earth is the only planet {0}', null)
) as v(n, template, hint)
where es.title = '92.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '92.3'
join (values
  (1, 'who runs away from home', array['that runs away from home']::text[]),
  (2, 'that were hanging on the wall', array['which were hanging on the wall']::text[]),
  (3, 'that cannot be explained', array['which cannot be explained']::text[]),
  (4, 'who has stayed there', array['that has stayed there']::text[]),
  (5, 'that happened in the past', array['which happened in the past']::text[]),
  (6, 'who developed the theory of relativity', array['that developed the theory of relativity']::text[]),
  (7, 'that can support life', array['which can support life']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '92.4', 'Are these sentences right or wrong? Correct them where necessary.', 3
from units where slug = 'unit-92';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-92' where es.title = '92.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Where''s the nearest shop {0} sells bread?', null),
  (2, 'Dan said some things about me {0} were not true.', null),
  (3, 'The driver {0} caused the accident was fined £500.', null),
  (4, 'Do you know the person {0} took these pictures?', null),
  (5, 'We live in a world {0} is changing all the time.', null),
  (6, 'Gary apologised for {0} he said.', null),
  (7, 'What was the name of the horse {0} won the race?', null)
) as v(n, template, hint)
where es.title = '92.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '92.4'
join (values
  (1, 'that', array['which']::text[]),
  (2, 'that', array['which']::text[]),
  (3, 'who', array['that']::text[]),
  (4, 'that', array['who']::text[]),
  (5, 'that', array['which']::text[]),
  (6, 'what', array[]::text[]),
  (7, 'that', array['which']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
