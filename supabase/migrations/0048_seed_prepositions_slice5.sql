-- Marco 4 (slice 47): seeds the fifth slice of the "Prepositions" module
-- — unit 125 (in/at/on position 3).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 125.1 is picture-based, same shape as 123.1/124.1 — a theory_images
-- placeholder plus each scene rebuilt from its picture caption.
--
-- Safe to re-run: unit 125 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 125: in/at/on (position) 3
-- ============================================================

delete from units where slug = 'unit-125';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 125, 'unit-125', 'in/at/on (position) 3', null,
  'in bed/hospital/prison, but at home/work/school/university. at an event (at a party, at a conference). Buildings often take either in or at, but at for where an event takes place (at the concert hall) and in when thinking of the building itself (all the rooms in the hotel). Towns/cities normally take in (in Paris), but at when thought of as a point on a journey (the train stops at Oxford). on a bus/train/plane/ship/bike, but in a car/taxi.', 4
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'in hospital / at work etc.',
  'We say that somebody is in bed / in hospital / in prison: James isn''t up yet. He''s still in bed. Anna''s mother is in hospital. We say that somebody is at home / at work / at school / at university / at college: I''ll be at work until 5.30. My sister is at university. My brother is still at school. We say be at home or be home (with or without at), but do something at home (with at): I''ll be home all evening. or I''ll be at home all evening. Shall we go to a restaurant or eat at home?', 0
from units where slug = 'unit-125';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'at a party / at a concert etc.',
  'We say that somebody is at an event (at a party, at a conference etc.): Were there many people at the party / at the meeting / at the wedding? I saw Steve at a conference / at a concert on Saturday.', 1
from units where slug = 'unit-125';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'in and at for buildings',
  'You can often use in or at with buildings. For example, you can eat in a restaurant or at a restaurant; you can buy food in a supermarket or at a supermarket. We usually say at when we say where an event takes place (a concert, a party, a meeting etc.): We went to a concert at the National Concert Hall. The meeting took place at the company''s head office in Frankfurt. There was a robbery at the supermarket. We say at somebody''s house: I was at Helen''s house last night. or I was at Helen''s last night. In the same way we say at the doctor''s, at the hairdresser''s etc. We use in when we are thinking about the building itself. Compare at and in: I was at Helen''s (house) last night. It''s always cold in Helen''s house. The heating doesn''t work well. (not at Helen''s house) We had dinner at the hotel. All the rooms in the hotel have air conditioning. (not at the hotel) We say at the station / at the airport: There''s no need to meet me at the station. I can get a taxi.', 2
from units where slug = 'unit-125';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'in and at for towns etc.',
  'We normally use in with cities, towns and villages: The Louvre is a famous art museum in Paris. (not at Paris) Sam''s parents live in a village in the south of France. (not at a village) We use at when we think of the place as a point or station on a journey: Does this train stop at Oxford? (= at Oxford station)', 3
from units where slug = 'unit-125';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'on a bus / in a car etc.',
  'We usually say on a bus / on a train / on a plane / on a ship but in a car / in a taxi: The bus was very full. There were too many people on it. Laura arrived in a taxi. We say on a bike (= bicycle) / on a motorbike / on a horse: Jane passed me on her bike.', 4
