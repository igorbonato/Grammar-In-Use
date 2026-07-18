-- Marco 4 (slice 46): seeds the fourth slice of the "Prepositions" module
-- — unit 124 (in/at/on position 2).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode for 124.2 where -layout
-- scattered trailing clauses away from their items) and cross-checked
-- against pdf/Key to Exercises.pdf (plain mode).
--
-- 124.1 ("Answer the questions about the pictures") is picture-based, same
-- shape as 123.1/0046 — a theory_images placeholder plus inline scene
-- descriptions rebuilt from the picture captions and the Key's answers.
--
-- 124.2's trailing clauses ("this morning.", "of the United States." etc.)
-- don't map 1:1 in sequence to their items under -layout OR plain
-- extraction — resolved by matching each answer phrase (from the Key) to
-- whichever trailing clause makes it a complete, sensible sentence, same
-- approach as 89.3/91.4 in earlier modules.
--
-- Safe to re-run: unit 124 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 124: in/at/on (position) 2
-- ============================================================

delete from units where slug = 'unit-124';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 124, 'unit-124', 'in/at/on (position) 2', null,
  'in a line/queue, in a picture, in a newspaper, in an office, in the sky, in the world, in the country. on the left/right, on the ground/first floor, on a map/menu/list/website, on a river/road/coast, on the way (somewhere). at the top/bottom/end (of something). in the front/back of a car, but at the front/back of a building or group, and on the front/back of an envelope. in the corner (of a room), but at/on the corner (of a street).', 3
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'in a line, in a picture, in the sky ...',
  'We say that somebody/something is: in a line, in a row, in a queue; in a picture, in a photo(graph); in a newspaper, in a magazine, in a book; in an office, in a department; in the sky, in the world; in the country (= not in a town). When I go to the cinema, I like to sit in the front row. Amy works in the sales department. Who is the woman in that picture? Do you live in a city or in the country? It''s a lovely day. There isn''t a cloud in the sky.', 0
from units where slug = 'unit-124';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'on the left, on the second floor ...',
  'We say that somebody/something is: on the left, on the right (or on the left-hand side, on the right-hand side) — Do you drive on the left or on the right in your country? on the ground floor, on the first floor, on the second floor etc. — Our apartment is on the second floor of the building. on a map, on a menu, on a list, on a page, on a website — Here''s the shopping list. Don''t buy anything that''s not on the list. You''ll find the information you need on our website. We say that a place is on a river / on a road / on the coast: Vienna is on the (river) Danube. The town where you live — is it on the coast or is it inland? We say on the way (from one place to another): We stopped at a shop on the way home.', 1
from units where slug = 'unit-124';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'at the top, at the bottom, at the end',
  'We say: at the top (of ...), at the bottom (of ...), at the end (of ...). Write your name at the top of the page. Jane lives at the other end of the street.', 2
from units where slug = 'unit-124';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'in/at/on the front and back',
  'We say: in the front, in the back of a car — I was in the back (of the car) when we had the accident. at the front, at the back of a building / theatre / group of people etc. — The garden is at the back of the house. Let''s sit at the front (of the cinema). We were at the back, so we couldn''t see very well. on the front, on the back of an envelope / a piece of paper etc. — I wrote the date on the back of the photo.', 3
from units where slug = 'unit-124';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'in/at/on the corner',
  'We say: in the corner of a room — The TV is in the corner of the room. at the corner or on the corner of a street — There is a small shop at the corner (of the street). or ... on the corner (of the street).', 4
