-- Marco 4 (slice 37): seeds the second slice of the "Conjunctions and
-- prepositions" module — unit 115 (unless; as long as / so long as /
-- provided / providing).
--
-- Sourced from pdf/Modulos/Conjunctions and prepositions.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode). Seeded one unit per migration
-- from here on, per Igor's request.
--
-- 115.4 ("Use your own ideas to complete these sentences") is skipped as
-- open-ended — the Key itself labels it "Example answers" for genuinely
-- personal completions, same policy as every prior module.
--
-- Safe to re-run: unit 115 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 115: unless; as long as / so long as / provided / providing
-- ============================================================

delete from units where slug = 'unit-115';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 115, 'unit-115', 'unless', null,
  'unless = except if: you can''t go in unless you are a member. Instead of unless you can often say if ... not. as long as / so long as and provided (that) / providing (that) all mean "if, on condition that": you can borrow my car as long as you promise not to drive too fast. Talking about the future, we do not use will after unless / as long as / provided / providing — we use a present tense instead.', 2
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'unless',
  'Study this example situation: The club is for members only. You can''t go in unless you are a member. This means: You can''t go in except if you are a member. You can go in only if you are a member. unless = except if. Some more examples of unless: I''ll see you tomorrow unless I have to work late. (= except if I have to work late) There are no buses to the beach. Unless you have a car, it''s difficult to get there. ''Shall I tell Lisa what happened?'' ''Not unless she asks you.'' (= tell her only if she asks you) Ben hates to complain. He wouldn''t complain about something unless it was really bad. We can take a taxi to the restaurant — unless you''d prefer to walk. Instead of unless it is often possible to say if ... not: Unless we leave now, we''ll be late. or If we don''t leave now, we''ll ...', 0
from units where slug = 'unit-115';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'as long as / provided / providing',
  'You can say as long as or so long as (= if, on condition that): You can borrow my car as long as you promise not to drive too fast. (= You can borrow my car, but you must promise not to drive too fast. This is a condition.) You can also say provided (that) or providing (that): Travelling by car is convenient provided (that) you have somewhere to park. (= It''s convenient but only if you have somewhere to park.) Providing (that) the room is clean, I don''t mind which hotel we stay at. (= The room must be clean, but otherwise I don''t mind.)', 1
from units where slug = 'unit-115';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'unless / as long as etc. for the future',
  'When we are talking about the future, we do not use will after unless / as long as / so long as / provided / providing. We use a present tense (see Unit 25): I''m not going out unless it stops raining. (not unless it will stop) Providing the weather is good, we''re going to have a picnic tomorrow. (not providing the weather will be good)', 2
from units where slug = 'unit-115';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-115'
join (values
  ('A', 'You can''t go in unless you are a member.', null, 0),
  ('A', 'I''ll see you tomorrow unless I have to work late.', '= except if I have to work late', 1),
  ('A', 'Unless you have a car, it''s difficult to get there.', null, 2),
  ('A', '''Shall I tell Lisa what happened?'' ''Not unless she asks you.''', '= tell her only if she asks you', 3),
  ('A', 'He wouldn''t complain about something unless it was really bad.', null, 4),
  ('A', 'We can take a taxi to the restaurant — unless you''d prefer to walk.', null, 5),
  ('A', 'Unless we leave now, we''ll be late. or If we don''t leave now, we''ll ...', null, 6),
  ('B', 'You can borrow my car as long as you promise not to drive too fast.', null, 0),
  ('B', 'Travelling by car is convenient provided (that) you have somewhere to park.', null, 1),
  ('B', 'Providing (that) the room is clean, I don''t mind which hotel we stay at.', null, 2),
  ('C', 'I''m not going out unless it stops raining.', 'not unless it will stop', 0),
  ('C', 'Providing the weather is good, we''re going to have a picnic tomorrow.', 'not providing the weather will be good', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 115.1-115.3; 115.4 skipped as open-ended.
-- Each renumbered from 1, dropping the book's own worked example(s) at
-- the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '115.1', 'Write a new sentence with the same meaning. Use unless in your sentence.', 0
from units where slug = 'unit-115';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-115' where es.title = '115.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Listen carefully, or you won''t know what to do. You won''t know what to do {0}', null),
  (2, 'She must apologise to me, or I''ll never speak to her again. I''ll never speak to her again {0}', null),
  (3, 'You have to speak very slowly, or he won''t understand you. He won''t understand you {0}', null),
  (4, 'Business must improve soon, or the company will have to close. The company will have to close {0}', null),
  (5, 'We need to do something soon, or the problem will get worse. The problem will get worse {0}', null)
) as v(n, template, hint)
where es.title = '115.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '115.1'
join (values
  (1, 'unless you listen carefully.', array[]::text[]),
  (2, 'unless she apologises to me.', array['unless she apologises.']::text[]),
  (3, 'unless you speak very slowly.', array[]::text[]),
  (4, 'unless business improves soon.', array[]::text[]),
  (5, 'unless we do something soon.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '115.2', 'Write sentences with unless.', 1
from units where slug = 'unit-115';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-115' where es.title = '115.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t want to go to the party alone. I''m going only if you go too. I''m not going {0}', null),
  (2, 'Don''t worry about the dog. It will chase you only if you move suddenly. The dog {0}', null),
  (3, 'Ben isn''t very talkative. He''ll speak to you only if you ask him something. Ben {0}', null),
  (4, 'Today is a public holiday. The doctor will see you only if it''s an emergency. The doctor {0}', null)
) as v(n, template, hint)
where es.title = '115.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '115.2'
join (values
  (1, 'unless you go too.', array['to the party unless you go too.', 'unless you''re going too.']::text[]),
  (2, 'won''t chase you unless you move suddenly.', array[]::text[]),
  (3, 'won''t speak to you unless you ask him something.', array[]::text[]),
  (4, 'won''t see you unless it''s an emergency.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '115.3', 'Which is correct?', 2
from units where slug = 'unit-115';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-115' where es.title = '115.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We''re going to the beach tomorrow {0} the weather is bad.', '(unless / providing)'),
  (2, 'We''re going to the beach tomorrow {0} the weather is good.', '(unless / providing)'),
  (3, 'I don''t mind if you come home late {0} you come in quietly.', '(unless / as long as)'),
  (4, 'I''m going now {0} you want me to stay.', '(unless / provided)'),
  (5, 'I don''t watch TV {0} I have nothing else to do.', '(unless / as long as)'),
  (6, 'Children are allowed to use the swimming pool {0} they are with an adult.', '(unless / provided)'),
  (7, '{0} they are with an adult, children are not allowed to use the swimming pool.', '(Unless / Provided)'),
  (8, 'We can sit here in the corner {0} you''d rather sit by the window.', '(unless / as long as)'),
  (9, '''Our holiday cost a lot of money.'' ''Did it? Well, that doesn''t matter {0} you enjoyed yourselves.''', '(unless / as long as)')
) as v(n, template, hint)
where es.title = '115.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '115.3'
join (values
  (1, 'unless'), (2, 'providing'), (3, 'as long as'), (4, 'unless'), (5, 'unless'),
  (6, 'provided'), (7, 'Unless'), (8, 'unless'), (9, 'as long as')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
