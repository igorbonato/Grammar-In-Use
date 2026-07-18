-- Additional exercise 35: "Noun/adjective + preposition" (Units 129-131).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode). No worked
-- example — the Key starts at item 1, so all 12 items are seeded.
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 35' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 35', 'Put in the missing preposition.', 0
from units u where u.slug = 'unit-129';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-129','unit-130','unit-131')
where es.title = 'Additional exercise 35' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'The plan has been changed, but nobody seems to know the reason {0} this.'),
  (2, 'Don''t ask me to decide. I''m not very good {0} making decisions.'),
  (3, 'Some people say that Sue is unfriendly, but she''s always very nice {0} me.'),
  (4, 'What do you think is the best solution {0} the problem?'),
  (5, 'Recently there has been a big increase {0} the number of tourists visiting the city.'),
  (6, 'He lives a rather lonely life. He doesn''t have much contact {0} other people.'),
  (7, 'Paul is a keen photographer. He likes taking pictures {0} people.'),
  (8, 'Michael got married {0} a woman he met when he was studying at college.'),
  (9, 'He''s very brave. He''s not scared {0} anything.'),
  (10, 'I''m surprised {0} the traffic today. I didn''t think it would be so busy.'),
  (11, 'Thank you for lending me the guidebook. It was full {0} useful information.'),
  (12, 'I''m afraid I''ve had to change my plans, so I can''t meet you tomorrow. I''m sorry {0} that.')
) as v(n, template)
where es.title = 'Additional exercise 35';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 35' and es.kind = 'additional'
join (values
  (1, 'for', array[]::text[]),
  (2, 'at', array[]::text[]),
  (3, 'to', array[]::text[]),
  (4, 'to', array[]::text[]),
  (5, 'in', array[]::text[]),
  (6, 'with', array[]::text[]),
  (7, 'of', array[]::text[]),
  (8, 'to', array[]::text[]),
  (9, 'of', array[]::text[]),
  (10, 'at', array['by']::text[]),
  (11, 'of', array[]::text[]),
  (12, 'about', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
