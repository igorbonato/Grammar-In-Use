-- Additional exercise 9: "Past continuous and used to" (Units 6, 18).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Items 1-2 are the book's own two worked examples (Key starts at
-- item 3) — dropped, renumbered from 1.
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 9' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 9',
  'Complete the sentences using the past continuous (was/were -ing) or used to ... . Use the verb in brackets.', 0
from units u where u.slug = 'unit-6';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-6', 'unit-18')
where es.title = 'Additional exercise 9' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I {0} a lot, but I don''t use my car very much these days.', '(drive)'),
  (2, 'I asked the taxi driver to slow down. She {0} too fast.', '(drive)'),
  (3, 'Rosemary and Jonathan met for the first time when they {0} in the same bank.', '(work)'),
  (4, 'When I was a child, I {0} a lot of bad dreams.', '(have)'),
  (5, 'I wonder what Joe is doing these days. He {0} in Spain when I last heard from him.', '(live)'),
  (6, '''Where were you yesterday afternoon?'' ''I {0} volleyball.''', '(play)'),
  (7, '''Do you do any sports?'' ''Not these days, but I {0} volleyball.''', '(play)'),
  (8, 'George looked very smart at the party. He {0} a very nice suit.', '(wear)')
) as v(n, template, hint)
where es.title = 'Additional exercise 9';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 9' and es.kind = 'additional'
join (values
  (1, 'used to drive'),
  (2, 'was driving'),
  (3, 'were working'),
  (4, 'used to have'),
  (5, 'was living'),
  (6, 'was playing'),
  (7, 'used to play'),
  (8, 'was wearing')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
