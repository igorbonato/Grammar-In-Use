-- Marco 4 (slice 61): seeds the third slice of the "Phrasal verbs"
-- module — unit 139 (Phrasal verbs 3: out).
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 139.3 is picture-based (5 small scenes), same shape as prior
-- picture exercises — a theory_images placeholder plus each scene
-- rebuilt from its picture caption + surrounding text.
--
-- Safe to re-run: unit 139 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 139: Phrasal verbs 3 out
-- ============================================================

delete from units where slug = 'unit-139';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 139, 'unit-139', 'Phrasal verbs 3 out', null,
  'out = not burning/not shining (go out, put out a fire/cigarette/light, turn out a light, blow out a candle). work out = do physical exercise; develop/progress; be calculated at; calculate; understand/find an answer (also figure out). carry out an order/experiment/survey/plan; find out = get information; give/hand out = give to each person; point out = draw attention to; run out (of something) = use it all up; sort out = find a solution to, put in order; turn out to be / turn out nice etc.; try out = test something new.', 2
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'out = not burning, not shining',
  'go out; put out a fire / a cigarette / a light; turn out a light; blow out a candle.', 0
from units where slug = 'unit-139';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'work out',
  'work out = do physical exercises. work out = develop, progress. work out (for calculations) = be calculated at. work (something) out = calculate. work out or figure out = understand, think about a problem and find an answer.', 1
from units where slug = 'unit-139';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Other verbs + out',
  'carry out an order / an experiment / a survey / an investigation / a plan etc. find out that/what/when ..., find out about ... = get information about. give/hand things out = give to each person. point something out (to somebody) = draw attention to it. run out (of something) = use all of it. sort something out = find a solution to, put in order. turn out to be ... / turn out good/nice etc. / turn out that ... try out a machine, a system, a new idea etc. = test it to see if it is OK.', 2
from units where slug = 'unit-139';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-139'
join (values
  ('A', 'Suddenly all the lights in the building went out.', null, 0),
  ('A', 'I put the fire out with a fire extinguisher.', null, 1),
  ('A', 'We don''t need the candle. You can blow it out.', null, 2),
  ('B', 'Rachel works out at the gym three times a week.', null, 0),
  ('B', 'Good luck for the future. I hope everything works out well for you.', null, 1),
  ('B', 'The total bill for three people is 97.35. That works out at 32.45 each.', null, 2),
  ('B', 'I can''t work it out in my head.', null, 3),
  ('B', 'Investigators are trying to work out what caused the accident.', 'or figure out', 4),
  ('C', 'Soldiers are expected to carry out orders.', null, 0),
  ('C', 'The police never found out who committed the crime.', null, 1),
  ('C', 'At the end of the lecture, the speaker gave out information sheets to the audience.', null, 2),
  ('C', 'As we drove through the city, the tour guide pointed out all the sights.', null, 3),
  ('C', 'We ran out of petrol on the motorway.', '= we used all our petrol', 4),
  ('C', 'There are a few problems we need to sort out.', null, 5),
  ('C', 'Nobody believed Paul at first, but he turned out to be right.', null, 6),
  ('C', 'The company is trying out some new software at the moment.', null, 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 139.1-139.4; each renumbered from 1,
-- dropping the book's own worked example)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '139.1', 'Which words can go together? Choose from the list: a candle, a fire, a light, a new product, an order, a problem.', 0
from units where slug = 'unit-139';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-139' where es.title = '139.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'blow out {0}', null),
  (2, 'carry out {0}', null),
  (3, 'put out {0}', null),
  (4, 'try out {0}', null),
  (5, 'sort out {0}', null)
) as v(n, template, hint)
where es.title = '139.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '139.1'
join (values
  (1, 'a candle'), (2, 'an order'), (3, 'a fire'),
  (4, 'a new product'), (5, 'a problem')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '139.2', 'Complete the sentences using a verb + out.', 1
from units where slug = 'unit-139';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-139' where es.title = '139.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Steve is very fit. He does a lot of sport and {0} regularly.', null),
  (2, 'The road will be closed for two days while building work is {0}.', null),
  (3, 'We didn''t manage to discuss everything at the meeting. We {0} of time.', null),
  (4, 'You have to {0} the problem yourself. I can''t do it for you.', null),
  (5, 'I need to {0} what happened exactly. It''s not clear at the moment.', null),
  (6, 'The new drug will be {0} on a small group of patients.', null),
  (7, 'I thought the two books were the same until someone {0} the difference.', null),
  (8, 'They got married a few years ago, but it didn''t {0} and they separated.', null),
  (9, 'There was a power cut and all the lights {0}.', null),
  (10, 'We thought she was American at first, but she {0} to be Swedish.', null),
  (11, 'Sometimes it {0} cheaper to eat in a restaurant than to cook at home.', null),
  (12, 'How did you {0} about the project? Did somebody tell you?', null),
  (13, 'It took firefighters two hours to {0} the fire.', null),
  (14, 'I can''t {0} how the water is getting into the house.', null)
) as v(n, template, hint)
where es.title = '139.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '139.2'
join (values
  (1, 'works out', array[]::text[]),
  (2, 'carried out', array[]::text[]),
  (3, 'ran out', array[]::text[]),
  (4, 'sort out', array[]::text[]),
  (5, 'find out', array['work out', 'figure out']::text[]),
  (6, 'tried out', array[]::text[]),
  (7, 'pointed out', array[]::text[]),
  (8, 'work out', array[]::text[]),
  (9, 'went out', array[]::text[]),
  (10, 'turned out', array[]::text[]),
  (11, 'works out', array['turns out']::text[]),
  (12, 'find out', array[]::text[]),
  (13, 'put out', array[]::text[]),
  (14, 'figure out', array['work out']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: five small pictures used in exercise 139.3 — a man and woman stranded by their car with an empty fuel gauge; a man with a beard handing out leaflets on the street; a sunny sky replacing an earlier cloudy one; Sally and Kim exercising at the gym; Joe holding an empty water bottle; Lisa looking puzzled at a camera]', 0
from units where slug = 'unit-139';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '139.3', 'For each picture, complete the sentence using a verb + out.', 2
from units where slug = 'unit-139';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-139' where es.title = '139.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The man with the beard is {0} leaflets.', null),
  (2, 'The weather has {0}.', null),
  (3, 'Sally and Kim are {0} at the gym.', null),
  (4, 'Joe has {0} water.', null),
  (5, 'Lisa is trying to {0} how to use the camera.', null)
) as v(n, template, hint)
where es.title = '139.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '139.3'
join (values
  (1, 'giving out', array['handing out']::text[]),
  (2, 'turned out nice', array['turned out fine', 'turned out sunny']::text[]),
  (3, 'working out', array[]::text[]),
  (4, 'run out of', array[]::text[]),
  (5, 'work out', array['figure out']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '139.4', 'Complete the sentences. Each time use a verb + out.', 3
from units where slug = 'unit-139';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-139' where es.title = '139.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A: This recipe looks interesting. B: Yes, let''s {0}.', null),
  (2, 'A: How much money do I owe you exactly? B: Just a moment. I''ll have to {0}.', null),
  (3, 'A: What happened about your problem with your bank? B: It''s OK now. I went to see them and we {0}.', null),
  (4, 'A: You''ve written the wrong date on this form. B: Oh, so I have. Thanks for {0}.', null)
) as v(n, template, hint)
where es.title = '139.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '139.4'
join (values
  (1, 'try it out', array[]::text[]),
  (2, 'work it out', array[]::text[]),
  (3, 'sorted it out', array['worked it out']::text[]),
  (4, 'pointing it out', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
