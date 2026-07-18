-- Marco 4 (slice 41): seeds the sixth slice of the "Conjunctions and
-- prepositions" module — unit 119 (during, for and while).
--
-- Sourced from pdf/Modulos/Conjunctions and prepositions.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 119.3 is the only exercise in this unit with no pre-filled worked
-- example — the Key gives answers for all ten items, confirmed by the
-- raw extraction showing item 1 as a genuine blank, not a filled example.
--
-- 119.4 ("Use your own ideas to complete these sentences") is skipped as
-- open-ended — the Key labels it "Example answers", same policy as every
-- prior module.
--
-- Written in multiple smaller Write/Edit calls rather than one large
-- Write, same fallback used for units 116-118 after the content-filtering
-- errors earlier in this module.
--
-- Safe to re-run: unit 119 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 119: during, for and while
-- ============================================================

delete from units where slug = 'unit-119';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 119, 'unit-119', 'during, for and while', null,
  'during (+ noun) says WHEN something happens, at a time between the start and end of something (I fell asleep during the movie). for (+ a period of time) says HOW LONG something goes on (we watched TV for two hours) — we never say "during two hours". while (+ subject + verb) works like during but introduces a clause instead of a noun (I fell asleep while I was watching TV). Talking about the future, use a present tense after while, not will.', 6
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'during',
  'during = at a time between the start and end of something: I fell asleep during the movie. (= at a time between the start and end of the movie) We met some really nice people during our holiday. The ground is wet. It must have rained during the night. With ''time words'' (the morning, the night, the summer etc.), you can usually say in or during: It rained in the night. or ... during the night. It''s lovely here during the summer. or ... in the summer.', 0
from units where slug = 'unit-119';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'for and during',
  'We use for (+ a period of time) to say how long something goes on: We watched TV for two hours last night. Jess is going away for a week in September. How are you? I haven''t seen you for ages. Are you going away for the weekend? We do not use during to say how long something goes on. We do not say ''during two hours'', ''during five years'' etc.: It rained for three days without stopping. (not during three days) We use during to say when something happens (not how long). Compare during and for: ''When did you fall asleep?'' ''During the movie.'' ''How long were you asleep?'' ''For half an hour.''', 1
from units where slug = 'unit-119';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'during vs. while',
  'Compare: We use during + noun: I fell asleep during the movie. We met a lot of interesting people during our holiday. Robert suddenly began to feel ill during the exam. We use while + subject + verb: I fell asleep while I was watching TV. We met a lot of interesting people while we were on holiday. Robert suddenly began to feel ill while he was doing the exam. Some more examples of while: We saw Clare while we were waiting for the bus. While you were out, there was a phone call for you. Alex read a book while Amy watched TV. When we are talking about the future, we use the present after while. Do not use ''will'' (see Unit 25): I''m going to Moscow next week. I hope the weather will be good while I''m there. (not while I will be) What are you going to do while you''re waiting? (not while you''ll be waiting)', 2
