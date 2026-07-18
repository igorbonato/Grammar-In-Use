-- Marco 4 (slice 58): seeds the sixteenth and final slice of the
-- "Prepositions" module — unit 136 (Verb + preposition 5:
-- in/into/with/to/on).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode). This completes the
-- "Prepositions" module: the PDF's unit headers stop at 136 (confirmed
-- via a full-file grep sweep at the start of this slice sequence) — units
-- 121-136, 16 units across sixteen slices (0044-0059), matching the
-- one-unit-per-slice convention used throughout.
--
-- 136.4 ("Use your own ideas to complete these sentences") is skipped as
-- open-ended — the Key labels it "Example answers", same policy as every
-- prior module.
--
-- Safe to re-run: unit 136 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 136: Verb + preposition 5 in/into/with/to/on
-- ============================================================

delete from units where slug = 'unit-136';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 136, 'unit-136', 'Verb + preposition 5 in/into/with/to/on', null,
  'believe in (something exists / it''s right to do), specialise in, succeed in. break/crash/drive/divide/translate into. collide/fill/provide with (but full of). happen to, invite to, prefer one thing to another. concentrate/insist/spend (money) on.', 15
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verb + in',
  'believe in ... = believe that something exists, believe that it''s good to do something: Do you believe in God? (= do you believe that God exists?) I believe in saying what I think. (= I believe it is right to say what I think) but ''believe something'' (= believe that it is true), ''believe somebody'' (= believe what they say): The story can''t be true. I don''t believe it. (not believe in it) specialise in ...: Helen is a lawyer. She specialises in company law. succeed in ...: I hope you succeed in finding the job you want.', 0
from units where slug = 'unit-136';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'verb + into',
  'break into ...: Our house was broken into a few days ago, but nothing was stolen. crash / drive / bump / run into ...: He lost control of the car and crashed into a wall. divide / cut / split something into two or more parts: The book is divided into three parts. translate a book etc. from one language into another: She''s a famous writer. Her books have been translated into many languages.', 1
from units where slug = 'unit-136';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'verb + with',
  'collide with ...: There was an accident this morning. A bus collided with a car. fill something with ... (but full of — see Unit 131A): Take this saucepan and fill it with water. provide / supply somebody with ...: The school provides all its students with books.', 2
from units where slug = 'unit-136';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'verb + to',
  'happen to ...: What happened to that gold watch you used to have? (= where is it now?) invite somebody to a party / a wedding etc.: They only invited a few people to their wedding. prefer one thing to another: I prefer tea to coffee.', 3
from units where slug = 'unit-136';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'verb + on',
  'concentrate on ...: I tried to concentrate on my work, but I kept thinking about other things. insist on ...: I wanted to go alone, but some friends of mine insisted on coming with me. spend (money) on ...: How much do you spend on food each week?', 4
