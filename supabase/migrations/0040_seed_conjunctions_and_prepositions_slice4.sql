-- Marco 4 (slice 39): seeds the fourth slice of the "Conjunctions and
-- prepositions" module — unit 117 (like and as).
--
-- Sourced from pdf/Modulos/Conjunctions and prepositions.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 117.2 ("Which goes with which?") is a matching exercise in the book
-- (six numbered sentences, six lettered completions) — adapted into the
-- usual "complete the sentence" fill-in shape, keeping item 1's pairing
-- as the worked example since the Key marks it solved already.
--
-- Written in multiple smaller Write/Edit calls rather than one large
-- Write, same fallback used for unit 116/0039 after the content-filtering
-- errors on that file.
--
-- Safe to re-run: unit 117 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 117: like and as
-- ============================================================

delete from units where slug = 'unit-117';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 117, 'unit-117', 'like and as', null,
  'like (= similar to, the same as) is a preposition, so it is followed by a noun, pronoun or -ing: like a palace, like this, like walking on ice. as (= in the same way as, in the same condition as) is used with subject + verb: left everything as it was — though like is also possible before subject + verb in this sense. as is also used in fixed expressions (as you know, as I expected, do as you like) and as a preposition meaning "in the position/form of" (I worked as a photographer), which has a different meaning from like (I''m like a taxi driver = I''m not one, but similar).', 4
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'like = similar to, the same as',
  'Like = similar to, the same as: What a beautiful house! It''s like a palace. (not as a palace) Be careful! The floor has been polished. It''s like walking on ice. (not as walking) It''s raining again. I hate weather like this. (not as this) ''What''s that noise?'' ''It sounds like a baby crying.'' (not as a baby crying) In these examples, like is a preposition. So it is followed by a noun (like a palace), a pronoun (like this) or -ing (like walking). Sometimes like = for example. You can also use such as: I enjoy water sports, like surfing, scuba diving and water-skiing. or I enjoy water sports, such as surfing ...', 0
from units where slug = 'unit-117';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'as = in the same way as',
  'As = in the same way as, in the same condition as. We use as with subject (S) + verb (V): I didn''t move anything. I left everything as it was. You should have done it as I showed you. We also use like in this way (+ subject + verb): I left everything like it was. Compare as and like. You can say: You should have done it as I showed you. or ... like I showed you. but You should have done it like this. (not as this) We say as usual / as always: You''re late as usual. As always, Nick was the first to complain. We say the same as ...: Your phone is the same as mine. (not the same like)', 1
from units where slug = 'unit-117';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'as you know / as I said / do as you like',
  'Sometimes as (+ subject + verb) has other meanings. For example, after do: You can do as you like. (= do what you like) They did as they promised. (= They did what they promised.) We also say as you know / as I said / as she expected / as I thought etc.: As you know, it''s Emma''s birthday next week. (= you know this already) Andy failed his driving test, as he expected. (= he expected this before) Like is not usual in these expressions, except with say (like I said): As I said yesterday, I''m sure we can solve the problem. or Like I said yesterday ...', 2
from units where slug = 'unit-117';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'as = preposition (in the position of)',
  'As can also be a preposition (as + noun), but the meaning is different from like. Compare: As a taxi driver, I spend most of my working life in a car. (I am a taxi driver, it''s my job.) Everyone in the family wants me to drive them to places. I''m like a taxi driver. (I''m not a taxi driver, but I''m like one.) As (preposition) = in the position of, in the form of etc.: Many years ago I worked as a photographer. (I was a photographer) Many words, for example ''work'' and ''rain'', can be used as verbs or nouns. London is fine as a place to visit, but I wouldn''t like to live there. The news of the tragedy came as a great shock.', 3
