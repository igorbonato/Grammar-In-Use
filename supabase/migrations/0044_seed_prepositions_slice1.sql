-- Marco 4 (slice 43): seeds the first slice of the "Prepositions" module
-- — unit 121 (at/on/in time).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Grepped unit-number headers across the whole file before assuming its
-- range (same check applied to every oversized PDF since Modals.pdf):
-- this file spans units 121-136 (16 units, confirmed no "137" header) —
-- the largest module in the book, tied with -ing-and-to.pdf. New module
-- `prepositions`, order_index 14, seeded one unit per migration slice per
-- the standing feedback memory from the Conjunctions and prepositions
-- module (also built via small Write + incremental Edit calls, same
-- memory).
--
-- 121.3 ("Which is correct: a, b, or both of them?") is adapted to a
-- short-answer format: the blank's correct answer is literally "a", "b",
-- or "both", matching the book's own three-way choice.
--
-- Safe to re-run: unit 121 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('prepositions', 'Prepositions', 14)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 121: at/on/in (time)
-- ============================================================

delete from units where slug = 'unit-121';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 121, 'unit-121', 'at/on/in (time)', null,
  'We use at for the time of day (at five o''clock), on for days and dates (on Friday, on 16 May), and in for longer periods like months, years and seasons (in June, in 2012, in winter). We do not use at/on/in before last/next/this/every (next Friday, not on next Friday). in ... also says how long something takes, or how far in the future (in a few minutes, in four weeks).', 0
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'at, on and in',
  'Compare at, on and in: They arrived at 5 o''clock. They arrived on Friday. They arrived in June. / They arrived in 2012. We use: at for the time of day — at five o''clock, at 11.45, at midnight, at lunchtime, at sunset etc. on for days and dates — on 16 May 2012, on New Year''s Day, on my birthday, on Friday / on Fridays. in for longer periods (months/years/seasons etc.) — in June, in 2012, in the 1990s, in the 20th century, in the past, in winter.', 0
from units where slug = 'unit-121';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'fixed time expressions with at',
  'We say: at the moment / at the minute / at present / at this time (= now) — Can we talk later? I''m busy at the moment. at the same time — Kate and I arrived at the same time. at the weekends / at weekends (or on the weekend / on weekends in American English) — Will you be here at the weekend? (or ... on the weekend) at Christmas (but on Christmas Day) — Do you give each other presents at Christmas? at night (= during nights in general), in the night (= during a particular night) — I don''t like working at night. but I was woken up by a noise in the night.', 1
from units where slug = 'unit-121';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'in the morning(s) but on Friday morning(s)',
  'We say: in the morning(s), in the afternoon(s), in the evening(s) — I''ll see you in the morning. Do you work in the evenings? but on Friday morning(s), on Sunday afternoon(s), on Monday evening(s) etc. — I''ll see you on Friday morning. Do you work on Saturday evenings?', 2
from units where slug = 'unit-121';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'no preposition before last/next/this/every',
  'We do not use at/on/in before last/next/this/every: I''ll see you next Friday. (not on next Friday) They got married last June. We often leave out on before days. So you can say: I''ll see you on Friday. or I''ll see you Friday. I don''t work on Monday mornings. or I don''t work Monday mornings.', 3
from units where slug = 'unit-121';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'in a few minutes / in six months',
  'We say that something will happen in a few minutes / in six months etc.: The train will be leaving in a few minutes. (= a few minutes from now) Andy has gone away. He''ll be back in a week. (= a week from now) They''ll be here in a moment. (= a moment from now, very soon) We also use in ... to say how long it takes to do something: I learnt to drive in four weeks. (= it took me four weeks to learn)', 4
