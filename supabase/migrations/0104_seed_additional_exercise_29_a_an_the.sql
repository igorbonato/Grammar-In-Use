-- Additional exercise 29: "a/an and the" (Units 69-78).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- "Put in a/an or the where necessary" reuses the established empty-
-- string "no word needed" convention (commit e793d03) for blanks
-- where no article is required.
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 29' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 29', 'Put in a/an or the where necessary. Leave the space empty if the sentence is already complete.', 0
from units u where u.slug = 'unit-69';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-69','unit-70','unit-71','unit-72','unit-73','unit-74','unit-75','unit-76','unit-77','unit-78')
where es.title = 'Additional exercise 29' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'If you go to live in {0} foreign country, you should try and learn {1} language.'),
  (2, 'Helen is {0} economist. She lives in {1} United States and works for {2} investment company.'),
  (3, 'I love {0} sport, especially {1} tennis. I play two or three times {2} week if I can, but I''m not {3} very good player.'),
  (4, 'I won''t be home for {0} dinner this evening. I''m meeting some friends after {1} work and we''re going to {2} cinema.'),
  (5, 'When {0} unemployment is high, it''s difficult for {1} people to find {2} work. It''s {3} big problem.'),
  (6, 'There was {0} accident as I was going {1} home last night. Two people were taken to {2} hospital. I think {3} most accidents are caused by {4} people driving too fast.'),
  (7, 'a: What''s {0} name of {1} hotel where you''re staying? b: {2} Ambassador. It''s in {3} Queen Street in {4} city centre. It''s near {5} station.'),
  (8, 'I have two brothers. {0} older one is training to be {1} pilot. {2} younger one is still at {3} school. When he leaves {4} school, he wants to go to {5} university to study {6} law.')
) as v(n, template)
where es.title = 'Additional exercise 29';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 29' and es.kind = 'additional'
join (values
  (1, 0, 'a', array[]::text[]), (1, 1, 'the', array[]::text[]),
  (2, 0, 'an', array[]::text[]), (2, 1, 'the', array[]::text[]), (2, 2, 'an', array[]::text[]),
  (3, 0, '', array[]::text[]), (3, 1, '', array[]::text[]), (3, 2, 'a', array[]::text[]), (3, 3, 'a', array[]::text[]),
  (4, 0, '', array[]::text[]), (4, 1, '', array[]::text[]), (4, 2, 'the', array[]::text[]),
  (5, 0, '', array[]::text[]), (5, 1, '', array[]::text[]), (5, 2, '', array[]::text[]), (5, 3, 'a', array[]::text[]),
  (6, 0, 'an', array[]::text[]), (6, 1, '', array[]::text[]), (6, 2, '', array['the']::text[]), (6, 3, '', array[]::text[]), (6, 4, '', array[]::text[]),
  (7, 0, 'the', array[]::text[]), (7, 1, 'the', array[]::text[]), (7, 2, 'The', array[]::text[]), (7, 3, '', array[]::text[]), (7, 4, 'the', array[]::text[]), (7, 5, 'the', array[]::text[]),
  (8, 0, 'The', array[]::text[]), (8, 1, 'a', array[]::text[]), (8, 2, 'The', array[]::text[]), (8, 3, '', array[]::text[]), (8, 4, '', array[]::text[]), (8, 5, '', array[]::text[]), (8, 6, '', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