from units where slug = 'unit-117';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-117'
join (values
  ('A', 'It''s like a palace.', 'not as a palace', 0),
  ('A', 'It''s like walking on ice.', 'not as walking', 1),
  ('A', 'I hate weather like this.', 'not as this', 2),
  ('A', '''It sounds like a baby crying.''', 'not as a baby crying', 3),
  ('A', 'I enjoy water sports, like surfing, scuba diving and water-skiing.', 'or such as surfing', 4),
  ('B', 'I left everything as it was.', null, 0),
  ('B', 'You should have done it as I showed you.', null, 1),
  ('B', 'I left everything like it was.', null, 2),
  ('B', 'You should have done it like this.', 'not as this', 3),
  ('B', 'You''re late as usual.', null, 4),
  ('B', 'Your phone is the same as mine.', 'not the same like', 5),
  ('C', 'You can do as you like.', '= do what you like', 0),
  ('C', 'As you know, it''s Emma''s birthday next week.', '= you know this already', 1),
  ('C', 'Andy failed his driving test, as he expected.', '= he expected this before', 2),
  ('C', 'As I said yesterday, I''m sure we can solve the problem.', 'or Like I said yesterday', 3),
  ('D', 'As a taxi driver, I spend most of my working life in a car.', 'I am a taxi driver, it''s my job', 0),
  ('D', 'I''m like a taxi driver.', 'I''m not a taxi driver, but I''m like one', 1),
  ('D', 'Many years ago I worked as a photographer.', 'I was a photographer', 2),
  ('D', 'The news of the tragedy came as a great shock.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 117.1-117.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '117.1', 'In some of these sentences, you need like (not as). Correct the sentences where necessary. Write OK if the sentence is correct.', 0
from units where slug = 'unit-117';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-117' where es.title = '117.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Do you think James looks as his father? {0}', null),
  (2, 'He gets on my nerves. I can''t stand people as him. {0}', null),
  (3, 'Why didn''t you do it as I told you to do it? {0}', null),
  (4, 'As her mother, Katherine has a very good voice. {0}', null),
  (5, 'You never listen. Talking to you is as talking to the wall. {0}', null),
  (6, 'I prefer the room as it was, before we decorated it. {0}', null),
  (7, 'I''ll phone you tomorrow as usual, OK? {0}', null),
  (8, 'She''s a very good swimmer. She swims as a fish. {0}', null)
) as v(n, template, hint)
where es.title = '117.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '117.1'
join (values
  (1, 'Do you think James looks like his father?'),
  (2, 'I can''t stand people like him.'),
  (3, 'OK'),
  (4, 'Like her mother, Katherine has a very good voice.'),
  (5, 'Talking to you is like talking to the wall.'),
  (6, 'OK'),
  (7, 'OK'),
  (8, 'She swims like a fish.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '117.2', 'Which goes with which? Complete each sentence with the matching ending.', 1
from units where slug = 'unit-117';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-117' where es.title = '117.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I like Tom''s idea. {0}', null),
  (2, 'I''m fed up with my job. {0}', null),
  (3, 'You drive too fast. {0}', null),
  (4, 'You don''t have to take my advice. {0}', null),
  (5, 'I couldn''t get a seat on the train. {0}', null)
) as v(n, template, hint)
where es.title = '117.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '117.2'
join (values
  (1, 'Let''s do as he suggests.'),
  (2, 'As I''ve told you before, it''s boring.'),
  (3, 'You should take more care, as I keep telling you.'),
  (4, 'You can do as you like.'),
  (5, 'It was full, as I expected.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '117.3', 'Complete the sentences using like or as + the following: a beginner, blocks of ice, a palace, a birthday present, a child, a theatre, winter, a tour guide.', 2
from units where slug = 'unit-117';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-117' where es.title = '117.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My feet are really cold. They''re {0}.', null),
  (2, 'I''ve been playing tennis for years, but I still play {0}.', null),
  (3, 'Marion once had a part-time job {0}.', null),
  (4, 'I wonder what that building is. It looks {0}.', null),
  (5, 'My brother gave me this watch {0} a long time ago.', null),
  (6, 'It''s very cold for the middle of summer. It''s {0}.', null),
  (7, 'He''s 22 years old, but he sometimes behaves {0}.', null)
) as v(n, template, hint)
where es.title = '117.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '117.3'
join (values
  (1, 'like blocks of ice'), (2, 'like a beginner'), (3, 'as a tour guide'), (4, 'like a theatre'),
  (5, 'as a birthday present'), (6, 'like winter'), (7, 'like a child')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '117.4', 'Put in like or as. Sometimes either word is possible.', 3
from units where slug = 'unit-117';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-117' where es.title = '117.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wish I had a car {0} yours.', null),
  (2, 'Hannah has been working {0} a waitress for the last two months.', null),
  (3, 'We saw Kevin last night. He was very cheerful, {0} always.', null),
  (4, 'You waste a lot of time doing things {0} sitting in cafes all day.', null),
  (5, '{0} you can imagine, we were very tired after such a long journey.', null),
  (6, 'Tom showed me some photos of the city {0} it was thirty years ago.', null),
  (7, 'My neighbour''s house is full of interesting things. It''s {0} a museum.', null),
  (8, 'In some countries in Asia, {0} Japan, Indonesia and Thailand, traffic drives on the left.', null),
  (9, 'The weather hasn''t changed. It''s the same {0} yesterday.', null),
  (10, 'You''re different from the other people I know. I don''t know anyone else {0} you.', null),
  (11, 'The news that they are getting married came {0} a complete surprise to me.', null),
  (12, 'This tea is awful. It tastes {0} water.', null),
  (13, 'Suddenly there was a terrible noise. It was {0} a bomb exploding.', null),
  (14, 'Right now I''m working in a shop. It''s not great, but it''s OK {0} a temporary job.', null),
  (15, 'Brian is a student, {0} most of his friends.', null)
) as v(n, template, hint)
where es.title = '117.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '117.4'
join (values
  (1, 'like', array[]::text[]),
  (2, 'as', array[]::text[]),
  (3, 'as', array[]::text[]),
  (4, 'like', array[]::text[]),
  (5, 'As', array[]::text[]),
  (6, 'as', array[]::text[]),
  (7, 'like', array[]::text[]),
  (8, 'like', array['such as']::text[]),
  (9, 'as', array[]::text[]),
  (10, 'like', array[]::text[]),
  (11, 'as', array[]::text[]),
  (12, 'like', array[]::text[]),
  (13, 'like', array[]::text[]),
  (14, 'as', array[]::text[]),
  (15, 'like', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
