-- Marco 4 (slice 49): seeds the seventh slice of the "Prepositions"
-- module — unit 127 (in/on/at other uses).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Safe to re-run: unit 127 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 127: in/on/at (other uses)
-- ============================================================

delete from units where slug = 'unit-127';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 127, 'unit-127', 'in/on/at (other uses)', null,
  'in the rain/sun/dark, in a language, in love, in a mood, in my opinion. on TV/the radio/the phone, on fire, on purpose, on the whole. on holiday, on a trip/tour/cruise, on business, on strike, on a diet. at the age of ..., at a speed/temperature of ... (at 100 degrees).', 6
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'in the rain, in love, in my opinion',
  'in the rain / in the sun / in the shade / in the dark / in bad weather etc.: We sat in the shade. It was too hot to sit in the sun. Don''t go out in the rain. Wait until it stops. in a language / in a currency etc.: How do you say ''thank you'' in Russian? How much is a hundred pounds in dollars? (be/fall) in love (with somebody): They''re very happy together. They''re in love. in a (good/bad) mood: You seem to be in a bad mood. What''s the matter? in (my) opinion: In my opinion the movie wasn''t very good.', 0
from units where slug = 'unit-127';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'on TV, on fire, on purpose',
  'on TV / on television, on the radio, on the phone, on fire, on purpose (= intentionally), on the whole (= in general). I didn''t see the news on TV. I heard the weather forecast on the radio. I''ve never met her, but I''ve spoken to her on the phone. Look! That car is on fire. I''m sorry. I didn''t mean to hurt you. I didn''t do it on purpose. Sometimes I have problems at work, but on the whole I enjoy my job.', 1
from units where slug = 'unit-127';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'on holiday, on business, on strike',
  '(be/go) on holiday / on vacation; (be/go) on a trip / on a tour / on a cruise etc.; (be/go to a place) on business; (be/go) on strike; (be/go) on a diet. I''m going on holiday next week. One day I''d like to go on a world tour. Emma''s away on business at the moment. There are no trains today. The drivers are on strike. I''ve put on weight. I''ll have to go on a diet. We also say ''go somewhere for a holiday'': Steve has gone to France for a holiday.', 2
from units where slug = 'unit-127';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'at the age of ..., at a speed of ...',
  'at the age of 16 / at 90 miles an hour / at 100 degrees etc.: Tracy left school at 16. or Tracy left school at the age of 16. The train was travelling at 120 miles an hour. Water boils at 100 degrees Celsius. We are now flying at a speed of 800 kilometres an hour and at an altitude of 9,000 metres.', 3
