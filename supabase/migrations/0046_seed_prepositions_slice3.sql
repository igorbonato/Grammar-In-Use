-- Marco 4 (slice 45): seeds the third slice of the "Prepositions" module
-- — unit 123 (in/at/on position 1).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode for 123.1/123.2 where
-- -layout scattered questions/completions away from their items) and
-- cross-checked against pdf/Key to Exercises.pdf (plain mode).
--
-- 123.1 ("Answer the questions about the pictures") is picture-based with
-- no fill-in text of its own — same shape as 46.1/78.1: the Key's answers
-- become the seeded correct answers directly, plus a theory_images
-- placeholder describing the eight pictures for Igor to replace, and each
-- template rephrases the picture's subject inline (from the parenthetical
-- labels under each picture) so the question is self-contained without
-- the image. Pictures 4 (door) and 7 (gate) each have two separate
-- questions sharing one picture (a notice AND a key on/in the door; a man
-- AND a bird at/on the gate) — flattened into separate sequential items.
--
-- Safe to re-run: unit 123 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 123: in/at/on (position) 1
-- ============================================================

delete from units where slug = 'unit-123';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 123, 'unit-123', 'in/at/on (position) 1', null,
  'in is for enclosed spaces (in a room, in a box, in the sea); at is for a specific point (at the bus stop, at the door, at the traffic lights); on is for a surface (on the table, on the wall, on the ceiling). Compare: there were people in the shop (inside it), but turn left at the shop (a point on your route); there is water in the bottle, but a label on the bottle.', 2
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'in',
  'in a room, in a garden, in a pool, in a building, in a town, in the sea, in a box, in the city centre, in a river etc. There''s no-one in the room / in the building / in the garden. What do you have in your hand / in your mouth? When we were in Italy, we spent a few days in Venice. I have a friend who lives in a small village in the mountains. There were some people swimming in the pool / in the sea / in the river.', 0
from units where slug = 'unit-123';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'at',
  'at the bus stop, at the door, at the roundabout, at her desk. Who is that man standing at the bus stop / at the door / at the window? Turn left at the traffic lights / at the next junction / at the roundabout / at the church. We have to get off the bus at the next stop. When you leave the hotel, please leave your key at reception. (= at the reception desk) Compare in and at: There were a lot of people in the shop. It was crowded. Go along this road, then turn left at the shop. I''ll meet you in the hotel lobby. (= in the building) I''ll meet you at the entrance to the hotel. (= outside the building)', 1
from units where slug = 'unit-123';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'on',
  'on the wall, on the door, on the ceiling, on her nose, on the floor, on the table, on a page, on an island. I sat on the floor / on the ground / on the grass / on the beach / on a chair. There''s a dirty mark on the ceiling / on your nose / on your shirt. Did you see the notice on the wall / on the door? You''ll find details of TV programmes on page seven of the newspaper. The hotel is on a small island in the middle of a lake. Compare in and on: There is some water in the bottle. There is a label on the bottle. Compare at and on: There is somebody at the door. Shall I go and see who it is? There is a notice on the door. It says ''Do not disturb''.', 2
