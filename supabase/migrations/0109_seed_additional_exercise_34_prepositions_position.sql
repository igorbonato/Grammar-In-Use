-- Additional exercise 34: "Prepositions (position and other uses)" (Units 123-128).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode). No worked example
-- this time — the Key starts at item 1, so all 25 items are seeded
-- (the Key's answer line wraps a word across two source lines right
-- after item 17 — easy to mistake for the end of the exercise; always
-- read past a wrapped line before assuming a Key block is finished).
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 34' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 34', 'Put in the missing preposition.', 0
from units u where u.slug = 'unit-123';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-123','unit-124','unit-125','unit-126','unit-127','unit-128')
where es.title = 'Additional exercise 34' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'I''d love to be able to visit every country {0} the world.'),
  (2, 'Jessica White is my favourite author. Have you read anything {0} her?'),
  (3, 'There''s a small shop {0} the end of this road.'),
  (4, 'Tom is away at the moment. He''s {0} holiday.'),
  (5, 'We live {0} the country, a long way from the nearest town.'),
  (6, 'I''ve got a stain {0} my jacket. I''ll have to have it cleaned.'),
  (7, 'We went {0} a party {1} Lisa''s house on Saturday.'),
  (8, 'Boston is {0} the east coast of the United States.'),
  (9, 'Look at the leaves {0} that tree. They''re a beautiful colour.'),
  (10, 'I''ve never been {0} Japan, but I''d like to go very much.'),
  (11, 'Mozart died {0} Vienna in 1791 {1} the age of 35.'),
  (12, '''Are you {0} this photo?'' ''Yes, that''s me, {1} the left.'''),
  (13, 'We went {0} the theatre last night. We had seats {1} the front row.'),
  (14, 'If you want to turn the light on, the switch is {0} the wall {1} the door.'),
  (15, 'It was late when we arrived {0} the hotel.'),
  (16, 'I couldn''t decide what to eat. There was nothing {0} the menu that I liked.'),
  (17, 'We live {0} a tower block. Our apartment is {1} the fifteenth floor.'),
  (18, 'Some parts of the film were a bit stupid, but {0} the whole I enjoyed it.'),
  (19, '''When you paid the restaurant bill, did you pay cash?'' ''No, I paid {0} credit card.'''),
  (20, '''How did you get here? Did you come {0} the bus?'' ''No, {1} car.'''),
  (21, 'I watched a really interesting programme {0} TV last night.'),
  (22, 'Helen works for a large company. She works {0} the customer services department.'),
  (23, 'Anna spent two years working {0} London before returning {1} Italy.'),
  (24, 'How was your trip {0} the beach? Did you have a good day?'),
  (25, 'On our first day in Paris, we went {0} a trip round the city.')
) as v(n, template)
where es.title = 'Additional exercise 34';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 34' and es.kind = 'additional'
join (values
  (1, 0, 'in', array[]::text[]),
  (2, 0, 'by', array[]::text[]),
  (3, 0, 'at', array[]::text[]),
  (4, 0, 'on', array[]::text[]),
  (5, 0, 'in', array[]::text[]),
  (6, 0, 'on', array[]::text[]),
  (7, 0, 'to', array[]::text[]), (7, 1, 'at', array[]::text[]),
  (8, 0, 'on', array[]::text[]),
  (9, 0, 'on', array[]::text[]),
  (10, 0, 'to', array[]::text[]),
  (11, 0, 'in', array[]::text[]), (11, 1, 'at', array[]::text[]),
  (12, 0, 'in', array[]::text[]), (12, 1, 'on', array[]::text[]),
  (13, 0, 'to', array[]::text[]), (13, 1, 'in', array[]::text[]),
  (14, 0, 'on', array[]::text[]), (14, 1, 'by', array['next to', 'beside']::text[]),
  (15, 0, 'at', array[]::text[]),
  (16, 0, 'on', array[]::text[]),
  (17, 0, 'in', array[]::text[]), (17, 1, 'on', array[]::text[]),
  (18, 0, 'on', array[]::text[]),
  (19, 0, 'by', array[]::text[]),
  (20, 0, 'on', array[]::text[]), (20, 1, 'by', array[]::text[]),
  (21, 0, 'on', array[]::text[]),
  (22, 0, 'in', array[]::text[]),
  (23, 0, 'in', array[]::text[]), (23, 1, 'to', array[]::text[]),
  (24, 0, 'to', array[]::text[]),
  (25, 0, 'on', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
