-- Marco 4 (slice 33): seeds the sixth slice of the "Adjectives and
-- adverbs" module — units 107 (Comparative 3: as ... as / than) and 108
-- (Superlative: the longest / the most enjoyable etc.).
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 108.3 has TWO pre-filled worked examples, not just one — item 1 for
-- the plain superlative + preposition pattern, item 6 for the "one of +
-- superlative + preposition" pattern it introduces partway through.
-- Confirmed via the Key, which skips from item 5 to item 7. Same
-- recurring gotcha as 96.2/0027 and every "two sub-patterns, two
-- examples" exercise since unit 52.1/0010; renumbered into one continuous
-- 1-8 sequence in this migration's DB rows.
--
-- 108.2 items 11 and 12 (renumbered 9 and 10) are the only two-blank
-- items in this slice.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 107: Comparative 3 (as ... as / than)
-- ============================================================

delete from units where slug = 'unit-107';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 107, 'unit-107', 'Comparative 3 (as ... as / than)', null,
  'not as ... as (or not so ... as) compares things where one is less than the other: he isn''t as rich as Sarah. less than works the same way: I spent less money than you. In positive sentences and questions, use as ... as (not so ... as): I got here as fast as I could. We say the same as (not the same like). After than/as you can use me/him/us or I am/he does/we have etc.: taller than me, or taller than I am.', 9
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'not as ... as, less than',
  'Study this example situation: Sarah, Joe and David are all very rich. Sarah has $20 million, Joe has $15 million and David has $10 million. So: Joe is rich. He is richer than David. But he isn''t as rich as Sarah. (= Sarah is richer than he is) Some more examples of not as ... (as): Jack isn''t as old as he looks. (= he looks older than he is) The town centre wasn''t as crowded as usual. (= it is usually more crowded) Lisa didn''t do as well in the exam as she had hoped. (= she had hoped to do better) The weather is better today. It''s not as cold. (= yesterday was colder than today) I don''t know as many people as you do. (= you know more people than me) ''How much was it? Fifty dollars?'' ''No, not as much as that.'' (= less than fifty dollars) You can also say not so ... (as): It''s not warm, but it''s not so cold as yesterday. (= it''s not as cold as ...) Less than is similar to not as ... as: I spent less money than you. (= I didn''t spend as much money as you) The city centre was less crowded than usual. (= it wasn''t as crowded as usual) I play tennis less than I used to. (= I don''t play as much as I used to)', 0
from units where slug = 'unit-107';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'as ... as in positive sentences and questions',
  'We also use as ... as (but not so ... as) in positive sentences and in questions: I''m sorry I''m late. I got here as fast as I could. There''s plenty of food. You can have as much as you want. Can you send me the information as soon as possible, please? Let''s walk. It''s just as quick as taking the bus. Also twice as ... as, three times as ... as etc.: Petrol is twice as expensive as it was a few years ago. Their house is about three times as big as ours. (or ... three times the size of ours)', 1
from units where slug = 'unit-107';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'the same as',
  'We say the same as (not the same like): Laura''s salary is the same as mine. or Laura gets the same salary as me. David is the same age as James. Sarah hasn''t changed. She still looks the same as she did ten years ago.', 2
from units where slug = 'unit-107';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'than me / than I am etc.',
  'You can say: You''re taller than me. or You''re taller than I am. (not usually You''re taller than I) He''s not as clever as her. or He''s not as clever as she is. They have more money than us. or They have more money than we have. I can''t run as fast as him. or I can''t run as fast as he can.', 3
