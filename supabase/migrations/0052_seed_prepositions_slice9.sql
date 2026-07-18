-- Marco 4 (slice 51): seeds the ninth slice of the "Prepositions" module
-- — unit 129 (Noun + preposition: reason for, cause of etc.).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode for 129.3 items 12-14
-- where -layout truncated the extraction) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Safe to re-run: unit 129 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 129: Noun + preposition (reason for, cause of etc.)
-- ============================================================

delete from units where slug = 'unit-129';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 129, 'unit-129', 'Noun + preposition (reason for, cause of etc.)', null,
  'Certain nouns pair with a fixed preposition: a demand/need/reason for; a cause/picture/photo/advantage of; an increase/decrease/rise/fall in; damage/an invitation/a solution/a key/an answer/a reply/a reaction to (or an attitude to/towards); a relationship/connection/contact with somebody, but between two things or people.', 8
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'noun + for ...',
  'a demand / a need for ...: The company went out of business. There was no demand for its product any more. There''s no excuse for behaviour like that. There''s no need for it. a reason for ...: The train was late, but nobody knew the reason for the delay. (not reason of)', 0
from units where slug = 'unit-129';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'noun + of ...',
  'a cause of ...: The cause of the explosion is unknown. a picture / a photo / a photograph / a map / a plan / a drawing (etc.) of ...: Rachel showed me some pictures of her family. I had a map of the town, so I was able to find my way around. an advantage / a disadvantage of ...: The advantage of living alone is that you can do what you like. but there is an advantage in doing something or to doing something: There are many advantages in living alone. or ... many advantages to living alone.', 1
from units where slug = 'unit-129';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'noun + in ...',
  'an increase / a decrease / a rise / a fall in (prices etc.): There has been an increase in the number of road accidents recently. Last year was a bad one for the company. There was a big fall in sales.', 2
from units where slug = 'unit-129';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'noun + to ...',
  'damage to ...: The accident was my fault, so I had to pay for the damage to the other car. an invitation to ... (a party / a wedding etc.): Did you get an invitation to the wedding? a solution to a problem / a key to a door / an answer to a question / a reply to a letter / a reaction to something: I hope we find a solution to the problem. (not a solution of the problem) I was surprised at her reaction to my suggestion. an attitude to ... or an attitude towards ...: His attitude to his job is very negative. or His attitude towards his job ...', 3
from units where slug = 'unit-129';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'noun + with ... / between ...',
  'a relationship / a connection / contact with ...: Do you have a good relationship with your parents? The police want to question a man in connection with the robbery. a relationship / a connection / contact / a difference between two things or people: The police believe that there is no connection between the two crimes. There are some differences between British and American English.', 4
