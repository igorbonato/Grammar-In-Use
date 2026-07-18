-- Marco 4 (slice 66): seeds the eighth slice of the "Phrasal verbs"
-- module — unit 144 (Phrasal verbs 8: up (2)).
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 144.1 ("Which goes with which?") is a matching exercise, adapted
-- the same way as 6.2/17.1/23.3/46.4/63.1/117.2 — each sentence
-- beginning becomes a fill-in-the-blank whose answer is the matched
-- ending's own text, not a letter.
-- 144.2 is picture-based (4 small pictures) — a theory_images
-- placeholder plus each scene rebuilt from its caption.
--
-- Safe to re-run: unit 144 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 144: Phrasal verbs 8 up (2)
-- ============================================================

delete from units where slug = 'unit-144';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 144, 'unit-144', 'Phrasal verbs 8 up (2)', null,
  'bring up a topic = introduce it in conversation; come up = be introduced in a conversation; come up with an idea/suggestion = produce it; make something up = invent something untrue. cheer up / cheer somebody up = become/make happier; save up for something = save money to buy it; clear up = become bright (weather). blow up = explode / destroy with a bomb; tear something up = tear it into pieces; beat somebody up = hit them repeatedly. break up / split up (with somebody) = separate; do up a coat/shoelace/buttons = fasten; do up a building/room = repair and improve it; look something up in a dictionary etc.; put up with something = tolerate it; hold up a person/plan = delay; mix up people/things, get them mixed up = confuse one for the other.', 7
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'bring up, come up, come up with, make up',
  'bring up a topic etc. = introduce it in a conversation. come up = be introduced in a conversation. come up with an idea, a suggestion etc. = produce an idea. make something up = invent something that is not true.', 0
from units where slug = 'unit-144';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'cheer up, save up, clear up',
  'cheer up = be happier, cheer somebody up = make somebody feel happier. save up for something / to do something = save money to buy something. clear up = become bright (for weather).', 1
from units where slug = 'unit-144';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'blow up, tear up, beat up',
  'blow up = explode, blow something up = destroy it with a bomb etc. tear something up = tear it into pieces. beat somebody up = hit someone repeatedly so that they are badly hurt.', 2
from units where slug = 'unit-144';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'break up, do up, look up, put up with, hold up, mix up',
  'break up, split up (with somebody) = separate. do up a coat, a shoelace, buttons etc. = fasten, tie etc. do up a building, a room etc. = repair and improve it. look something up in a dictionary/encyclopaedia etc. put up with something = tolerate a difficult situation or person. hold up a person, a plan etc. = delay. mix up people/things, get people/things mixed up = you think one is the other.', 3