from units where slug = 'unit-119';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-119'
join (values
  ('A', 'I fell asleep during the movie.', 'at a time between the start and end of the movie', 0),
  ('A', 'We met some really nice people during our holiday.', null, 1),
  ('A', 'The ground is wet. It must have rained during the night.', null, 2),
  ('B', 'We watched TV for two hours last night.', null, 0),
  ('B', 'How are you? I haven''t seen you for ages.', null, 1),
  ('B', 'It rained for three days without stopping.', 'not during three days', 2),
  ('B', '''When did you fall asleep?'' ''During the movie.''', null, 3),
  ('B', '''How long were you asleep?'' ''For half an hour.''', null, 4),
  ('C', 'I fell asleep while I was watching TV.', null, 0),
  ('C', 'We met a lot of interesting people while we were on holiday.', null, 1),
  ('C', 'Robert suddenly began to feel ill during the exam.', null, 2),
  ('C', 'Alex read a book while Amy watched TV.', null, 3),
  ('C', 'What are you going to do while you''re waiting?', 'not while you''ll be waiting', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 119.1-119.3; 119.4 skipped as open-ended.
-- Each renumbered from 1, dropping the book's own worked example(s) at
-- the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '119.1', 'Put in for or during.', 0
from units where slug = 'unit-119';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-119' where es.title = '119.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I went to the theatre last night. I met Sue {0} the interval.', null),
  (2, 'I felt really ill last week. I could hardly eat anything {0} three days.', null),
  (3, 'The traffic was bad. We were stuck in a traffic jam {0} two hours.', null),
  (4, 'Production at the factory was seriously affected {0} the strike.', null),
  (5, 'Sarah was very angry with me. She didn''t speak to me {0} a week.', null),
  (6, 'I don''t have much free time {0} the week, but I relax at weekends.', null),
  (7, 'I need a break. I think I''ll go away {0} a few days.', null),
  (8, 'The president gave a short speech. She spoke {0} only ten minutes.', null),
  (9, 'We were hungry when we arrived. We hadn''t eaten anything {0} the journey.', null),
  (10, 'We were hungry when we arrived. We hadn''t eaten anything {0} eight hours.', null)
) as v(n, template, hint)
where es.title = '119.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '119.1'
join (values
  (1, 'during'), (2, 'for'), (3, 'for'), (4, 'during'), (5, 'for'),
  (6, 'during'), (7, 'for'), (8, 'for'), (9, 'during'), (10, 'for')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '119.2', 'Put in during or while.', 1
from units where slug = 'unit-119';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-119' where es.title = '119.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I met Mike {0} I was shopping.', null),
  (2, '{0} I was on holiday, I didn''t use my phone at all.', null),
  (3, 'I learnt a lot {0} the course. The teachers were very good.', null),
  (4, 'There was a lot of noise {0} the night. What was it?', null),
  (5, 'I''d been away for many years. Many things had changed {0} that time.', null),
  (6, 'What did they say about me {0} I was out of the room?', null),
  (7, 'When I fly anywhere, I never eat anything {0} the flight.', null),
  (8, 'Please don''t interrupt me {0} I''m speaking.', null),
  (9, '{0} the festival, it''s almost impossible to find a hotel room here.', null),
  (10, 'We were hungry when we arrived. We hadn''t eaten anything {0} we were travelling.', null)
) as v(n, template, hint)
where es.title = '119.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '119.2'
join (values
  (1, 'while', array[]::text[]),
  (2, 'While', array[]::text[]),
  (3, 'during', array[]::text[]),
  (4, 'during', array['in']::text[]),
  (5, 'during', array['in']::text[]),
  (6, 'while', array[]::text[]),
  (7, 'during', array[]::text[]),
  (8, 'while', array[]::text[]),
  (9, 'During', array[]::text[]),
  (10, 'while', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '119.3', 'Put in during, for or while.', 2
from units where slug = 'unit-119';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-119' where es.title = '119.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I used to live in Berlin. I lived there {0} five years.', null),
  (2, 'One of the runners fell {0} the race but managed to get up and continue.', null),
  (3, 'Nobody came to see me {0} I was in hospital.', null),
  (4, 'Try to avoid travelling {0} the busy periods of the day.', null),
  (5, 'I was very tired. I slept {0} ten hours.', null),
  (6, 'Can you hold my bag {0} I try on this jacket?', null),
  (7, 'I''m not sure when we''ll arrive, but it will be sometime {0} the afternoon.', null),
  (8, 'I wasn''t well last week. I hardly ate anything {0} three days.', null),
  (9, 'My phone rang {0} we were having dinner.', null),
  (10, 'Nobody knows how many people were killed {0} the war.', null)
) as v(n, template, hint)
where es.title = '119.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '119.3'
join (values
  (1, 'for', array[]::text[]),
  (2, 'during', array[]::text[]),
  (3, 'while', array[]::text[]),
  (4, 'during', array['in']::text[]),
  (5, 'for', array[]::text[]),
  (6, 'while', array[]::text[]),
  (7, 'during', array['in']::text[]),
  (8, 'for', array[]::text[]),
  (9, 'while', array[]::text[]),
  (10, 'during', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