from units where slug = 'unit-107';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-107'
join (values
  ('A', 'He is richer than David. But he isn''t as rich as Sarah.', '= Sarah is richer than he is', 0),
  ('A', 'Jack isn''t as old as he looks.', '= he looks older than he is', 1),
  ('A', 'The town centre wasn''t as crowded as usual.', '= it is usually more crowded', 2),
  ('A', 'Lisa didn''t do as well in the exam as she had hoped.', '= she had hoped to do better', 3),
  ('A', 'I don''t know as many people as you do.', '= you know more people than me', 4),
  ('A', 'It''s not warm, but it''s not so cold as yesterday.', null, 5),
  ('A', 'I spent less money than you.', '= I didn''t spend as much money as you', 6),
  ('B', 'I got here as fast as I could.', null, 0),
  ('B', 'There''s plenty of food. You can have as much as you want.', null, 1),
  ('B', 'Can you send me the information as soon as possible, please?', null, 2),
  ('B', 'Let''s walk. It''s just as quick as taking the bus.', null, 3),
  ('B', 'Petrol is twice as expensive as it was a few years ago.', null, 4),
  ('B', 'Their house is about three times as big as ours.', 'or three times the size of ours', 5),
  ('C', 'Laura''s salary is the same as mine. or Laura gets the same salary as me.', null, 0),
  ('C', 'David is the same age as James.', null, 1),
  ('C', 'Sarah hasn''t changed. She still looks the same as she did ten years ago.', null, 2),
  ('D', 'You''re taller than me. or You''re taller than I am.', 'not usually You''re taller than I', 0),
  ('D', 'He''s not as clever as her. or He''s not as clever as she is.', null, 1),
  ('D', 'They have more money than us. or They have more money than we have.', null, 2),
  ('D', 'I can''t run as fast as him. or I can''t run as fast as he can.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 107.1-107.5; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '107.1', 'Complete the sentences using as ... as.', 0
from units where slug = 'unit-107';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-107' where es.title = '107.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My salary is high, but yours is higher. My salary isn''t {0}.', null),
  (2, 'You know a bit about cars, but I know more. You don''t {0}.', null),
  (3, 'We are busy today, but we were busier yesterday. We aren''t {0}.', null),
  (4, 'I still feel bad, but I felt a lot worse earlier. I don''t {0}.', null),
  (5, 'Our neighbours have lived here for quite a long time, but we''ve lived here longer. Our neighbours haven''t {0}.', null),
  (6, 'I was a little nervous before the interview, but usually I''m a lot more nervous. I wasn''t {0}.', null)
) as v(n, template, hint)
where es.title = '107.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '107.1'
join (values
  (1, 'as high as yours', array[]::text[]),
  (2, 'know as much about cars as me', array['know as much about cars as I do', 'know as much about cars as I know']::text[]),
  (3, 'as busy today as we were yesterday', array['as busy today as yesterday']::text[]),
  (4, 'feel as bad as I did earlier', array['feel as bad as I felt earlier']::text[]),
  (5, 'lived here as long as us', array['lived here as long as we have']::text[]),
  (6, 'as nervous before the interview as I usually am', array['as nervous as usual']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '107.2', 'Write a new sentence with the same meaning.', 1
from units where slug = 'unit-107';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-107' where es.title = '107.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The station was nearer than I thought. The station wasn''t {0}.', null),
  (2, 'The meal didn''t cost as much as I expected. The meal cost {0}.', null),
  (3, 'I watch TV less than I used to. I don''t {0}.', null),
  (4, 'Karen''s hair isn''t as long as it used to be. Karen used to {0}.', null),
  (5, 'I know them better than you do. You don''t {0}.', null),
  (6, 'There are fewer students in this class than in the other one. There aren''t {0}.', null)
) as v(n, template, hint)
where es.title = '107.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '107.2'
join (values
  (1, 'as far as I thought', array[]::text[]),
  (2, 'less than I expected', array[]::text[]),
  (3, 'watch TV as much as I used to', array['watch TV as often as I used to']::text[]),
  (4, 'have longer hair', array[]::text[]),
  (5, 'know them as well as me', array['know them as well as I do']::text[]),
  (6, 'as many students in this class as in the other one', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '107.3', 'Complete the sentences using as ... as. Choose from: fast, hard, long, often, quietly, soon, well.', 2
from units where slug = 'unit-107';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-107' where es.title = '107.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was a difficult question. I answered it {0} I could.', null),
  (2, '''How long can I stay with you?'' ''You can stay {0} you like.''', null),
  (3, 'I need the information quickly, so let me know {0} possible.', null),
  (4, 'I like to keep fit, so I go swimming {0} I can.', null),
  (5, 'I didn''t want to wake anybody, so I came in {0} I could.', null),
  (6, 'You always say how tiring your job is, but I work just {0} you.', null)
) as v(n, template, hint)
where es.title = '107.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '107.3'
join (values
  (1, 'as well as'), (2, 'as long as'), (3, 'as soon as'),
  (4, 'as often as'), (5, 'as quietly as'), (6, 'as hard as')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '107.4', 'Write sentences using the same as.', 3
from units where slug = 'unit-107';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-107' where es.title = '107.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You and I both have dark brown hair. Your hair {0} mine.', null),
  (2, 'I arrived at 10.25 and so did you. I arrived {0} you.', null),
  (3, 'My birthday is 5 April. It''s Tom''s birthday too. My birthday {0} Tom''s.', null)
) as v(n, template, hint)
where es.title = '107.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '107.4'
join (values
  (1, 'is the same colour as', array[]::text[]),
  (2, 'at the same time as', array['the same time as']::text[]),
  (3, 'is on the same day as', array['is the same as']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '107.5', 'Complete the sentences. Choose from: as, him, is, less, me, much, than, twice.', 4
from units where slug = 'unit-107';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-107' where es.title = '107.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My friends arrived earlier {0} I expected.', null),
  (2, 'I live in the same street {0} Katherine. We''re neighbours.', null),
  (3, 'He doesn''t know much. I know more than {0}.', null),
  (4, 'This morning there was {0} traffic than usual.', null),
  (5, 'I don''t watch TV as {0} as I used to.', null),
  (6, 'Your bag is quite light. Mine is {0} as heavy as yours.', null),
  (7, 'We were born in the same year. I''m a little older than she {0}.', null),
  (8, 'I was really surprised. Nobody was more surprised than {0}.', null)
) as v(n, template, hint)
where es.title = '107.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '107.5'
join (values
  (1, 'than'), (2, 'as'), (3, 'him'), (4, 'less'),
  (5, 'much'), (6, 'twice'), (7, 'is'), (8, 'me')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 108: Superlative (the longest / the most enjoyable etc.)
-- ============================================================

delete from units where slug = 'unit-108';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 108, 'unit-108', 'Superlative (the longest / the most enjoyable etc.)', null,
  'The superlative form is -est or most ..., following the same short-word/long-word rules as the comparative (Unit 105); irregular forms are best, worst, furthest/farthest. We normally use the (or my/your etc.) with a superlative: the hottest day of the year. eldest is only used for family members, like elder (Unit 106E). After a superlative we use in with places, organisations and groups (the longest river in the world), and of with a period of time (the hottest day of the year); the present perfect often follows (the best holiday I''ve had).', 10
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', '-est or most ...',
  'Look at these examples: What is the longest river in the world? What was the most enjoyable holiday you''ve ever had? Longest and most enjoyable are superlative forms. The superlative form is -est or most ... . In general, we use -est for short words and most ... for longer words: long → longest, hot → hottest, easy → easiest, hard → hardest; but most famous, most boring, most enjoyable, most difficult. A few superlative forms are irregular: good → best, bad → worst, far → furthest or farthest. The rules are the same as those for the comparative — see Unit 105. For spelling, see Appendix 6.', 0
from units where slug = 'unit-108';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'the + superlative',
  'We normally use the (or my/your etc.) with a superlative: Yesterday was the hottest day of the year. The Louvre in Paris is one of the most famous museums in the world. She is really nice — one of the nicest people I know. What''s the best movie you''ve ever seen, and what''s the worst? How old is your youngest child? Compare the superlative and the comparative: This hotel is the cheapest in town. (superlative) It''s cheaper than all the others in town. (comparative) He''s the most patient person I''ve ever met. He''s much more patient than I am.', 1
from units where slug = 'unit-108';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'oldest and eldest',
  'The superlative of old is oldest: That church is the oldest building in the town. (not the eldest) We use eldest only when we talk about people in a family (you can also use oldest): Their eldest son is 13 years old. (or Their oldest son) Are you the eldest in your family? (or the oldest)', 2
from units where slug = 'unit-108';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'superlative + in/of',
  'After superlatives we normally use in with places: What''s the longest river in the world? (not of the world) We had a nice room. It was one of the best in the hotel. (not of the hotel) We also use in for organisations and groups of people (a class / a company etc.): Who is the youngest student in the class? (not of the class) For a period of time (day, year etc.), we normally use of: Yesterday was the hottest day of the year. What was the happiest day of your life?', 3
from units where slug = 'unit-108';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'superlative + present perfect',
  'We often use the present perfect (I have done) after a superlative (see also Unit 8A): What''s the most important decision you''ve ever made? That was the best holiday I''ve had for a long time.', 4
from units where slug = 'unit-108';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-108'
join (values
  ('A', 'What is the longest river in the world?', null, 0),
  ('A', 'What was the most enjoyable holiday you''ve ever had?', null, 1),
  ('B', 'Yesterday was the hottest day of the year.', null, 0),
  ('B', 'The Louvre in Paris is one of the most famous museums in the world.', null, 1),
  ('B', 'She is really nice — one of the nicest people I know.', null, 2),
  ('B', 'What''s the best movie you''ve ever seen, and what''s the worst?', null, 3),
  ('B', 'How old is your youngest child?', null, 4),
  ('B', 'This hotel is the cheapest in town.', 'superlative', 5),
  ('B', 'It''s cheaper than all the others in town.', 'comparative', 6),
  ('B', 'He''s the most patient person I''ve ever met. He''s much more patient than I am.', null, 7),
  ('C', 'That church is the oldest building in the town.', 'not the eldest', 0),
  ('C', 'Their eldest son is 13 years old.', 'or Their oldest son', 1),
  ('C', 'Are you the eldest in your family?', 'or the oldest', 2),
  ('D', 'What''s the longest river in the world?', 'not of the world', 0),
  ('D', 'It was one of the best in the hotel.', 'not of the hotel', 1),
  ('D', 'Who is the youngest student in the class?', 'not of the class', 2),
  ('D', 'Yesterday was the hottest day of the year.', null, 3),
  ('D', 'What was the happiest day of your life?', null, 4),
  ('E', 'What''s the most important decision you''ve ever made?', null, 0),
  ('E', 'That was the best holiday I''ve had for a long time.', null, 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 108.1-108.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '108.1', 'Complete the sentences. Use the superlative forms (-est or most ...) of the words in the box: bad, cheap, good, honest, popular, short, tall.', 0
from units where slug = 'unit-108';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-108' where es.title = '108.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'This building is 250 metres high, but it''s not {0} in the city.', null),
  (2, 'It was an awful day. It was {0} day of my life.', null),
  (3, 'What is {0} sport in your country?', null),
  (4, 'I like the morning. For me it''s {0} part of the day.', null),
  (5, 'Sarah always tells the truth. She''s one of {0} people I know.', null),
  (6, 'A straight line is {0} distance between two points.', null)
) as v(n, template, hint)
where es.title = '108.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '108.1'
join (values
  (1, 'the tallest'), (2, 'the worst'), (3, 'the most popular'),
  (4, 'the best'), (5, 'the most honest'), (6, 'the shortest')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '108.2', 'Complete the sentences. Use a superlative (-est or most ...) or a comparative (-er or more ...).', 1
from units where slug = 'unit-108';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-108' where es.title = '108.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wasn''t feeling well yesterday, but I feel a bit {0} today.', '(good)'),
  (2, 'What''s {0} thing you''ve ever bought?', '(expensive)'),
  (3, 'I prefer this chair to the other one. It''s {0}.', '(comfortable)'),
  (4, 'Amy and Ben have three daughters. {0} is 14 years old.', '(old)'),
  (5, 'Who is the {0} person you know?', '(old)'),
  (6, 'What''s {0} way to get to the station?', '(quick)'),
  (7, 'Which is {0} — the bus or the train?', '(quick)'),
  (8, 'I can remember when I was three years old. It''s {0} memory.', '(early)'),
  (9, 'Everest is {0} mountain in the world. It is {1} than any other mountain.', '(high)'),
  (10, '''This knife isn''t very sharp. Do you have a {0} one?'' ''No, it''s {1} one I have.''', '(sharp)')
) as v(n, template, hint)
where es.title = '108.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '108.2'
join (values
  (1, 0, 'better', array[]::text[]),
  (2, 0, 'the most expensive', array[]::text[]),
  (3, 0, 'more comfortable', array[]::text[]),
  (4, 0, 'The eldest', array['The oldest']::text[]),
  (5, 0, 'oldest', array[]::text[]),
  (6, 0, 'the quickest', array[]::text[]),
  (7, 0, 'quicker', array[]::text[]),
  (8, 0, 'my earliest', array[]::text[]),
  (9, 0, 'the highest', array[]::text[]), (9, 1, 'higher', array[]::text[]),
  (10, 0, 'sharper', array[]::text[]), (10, 1, 'the sharpest', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '108.3', 'Complete the sentences. Use a superlative (-est or most ...) + a preposition (of or in); the later items use one of + a superlative + a preposition.', 2
from units where slug = 'unit-108';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-108' where es.title = '108.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Brazil is a very large country. It''s {0} South America.', null),
  (2, 'It was a very happy day. It was {0} my life.', null),
  (3, 'This is a very valuable painting. It''s {0} the museum.', null),
  (4, 'Spring is a very busy time for me. It''s {0} the year.', null),
  (5, 'He''s a very rich man. He''s one {0} the country.', null),
  (6, 'She''s a very good student. She''s {0} the class.', null),
  (7, 'It was a very bad experience. It was {0} my life.', null),
  (8, 'It''s a very famous university. It''s {0} the world.', null)
) as v(n, template, hint)
where es.title = '108.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '108.3'
join (values
  (1, 'the largest country in'), (2, 'the happiest day of'), (3, 'the most valuable painting in'),
  (4, 'the busiest time of'), (5, 'of the richest men in'), (6, 'one of the best students in'),
  (7, 'one of the worst experiences of'), (8, 'one of the most famous universities in')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '108.4', 'What do you say in these situations? Use a superlative + ever.', 3
from units where slug = 'unit-108';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-108' where es.title = '108.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Someone has just told you a joke which you think is very funny. You say: That''s {0}', '(funny / joke / ever / hear)'),
  (2, 'You''re drinking coffee with a friend. It''s really good coffee. You say: This {0}', '(good / coffee / ever / taste)'),
  (3, 'You have just run ten kilometres. You''ve never run further than this. You say: That {0}', '(far / ever / run)'),
  (4, 'You gave up your job. Now you think this was a very bad mistake. You say: It {0}', '(bad / mistake / ever / make)'),
  (5, 'Your friend meets a lot of people, some of them famous. You ask your friend: Who {0}', '(famous / person / ever / meet?)')
) as v(n, template, hint)
where es.title = '108.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '108.4'
join (values
  (1, 'the funniest joke I''ve ever heard.', array[]::text[]),
  (2, 'is the best coffee I''ve ever tasted.', array[]::text[]),
  (3, '''s the furthest I''ve ever run.', array['''s the farthest I''ve ever run.']::text[]),
  (4, '''s the worst mistake I''ve ever made.', array['was the worst mistake I''ve ever made.']::text[]),
  (5, '''s the most famous person you''ve ever met?', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
