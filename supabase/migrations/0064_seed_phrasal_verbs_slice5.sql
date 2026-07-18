-- Marco 4 (slice 63): seeds the fifth slice of the "Phrasal verbs"
-- module — unit 141 (Phrasal verbs 5: on/off (2)).
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 141.1 ("What do these sentences mean? a/b/c") is adapted to the
-- same "which is correct" short-answer format used for unit 121.3 —
-- the blank's correct answer is literally "a", "b" or "c", matching
-- the book's own three-way multiple choice.
--
-- Safe to re-run: unit 141 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 141: Phrasal verbs 5 on/off (2)
-- ============================================================

delete from units where slug = 'unit-141';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 141, 'unit-141', 'Phrasal verbs 5 on/off (2)', null,
  'verb + on = continue doing something: go on = continue; go on / carry on doing something = continue doing it; go on with / carry on with something = continue it; keep on doing (or keep doing) something = do it continuously or repeatedly; drive on / walk on / play on = continue driving/walking/playing etc. get on = progress; get on (with somebody) = have a good relationship; get on with something = continue something you have to do, usually after an interruption. verb + off: doze off / drop off / nod off = fall asleep; finish something off = do the last part of it; go off = make an alarm sound; put somebody off (doing) something = make them not want it/to do it any more; rip somebody off / be ripped off = cheat/be cheated; show off = try to impress people; tell somebody off = speak angrily to somebody because they did something wrong.', 4
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verb + on = continue doing something',
  'go on = continue. go on / carry on doing something = continue doing it. go on with / carry on with something = continue it. keep on doing (or keep doing) something = do it continuously or repeatedly. drive on / walk on / play on = continue driving/walking/playing etc.', 0
from units where slug = 'unit-141';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'get on',
  'get on = progress. get on (with somebody) = have a good relationship. get on with something = continue something you have to do, usually after an interruption.', 1
from units where slug = 'unit-141';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'verb + off',
  'doze off / drop off / nod off = fall asleep. finish something off = do the last part of it. go off = make an alarm sound. put somebody off (doing) something so that they don''t want it or want to do it any more. rip somebody off / be ripped off = cheat somebody / be cheated. show off = try to impress people with your ability, your knowledge etc. tell somebody off = speak angrily to somebody because they did something wrong.', 2
