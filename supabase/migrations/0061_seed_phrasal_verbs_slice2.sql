-- Marco 4 (slice 60): seeds the second slice of the "Phrasal verbs"
-- module — unit 138 (Phrasal verbs 2: in/out).
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Safe to re-run: unit 138 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 138: Phrasal verbs 2 in/out
-- ============================================================

delete from units where slug = 'unit-138';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 138, 'unit-138', 'Phrasal verbs 2 in/out', null,
  'in = into a room/building/car (get in, move in, check in); out = out of it (get out, check out). drop in = visit without arranging; join in = take part; plug in an electrical machine; take somebody in = deceive; fill in/out a form. eat out = eat at a restaurant; drop out of college/a race = stop before finishing; get out of something arranged = avoid it; leave something out = omit it; cross something out = draw a line through it.', 1
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Compare in and out',
  'in = into a room/building/car etc: get in (a car), let yourself in (with a key), dive in (a pool), move in (a new flat), check in (a hotel), go in, come in, walk in, break in (using force). out = out of a room/building/car etc: get out, locked out, climbed out, looked out (of a window), checked out, go out, get out, move out, let somebody out. Compare in and into: We were sitting in the kitchen. / She got into the car and drove off. Compare out and out of: She was sitting on the wall and then climbed out. / She climbed out of the swimming pool.', 0
from units where slug = 'unit-138';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Other verbs + in',
  'drop in = go and see somebody without arranging it in advance. join in = take part in something that other people are already doing. plug in = connect a piece of electrical equipment to the electricity supply. take somebody in = deceive somebody. fill in a form / fill out a form = complete a form by writing information on it.', 1
from units where slug = 'unit-138';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Other verbs + out',
  'eat out = eat at a restaurant, not at home. drop out (of college/a course/a race etc.) = stop doing it before you have finished. get out of something (that you arranged to do) = avoid doing it. leave something out = omit it, not include it. cross something out = draw a line through it (something you have written).', 2