from units where slug = 'unit-129';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-129'
join (values
  ('A', 'There was no demand for its product any more.', null, 0),
  ('A', 'Nobody knew the reason for the delay.', 'not reason of', 1),
  ('B', 'The cause of the explosion is unknown.', null, 0),
  ('B', 'Rachel showed me some pictures of her family.', null, 1),
  ('B', 'The advantage of living alone is that you can do what you like.', null, 2),
  ('B', 'There are many advantages in living alone.', 'or many advantages to living alone', 3),
  ('C', 'There has been an increase in the number of road accidents recently.', null, 0),
  ('C', 'There was a big fall in sales.', null, 1),
  ('D', 'I had to pay for the damage to the other car.', null, 0),
  ('D', 'Did you get an invitation to the wedding?', null, 1),
  ('D', 'I hope we find a solution to the problem.', 'not a solution of the problem', 2),
  ('D', 'His attitude to his job is very negative.', 'or attitude towards his job', 3),
  ('E', 'Do you have a good relationship with your parents?', null, 0),
  ('E', 'There is no connection between the two crimes.', null, 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 129.1-129.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '129.1', 'Complete the second sentence so that it has the same meaning as the first.', 0
from units where slug = 'unit-129';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-129' where es.title = '129.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We''re trying to solve the problem. We''re trying to find a solution {0}', null),
  (2, 'Sue gets on well with her brother. Sue has a good relationship {0}', null),
  (3, 'The cost of living has gone up a lot. There has been a big increase {0}', null),
  (4, 'I don''t know how to answer your question. I can''t think of an answer {0}', null),
  (5, 'I don''t think that a new road is necessary. I don''t think there is any need {0}', null),
  (6, 'I think that living in a big city has many advantages. I think that there are many advantages {0}', null),
  (7, 'Food prices fell last month. Last month there was a fall {0}', null),
  (8, 'Nobody wants shoes like these any more. There is no demand {0}', null),
  (9, 'In what way is your job different from mine? What is the difference {0}', null)
) as v(n, template, hint)
where es.title = '129.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '129.1'
join (values
  (1, 'to the problem.', array[]::text[]),
  (2, 'with her brother.', array[]::text[]),
  (3, 'in the cost of living.', array[]::text[]),
  (4, 'to your question.', array[]::text[]),
  (5, 'for a new road.', array[]::text[]),
  (6, 'in living in a big city.', array['to living in a big city.']::text[]),
  (7, 'in food prices.', array[]::text[]),
  (8, 'for shoes like these any more.', array[]::text[]),
  (9, 'between your job and mine?', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '129.2', 'Complete the sentences using these nouns + a preposition: cause, connection, contact, damage, invitation, key, photos, reason, reply.', 1
from units where slug = 'unit-129';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-129' where es.title = '129.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Thank you for the {0} your birthday party.', null),
  (2, 'Anna has little {0} her family these days. She rarely sees them.', null),
  (3, 'I can''t open this door. Do you have a {0} the other door?', null),
  (4, 'The {0} the fire at the hotel is still unknown.', null),
  (5, 'Did you get a {0} the email you sent?', null),
  (6, 'The two companies are separate. There is no {0} them.', null),
  (7, 'Jane showed me some {0} the city as it looked 100 years ago.', null),
  (8, 'Emily has decided to give up her job. I don''t know her {0} doing this.', null),
  (9, 'It wasn''t a bad accident. The {0} the car wasn''t serious.', null)
) as v(n, template, hint)
where es.title = '129.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '129.2'
join (values
  (1, 'invitation to', array[]::text[]),
  (2, 'contact with', array[]::text[]),
  (3, 'key to', array['key for']::text[]),
  (4, 'cause of', array[]::text[]),
  (5, 'reply to', array[]::text[]),
  (6, 'connection between', array[]::text[]),
  (7, 'photos of', array[]::text[]),
  (8, 'reason for', array[]::text[]),
  (9, 'damage to', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '129.3', 'Complete the sentences with the correct preposition.', 2
from units where slug = 'unit-129';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-129' where es.title = '129.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Money isn''t the solution {0} every problem.', null),
  (2, 'There has been an increase {0} the amount of traffic using this road.', null),
  (3, 'The advantage {0} having a car is that you don''t have to rely on public transport.', null),
  (4, 'There are many advantages {0} being able to speak a foreign language.', null),
  (5, 'Everything can be explained. There''s a reason {0} everything.', null),
  (6, 'When Paul left home, his attitude {0} many things seemed to change.', null),
  (7, 'Ben and I used to be good friends, but I don''t have much contact {0} him now.', null),
  (8, 'James did a very good drawing {0} his father. It looks just like him.', null),
  (9, 'What was Sarah''s reaction {0} the news?', null),
  (10, 'Nicola took a picture {0} me holding the baby.', null),
  (11, 'The show is very popular and there has been a great demand {0} tickets.', null),
  (12, 'There has been a lot of debate about the causes {0} climate change.', null),
  (13, 'The fact that Jane was offered a job in the company has no connection {0} the fact that she is a friend of the managing director.', null)
) as v(n, template, hint)
where es.title = '129.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '129.3'
join (values
  (1, 'to', array[]::text[]),
  (2, 'in', array[]::text[]),
  (3, 'of', array[]::text[]),
  (4, 'in', array['to']::text[]),
  (5, 'for', array[]::text[]),
  (6, 'to', array['towards']::text[]),
  (7, 'with', array[]::text[]),
  (8, 'of', array[]::text[]),
  (9, 'to', array[]::text[]),
  (10, 'of', array[]::text[]),
  (11, 'for', array[]::text[]),
  (12, 'of', array[]::text[]),
  (13, 'with', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