from units where slug = 'unit-124';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-124'
join (values
  ('A', 'When I go to the cinema, I like to sit in the front row.', null, 0),
  ('A', 'Amy works in the sales department.', null, 1),
  ('A', 'Who is the woman in that picture?', null, 2),
  ('B', 'Do you drive on the left or on the right in your country?', null, 0),
  ('B', 'Our apartment is on the second floor of the building.', null, 1),
  ('B', 'Vienna is on the (river) Danube.', null, 2),
  ('B', 'We stopped at a shop on the way home.', null, 3),
  ('C', 'Write your name at the top of the page.', null, 0),
  ('C', 'Jane lives at the other end of the street.', null, 1),
  ('D', 'I was in the back (of the car) when we had the accident.', null, 0),
  ('D', 'The garden is at the back of the house.', null, 1),
  ('D', 'I wrote the date on the back of the photo.', null, 2),
  ('E', 'The TV is in the corner of the room.', null, 0),
  ('E', 'There is a small shop at the corner (of the street).', 'or on the corner', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 124.1-124.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: ten small pictures used in exercise 124.1 — Amy''s flat on the second floor of a building, a woman standing on a street corner, a man standing in the corner of a room, a cat at the top of some stairs, a dog in the back of a car, Lisa at the front of a group, a post office on the left of a street, Gary sitting in the back row at the cinema, a bank at the end of a street]', 0
from units where slug = 'unit-124';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '124.1', 'Answer the questions about the pictures. Use in, at or on with the words below the pictures.', 0
from units where slug = 'unit-124';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-124' where es.title = '124.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Picture: Amy lives in this building. Amy''s flat is on the second floor. Where''s her flat exactly? {0}', null),
  (2, 'Picture: a woman standing on a street corner. Where is the woman standing? {0}', null),
  (3, 'Picture: a man standing in the corner of a room. Where is the man standing? {0}', null),
  (4, 'Picture: a cat at the top of some stairs. Where''s the cat? {0}', null),
  (5, 'Picture: a dog in the back of a car. Where''s the dog? {0}', null),
  (6, 'Picture: Lisa is in this group of people, standing at the front. Where is she? {0}', null),
  (7, 'Picture: a post office on the left side of a street. Where''s the post office? {0}', null),
  (8, 'Picture: Gary is at the cinema, sitting in the back row. Where is he sitting? {0}', null),
  (9, 'Picture: a bank at the end of a street. Where is the bank? {0}', null)
) as v(n, template, hint)
where es.title = '124.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '124.1'
join (values
  (1, 'On the second floor.', array[]::text[]),
  (2, 'On the corner.', array['At the corner.']::text[]),
  (3, 'In the corner.', array[]::text[]),
  (4, 'At the top of the stairs.', array[]::text[]),
  (5, 'In the back of the car.', array[]::text[]),
  (6, 'At the front.', array[]::text[]),
  (7, 'On the left.', array[]::text[]),
  (8, 'In the back row.', array[]::text[]),
  (9, 'At the end of the street.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '124.2', 'Complete the sentences. Use in, at or on + the following: the west coast, the world, the back of the class, the sky, the front row, the right, the back of this card, the way to work.', 1
from units where slug = 'unit-124';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-124' where es.title = '124.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'In most countries people drive {0}?', null),
  (2, 'What is the tallest building {0}?', null),
  (3, 'I met a friend of mine {0} this morning.', null),
  (4, 'San Francisco is {0} of the United States.', null),
  (5, 'We went to the theatre last night. We had seats {0}.', null),
  (6, 'I couldn''t hear the teacher. She spoke quietly and I was sitting {0}.', null),
  (7, 'I don''t have your address. Could you write it {0}?', null)
) as v(n, template, hint)
where es.title = '124.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '124.2'
join (values
  (1, 'on the right'), (2, 'in the world'), (3, 'on the way to work'), (4, 'on the west coast'),
  (5, 'in the front row'), (6, 'at the back of the class'), (7, 'on the back of this card')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '124.3', 'Complete the sentences with in, at or on.', 2
from units where slug = 'unit-124';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-124' where es.title = '124.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Is your sister {0} this photo? I don''t recognise her.', null),
  (2, 'They live in a small house {0} the bottom of the hill.', null),
  (3, 'We normally use the front entrance to the building, but there''s another one {0} the back.', null),
  (4, 'We had to wait {0} a queue for an hour to check in at the airport.', null),
  (5, 'There was a list of names, but my name wasn''t {0} the list.', null),
  (6, 'Is there anything interesting {0} today''s newspaper?', null),
  (7, 'I love to look up at the stars {0} the sky at night.', null),
  (8, 'When I''m a passenger in a car, I prefer to sit {0} the front.', null),
  (9, 'I live in a very small village. You probably won''t find it {0} your map.', null),
  (10, 'Joe works {0} the furniture department of a large store.', null),
  (11, 'Paris is {0} the (river) Seine.', null),
  (12, 'I don''t like cities. I''d much prefer to live {0} the country.', null),
  (13, 'My office is {0} the top floor. It''s {1} your left as you come out of the lift.', null)
) as v(n, template, hint)
where es.title = '124.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '124.3'
join (values
  (1, 0, 'in'), (2, 0, 'at'), (3, 0, 'at'), (4, 0, 'in'), (5, 0, 'on'),
  (6, 0, 'in'), (7, 0, 'in'), (8, 0, 'in'), (9, 0, 'on'), (10, 0, 'in'),
  (11, 0, 'on'), (12, 0, 'in'), (13, 0, 'on'), (13, 1, 'on')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