from units where slug = 'unit-136';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-136'
join (values
  ('A', 'Do you believe in God?', null, 0),
  ('A', 'I don''t believe it.', 'not believe in it', 1),
  ('A', 'She specialises in company law.', null, 2),
  ('B', 'He lost control of the car and crashed into a wall.', null, 0),
  ('B', 'The book is divided into three parts.', null, 1),
  ('B', 'Her books have been translated into many languages.', null, 2),
  ('C', 'A bus collided with a car.', null, 0),
  ('C', 'Fill it with water.', null, 1),
  ('C', 'The school provides all its students with books.', null, 2),
  ('D', 'What happened to that gold watch you used to have?', null, 0),
  ('D', 'They only invited a few people to their wedding.', null, 1),
  ('D', 'I prefer tea to coffee.', null, 2),
  ('E', 'I tried to concentrate on my work.', null, 0),
  ('E', 'Some friends of mine insisted on coming with me.', null, 1),
  ('E', 'How much do you spend on food each week?', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 136.1-136.3; 136.4 skipped as open-ended.
-- Each renumbered from 1, dropping the book's own worked example(s) at
-- the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '136.1', 'Complete the sentences using these verbs (in the correct form) + a preposition: believe, break, concentrate, divide, drive, fill, happen, invite, succeed.', 0
from units where slug = 'unit-136';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-136' where es.title = '136.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I haven''t seen Mike for ages. I wonder what has {0} him.', null),
  (2, 'It''s a very large house. It''s {0} four apartments.', null),
  (3, 'We''ve been {0} the party, but unfortunately we can''t go.', null),
  (4, 'I don''t {0} ghosts. I think people imagine that they see them.', null),
  (5, 'Steve gave me an empty bucket and told me to {0} it {1} water.', null),
  (6, 'A burglar is someone who {0} a house to steal things.', null),
  (7, 'Don''t try and do two things together. {0} one thing at a time.', null),
  (8, 'It wasn''t easy, but in the end we {0} finding a solution to the problem.', null),
  (9, 'The car in front of me stopped suddenly. Unfortunately I couldn''t stop in time and {0} the back of it.', null)
) as v(n, template, hint)
where es.title = '136.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '136.1'
join (values
  (1, 0, 'happened to'),
  (2, 0, 'divided into'),
  (3, 0, 'invited to'),
  (4, 0, 'believe in'),
  (5, 0, 'fill'), (5, 1, 'with'),
  (6, 0, 'breaks into'),
  (7, 0, 'Concentrate on'),
  (8, 0, 'succeeded in'),
  (9, 0, 'drove into')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '136.2', 'Complete the second sentence so that it means the same as the first.', 1
from units where slug = 'unit-136';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-136' where es.title = '136.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t mind big cities, but I prefer small towns. I prefer {0}', null),
  (2, 'I got all the information I needed from the company. The company provided me {0}', null),
  (3, 'This morning I bought a pair of shoes, which cost eighty pounds. This morning I spent {0}', null),
  (4, 'There are ten districts in the city. The city is divided {0}', null)
) as v(n, template, hint)
where es.title = '136.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '136.2'
join (values
  (1, 'small towns to big cities.'),
  (2, 'with all the information I needed.'),
  (3, 'eighty pounds on a pair of shoes.'),
  (4, 'into ten districts.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '136.3', 'Put in the correct preposition. If the sentence is already complete, leave the space empty.', 2
from units where slug = 'unit-136';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-136' where es.title = '136.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A strange thing happened {0} me a few days ago.', null),
  (2, 'Mark decided to give up sport to concentrate {0} his studies.', null),
  (3, 'Money should be used well. I don''t believe {0} wasting it.', null),
  (4, 'My present job isn''t wonderful, but I prefer it {0} what I did before.', null),
  (5, 'I hope you succeed {0} getting what you want.', null),
  (6, 'Ben was injured playing football when he collided {0} another player.', null),
  (7, 'There was an awful noise as the car crashed {0} a tree.', null),
  (8, 'Patrick is a photographer. He specialises {0} sports photography.', null),
  (9, 'Joe doesn''t spend much money {0} clothes.', null),
  (10, 'I was amazed when I heard the news. I couldn''t believe {0} it.', null),
  (11, 'Somebody broke {0} my car and stole my bag.', null),
  (12, 'I was quite cold, but Tom insisted {0} having the window open.', null),
  (13, 'The teacher decided to split the class {0} four groups.', null),
  (14, 'I filled the tank, but unfortunately I filled it {0} the wrong kind of fuel.', null),
  (15, 'Some things are difficult to translate {0} one language {1} another.', null)
) as v(n, template, hint)
where es.title = '136.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '136.3'
join (values
  (1, 0, 'to'), (2, 0, 'on'), (3, 0, 'in'), (4, 0, 'to'), (5, 0, 'in'),
  (6, 0, 'with'), (7, 0, 'into'), (8, 0, 'in'), (9, 0, 'on'), (10, 0, ''),
  (11, 0, 'into'), (12, 0, 'on'), (13, 0, 'into'), (14, 0, 'with'),
  (15, 0, 'from'), (15, 1, 'into')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
