-- Marco 4 (slice 64): seeds the sixth slice of the "Phrasal verbs"
-- module — unit 142 (Phrasal verbs 6: up/down).
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 142.1 is picture-based (8 small before/now scenes) — a
-- theory_images placeholder plus each scene rebuilt from its
-- surrounding text and the Key's own answers (the raw pdftotext
-- layout interleaved picture captions and is not reliably readable
-- as running prose for this exercise).
--
-- Safe to re-run: unit 142 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 142: Phrasal verbs 6 up/down
-- ============================================================

delete from units where slug = 'unit-142';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 142, 'unit-142', 'Phrasal verbs 6 up/down', null,
  'up and down: put something up (on a wall) vs. take something down; pick something up vs. put something down; stand up vs. sit down/bend down/lie down; turn something up vs. turn something down. knock down a building / cut something down / be knocked down (by a car) / burn down = be destroyed by fire. down = getting less: slow down; calm (somebody) down; cut down (on something) = eat/drink/do something less often. Other verbs + down: break down = stop working; close down / shut down = stop doing business; let somebody down = disappoint them; turn somebody/something down = refuse; write something down = write it on paper to remember it.', 5
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Compare up and down',
  'put something up (on a wall etc.) vs. take something down (from a wall etc.). pick something up vs. put something down. stand up vs. sit down / bend down / lie down. turn something up vs. turn something down.', 0
from units where slug = 'unit-142';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'knock down, cut down etc.',
  'knock down a building / blow something down / cut something down etc. be knocked down (by a car etc.). burn down = be destroyed by fire.', 1
from units where slug = 'unit-142';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'down = getting less',
  'slow down = go more slowly. calm (somebody) down = become calmer, make somebody calmer. cut down (on something) = eat, drink or do something less often.', 2
from units where slug = 'unit-142';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'Other verbs + down',
  'break down = stop working (for machines, cars, relationships etc.). close down / shut down = stop doing business. let somebody down = disappoint them because you didn''t do what they hoped. turn somebody/something down = refuse an application, an offer etc. write something down = write something on paper because you may need the information later.', 3
from units where slug = 'unit-142';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-142'
join (values
  ('A', 'I put a picture up on the wall.', null, 0),
  ('A', 'I didn''t like the picture, so I took it down.', null, 1),
  ('A', 'There was a letter on the floor. I picked it up and looked at it.', null, 2),
  ('A', 'I stopped writing and put down my pen.', null, 3),
  ('A', 'Alan stood up and walked out.', null, 4),
  ('A', 'I bent down to tie my shoelace.', null, 5),
  ('A', 'I can''t hear the TV. Can you turn it up a bit?', null, 6),
  ('A', 'The oven is too hot. Turn it down to 150 degrees.', null, 7),
  ('B', 'Some old houses were knocked down to make way for the new shopping centre.', null, 0),
  ('B', 'Why did you cut down the tree in your garden?', null, 1),
  ('B', 'A man was knocked down by a car and taken to hospital.', null, 2),
  ('B', 'They were able to put out the fire before the house burnt down.', null, 3),
  ('C', 'You''re driving too fast. Slow down.', null, 0),
  ('C', 'Calm down. There''s no point in getting angry.', null, 1),
  ('C', 'I''m trying to cut down on coffee. I drink too much of it.', null, 2),
  ('D', 'The car broke down and I had to phone for help.', null, 0),
  ('D', 'Their marriage broke down after only a few months.', null, 1),
  ('D', 'There used to be a shop at the end of the street. It closed down a few years ago.', null, 2),
  ('D', 'You can always rely on Paul. He''ll never let you down.', null, 3),
  ('D', 'I applied for several jobs, but I was turned down for all of them.', null, 4),
  ('D', 'Rachel was offered the job, but she decided to turn it down.', null, 5),
  ('D', 'I can''t remember Ben''s address. I wrote it down, but I can''t find it.', null, 6)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 142.1-142.3; each renumbered from 1,
-- dropping the book's own worked example)
-- ------------------------------------------------------------

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: eight small "before/now" pictures used in exercise 142.1 — a tree next to a house then gone; shelves on a wall then removed; a man in a low room unable to stand; a woman turning up the volume on a radio; two people putting bags down on the ground at a bus stop; trees blown over in a storm; new curtains still folded, not yet hung; Lisa bending down to pick up dropped keys]', 0
from units where slug = 'unit-142';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '142.1', 'Complete the sentences. Use a verb + up or down.', 0
from units where slug = 'unit-142';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-142' where es.title = '142.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There used to be some shelves on the wall, but I {0}.', null),
  (2, 'The ceiling was so low, he couldn''t {0}.', null),
  (3, 'She couldn''t hear the radio very well, so she {0}.', null),
  (4, 'While they were waiting for the bus, they {0} on the ground.', null),
  (5, 'A few trees {0} in the storm last week.', null),
  (6, 'We''ve got some new curtains, but we haven''t {0} yet.', null),
  (7, 'Lisa dropped her keys, so she {0}.', null)
) as v(n, template, hint)
where es.title = '142.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '142.1'
join (values
  (1, 'took them down'), (2, 'stand up'), (3, 'turned it up'),
  (4, 'put their bags down'), (5, 'were blown down'), (6, 'put them up'),
  (7, 'bent down and picked them up')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '142.2', 'Complete the sentences. Use a verb (in the correct form) + down. Choose from: calm, cut, let, take, turn, write.', 1
from units where slug = 'unit-142';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-142' where es.title = '142.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The music was too loud, so I {0}.', null),
  (2, 'David was very angry. I tried to {0}.', null),
  (3, 'I promised I would help Anna. I don''t want to {0}.', null),
  (4, 'I''ve forgotten my password. I should have {0}.', null),
  (5, 'Those trees are beautiful. Please don''t {0}.', null)
) as v(n, template, hint)
where es.title = '142.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '142.2'
join (values
  (1, 'turned it down'), (2, 'calm him down'), (3, 'let her down'),
  (4, 'written it down'), (5, 'cut them down')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '142.3', 'Complete the sentences. Use a verb + down.', 2
from units where slug = 'unit-142';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-142' where es.title = '142.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I was really angry. It took me a long time to {0}.', null),
  (2, 'The train {0} as it approached the station.', null),
  (3, 'Sarah applied to study medicine at university, but she {0}.', null),
  (4, 'Our car is very reliable. It has never {0}.', null),
  (5, 'I spend too much money. I''m going to {0} on things I don''t need.', null),
  (6, 'I didn''t play well. I felt that I had {0} the other players in the team.', null),
  (7, 'The shop {0} because it was losing money.', null),
  (8, 'It''s a very ugly building. Many people would like it to {0}.', null),
  (9, 'I can''t understand why you {0} the chance of working in another country for a year. It would have been a great experience for you.', null),
  (10, 'I didn''t see the accident. Someone told me that a boy {0} as he was crossing the road.', null),
  (11, 'Peter got married when he was 20, but unfortunately the marriage {0} a few years later.', null)
) as v(n, template, hint)
where es.title = '142.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '142.3'
join (values
  (1, 'calm down', array[]::text[]),
  (2, 'slowed down', array[]::text[]),
  (3, 'was turned down', array[]::text[]),
  (4, 'broken down', array[]::text[]),
  (5, 'cut down', array[]::text[]),
  (6, 'let down', array[]::text[]),
  (7, 'closed down', array['has closed down']::text[]),
  (8, 'be knocked down', array[]::text[]),
  (9, 'turned down', array[]::text[]),
  (10, 'was knocked down', array[]::text[]),
  (11, 'broke down', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