from units where slug = 'unit-138';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-138'
join (values
  ('A', 'Here''s a key so that you can let yourself in.', null, 0),
  ('A', 'I''ve got a new flat. I''m moving in on Friday.', null, 1),
  ('A', 'We arrived at the hotel and checked in.', null, 2),
  ('A', 'The car stopped and the driver got out.', null, 3),
  ('A', 'Somebody must have broken in and stolen some jewellery.', null, 4),
  ('B', 'If you''re in our part of town, drop in and see us sometime.', null, 0),
  ('B', 'Some children were playing a game, and Joe joined in.', null, 1),
  ('B', 'The fridge isn''t working because you haven''t plugged it in.', null, 2),
  ('B', 'I thought the email was genuine. I was completely taken in by it.', null, 3),
  ('B', 'Can you fill in this questionnaire, please?', null, 4),
  ('C', 'Let''s eat out tonight. I don''t want to cook.', null, 0),
  ('C', 'Rob started a course in computing, but he dropped out after a few weeks.', null, 1),
  ('C', 'I''ve arranged to go to Jane''s party, but now I want to get out of it.', null, 2),
  ('C', 'I''ve given you all the details. I don''t think I''ve left anything out.', null, 3),
  ('C', 'You''ve spelled my name wrong. Can you cross it out and write it again?', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 138.1-138.5; each renumbered from 1,
-- dropping the book's own worked example)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '138.1', 'Complete the sentences.', 0
from units where slug = 'unit-138';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-138' where es.title = '138.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Lisa doesn''t like cooking, so she {0} a lot.', null),
  (2, 'If you''re in our part of town, you should {0} and say hello.', null),
  (3, 'Could you {0} this questionnaire? It will only take five minutes.', null),
  (4, 'Amy isn''t living in this house any more. She {0} a few weeks ago.', null),
  (5, 'After breakfast, we {0} of the hotel and got a taxi to the airport.', null),
  (6, 'I wanted to charge my phone, but there was nowhere to {0} the charger in.', null),
  (7, 'Paul started doing a Spanish course, but he {0} after a few weeks.', null),
  (8, 'Be careful! The water isn''t very deep here, so don''t {0}.', null)
) as v(n, template, hint)
where es.title = '138.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '138.1'
join (values
  (1, 'eats out'), (2, 'drop in'), (3, 'fill in'), (4, 'moved out'),
  (5, 'checked out'), (6, 'plug'), (7, 'dropped out'), (8, 'dive in')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '138.2', 'Complete the sentences with in, into, out or out of.', 1
from units where slug = 'unit-138';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-138' where es.title = '138.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We arrived at the hotel and checked {0}.', null),
  (2, 'When are you moving {0} your new flat?', null),
  (3, 'The car stopped and the driver got {0}.', null),
  (4, 'Thieves broke {0} the house and stole some jewellery.', null),
  (5, 'How did the thieves break {0}? Through a window?', null),
  (6, 'He opened his wallet and something fell {0}.', null),
  (7, 'Kate was angry and walked {0} the meeting.', null)
) as v(n, template, hint)
where es.title = '138.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '138.2'
join (values
  (1, 'in'), (2, 'into'), (3, 'out'), (4, 'into'),
  (5, 'in'), (6, 'out'), (7, 'out of')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '138.3', 'Complete the sentences using a verb + in or out (of).', 2
from units where slug = 'unit-138';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-138' where es.title = '138.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Not all the runners finished the race. Three of them {0}.', null),
  (2, 'I went to see Joe and Sophie in their new house. They {0} last week.', null),
  (3, 'I''ve told you everything you need to know. I don''t think I''ve {0} anything.', null),
  (4, 'Some people in the crowd started singing. Then a few more people {0} and soon everybody was singing.', null),
  (5, 'Don''t be {0} by him. If I were you, I wouldn''t believe anything he says.', null),
  (6, 'I {0} to see Laura a few days ago. She was fine.', null)
) as v(n, template, hint)
where es.title = '138.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '138.3'
join (values
  (1, 'dropped out'), (2, 'moved in'), (3, 'left out'),
  (4, 'joined in'), (5, 'taken in'), (6, 'dropped in')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '138.4', 'Complete the sentences. Use the word in brackets in the correct form.', 3
from units where slug = 'unit-138';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-138' where es.title = '138.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''What do I have to do with these forms?'' ''{0} and send them to this address.''', '(fill)'),
  (2, '''I''ve made a mistake on this form.'' ''That''s OK. Just {0} and correct it.''', '(cross)'),
  (3, '''Have you been to the new club I told you about?'' ''No. We went there, but they wouldn''t {0} because we weren''t members.''', '(let)'),
  (4, '''Can we meet tomorrow at ten?'' ''Probably. I have another meeting, but I think I can {0}.''', '(get)')
) as v(n, template, hint)
where es.title = '138.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '138.4'
join (values
  (1, 'Fill them in', array['Fill them out']::text[]),
  (2, 'cross it out', array[]::text[]),
  (3, 'let us in', array[]::text[]),
  (4, 'get out of it', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '138.5', 'Complete the second sentence so that it means the same as the first. Use a verb from Section B or C.', 4
from units where slug = 'unit-138';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-138' where es.title = '138.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Why didn''t you finish college? Why did you {0}?', null),
  (2, 'Please complete the application form. Please {0}.', null),
  (3, 'I can''t avoid going to the party. I can''t {0}.', null),
  (4, 'I thought the email was genuine, but it wasn''t. I was completely {0} the email.', null),
  (5, 'You must come and see us sometime. You must {0} sometime.', null),
  (6, 'Steve was upset because he wasn''t chosen for the team. Steve was upset because he {0} the team.', null)
) as v(n, template, hint)
where es.title = '138.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '138.5'
join (values
  (1, 'drop out of college', array[]::text[]),
  (2, 'fill in the application form', array['fill out the application form']::text[]),
  (3, 'get out of going', array[]::text[]),
  (4, 'taken in by', array[]::text[]),
  (5, 'drop in and see us', array['drop in sometime', 'drop in']::text[]),
  (6, 'was left out of', array['had been left out of']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