from units where slug = 'unit-141';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-141'
join (values
  ('A', 'The party went on until 4 o''clock in the morning.', null, 0),
  ('A', 'We can''t go on spending money like this. We''ll have nothing left soon.', null, 1),
  ('A', 'I don''t want to carry on working here. I''m going to look for another job.', null, 2),
  ('A', 'Don''t let me disturb you. Please carry on with what you''re doing.', null, 3),
  ('A', 'He keeps on criticising me. It''s not fair!', 'or He keeps criticising me', 4),
  ('A', 'Shall we stop at this petrol station or shall we drive on to the next one?', null, 5),
  ('B', 'How are you getting on in your new job?', '= How is it going?', 0),
  ('B', 'Joanne and Karen don''t get on. They''re always arguing.', null, 1),
  ('B', 'Richard gets on well with his neighbours. They''re all very friendly.', null, 2),
  ('B', 'I must get on with my work. I have a lot to do.', null, 3),
  ('C', 'I dozed off during the lecture. It was very boring.', null, 0),
  ('C', '''Have you finished painting the kitchen?'' ''Nearly. I''ll finish it off tomorrow.''', null, 1),
  ('C', 'Did you hear the alarm go off?', null, 2),
  ('C', 'We wanted to go to the exhibition, but we were put off by the long queue.', '= we didn''t go because of the long queue', 3),
  ('C', 'What put you off applying for the job? Was the salary too low?', null, 4),
  ('C', 'Did you really pay 2,000 for that painting? I think you were ripped off.', '= you paid too much', 5),
  ('C', 'Look at that boy on the bike riding with no hands. He''s just showing off.', null, 6),
  ('C', 'Clare''s mother told her off for wearing dirty shoes in the house.', null, 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 141.1-141.3; each renumbered from 1,
-- dropping the book's own worked example)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '141.1', 'What do these sentences mean? Choose the correct meaning — a, b or c.', 0
from units where slug = 'unit-141';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-141' where es.title = '141.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I nodded off. a I agreed. b I felt sick. c I fell asleep. Which is correct — a, b, or c? {0}', null),
  (2, 'We were ripped off. a We were attacked. b We paid too much. c Our clothes were torn. Which is correct — a, b, or c? {0}', null),
  (3, 'I told them off. a I criticised them. b I was satisfied with them. c I told them to go away. Which is correct — a, b, or c? {0}', null),
  (4, 'They don''t get on. a They don''t like each other much. b They are lazy. c They don''t know each other. Which is correct — a, b, or c? {0}', null),
  (5, 'He was showing off. a He was joking. b He was trying to impress us. c He wasn''t telling the truth. Which is correct — a, b, or c? {0}', null)
) as v(n, template, hint)
where es.title = '141.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '141.1'
join (values
  (1, 'c'), (2, 'b'), (3, 'a'), (4, 'a'), (5, 'b')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '141.2', 'Complete each sentence using a verb + on or off.', 1
from units where slug = 'unit-141';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-141' where es.title = '141.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m not ready to go home yet. I have a few things to {0}.', null),
  (2, '''Shall I stop the car here?'' ''No, {0} a bit further.''', null),
  (3, 'Dan paid too much for the car he bought. I think he was {0}.', null),
  (4, 'Emma is enjoying her course at university. She''s {0} very well.', null),
  (5, 'The fire alarm {0} and everybody had to leave the building.', null),
  (6, 'Ben was {0} by his boss for being late for work repeatedly.', null),
  (7, 'The meeting has only just finished. It {0} longer than expected.', null),
  (8, 'I really like working with my colleagues. We all {0} really well together.', null),
  (9, 'I {0} making the same mistake. It''s very frustrating.', null),
  (10, 'I''ve just had a coffee break, and now I must {0} with my work.', null),
  (11, 'Peter likes people to know how clever he is. He''s always {0}.', null),
  (12, 'We decided not to go to the concert. We were {0} by the cost of tickets.', null),
  (13, 'Jack paused for a moment and then {0} with his story.', null),
  (14, 'I was so tired at work today. I nearly {0} at my desk a couple of times.', null)
) as v(n, template, hint)
where es.title = '141.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '141.2'
join (values
  (1, 'finish off', array[]::text[]),
  (2, 'drive on', array['carry on', 'go on']::text[]),
  (3, 'ripped off', array[]::text[]),
  (4, 'getting on', array[]::text[]),
  (5, 'went off', array[]::text[]),
  (6, 'told off', array[]::text[]),
  (7, 'went on', array[]::text[]),
  (8, 'get on', array[]::text[]),
  (9, 'keep on', array['keep']::text[]),
  (10, 'get on', array['carry on']::text[]),
  (11, 'showing off', array[]::text[]),
  (12, 'put off', array[]::text[]),
  (13, 'went on', array['carried on']::text[]),
  (14, 'dozed off', array['dropped off', 'nodded off']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '141.3', 'Complete the sentences. Use a verb (in the correct form) + on or off. Sometimes you will need other words as well. Choose from: carry, finish, get, get, go, keep, rip, tell.', 2
from units where slug = 'unit-141';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-141' where es.title = '141.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A: What''s Tanya like? B: She''s very nice and easy-going. She {0} everybody.', null),
  (2, 'A: Is Gary going to retire soon? B: No, he likes his job and wants to {0} working.', null),
  (3, 'A: Have you written the letter you had to write? B: I''ve started it. I''ll {0} tomorrow.', null),
  (4, 'A: We took a taxi to the airport. It cost £40. B: £40! Normally it costs about £20. You {0}.', null),
  (5, 'A: Why were you late for work this morning? B: I overslept. My alarm clock didn''t {0}.', null),
  (6, 'A: Some children at the next table in the restaurant were behaving very badly. B: Why didn''t their parents {0}?', null),
  (7, 'A: Is Kate good at making decisions? B: No, she isn''t. She {0} changing her mind.', null)
) as v(n, template, hint)
where es.title = '141.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '141.3'
join (values
  (1, 'gets on with', array[]::text[]),
  (2, 'carry on', array['go on', 'keep on', 'keep']::text[]),
  (3, 'finish it off', array[]::text[]),
  (4, 'were ripped off', array[]::text[]),
  (5, 'go off', array[]::text[]),
  (6, 'tell them off', array[]::text[]),
  (7, 'keeps on', array['keeps']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