from units where slug = 'unit-121';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-121'
join (values
  ('A', 'They arrived at 5 o''clock.', null, 0),
  ('A', 'They arrived on Friday.', null, 1),
  ('A', 'They arrived in June. / They arrived in 2012.', null, 2),
  ('B', 'Can we talk later? I''m busy at the moment.', null, 0),
  ('B', 'Kate and I arrived at the same time.', null, 1),
  ('B', 'Do you give each other presents at Christmas?', null, 2),
  ('B', 'I don''t like working at night. but I was woken up by a noise in the night.', null, 3),
  ('C', 'I''ll see you in the morning.', null, 0),
  ('C', 'I''ll see you on Friday morning.', null, 1),
  ('C', 'Do you work on Saturday evenings?', null, 2),
  ('D', 'I''ll see you next Friday.', 'not on next Friday', 0),
  ('D', 'They got married last June.', null, 1),
  ('D', 'I''ll see you on Friday. or I''ll see you Friday.', null, 2),
  ('E', 'The train will be leaving in a few minutes.', '= a few minutes from now', 0),
  ('E', 'He''ll be back in a week.', '= a week from now', 1),
  ('E', 'I learnt to drive in four weeks.', '= it took me four weeks to learn', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 121.1-121.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '121.1', 'Put in at, on or in.', 0
from units where slug = 'unit-121';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-121' where es.title = '121.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ve been invited to a wedding {0} 14 February.', null),
  (2, 'Amy''s birthday is {0} May, but I don''t know which date.', null),
  (3, 'This park is popular and gets very busy {0} weekends.', null),
  (4, 'I haven''t seen Kate for a few days. I last saw her {0} Tuesday.', null),
  (5, 'Jonathan is 63. He''ll be retiring from his job {0} two years.', null),
  (6, 'I''m busy right now. I''ll be with you {0} a moment.', null),
  (7, 'Sam isn''t here {0} the moment, but he''ll be here this afternoon.', null),
  (8, 'There are usually a lot of parties {0} New Year''s Eve.', null),
  (9, 'I don''t like the dark. I try to avoid going out {0} night.', null),
  (10, 'It rained very hard {0} the night. Did you hear it?', null),
  (11, 'My car is being repaired at the garage. It will be ready {0} two hours.', null),
  (12, 'The bus station was busy. A lot of buses were leaving {0} the same time.', null),
  (13, 'Helen and David always go out for dinner {0} their wedding anniversary.', null),
  (14, 'It was a short book and easy to read. I read it {0} a day.', null),
  (15, '{0} midday, the sun is at its highest point in the sky.', null),
  (16, 'This building is very old. It was built {0} the fifteenth century.', null),
  (17, 'The office is closed {0} Wednesday afternoons.', null),
  (18, 'In the UK many people go home to see their families {0} Christmas.', null),
  (19, 'My flight arrives {0} 5 o''clock {1} the morning.', null),
  (20, 'The course begins {0} 7 January and ends sometime {1} April.', null),
  (21, 'I might not be at home {0} Tuesday morning, but I''ll be there {1} the afternoon.', null)
) as v(n, template, hint)
where es.title = '121.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '121.1'
join (values
  (1, 0, 'on', array[]::text[]),
  (2, 0, 'in', array[]::text[]),
  (3, 0, 'at', array['on']::text[]),
  (4, 0, 'on', array[]::text[]),
  (5, 0, 'in', array[]::text[]),
  (6, 0, 'in', array[]::text[]),
  (7, 0, 'at', array[]::text[]),
  (8, 0, 'on', array[]::text[]),
  (9, 0, 'at', array[]::text[]),
  (10, 0, 'in', array[]::text[]),
  (11, 0, 'in', array[]::text[]),
  (12, 0, 'at', array[]::text[]),
  (13, 0, 'on', array[]::text[]),
  (14, 0, 'in', array[]::text[]),
  (15, 0, 'At', array[]::text[]),
  (16, 0, 'in', array[]::text[]),
  (17, 0, 'on', array[]::text[]),
  (18, 0, 'at', array[]::text[]),
  (19, 0, 'at', array[]::text[]), (19, 1, 'in', array[]::text[]),
  (20, 0, 'on', array[]::text[]), (20, 1, 'in', array[]::text[]),
  (21, 0, 'on', array[]::text[]), (21, 1, 'in', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '121.2', 'Complete the sentences. Use at, on or in + the following: the evening, about 20 minutes, 1756, the same time, the 1920s, the moment, 21 July 1969, night, Saturdays, 11 seconds.', 1
from units where slug = 'unit-121';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-121' where es.title = '121.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'If the sky is clear, you can see the stars {0}.', null),
  (2, 'After working hard during the day, I like to relax {0}.', null),
  (3, 'Neil Armstrong was the first man to walk on the moon {0}.', null),
  (4, 'It''s difficult to listen if everyone is speaking {0}.', null),
  (5, 'Jazz became popular in the United States {0}.', null),
  (6, 'I''m just going out to the shop. I''ll be back {0}.', null),
  (7, 'I don''t think we need an umbrella. It''s not raining {0}.', null),
  (8, 'Ben is a very fast runner. He can run 100 metres {0}.', null),
  (9, 'Lisa works from Monday to Friday. Sometimes she also works {0}.', null)
) as v(n, template, hint)
where es.title = '121.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '121.2'
join (values
  (1, 'at night'), (2, 'in the evening'), (3, 'on 21 July 1969'), (4, 'at the same time'),
  (5, 'in the 1920s'), (6, 'in about 20 minutes'), (7, 'at the moment'), (8, 'in 11 seconds'), (9, 'on Saturdays')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '121.3', 'Which is correct: a, b, or both of them?', 2
from units where slug = 'unit-121';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-121' where es.title = '121.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a Paul got married in April. b Paul got married April. Which is correct — a, b, or both? {0}', null),
  (2, 'a I play tennis on Sunday mornings. b I play tennis Sunday mornings. Which is correct — a, b, or both? {0}', null),
  (3, 'a We were ill at the same time. b We were ill in the same time. Which is correct — a, b, or both? {0}', null),
  (4, 'a What are you doing at the weekend? b What are you doing on the weekend? Which is correct — a, b, or both? {0}', null),
  (5, 'a Oliver was born at 10 May 1993. b Oliver was born on 10 May 1993. Which is correct — a, b, or both? {0}', null),
  (6, 'a He left school last June. b He left school in last June. Which is correct — a, b, or both? {0}', null),
  (7, 'a Will you be here on Tuesday? b Will you be here Tuesday? Which is correct — a, b, or both? {0}', null),
  (8, 'a I don''t like driving in night. b I don''t like driving at night. Which is correct — a, b, or both? {0}', null)
) as v(n, template, hint)
where es.title = '121.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '121.3'
join (values
  (1, 'a'), (2, 'both'), (3, 'a'), (4, 'both'), (5, 'b'), (6, 'a'), (7, 'both'), (8, 'b')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
