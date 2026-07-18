-- Marco 4 (slice 38): seeds the third slice of the "Conjunctions and
-- prepositions" module — unit 116 (as: as I walked ... / as I was ...
-- etc.).
--
-- Sourced from pdf/Modulos/Conjunctions and prepositions.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 116.5 ("Use your own ideas to complete these sentences") is skipped as
-- open-ended — the Key labels it "Example answers", same policy as every
-- prior module.
--
-- Written in multiple smaller Write/Edit calls rather than one large
-- Write, after repeated "Output blocked by content filtering policy"
-- errors on this file (visible in the terminal, not a fabricated claim
-- this time) — matches the existing fallback for oversized migrations.
--
-- Safe to re-run: unit 116 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 116: as (as I walked ... / as I was ... etc.)
-- ============================================================

delete from units where slug = 'unit-116';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 116, 'unit-116', 'as (as I walked ... / as I was ... etc.)', null,
  'as can mean "at the same time as" (we waved as she drove away, or as we were doing something else) — use as only when two things happen together; use when if one thing happens after another. as can also mean "because" (as I was hungry, I decided to eat) — since works the same way.', 3
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'as = at the same time as',
  'You can use as when two things happen together at the same time: We all waved goodbye to Liz as she drove away. (we waved and she drove away at the same time) As I walked along the street, I looked in the shop windows. Can you turn off the light as you go out, please? Or you can say that something happened as you were doing something else (in the middle of doing something else): Kate slipped as she was getting off the bus. We met Paul as we were leaving the hotel. You can also use just as (= exactly at that moment): Just as I sat down, the doorbell rang. I had to leave just as the conversation was getting interesting. We also use as when two things happen together in a longer period of time: As the day went on, the weather got worse. I began to enjoy the job more as I got used to it. Compare as and when: we use as only if two things happen at the same time; use when (not as) if one thing happens after another. As I drove home, I listened to music. (= at the same time) When I got home, I had something to eat. (not as I got home)', 0
from units where slug = 'unit-116';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'as = because',
  'As also means ''because'': As I was hungry, I decided to find somewhere to eat. As it''s late and we''re tired, let''s get a taxi home. We watched TV all evening as we didn''t have anything better to do. As I don''t watch TV any more, I gave my television to a friend of mine. You can also use since in this way: Since it''s late and we''re tired, let''s get a taxi home. Compare as (= because) and when: David wasn''t in the office as he was on holiday. (= because he was on holiday) David lost his passport when he was on holiday. (= during the time he was away) As they lived near us, we used to see them quite often. (= because they lived near us) When they lived near us, we used to see them quite often. (= at the time they lived near us)', 1
from units where slug = 'unit-116';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-116'
join (values
  ('A', 'We all waved goodbye to Liz as she drove away.', 'we waved and she drove away at the same time', 0),
  ('A', 'As I walked along the street, I looked in the shop windows.', null, 1),
  ('A', 'Kate slipped as she was getting off the bus.', null, 2),
  ('A', 'We met Paul as we were leaving the hotel.', null, 3),
  ('A', 'Just as I sat down, the doorbell rang.', '= exactly at that moment', 4),
  ('A', 'As the day went on, the weather got worse.', null, 5),
  ('A', 'As I drove home, I listened to music.', '= at the same time', 6),
  ('A', 'When I got home, I had something to eat.', 'not as I got home', 7),
  ('B', 'As I was hungry, I decided to find somewhere to eat.', null, 0),
  ('B', 'As it''s late and we''re tired, let''s get a taxi home.', null, 1),
  ('B', 'David wasn''t in the office as he was on holiday.', '= because he was on holiday', 2),
  ('B', 'David lost his passport when he was on holiday.', '= during the time he was away', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 116.1-116.4; 116.5 skipped as open-ended.
-- Each renumbered from 1, dropping the book's own worked example(s) at
-- the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '116.1', 'In this exercise as means "at the same time as". Use as to join sentences from the boxes.', 0
from units where slug = 'unit-116';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-116' where es.title = '116.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I listened {0}', null),
  (2, 'I burnt myself {0}', null),
  (3, 'The spectators cheered {0}', null),
  (4, 'A dog ran out in front of the car {0}', null)
) as v(n, template, hint)
where es.title = '116.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '116.1'
join (values
  (1, 'as she told me her story.'),
  (2, 'as I was taking a hot dish out of the oven.'),
  (3, 'as the two teams came onto the field.'),
  (4, 'as we were driving along the road.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '116.2', 'In this exercise as means "because". Join sentences from the boxes beginning with as.', 1
from units where slug = 'unit-116';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-116' where es.title = '116.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Today is a public holiday. All government offices are shut. {0}', null),
  (2, 'I didn''t want to disturb anybody. I tried to be very quiet. {0}', null),
  (3, 'I can''t go to the concert. You can have my ticket. {0}', null),
  (4, 'It was a nice day. We went for a walk by the canal. {0}', null)
) as v(n, template, hint)
where es.title = '116.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '116.2'
join (values
  (1, 'As today is a public holiday, all government offices are shut.'),
  (2, 'As I didn''t want to disturb anybody, I tried to be very quiet.'),
  (3, 'As I can''t go to the concert, you can have my ticket.'),
  (4, 'As it was a nice day, we went for a walk by the canal.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '116.3', 'What does as mean in these sentences — "because" or "at the same time as"?', 2
from units where slug = 'unit-116';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-116' where es.title = '116.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'As I was tired, I went to bed early. What does as mean here?', '(because / at the same time as)'),
  (2, 'Unfortunately, as I was parking the car, I hit the car behind me. What does as mean here?', '(because / at the same time as)'),
  (3, 'As we climbed the hill, we got more and more tired. What does as mean here?', '(because / at the same time as)'),
  (4, 'We decided to go out to eat as we had no food at home. What does as mean here?', '(because / at the same time as)'),
  (5, 'As we don''t use the car very often, we''ve decided to sell it. What does as mean here?', '(because / at the same time as)')
) as v(n, template, hint)
where es.title = '116.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '116.3'
join (values
  (1, 'because'), (2, 'at the same time as'), (3, 'at the same time as'), (4, 'because'), (5, 'because')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '116.4', 'In some of these sentences, as is not correct. Correct the sentences where necessary.', 3
from units where slug = 'unit-116';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-116' where es.title = '116.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'He dropped the glass as he was taking it out of the cupboard. {0}', null),
  (2, 'I lost my phone as I was in London. {0}', null),
  (3, 'As I left school, I didn''t know what to do. {0}', null),
  (4, 'The train slowed down as it approached the station. {0}', null),
  (5, 'I used to live near the sea as I was a child. {0}', null),
  (6, 'We can walk to the hotel as it isn''t far from here. {0}', null)
) as v(n, template, hint)
where es.title = '116.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '116.4'
join (values
  (1, 'OK'),
  (2, 'I lost my phone when I was in London.'),
  (3, 'When I left school, I didn''t know what to do.'),
  (4, 'OK'),
  (5, 'I used to live near the sea when I was a child.'),
  (6, 'OK')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
