-- Additional exercise 32: "Conjunctions" (Units 25, 38, 112-118).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 32' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 32', 'Which is correct?', 0
from units u where u.slug = 'unit-25';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-25','unit-38','unit-112','unit-113','unit-114','unit-115','unit-116','unit-117','unit-118')
where es.title = 'Additional exercise 32' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Don''t throw that bag away. {0} you don''t want it, I''ll have it.'),
  (2, 'Please report to reception {0} you arrive at the hotel.'),
  (3, 'We''ve arranged to go to the beach tomorrow, but we won''t go {0} it''s raining.'),
  (4, 'Tanya is in her final year at school. She still doesn''t know what she''s going to do {0} she leaves.'),
  (5, 'What would you do {0} you lost your keys?'),
  (6, 'I hope I''ll be able to come to the party, but I''ll let you know {0} I can''t.'),
  (7, 'I don''t want to be disturbed, so don''t phone me {0} it''s something important.'),
  (8, 'Please sign the contract {0} you''re happy with the conditions.'),
  (9, 'I like travelling by ship {0} the sea is not rough.'),
  (10, 'You might not remember the name of the hotel, so write it down {0} you forget it.'),
  (11, 'It''s not cold now, but take your coat with you {0} it gets cold later.'),
  (12, 'Take your coat with you and then you can put it on {0} it gets cold later.'),
  (13, 'They always have the TV on, {0} nobody is watching it.'),
  (14, '{0} I left home early, I got to work late.'),
  (15, '{0} we''ve known each other a long time, we''re not particularly close friends.'),
  (16, '''When did you leave school?'' ''{0} I was 17.'''),
  (17, 'I think Amy will be very pleased {0} she hears the news.')
) as v(n, template)
where es.title = 'Additional exercise 32';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 32' and es.kind = 'additional'
join (values
  (1, 'If'), (2, 'when'), (3, 'if'), (4, 'when'), (5, 'if'), (6, 'if'), (7, 'unless'),
  (8, 'if'), (9, 'as long as'), (10, 'in case'), (11, 'in case'), (12, 'if'), (13, 'even if'),
  (14, 'Although'), (15, 'Although'), (16, 'When'), (17, 'when')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
