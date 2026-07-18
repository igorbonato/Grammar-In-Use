-- Marco 4 (slice 42): seeds the seventh and final slice of the
-- "Conjunctions and prepositions" module — unit 120 (by and until; by the
-- time ...).
--
-- Sourced from pdf/Modulos/Conjunctions and prepositions.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode). This completes the "Conjunctions
-- and prepositions" module: the PDF's unit headers stop at 120 (confirmed
-- via a full-file grep sweep at the start of this slice sequence) — units
-- 113-120, 8 units across seven slices (0037 two-unit, then 0038-0043 one
-- unit each per Igor's request partway through).
--
-- 120.3 ("Use your own ideas to complete these sentences. Use by or
-- until.") is skipped as open-ended — the Key labels it "Example
-- answers", same policy as every prior module.
--
-- Written in multiple smaller Write/Edit calls rather than one large
-- Write, same fallback used for units 116-119 after the content-filtering
-- errors earlier in this module.
--
-- Safe to re-run: unit 120 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 120: by and until; by the time ...
-- ============================================================

delete from units where slug = 'unit-120';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 120, 'unit-120', 'by and until by the time ...', null,
  'by = not later than (I have to be home by 5 o''clock). until (or till) says how long a situation continues (I stayed in bed until half past ten) — compare: something continues until a future time, but something happens by a future time. by the time something happens/happened describes what has already occurred, often unexpectedly, by a given point (by the time we get there, it will be closed).', 7
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'by = not later than',
  'by ... = not later than: I sent the documents today, so they should arrive by Monday. (= on or before Monday, not later than Monday) We''d better hurry. We have to be home by 5 o''clock. (= at or before 5 o''clock, not later than 5 o''clock) Where''s Sarah? She should be here by now. (= now or before now — so she should already be here) This milk has to be used by 14 August.', 0
from units where slug = 'unit-120';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'until (or till)',
  'We use until (or till) to say how long a situation continues: ''Shall we go now?'' ''No, let''s wait until it stops raining.'' or ... till it stops raining. I was very tired this morning. I stayed in bed until half past ten. I didn''t get up until half past ten. Compare until and by: something continues until a time in the future — Joe will be away until Monday. (so he''ll be back on Monday) I''ll be working until 11.30. (so I''ll stop working at 11.30) Something happens by a time in the future — Joe will be back by Monday. (= not later than Monday) I''ll have finished my work by 11.30. (= I''ll finish it not later than 11.30)', 1
from units where slug = 'unit-120';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'by the time something happens/happened',
  'You can say ''by the time something happens'': It''s too late to go to the bank now. By the time we get there, it will be closed. (= it will close between now and the time we get there) You''ll need plenty of time at the airport. By the time you check in and go through security, it will be time for your flight. Hurry up! By the time we get to the cinema, the film will already have started. You can say ''by the time something happened'' (for the past): Karen''s car broke down on the way to the party last night. By the time she arrived, most of the other guests had left. I had a lot of work to do yesterday evening. I was very tired by the time I finished. We went to the cinema last night. It took us a long time to find somewhere to park the car. By the time we got to the cinema, the film had already started. You can say by then or by that time: Karen finally got to the party at midnight, but by then most of the other guests had left. or ... but by that time, most of the other guests had left.', 2
from units where slug = 'unit-120';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-120'
join (values
  ('A', 'They should arrive by Monday.', 'on or before Monday, not later than Monday', 0),
  ('A', 'We have to be home by 5 o''clock.', null, 1),
  ('A', 'She should be here by now.', 'now or before now', 2),
  ('B', 'Let''s wait until it stops raining.', null, 0),
  ('B', 'I stayed in bed until half past ten.', null, 1),
  ('B', 'Joe will be away until Monday.', 'so he''ll be back on Monday', 2),
  ('B', 'Joe will be back by Monday.', 'not later than Monday', 3),
  ('C', 'By the time we get there, it will be closed.', null, 0),
  ('C', 'By the time we get to the cinema, the film will already have started.', null, 1),
  ('C', 'By the time she arrived, most of the other guests had left.', null, 2),
  ('C', 'I was very tired by the time I finished.', null, 3),
  ('C', 'By then most of the other guests had left.', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 120.1-120.2 and 120.4; 120.3 skipped as
-- open-ended. Each renumbered from 1, dropping the book's own worked
-- example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '120.1', 'Complete the sentences with by.', 0
from units where slug = 'unit-120';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-120' where es.title = '120.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I have to be at the airport not later than 8.30. I have to be at the airport {0}', null),
  (2, 'Let me know not later than Saturday whether you can come to the party. {0}', null),
  (3, 'Please make sure that you''re here not later than 2 o''clock. Please make sure that {0}', null),
  (4, 'If we leave now, we should arrive not later than lunchtime. If we leave now, {0}', null)
) as v(n, template, hint)
where es.title = '120.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '120.1'
join (values
  (1, 'by 8.30.'),
  (2, 'Let me know by Saturday whether you can come to the party.'),
  (3, 'you''re here by 2 o''clock.'),
  (4, 'we should arrive by lunchtime.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '120.2', 'Put in by or until.', 1
from units where slug = 'unit-120';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-120' where es.title = '120.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sorry, but I must go. I have to be home {0} 5 o''clock.', null),
  (2, 'According to the forecast, the bad weather will continue {0} the weekend.', null),
  (3, 'I don''t know whether to apply for the job or not. I have to decide {0} Friday.', null),
  (4, 'I think I''ll wait {0} Thursday before making a decision.', null),
  (5, 'I''m still waiting for Tom to call me. He should have called me {0} now.', null),
  (6, 'I need to pay this bill. It has to be paid {0} tomorrow.', null),
  (7, 'Don''t pay the bill today. Wait {0} tomorrow.', null),
  (8, 'We haven''t finished painting the house yet. We hope to finish {0} Tuesday.', null),
  (9, '''Will you still be in the office at 6.30?'' ''No, I''ll have gone home {0} then.''', null),
  (10, 'I''m moving into my new flat next week. I''m staying with a friend {0} then.', null),
  (11, 'I''ve got a lot of work to do. {0} the time I finish, it will be time to go to bed.', null),
  (12, 'We have plenty of time. The film doesn''t start {0} 8.30.', null),
  (13, 'It is hoped that the new bridge will be completed {0} the end of the year.', null)
) as v(n, template, hint)
where es.title = '120.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '120.2'
join (values
  (1, 'by'), (2, 'until'), (3, 'by'), (4, 'until'), (5, 'by'),
  (6, 'by'), (7, 'until'), (8, 'by'), (9, 'by'), (10, 'until'),
  (11, 'By'), (12, 'until'), (13, 'by')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '120.4', 'Read the situations and complete the sentences using By the time ... .', 2
from units where slug = 'unit-120';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-120' where es.title = '120.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I intended to catch a train, but it took me longer than expected to get to the station. {0}, my train had already left.', null),
  (2, 'I wanted to go shopping after work. But I finished work much later than expected. {0}, it was too late to go shopping.', null),
  (3, 'I saw two men who looked as if they were trying to steal a car. I called the police, but it was some time before they arrived. {0}, the two men had disappeared.', null),
  (4, 'We climbed a mountain and it took us a long time to get to the top. There wasn''t much time to enjoy the view. {0}, we had to come down again.', null)
) as v(n, template, hint)
where es.title = '120.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '120.4'
join (values
  (1, 'By the time I got to the station', array[]::text[]),
  (2, 'By the time I finished work', array['By the time I finished']::text[]),
  (3, 'By the time the police arrived', array[]::text[]),
  (4, 'By the time we got to the top', array['By the time we got to the top of the mountain']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
