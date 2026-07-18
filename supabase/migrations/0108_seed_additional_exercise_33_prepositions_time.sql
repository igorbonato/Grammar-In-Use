-- Additional exercise 33: "Prepositions (time)" (Units 12, 119-122).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 33' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 33', 'Put in one of the following: at, on, in, during, for, since, by, until.', 0
from units u where u.slug = 'unit-12';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-12','unit-119','unit-120','unit-121','unit-122')
where es.title = 'Additional exercise 33' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'We''re having a party {0} Saturday. Can you come?'),
  (2, 'I''ve got an interview next week. It''s {0} Tuesday morning {1} 9.30.'),
  (3, 'Sue isn''t usually here {0} weekends. She goes away.'),
  (4, 'The train service is very good. The trains are nearly always {0} time.'),
  (5, 'It was a confusing situation. Many things were happening {0} the same time.'),
  (6, 'I couldn''t decide whether or not to buy the sweater. {0} the end I decided not to.'),
  (7, 'The road is busy all the time, even {0} night.'),
  (8, 'I met a lot of nice people {0} my stay in New York.'),
  (9, 'I saw Helen {0} Friday, but I haven''t seen her {1} then.'),
  (10, 'Robert has been doing the same job {0} five years.'),
  (11, 'Lisa''s birthday is {0} the end of March. I''m not sure exactly which day it is.'),
  (12, 'We have friends staying with us {0} the moment. They''re staying {1} Friday.'),
  (13, 'If you''re interested in applying for the job, your application must be received {0} Friday.'),
  (14, 'I''m just going out. I won''t be long — I''ll be back {0} ten minutes.')
) as v(n, template)
where es.title = 'Additional exercise 33';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 33' and es.kind = 'additional'
join (values
  (1, 0, 'on', array[]::text[]),
  (2, 0, 'on', array[]::text[]), (2, 1, 'at', array[]::text[]),
  (3, 0, 'at', array['on']::text[]),
  (4, 0, 'on', array[]::text[]),
  (5, 0, 'at', array[]::text[]),
  (6, 0, 'In', array[]::text[]),
  (7, 0, 'at', array[]::text[]),
  (8, 0, 'during', array[]::text[]),
  (9, 0, 'on', array[]::text[]), (9, 1, 'since', array[]::text[]),
  (10, 0, 'for', array[]::text[]),
  (11, 0, 'at', array[]::text[]),
  (12, 0, 'at', array[]::text[]), (12, 1, 'until', array[]::text[]),
  (13, 0, 'by', array[]::text[]),
  (14, 0, 'in', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