from units where slug = 'unit-127';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-127'
join (values
  ('A', 'We sat in the shade. It was too hot to sit in the sun.', null, 0),
  ('A', 'How do you say ''thank you'' in Russian?', null, 1),
  ('A', 'They''re very happy together. They''re in love.', null, 2),
  ('A', 'You seem to be in a bad mood. What''s the matter?', null, 3),
  ('A', 'In my opinion the movie wasn''t very good.', null, 4),
  ('B', 'I didn''t see the news on TV.', null, 0),
  ('B', 'Look! That car is on fire.', null, 1),
  ('B', 'I didn''t do it on purpose.', null, 2),
  ('B', 'On the whole I enjoy my job.', null, 3),
  ('C', 'I''m going on holiday next week.', null, 0),
  ('C', 'Emma''s away on business at the moment.', null, 1),
  ('C', 'The drivers are on strike.', null, 2),
  ('C', 'I''ll have to go on a diet.', null, 3),
  ('D', 'Tracy left school at 16. or Tracy left school at the age of 16.', null, 0),
  ('D', 'The train was travelling at 120 miles an hour.', null, 1),
  ('D', 'Water boils at 100 degrees Celsius.', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 127.1-127.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '127.1', 'Complete the sentences using in + the following: the mood, cold weather, love, my opinion, French, kilometres, the shade.', 0
from units where slug = 'unit-127';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-127' where es.title = '127.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Matt likes to keep warm, so he doesn''t go out much {0}.', null),
  (2, 'The movie was {0} with English subtitles.', null),
  (3, 'They fell {0} almost immediately and were married in a few weeks.', null),
  (4, 'I don''t feel like going to a party tonight. I''m not {0}.', null),
  (5, 'It''s too hot here. I''m going to sit {0} under that tree.', null),
  (6, 'Amanda thought the restaurant was OK, but {0} it wasn''t very good.', null),
  (7, 'Fifty miles? What''s that {0}?', null)
) as v(n, template, hint)
where es.title = '127.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '127.1'
join (values
  (1, 'in cold weather'), (2, 'in French'), (3, 'in love'), (4, 'in the mood'),
  (5, 'in the shade'), (6, 'in my opinion'), (7, 'in kilometres')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '127.2', 'Complete the sentences using on + the following: business, a cruise, a diet, fire, holiday, her phone, purpose, strike, TV, a tour, the whole.', 1
from units where slug = 'unit-127';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-127' where es.title = '127.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Workers at the company have gone {0} for better pay and conditions.', null),
  (2, 'Don''t go {0} if you don''t like being at sea.', null),
  (3, 'There was panic when people realised that the building was {0}.', null),
  (4, 'Soon after we arrived, we were taken {0} of the city.', null),
  (5, 'Emma has lots of useful apps {0}.', null),
  (6, 'I feel lazy this evening. Is there anything worth watching {0}?', null),
  (7, 'I''m sorry. It was an accident. I didn''t do it {0}.', null),
  (8, 'If you are {0}, there are certain things you''re not allowed to eat.', null),
  (9, 'We''ll be {0} from Friday. We''re going to the mountains.', null),
  (10, 'Jane''s job involves a lot of travelling. She often has to go away {0}.', null),
  (11, 'Some of the exam questions were hard, but {0} it was OK.', null)
) as v(n, template, hint)
where es.title = '127.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '127.2'
join (values
  (1, 'on strike'), (2, 'on a cruise'), (3, 'on fire'), (4, 'on a tour'), (5, 'on her phone'),
  (6, 'on TV'), (7, 'on purpose'), (8, 'on a diet'), (9, 'on holiday'), (10, 'on business'), (11, 'on the whole')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '127.3', 'Complete the sentences with in, on or at.', 2
from units where slug = 'unit-127';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-127' where es.title = '127.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When I was 14, I went {0} a trip to France organised by my school.', null),
  (2, 'Julia''s grandmother died recently {0} the age of 90.', null),
  (3, 'Can you turn the light on, please? I don''t want to sit {0} the dark.', null),
  (4, 'We didn''t go {0} holiday last year. We stayed at home.', null),
  (5, 'I hate driving {0} fog. You can''t see anything.', null),
  (6, 'Technology has developed {0} great speed.', null),
  (7, 'David got married {0} 19, which is rather young to get married.', null),
  (8, 'I listened to an interesting programme {0} the radio this morning.', null),
  (9, 'I wouldn''t like to go {0} a cruise. I think I''d get bored.', null),
  (10, 'The earth travels round the sun {0} 107,000 kilometres an hour.', null),
  (11, 'I shouldn''t eat too much. I''m supposed to be {0} a diet.', null),
  (12, 'A lot of houses were damaged {0} the storm last week.', null),
  (13, 'I won''t be here next week. I''ll be {0} holiday.', null),
  (14, 'I wouldn''t like his job. He spends most of his time talking {0} the phone.', null),
  (15, '''Did you enjoy your holiday?'' ''Not every minute, but {0} the whole, yes.''', null),
  (16, '{0} your opinion, what should I do?', null),
  (17, 'Ben is a happy sort of person. He always seems to be {0} a good mood.', null),
  (18, 'I don''t think violent films should be shown {0} TV.', null),
  (19, 'The museum guidebook is available {0} several languages.', null)
) as v(n, template, hint)
where es.title = '127.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '127.3'
join (values
  (1, 'on'), (2, 'at'), (3, 'in'), (4, 'on'), (5, 'in'), (6, 'at'), (7, 'at'),
  (8, 'on'), (9, 'on'), (10, 'at'), (11, 'on'), (12, 'in'), (13, 'on'), (14, 'on'),
  (15, 'on'), (16, 'In'), (17, 'in'), (18, 'on'), (19, 'in')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
