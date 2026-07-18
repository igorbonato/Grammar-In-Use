-- Additional exercise 31: "Adjectives and adverbs" (Units 98-108).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- "Correct the sentences ... write OK if already correct" reuses the
-- literal 'OK' whole-sentence convention (first introduced for unit
-- 95.3/96.2, reused since) for the already-correct items.
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 31' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 31', 'There are mistakes in some of these sentences. Correct the sentences where necessary. Write ''OK'' if the sentence is already correct.', 0
from units u where u.slug = 'unit-98';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-98','unit-99','unit-100','unit-101','unit-102','unit-103','unit-104','unit-105','unit-106','unit-107','unit-108')
where es.title = 'Additional exercise 31' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'The city is very polluted. It''s the more polluted place I''ve ever been to. {0}'),
  (2, 'I was disappointing that I didn''t get the job. I was well-qualified and the interview went well. {0}'),
  (3, 'It''s warm today, but there''s quite a strong wind. {0}'),
  (4, 'Joe works hardly, but he doesn''t get paid very much. {0}'),
  (5, 'The company''s offices are in a modern large building. {0}'),
  (6, 'Dan is a very fast runner. I wish I could run as fast as him. {0}'),
  (7, 'I missed the three last days of the course because I was ill. {0}'),
  (8, 'You don''t look happy. What''s the matter? {0}'),
  (9, 'The weather has been unusual cold for the time of the year. {0}'),
  (10, 'The water in the pool was too dirty to swim in it. {0}'),
  (11, 'I got impatient because we had to wait so long time. {0}'),
  (12, 'Is this box big enough or do you need a bigger one? {0}'),
  (13, 'This morning I got up more early than usual. {0}')
) as v(n, template)
where es.title = 'Additional exercise 31';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 31' and es.kind = 'additional'
join (values
  (1, 'It''s the most polluted place I''ve ever been to.', array[]::text[]),
  (2, 'I was disappointed that I didn''t get the job.', array[]::text[]),
  (3, 'OK', array[]::text[]),
  (4, 'Joe works hard, but he doesn''t get paid very much.', array[]::text[]),
  (5, 'The company''s offices are in a large modern building.', array[]::text[]),
  (6, 'OK', array['I wish I could run as fast as he can.']::text[]),
  (7, 'I missed the last three days of the course because I was ill.', array[]::text[]),
  (8, 'OK', array[]::text[]),
  (9, 'The weather has been unusually cold for the time of the year.', array[]::text[]),
  (10, 'The water in the pool was too dirty to swim in.', array[]::text[]),
  (11, 'I got impatient because we had to wait such a long time.', array['I got impatient because we had to wait so long.']::text[]),
  (12, 'OK', array[]::text[]),
  (13, 'This morning I got up earlier than usual.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