from units where slug = 'unit-125';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-125'
join (values
  ('A', 'James isn''t up yet. He''s still in bed.', null, 0),
  ('A', 'Anna''s mother is in hospital.', null, 1),
  ('A', 'I''ll be at work until 5.30.', null, 2),
  ('A', 'My sister is at university.', null, 3),
  ('B', 'Were there many people at the party?', null, 0),
  ('B', 'I saw Steve at a conference on Saturday.', null, 1),
  ('C', 'We went to a concert at the National Concert Hall.', null, 0),
  ('C', 'I was at Helen''s house last night.', null, 1),
  ('C', 'It''s always cold in Helen''s house.', 'not at Helen''s house', 2),
  ('C', 'There''s no need to meet me at the station.', null, 3),
  ('D', 'The Louvre is a famous art museum in Paris.', 'not at Paris', 0),
  ('D', 'Does this train stop at Oxford?', '= at Oxford station', 1),
  ('E', 'The bus was very full. There were too many people on it.', null, 0),
  ('E', 'Laura arrived in a taxi.', null, 1),
  ('E', 'Jane passed me on her bike.', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 125.1-125.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: eight small pictures used in exercise 125.1 — a car hire desk at the airport, Dave on a train, Karen at a conference, Martin in a hospital bed, Judy at the hairdresser''s, Gary on his bike, a New York skyline, the Savoy Theatre]', 0
from units where slug = 'unit-125';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '125.1', 'Complete the sentences about the pictures. Use in, at or on with the words below the pictures.', 0
from units where slug = 'unit-125';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-125' where es.title = '125.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Picture: Dave, travelling on a train. Dave is {0}', null),
  (2, 'Picture: Karen, at a conference. Karen is {0}', null),
  (3, 'Picture: Martin, in a hospital bed. Martin {0}', null),
  (4, 'Picture: Judy, at the hairdresser''s. Judy is {0}', null),
  (5, 'Picture: Gary, riding his bike. I saw Gary {0}', null),
  (6, 'Picture: the New York skyline. We spent a few days {0}', null),
  (7, 'Picture: the Savoy Theatre. We went to a show {0}', null)
) as v(n, template, hint)
where es.title = '125.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '125.1'
join (values
  (1, 'on a train', array[]::text[]),
  (2, 'at a conference', array[]::text[]),
  (3, 'is in hospital', array['is in the hospital']::text[]),
  (4, 'at the hairdresser''s', array[]::text[]),
  (5, 'on his bike', array[]::text[]),
  (6, 'in New York', array[]::text[]),
  (7, 'at the Savoy Theatre', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '125.2', 'Complete the sentences. Use in, at or on + the following: the plane, the station, a taxi, the art gallery, Tokyo, school, prison, the sports centre.', 1
from units where slug = 'unit-125';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-125' where es.title = '125.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We can get coffee {0} while we''re waiting for our train.', null),
  (2, 'We walked to the restaurant, but we went home {0}.', null),
  (3, 'I play basketball {0} on Friday evenings.', null),
  (4, 'I enjoyed the flight, but the food {0} was awful.', null),
  (5, 'Vicky has gone to Japan. She''s living {0}.', null),
  (6, '''Does your sister have a job?'' ''No, she''s only 16. She''s still {0}.''', null),
  (7, 'There''s a new exhibition of paintings {0}. Let''s go and see it.', null)
) as v(n, template, hint)
where es.title = '125.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '125.2'
join (values
  (1, 'at the station'), (2, 'in a taxi'), (3, 'at the sports centre'), (4, 'on the plane'),
  (5, 'in Tokyo'), (6, 'at school'), (7, 'at the art gallery')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '125.3', 'Complete these sentences with in, at or on.', 2
from units where slug = 'unit-125';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-125' where es.title = '125.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There isn''t a shop {0} the village where I live. It''s very small.', null),
  (2, 'Joe wasn''t {0} the party. I don''t know why he didn''t go.', null),
  (3, 'There were about ten tables {0} the restaurant, and four tables outside.', null),
  (4, 'I don''t know where my umbrella is. Perhaps I left it {0} the bus.', null),
  (5, 'What do you want to study {0} university?', null),
  (6, 'I didn''t feel well when I woke up, so I stayed {0} bed.', null),
  (7, 'We were {0} Sarah''s house last night. She invited us to dinner.', null),
  (8, 'It was a very slow train. It stopped {0} every station.', null),
  (9, 'Shall we travel {0} your car or mine?', null),
  (10, 'We took a taxi and Ben followed {0} his motorbike.', null),
  (11, 'I''d like to see a movie. What''s on {0} the cinema this week?', null),
  (12, 'We went to see a movie last night. It was really cold {0} the cinema.', null),
  (13, 'Two people were injured in the accident and are still {0} hospital.', null),
  (14, 'Our flight was delayed. We had to wait {0} the airport for three hours.', null),
  (15, 'I didn''t expect you to be {0} home. I thought you''d be {1} work.', null)
) as v(n, template, hint)
where es.title = '125.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '125.3'
join (values
  (1, 0, 'in'), (2, 0, 'at'), (3, 0, 'in'), (4, 0, 'on'), (5, 0, 'at'),
  (6, 0, 'in'), (7, 0, 'at'), (8, 0, 'at'), (9, 0, 'in'), (10, 0, 'on'),
  (11, 0, 'at'), (12, 0, 'in'), (13, 0, 'in'), (14, 0, 'at'),
  (15, 0, 'at'), (15, 1, 'at')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