from units where slug = 'unit-123';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-123'
join (values
  ('A', 'There''s no-one in the room.', null, 0),
  ('A', 'What do you have in your hand?', null, 1),
  ('A', 'I have a friend who lives in a small village in the mountains.', null, 2),
  ('B', 'Who is that man standing at the bus stop?', null, 0),
  ('B', 'Turn left at the traffic lights.', null, 1),
  ('B', 'I''ll meet you in the hotel lobby.', '= in the building', 2),
  ('B', 'I''ll meet you at the entrance to the hotel.', '= outside the building', 3),
  ('C', 'I sat on the floor / on the ground / on the grass.', null, 0),
  ('C', 'Did you see the notice on the wall / on the door?', null, 1),
  ('C', 'The hotel is on a small island in the middle of a lake.', null, 2),
  ('C', 'There is some water in the bottle. There is a label on the bottle.', null, 3),
  ('C', 'There is somebody at the door.', null, 4),
  ('C', 'There is a notice on the door.', null, 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 123.1-123.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: eight small pictures used in exercise 123.1 — a label on a bottle, a fly on a man''s arm, a car waiting at traffic lights, a notice and a key on/in a door, shelves on a wall, the Eiffel Tower in Paris, a man standing and a bird sitting at/on a gate, children playing on a beach]', 0
from units where slug = 'unit-123';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '123.1', 'Answer the questions about the pictures. Use in, at or on with the words below the pictures.', 0
from units where slug = 'unit-123';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-123' where es.title = '123.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Picture: a fly on a man''s arm. Where''s the fly? {0}', null),
  (2, 'Picture: a car waiting at traffic lights. Where''s the car waiting? {0}', null),
  (3, 'Picture: a notice fixed to a door. Where''s the notice? {0}', null),
  (4, 'Same picture: a key in the door. Where''s the key? {0}', null),
  (5, 'Picture: shelves fixed to a wall. Where are the shelves? {0}', null),
  (6, 'Picture: the Eiffel Tower. Where''s the Eiffel Tower? {0}', null),
  (7, 'Picture: a man standing by a gate. Where''s the man standing? {0}', null),
  (8, 'Same picture: a bird sitting on the gate. Where''s the bird? {0}', null),
  (9, 'Picture: children playing on a beach. Where are the children playing? {0}', null)
) as v(n, template, hint)
where es.title = '123.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '123.1'
join (values
  (1, 'On his arm.', array['On the man''s arm.']::text[]),
  (2, 'At the traffic lights.', array[]::text[]),
  (3, 'On the door.', array[]::text[]),
  (4, 'In the door.', array[]::text[]),
  (5, 'On the wall.', array[]::text[]),
  (6, 'In Paris.', array[]::text[]),
  (7, 'At the gate.', array[]::text[]),
  (8, 'On the gate.', array[]::text[]),
  (9, 'On the beach.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '123.2', 'Complete the sentences. Use in, at or on + the following: the window, his hand, the mountains, that tree, my guitar, the river, the island, junction 14.', 1
from units where slug = 'unit-123';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-123' where es.title = '123.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'One of the strings {0} is broken.', null),
  (2, 'Leave the motorway {0} and then turn left.', null),
  (3, 'He was holding something {0}, but I couldn''t see what it was.', null),
  (4, 'The leaves {0} are a beautiful colour.', null),
  (5, 'You can go skiing {0} near here. There''s plenty of snow.', null),
  (6, 'There''s nobody living {0}. It''s uninhabited.', null),
  (7, 'He spends most of the day sitting {0} and looking outside.', null)
) as v(n, template, hint)
where es.title = '123.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '123.2'
join (values
  (1, 'on my guitar'), (2, 'at junction 14'), (3, 'in his hand'), (4, 'on that tree'),
  (5, 'in the mountains'), (6, 'on the island'), (7, 'at the window')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '123.3', 'Complete the sentences with in, at or on.', 2
from units where slug = 'unit-123';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-123' where es.title = '123.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Nicola was wearing a silver ring {0} her little finger.', null),
  (2, 'There was a security guard standing {0} the entrance to the building.', null),
  (3, 'I wasn''t sure whether I had come to the right office. There was no name {0} the door.', null),
  (4, 'There are plenty of shops and restaurants {0} the town centre.', null),
  (5, 'You''ll find the weather forecast {0} the back page of the newspaper.', null),
  (6, 'The headquarters of the company are {0} California.', null),
  (7, 'I wouldn''t like an office job. I couldn''t spend the whole day sitting {0} a desk.', null),
  (8, 'The man the police are looking for has a scar {0} his right cheek.', null),
  (9, 'If you come here by bus, get off {0} the stop after the traffic lights.', null),
  (10, 'Have you ever been camping? Have you ever slept {0} a tent?', null),
  (11, 'Emily was sitting {0} the balcony reading a book.', null),
  (12, 'My brother lives {0} a small village {1} the south-west of England.', null),
  (13, 'I like that picture hanging {0} the wall {1} the kitchen.', null)
) as v(n, template, hint)
where es.title = '123.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '123.3'
join (values
  (1, 0, 'on'), (2, 0, 'at'), (3, 0, 'on'), (4, 0, 'in'), (5, 0, 'on'),
  (6, 0, 'in'), (7, 0, 'at'), (8, 0, 'on'), (9, 0, 'at'), (10, 0, 'in'),
  (11, 0, 'on'), (12, 0, 'in'), (12, 1, 'in'), (13, 0, 'on'), (13, 1, 'in')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