from units where slug = 'unit-144';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-144'
join (values
  ('A', 'I don''t want to hear any more about this. Please don''t bring it up again.', null, 0),
  ('A', 'Some interesting things came up in our discussion yesterday.', null, 1),
  ('A', 'Sarah is very creative. She''s always coming up with new ideas.', null, 2),
  ('A', 'What Kevin told you about himself wasn''t true. He made it all up.', null, 3),
  ('B', 'You look so sad! Cheer up!', null, 0),
  ('B', 'Helen is depressed. What can we do to cheer her up?', null, 1),
  ('B', 'Dan is saving up for a trip to New Zealand.', null, 2),
  ('B', 'It was raining when I got up, but it cleared up later.', null, 3),
  ('C', 'The engine caught fire and blew up.', null, 0),
  ('C', 'The bridge was blown up during the war.', null, 1),
  ('C', 'I didn''t read the letter. I just tore it up and threw it away.', null, 2),
  ('C', 'A friend of mine was attacked and beaten up. He had to go to hospital.', null, 3),
  ('D', 'I''m surprised to hear that Kate and Paul have split up. They seemed very happy together.', null, 0),
  ('D', 'It''s quite cold. Do up your coat before you go out.', null, 1),
  ('D', 'The kitchen looks great now that it has been done up.', null, 2),
  ('D', 'If you don''t know the meaning of a word, you can look it up (in a dictionary).', null, 3),
  ('D', 'We live on a busy road, so we have to put up with a lot of noise from the traffic.', null, 4),
  ('D', 'Don''t wait for me. I don''t want to hold you up.', null, 5),
  ('D', 'Plans to build a new factory have been held up because of financial problems.', null, 6),
  ('D', 'The two brothers look very similar. People often mix them up.', 'or ... People often get them mixed up', 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 144.1-144.4; each renumbered from 1,
-- dropping the book's own worked example)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '144.1', 'Which goes with which? Combine the sentences.', 0
from units where slug = 'unit-144';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-144' where es.title = '144.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Jane came up with {0}.', null),
  (2, 'Paul is always making up {0}.', null),
  (3, 'I think you should do up {0}.', null),
  (4, 'I don''t think you should bring up {0}.', null),
  (5, 'I''m saving up for {0}.', null),
  (6, 'We had to put up with {0}.', null)
) as v(n, template, hint)
where es.title = '144.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '144.1'
join (values
  (1, 'a good suggestion'), (2, 'excuses'), (3, 'your jacket'),
  (4, 'that subject'), (5, 'a motorbike'), (6, 'a lot of bad weather')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: four small "before/now" pictures used in exercise 144.2 — stormy weather this morning replaced by sunshine now; Lisa stuck in traffic on the phone apologising for being late; an old house being renovated into a nice one; Joe looking depressed at dinner with friends]', 0
from units where slug = 'unit-144';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '144.2', 'Look at the pictures and complete the sentences. You will need two or three words each time.', 1
from units where slug = 'unit-144';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-144' where es.title = '144.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Lisa was late because she was {0} in the traffic.', null),
  (2, 'They bought an old house and {0}. It''s really nice now.', null),
  (3, 'Joe was really depressed. We took him out for a meal to {0}.', null)
) as v(n, template, hint)
where es.title = '144.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '144.2'
join (values
  (1, 'held up', array[]::text[]),
  (2, 'did it up', array[]::text[]),
  (3, 'cheer him up', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '144.3', 'Complete the sentences using a verb + up. Sometimes you will need other words as well.', 2
from units where slug = 'unit-144';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-144' where es.title = '144.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The ship {0} and sank. The cause of the explosion was never discovered.', null),
  (2, 'James was attacked and {0} by three men he''d never seen before.', null),
  (3, 'Robert and Tina aren''t together any more. They''ve {0}.', null),
  (4, 'My hands were so cold, I found it hard to {0} my shoelaces.', null),
  (5, 'It''s been raining all morning. Let''s hope it {0} this afternoon.', null),
  (6, 'I turned up for the party on the wrong day. I got the dates {0}.', null)
) as v(n, template, hint)
where es.title = '144.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '144.3'
join (values
  (1, 'blew up', array[]::text[]),
  (2, 'beaten up', array[]::text[]),
  (3, 'broken up', array['split up']::text[]),
  (4, 'do up', array[]::text[]),
  (5, 'clears up', array['will clear up']::text[]),
  (6, 'mixed up', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '144.4', 'Complete the sentences using a verb + up. You will need other words as well.', 3
from units where slug = 'unit-144';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-144' where es.title = '144.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t know what this word means. I''ll have to {0}.', null),
  (2, 'I''m fed up with the way my boss treats me. I don''t see why I should {0} it.', null),
  (3, 'I don''t believe the story you''re telling me. I think you''re {0}.', null),
  (4, 'The problem was complicated, but we managed to {0} a solution.', null),
  (5, 'Before you throw these documents away, you should {0}.', null),
  (6, 'I''m trying to spend less money at the moment. I''m {0} a holiday.', null),
  (7, 'Tina doesn''t like talking about the accident, so it''s better not to {0}.', null),
  (8, 'The words ''there'' and ''their'' sound the same, so it''s easy to {0}.', null)
) as v(n, template, hint)
where es.title = '144.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '144.4'
join (values
  (1, 'look it up', array[]::text[]),
  (2, 'put up with', array[]::text[]),
  (3, 'making it up', array[]::text[]),
  (4, 'come up with', array[]::text[]),
  (5, 'tear them up', array[]::text[]),
  (6, 'saving up for', array[]::text[]),
  (7, 'bring it up', array[]::text[]),
  (8, 'mix them up', array['get them mixed up']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
