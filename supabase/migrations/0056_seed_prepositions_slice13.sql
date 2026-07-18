-- Marco 4 (slice 55): seeds the thirteenth slice of the "Prepositions"
-- module — unit 133 (Verb + preposition 2: about/for/of/after).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 133.1 ("Which is right?") gives two inline phrase options per item
-- (rather than lettered a/b) — kept the book's own two-option shape in
-- the hint, with the correct full phrase as the blank's answer.
--
-- 133.5 items 4, 6 and 8 (renumbered 3, 5, 7) are the only two-blank
-- items in this exercise.
--
-- Safe to re-run: unit 133 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 133: Verb + preposition 2 about/for/of/after
-- ============================================================

delete from units where slug = 'unit-133';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 133, 'unit-133', 'Verb + preposition 2 about/for/of/after', null,
  'talk/read/know/have a discussion about (but discuss something, no preposition); do something/nothing about a problem. ask/apply/wait/search for; leave (a place) for (another place) — but ask somebody the way, no preposition. take care of / care for = look after; care about = think something matters; care what/how/where (no preposition). look for = search; look after = take care of.', 12
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verb + about',
  'talk / read / know about ...: We talked about a lot of things at the meeting. have a discussion about something: We had a discussion about what we should do. But we say ''discuss something'' (no preposition): We discussed what we should do. (not discussed about) do something/nothing about something = do something/nothing to improve a situation: If you''re worried about the problem, you should do something about it.', 0
from units where slug = 'unit-133';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'verb + for',
  'ask (somebody) for ...: I sent an email to the company asking them for more information about the job. But we say ''ask somebody the way / the time'' etc. (no preposition): I asked somebody the way to the station. apply (to a company etc.) for a job etc.: I think you could do this job. Why don''t you apply for it? wait for somebody, wait for something (to happen): Don''t wait for me. I''ll join you later. I''m not going out yet. I''m waiting for the rain to stop. search (a person / a place / a bag etc.) for ...: I''ve searched the house for my keys, but I still can''t find them. leave (a place) for another place: I haven''t seen her since she left (home) for work. (not left to work)', 1
from units where slug = 'unit-133';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'take care of, care for and care about',
  'take care of ... = look after, keep safe, take responsibility for: Don''t worry about me. I can take care of myself. I''ll take care of the travel arrangements. You don''t need to do anything. care for somebody = take care of them, keep them safe: Alan is 85 and lives alone. He needs somebody to care for him. I don''t care for something = I don''t like it: I don''t care for hot weather. (= I don''t like ...) care about ... = think that somebody/something is important: He''s very selfish. He doesn''t care about other people. care what/where/how ... etc. (without about): You can do what you like. I don''t care what you do.', 2
from units where slug = 'unit-133';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'look for and look after',
  'look for ... = search for, try to find: I''ve lost my keys. Can you help me to look for them? look after ... = take care of, keep safe or in good condition: Alan is 85 and lives alone. He needs somebody to look after him. (not look for) You can borrow this book, but please look after it.', 3
