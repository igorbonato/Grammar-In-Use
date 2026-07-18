-- Marco 4 (slice 48): seeds the sixth slice of the "Prepositions" module
-- — unit 126 (to, at, in and into).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 126.2 ("Write sentences about places you have been to") is skipped as
-- open-ended — the Key gives only frequency scaffolds ("I've been to ...
-- once.") with the place itself left to the student, same policy as every
-- prior module.
--
-- Safe to re-run: unit 126 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 126: to, at, in and into
-- ============================================================

delete from units where slug = 'unit-126';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 126, 'unit-126', 'to, at, in and into', null,
  'Use to for movement towards a place (go to China, come to my house) — compare to (movement) with in/at (position): they are going to France, but they live in France. We say get to a place, but arrive in a town/country and arrive at other places. home takes no preposition (go home, get home, not "to home"). into (or often just in with go/get/put) means entering a place; the opposite is out of. For buses/trains/planes, use get on and get off.', 5
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'to for movement',
  'We say go/come/travel (etc.) to a place or event. For example: go to China, go to work, come to my house, go back to Italy, go to the bank, drive to the airport, return to London, go to a party, be taken to hospital. When are your friends going back to Italy? (not going back in Italy) Three people were injured in the accident and taken to hospital. In the same way we say Welcome to ..., a trip to ..., a visit to ..., on my way to ... etc.: Welcome to our country! (not Welcome in) We had to cancel our trip to Paris. Compare to (for movement) and in/at (for position): They are going to France. but They live in France. Can you come to the party? but I''ll see you at the party. We say ''(I''ve) been to'' a place or an event: I''ve been to Italy four times, but I''ve never been to Rome. Amanda has never been to a football match in her life.', 0
from units where slug = 'unit-126';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'get and arrive',
  'We say get to a place: They got to the hotel at midnight. What time did you get to the party? We say arrive in ... or arrive at ... (not arrive to). We say arrive in a town or country: They arrived in Madrid / in Spain a week ago. For other places (buildings etc.) or events, we say arrive at: What time did you arrive at the hotel / at the airport / at the party?', 1
from units where slug = 'unit-126';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'home',
  'We say: go home, come home, get home, arrive home, on the way home etc. (no preposition). We do not say ''to home'': What time did you get home? (not get to home) I met Lisa on my way home.', 2
from units where slug = 'unit-126';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'into',
  'go into, get into ... etc. = enter (a room / a building / a car etc.): I opened the door, went into the room and sat down. A bird flew into the kitchen through the window. Every month my salary is paid directly into my bank account. With some verbs (especially go/get/put) we often use in (instead of into): She got in the car and drove away. or She got into the car ... I read the letter and put it back in the envelope. The opposite of into is out of: She got out of the car and went into a shop. For buses, trains and planes, we usually say get on and get off: She got on the bus and I never saw her again. You need to get off (the train) at the next station.', 3
from units where slug = 'unit-126';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-126'
join (values
  ('A', 'When are your friends going back to Italy?', 'not going back in Italy', 0),
  ('A', 'Three people were injured in the accident and taken to hospital.', null, 1),
  ('A', 'Welcome to our country!', 'not Welcome in', 2),
  ('A', 'They are going to France. but They live in France.', null, 3),
  ('A', 'Can you come to the party? but I''ll see you at the party.', null, 4),
  ('A', 'I''ve been to Italy four times, but I''ve never been to Rome.', null, 5),
  ('B', 'They got to the hotel at midnight.', null, 0),
  ('B', 'They arrived in Madrid / in Spain a week ago.', null, 1),
  ('B', 'What time did you arrive at the hotel?', null, 2),
  ('C', 'What time did you get home?', 'not get to home', 0),
  ('C', 'I met Lisa on my way home.', null, 1),
  ('D', 'I opened the door, went into the room and sat down.', null, 0),
  ('D', 'A bird flew into the kitchen through the window.', null, 1),
  ('D', 'She got in the car and drove away. or She got into the car ...', null, 2),
  ('D', 'She got out of the car and went into a shop.', null, 3),
  ('D', 'She got on the bus and I never saw her again.', null, 4),
  ('D', 'You need to get off (the train) at the next station.', null, 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 126.1, 126.3, 126.4; 126.2 skipped as
-- open-ended. Each renumbered from 1, dropping the book's own worked
-- example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '126.1', 'Put in to/at/in/into where necessary. If no preposition is necessary, leave the space empty.', 0
from units where slug = 'unit-126';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-126' where es.title = '126.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We left our luggage {0} the station and went to find something to eat.', null),
  (2, 'Shall we take a taxi {0} the station or shall we walk?', null),
  (3, 'I have to go {0} the bank today. What time does it open?', null),
  (4, 'The Amazon flows {0} the Atlantic Ocean.', null),
  (5, 'I missed the bus, so I walked {0} home.', null),
  (6, 'Have you ever been {0} Canada?', null),
  (7, 'I lost my key, but I managed to climb {0} the house through a window.', null),
  (8, 'We got stuck in a traffic jam on our way {0} the airport.', null),
  (9, 'We had lunch {0} the airport while we were waiting for our plane.', null),
  (10, 'It took us four hours to get {0} the top of the mountain.', null),
  (11, 'Welcome {0} the hotel. We hope you enjoy your stay here.', null),
  (12, 'We drove along the main road and then turned {0} a narrow side street.', null),
  (13, 'Did you enjoy your visit {0} the zoo?', null),
  (14, 'I did some shopping on my way {0} home.', null),
  (15, 'Marcel is French. He has just returned {0} France after two years {1} Brazil.', null),
  (16, 'Carl was born {0} Chicago, but his family moved {1} Boston when he was three.', null)
) as v(n, template, hint)
where es.title = '126.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '126.1'
join (values
  (1, 0, 'at'), (2, 0, 'to'), (3, 0, 'to'), (4, 0, 'into'), (5, 0, ''),
  (6, 0, 'to'), (7, 0, 'into'), (8, 0, 'to'), (9, 0, 'at'), (10, 0, 'to'),
  (11, 0, 'to'), (12, 0, 'into'), (13, 0, 'to'), (14, 0, ''),
  (15, 0, 'to'), (15, 1, 'in'), (16, 0, 'in'), (16, 1, 'to')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '126.3', 'Put in to/at/in where necessary. If no preposition is necessary, leave the space empty.', 1
from units where slug = 'unit-126';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-126' where es.title = '126.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'They arrived {0} Barcelona a few days ago.', null),
  (2, 'What time did you get {0} home last night?', null),
  (3, 'What time do you usually arrive {0} work in the morning?', null),
  (4, 'When we got {0} the cinema, there was a long queue outside.', null),
  (5, 'We were delayed and arrived {0} home very late.', null)
) as v(n, template, hint)
where es.title = '126.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '126.3'
join (values
  (1, 'in'), (2, ''), (3, 'at'), (4, 'to'), (5, '')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '126.4', 'Write sentences using got + into / out of / on / off.', 2
from units where slug = 'unit-126';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-126' where es.title = '126.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You were waiting at the bus stop. At last your bus came and stopped. The doors opened. What did you do then? I {0}', null),
  (2, 'You drove home in your car. You stopped outside your house and parked the car. What did you do then? {0}', null),
  (3, 'You were travelling by train to Manchester. When the train got to Manchester, what did you do? {0}', null),
  (4, 'You needed a taxi. After a few minutes a taxi stopped for you. You opened the door. What did you do then? {0}', null),
  (5, 'You were travelling by plane. At the end of your flight, your plane landed at the airport and stopped. The doors were opened, you took your bag and stood up. What did you do then? {0}', null)
) as v(n, template, hint)
where es.title = '126.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '126.4'
join (values
  (1, 'got on the bus.', array[]::text[]),
  (2, 'I got out of the car.', array['I got out of my car.']::text[]),
  (3, 'I got off the train.', array[]::text[]),
  (4, 'I got into the taxi.', array['I got in the taxi.', 'I got in.']::text[]),
  (5, 'I got off the plane.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
