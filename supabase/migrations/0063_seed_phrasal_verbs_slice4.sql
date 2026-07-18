-- Marco 4 (slice 62): seeds the fourth slice of the "Phrasal verbs"
-- module — unit 140 (Phrasal verbs 4: on/off (1)).
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 140.3 is picture-based (5 small scenes), same shape as prior
-- picture exercises — a theory_images placeholder plus each scene
-- rebuilt from its picture caption + surrounding text.
--
-- Safe to re-run: unit 140 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 140: Phrasal verbs 4 on/off (1)
-- ============================================================

delete from units where slug = 'unit-140';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 140, 'unit-140', 'Phrasal verbs 4 on/off (1)', null,
  'on/off for lights and machines: the light is on, put/leave the light on, turn/switch the light on or off; also put music on, put the kettle on. on/off for events: go on = happen; call something off = cancel it; put something off / put off doing something = delay it. on/off for clothes: put on clothes/glasses/make-up; put on weight = get heavier; try on clothes; take off clothes/glasses. off = away from a person or place: be off (to a place); walk/run/drive/ride/go off; set off = start a journey; take off = leave the ground (planes); see somebody off = go with them to the airport/station to say goodbye.', 3
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'on and off for lights, machines etc.',
  'We say: the light is on / put the light on / leave the light on etc. turn the light on/off or switch the light on/off. Also: put (music, a song) on, put the kettle on.', 0
from units where slug = 'unit-140';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'on and off for events etc.',
  'go on = happen. call something off = cancel it. put something off, put off doing something = delay it.', 1
from units where slug = 'unit-140';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'on and off for clothes etc.',
  'put on clothes, glasses, make-up, a seat belt etc. put on weight = get heavier. try on clothes (to see if they fit). take off clothes, glasses etc.', 2
from units where slug = 'unit-140';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'off = away from a person or place',
  'be off (to a place). walk off / run off / drive off / ride off / go off (similar to walk away / run away etc.). set off = start a journey. take off = leave the ground (for planes). see somebody off = go with them to the airport/station to say goodbye.', 3
from units where slug = 'unit-140';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-140'
join (values
  ('A', 'Shall I leave the lights on or turn them off?', null, 0),
  ('A', '''Is the heating on?'' ''No, I switched it off.''', null, 1),
  ('A', 'Let''s put some music on. What would you like to hear?', null, 2),
  ('A', 'We need boiling water, so I''ll put the kettle on.', null, 3),
  ('B', 'What''s all that noise? What''s going on?', '= what''s happening', 0),
  ('B', 'The concert in the park had to be called off because of the weather.', null, 1),
  ('B', 'The election has been put off until January.', null, 2),
  ('B', 'We can''t put off making a decision. We have to decide now.', null, 3),
  ('C', 'My hands were cold, so I put my gloves on.', null, 0),
  ('C', 'I''ve put on two kilos in the last month.', null, 1),
  ('C', 'I tried on a jacket in the shop, but it didn''t look right.', null, 2),
  ('C', 'It was warm, so I took off my coat.', null, 3),
  ('D', 'Tomorrow I''m off to Paris. I''m off on holiday.', null, 0),
  ('D', 'Anna got on her bike and rode off.', null, 1),
  ('D', 'Mark left home at the age of eighteen and went off to Canada.', null, 2),
  ('D', 'We set off early to avoid the traffic.', '= we left early', 3),
  ('D', 'After a long delay, the plane finally took off.', null, 4),
  ('D', 'Helen was going away. We went to the station with her to see her off.', null, 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 140.1-140.3; each renumbered from 1,
-- dropping the book's own worked example)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '140.1', 'Complete the sentences using put on + the following: some music, the heating, the kettle, the light, the oven.', 0
from units where slug = 'unit-140';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-140' where es.title = '140.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was getting cold, so I {0}.', null),
  (2, 'I wanted to bake a cake, so I {0}.', null),
  (3, 'I wanted to make some tea, so I {0}.', null),
  (4, 'I wanted to relax, so I {0}.', null)
) as v(n, template, hint)
where es.title = '140.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '140.1'
join (values
  (1, 'put the heating on', array['put on the heating']::text[]),
  (2, 'put the oven on', array['put on the oven']::text[]),
  (3, 'put the kettle on', array['put on the kettle']::text[]),
  (4, 'put some music on', array['put on some music']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '140.2', 'Complete the sentences. Use a verb + on or off.', 1
from units where slug = 'unit-140';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-140' where es.title = '140.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'What are all these people doing? What''s {0}?', null),
  (2, 'The weather was too bad for the plane to {0}, so the flight was delayed.', null),
  (3, 'Rachel got into her car and {0} at high speed.', null),
  (4, 'Tim is too thin. He needs to {0} weight.', null),
  (5, 'We spent the whole day walking. We {0} at 8 am and walked for ten hours.', null),
  (6, 'Don''t {0} until tomorrow what you can do today.', null),
  (7, 'They''ve changed their minds about getting married. The wedding has been {0}.', null),
  (8, 'Are you cold? Shall I get you a sweater to {0}?', null),
  (9, 'I {0} some jeans in the shop, but they were too tight.', null),
  (10, 'When I go away, I prefer to be alone at the station or airport. I don''t like it when people come to {0} me {1}.', null),
  (11, 'I need to make an appointment to see the dentist, but I keep {0} it {1}.', null)
) as v(n, template, hint)
where es.title = '140.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '140.2'
join (values
  (1, 'going on', array[]::text[]),
  (2, 'take off', array[]::text[]),
  (3, 'drove off', array['went off']::text[]),
  (4, 'put on', array[]::text[]),
  (5, 'set off', array[]::text[]),
  (6, 'put off', array[]::text[]),
  (7, 'called off', array[]::text[]),
  (8, 'put on', array[]::text[]),
  (9, 'tried on', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, 'see'
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '140.2'
where sen.sentence_number = 10;

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 1, 'off'
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '140.2'
where sen.sentence_number = 10;

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, 'putting'
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '140.2'
where sen.sentence_number = 11;

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 1, 'off'
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '140.2'
where sen.sentence_number = 11;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: five small pictures used in exercise 140.3 — a plane leaving the runway with a clock showing 10:55; Maria in a shop trying on a hat that is too big; a "match cancelled" sign at a rainy football pitch; Mark''s parents waving goodbye to him at the airport; a man taking sunglasses out of his pocket and putting them on]', 0
from units where slug = 'unit-140';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '140.3', 'Look at the pictures and complete the sentences.', 2
from units where slug = 'unit-140';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-140' where es.title = '140.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The plane {0} at 10.55.', null),
  (2, 'Maria {0}, but it was too big for her.', null),
  (3, 'The match {0} because of the weather.', null),
  (4, 'Mark''s parents went to the airport to {0}.', null),
  (5, 'He took his sunglasses out of his pocket and {0}.', null)
) as v(n, template, hint)
where es.title = '140.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '140.3'
join (values
  (1, 'took off', array[]::text[]),
  (2, 'tried on a hat', array['tried on the hat', 'tried a hat on', 'tried the hat on']::text[]),
  (3, 'was called off', array[]::text[]),
  (4, 'see him off', array[]::text[]),
  (5, 'put them on', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