from units where slug = 'unit-133';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-133'
join (values
  ('A', 'We talked about a lot of things at the meeting.', null, 0),
  ('A', 'We discussed what we should do.', 'not discussed about', 1),
  ('B', 'Why don''t you apply for it?', null, 0),
  ('B', 'I''m waiting for the rain to stop.', null, 1),
  ('B', 'I asked somebody the way to the station.', null, 2),
  ('C', 'I can take care of myself.', null, 0),
  ('C', 'He needs somebody to care for him.', null, 1),
  ('C', 'I don''t care for hot weather.', '= I don''t like it', 2),
  ('C', 'He doesn''t care about other people.', null, 3),
  ('D', 'Can you help me to look for them?', null, 0),
  ('D', 'He needs somebody to look after him.', 'not look for', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 133.1-133.5; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '133.1', 'Which is right?', 0
from units where slug = 'unit-133';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-133' where es.title = '133.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I sent her an email. Now I''m {0}.', '(waiting for her to reply / waiting her to reply)'),
  (2, 'A security guard {0} as I entered the building.', '(searched my bag / searched for my bag)'),
  (3, 'I paid the taxi driver and {0}.', '(asked him a receipt / asked him for a receipt)'),
  (4, 'I wanted to get to the city centre, so I stopped a man {0}.', '(to ask the way / to ask for the way)'),
  (5, 'We {0}, but we didn''t reach a decision.', '(discussed about the problem / discussed the problem)'),
  (6, 'There are many problems, but the government does {0}.', '(nothing for them / nothing about them)'),
  (7, 'My flight is at 9.30. What time do I need to leave the hotel {0}?', '(to the airport / for the airport)')
) as v(n, template, hint)
where es.title = '133.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '133.1'
join (values
  (1, 'waiting for her to reply'), (2, 'searched my bag'), (3, 'asked him for a receipt'),
  (4, 'to ask the way'), (5, 'discussed the problem'), (6, 'nothing about them'), (7, 'for the airport')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '133.2', 'Put in the correct preposition. If no preposition is necessary, leave the space empty.', 1
from units where slug = 'unit-133';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-133' where es.title = '133.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ve applied {0} three universities. I hope one of them accepts me.', null),
  (2, 'If you don''t want the job, there''s no point in applying {0} it.', null),
  (3, 'I don''t want to talk {0} what happened last night. Let''s forget it.', null),
  (4, 'I don''t want to discuss {0} what happened last night. Let''s forget it.', null),
  (5, 'We had an interesting discussion {0} the problem, but we didn''t reach a decision.', null),
  (6, 'My friends are in Italy. They''re in Rome now and tomorrow they leave {0} Milan.', null),
  (7, 'The roof of the house is in bad condition. We need to do something {0} it.', null)
) as v(n, template, hint)
where es.title = '133.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '133.2'
join (values
  (1, 'to'), (2, 'for'), (3, 'about'), (4, ''), (5, 'about'), (6, 'for'), (7, 'about')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '133.3', 'Put in the correct preposition after care. If no preposition is necessary, leave the space empty.', 2
from units where slug = 'unit-133';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-133' where es.title = '133.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Who''s going to take care {0} you when you are old?', null),
  (2, 'She doesn''t care {0} the exam. She doesn''t care whether she passes or fails.', null),
  (3, 'I don''t like this coat very much. I don''t care {0} the colour.', null),
  (4, 'Don''t worry about the shopping. I''ll take care {0} that.', null),
  (5, 'He gave up his job to care {0} his elderly father.', null),
  (6, 'I want to have a good holiday. I don''t care {0} the cost.', null),
  (7, 'I want to have a good holiday. I don''t care {0} how much it costs.', null)
) as v(n, template, hint)
where es.title = '133.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '133.3'
join (values
  (1, 'of'), (2, 'about'), (3, 'for'), (4, 'of'), (5, 'for'), (6, 'about'), (7, '')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '133.4', 'Complete the sentences with look for or look after. Use the correct form of look (looks/looked/looking).', 3
from units where slug = 'unit-133';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-133' where es.title = '133.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Kate is {0} a job. I hope she finds one soon.', null),
  (2, 'Who {0} you when you were ill?', null),
  (3, 'The car park was full, so we had to {0} somewhere else to park.', null),
  (4, 'A child minder is somebody who {0} other people''s children.', null),
  (5, 'I''m {0} Lisa. I need to ask her something. Have you seen her?', null)
) as v(n, template, hint)
where es.title = '133.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '133.4'
join (values
  (1, 'looking for'), (2, 'looked after'), (3, 'look for'), (4, 'looks after'), (5, 'looking for')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '133.5', 'Complete the sentences with these verbs (in the correct form) + a preposition: apply, ask, do, leave, look, talk, wait.', 4
from units where slug = 'unit-133';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-133' where es.title = '133.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sarah wasn''t ready. We had to {0} her.', null),
  (2, 'I think Amy likes her job, but she doesn''t {0} it much.', null),
  (3, 'Don''t {0} me {1} money. I don''t have any.', null),
  (4, 'Ben is unemployed. He has {0} several jobs, but hasn''t had any luck.', null),
  (5, 'If something is wrong, why don''t you {0} something {1} it?', null),
  (6, 'Helen''s car is very old, but she {0} it. It''s in excellent condition.', null),
  (7, 'Diane is from Boston, but now she lives in Paris. She {0} Boston {1} Paris when she was 19.', null)
) as v(n, template, hint)
where es.title = '133.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '133.5'
join (values
  (1, 0, 'wait for', array[]::text[]),
  (2, 0, 'talk about', array[]::text[]),
  (3, 0, 'ask', array[]::text[]), (3, 1, 'for', array[]::text[]),
  (4, 0, 'applied for', array[]::text[]),
  (5, 0, 'do', array[]::text[]), (5, 1, 'about', array[]::text[]),
  (6, 0, 'looks after', array['has looked after']::text[]),
  (7, 0, 'left', array[]::text[]), (7, 1, 'for', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
