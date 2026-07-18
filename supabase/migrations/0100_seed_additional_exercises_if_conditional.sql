-- Additional exercises 19-20: "if (conditional)" (Units 25, 38-40).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 21 ("Use your own ideas...") is genuinely open-ended this
-- time — the Key is explicitly labelled "Example answers" and the
-- sentence starters (e.g. "I'd go out tonight if ___", "Who would
-- you phone if ___?") admit many substantively different valid
-- completions, unlike earlier "own ideas" exercises in this project
-- that turned out to have one fixed grammar pattern — skipped per
-- the established "open-ended exercises are skipped" convention.
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 19', 'Additional exercise 20') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 19', 'Put the verb into the correct form.', 0
from units u where u.slug = 'unit-25';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-25', 'unit-38', 'unit-39', 'unit-40')
where es.title = 'Additional exercise 19' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'If the doorbell {0}, don''t answer it.', '(ring)'),
  (2, 'I can''t decide what to do. What would you do if {0} me?', '(you / be)'),
  (3, 'a: What shall we do tomorrow? b: Well, if {0} a nice day, we can go to the beach.', '(it / be)'),
  (4, 'a: Let''s go to the beach. b: No, it''s not warm enough. If {0} warmer, I''d go.', '(it / be)'),
  (5, 'a: Did you go to the beach yesterday? b: No, it was too cold. If {0} warmer, we might have gone.', '(it / be)'),
  (6, 'If {0} enough money to go anywhere in the world, where would you go?', '(you / have)'),
  (7, 'I didn''t have my phone with me, so I couldn''t call you. I would have called you if {0} my phone.', '(I / have)'),
  (8, 'The accident was your fault. If you''d been driving more carefully, {0}.', '(it / not / happen)'),
  (9, 'a: Why do you watch the news every day? b: Well, if {0} it, I wouldn''t know what was happening in the world.', '(I / not / watch)')
) as v(n, template, hint)
where es.title = 'Additional exercise 19';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 19' and es.kind = 'additional'
join (values
  (1, 'rings', array[]::text[]),
  (2, 'you were', array[]::text[]),
  (3, 'it''s', array['it is']::text[]),
  (4, 'it was', array['it were']::text[]),
  (5, 'it had been', array[]::text[]),
  (6, 'you had', array[]::text[]),
  (7, 'I''d had', array['I had had']::text[]),
  (8, 'it wouldn''t have happened', array[]::text[]),
  (9, 'I didn''t watch', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 20', 'Complete the sentences.', 1
from units u where u.slug = 'unit-25';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-25', 'unit-38', 'unit-39', 'unit-40')
where es.title = 'Additional exercise 20' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'It''s getting late. I don''t think Sarah will call me now. I''d be surprised if Sarah {0} now.'),
  (2, 'I''m sorry I disturbed you. I didn''t know you were busy. If {0} you were busy, I {1} you.'),
  (3, 'There are a lot of accidents on this road. There is no speed limit. There {0} so many accidents if {1} a speed limit.'),
  (4, 'You didn''t tell me about the problem, so I didn''t try to help you. If {0} the problem, {1} you.'),
  (5, 'It started to rain, but fortunately I had an umbrella. I {0} very wet if {1} an umbrella.'),
  (6, 'Mark failed his driving test. He was very nervous and that''s why he failed. If he {0} so nervous, he {1} the test.')
) as v(n, template)
where es.title = 'Additional exercise 20';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 20' and es.kind = 'additional'
join (values
  (1, 0, 'called me', array[]::text[]),
  (2, 0, 'I''d known', array['I had known']::text[]), (2, 1, 'wouldn''t have disturbed', array[]::text[]),
  (3, 0, 'wouldn''t be', array[]::text[]), (3, 1, 'there was', array['there were']::text[]),
  (4, 0, 'you''d told me about', array[]::text[]), (4, 1, 'I would have tried to help', array['I''d have tried to help', 'I would have helped', 'I''d have helped']::text[]),
  (5, 0, 'would have got', array['would have gotten']::text[]), (5, 1, 'I hadn''t had', array[]::text[]),
  (6, 0, 'hadn''t been', array['hadn''t got', 'hadn''t gotten']::text[]), (6, 1, 'wouldn''t have failed', array['would have passed', '''d have passed']::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
