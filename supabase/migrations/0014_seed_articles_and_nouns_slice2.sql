-- Marco 4 (slice 13): seeds the second slice of the "Articles and nouns"
-- module — units 71-73 (Countable nouns with a/an and some, a/an and the,
-- the 1).
--
-- Sourced from pdf/Modulos/Articles and nouns.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
-- The Key's own 3-column page layout garbles badly under `-layout`
-- (adjacent columns interleave mid-word, e.g. "1 aa" for "1a a"); re-
-- extracted the relevant pages WITHOUT -layout (plain reading order) to
-- disambiguate 72.2 and the 73.x exercises, then verified every answer
-- against the exercise text's own context before trusting it.
--
-- This slice is the first to use empty-string correct answers ("no word
-- necessary") — see 73.1 item 6a (travel in space, no article) — now
-- gradable after today's exerciseGrading.ts fix (empty correctAnswer means
-- the blank is only right when left empty). 72.3, by contrast, turned out
-- to need an article/the in every one of its 13 items despite the "where
-- necessary" instruction — not every such exercise actually has an empty
-- case, so each one still needs checking against the Key rather than
-- assumed.
--
-- 71.1 and 71.2 each have TWO pre-filled worked examples (same gotcha as
-- 69.2/69.3 in the previous slice); 71.3, 71.4, 72.2's item 1, and 73.2's
-- item 1 have the usual single worked example. All renumbered from 1 in
-- this migration's DB rows, per the established convention.
--
-- 71.4, 73.1 and 73.4 present short two-line dialogues (A: ... B: ...) or
-- multi-blank sentences; each book item becomes one exercise_sentence with
-- multiple blank indices in reading order, one per {n} placeholder.
--
-- 72.4 ("Answer these questions ... How often do you ...?") is skipped as
-- open-ended: the Key itself labels its answers "Example answers" and they
-- are personal habitual-frequency facts that genuinely vary per learner
-- (same reasoning as 39.4/53.4/58.1/59.1 in prior migrations).
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 71: Countable nouns with a/an and some
-- ============================================================

delete from units where slug = 'unit-71';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 71, 'unit-71', 'Countable nouns with a/an and some', null,
  'Before singular countable nouns you can use a/an, but you cannot use a singular countable noun alone. Plural countable nouns can be used alone (in general) or with some, meaning a number of, or some but not all.', 2
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'a/an with singular countable nouns',
  'Countable nouns can be singular (a dog, a child, an umbrella) or plural (dogs, some children, two umbrellas). Before singular countable nouns you can use a/an: Bye! Have a nice evening. Do you need an umbrella? You cannot use a singular countable noun alone, without a/the/my etc.: She never wears a hat (not wears hat), Be careful of the dog, What a beautiful day!, Did you hurt your leg?', 0
from units where slug = 'unit-71';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'a/an to say what kind of thing/person; the plural noun alone',
  'We use a/an to say what kind of thing something is, or what kind of person somebody is: That''s a nice table. In the plural we use the noun alone, not some ...: Those are nice chairs (not some nice chairs). Compare: A dog is an animal / Dogs are animals; I''m an optimist / We''re optimists; My father is a doctor / My parents are both doctors. We say that somebody has a long nose / a nice face / blue eyes / long fingers etc.: Jack has a long nose (not the long nose), Jack has blue eyes (not the blue eyes). We use a/an when we say what somebody''s job is: Sandra is a nurse (not Sandra is nurse). Would you like to be an English teacher?', 1
from units where slug = 'unit-71';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'some with plural countable nouns',
  'You can use some with plural countable nouns, in two ways. (1) some = a number of / a few of / a pair of: I''ve seen some good movies recently (not I''ve seen good movies). Often you can say the same thing with or without some: I need (some) new clothes. Do not use some when you are talking about things in general: I love bananas (not some bananas). (2) some = some but not all: Some children learn very quickly (but not all children). Tomorrow there will be rain in some places, but most of the country will be dry.', 2
from units where slug = 'unit-71';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-71'
join (values
  ('A', 'Bye! Have a nice evening.', null, 0),
  ('A', 'Do you need an umbrella?', null, 1),
  ('A', 'She never wears a hat. (not wears hat)', null, 2),
  ('A', 'Be careful of the dog.', null, 3),
  ('A', 'What a beautiful day!', null, 4),
  ('A', 'Did you hurt your leg?', null, 5),
  ('B', 'That''s a nice table.', null, 0),
  ('B', 'Those are nice chairs. (not some nice chairs)', null, 1),
  ('B', 'A dog is an animal.', 'singular', 2),
  ('B', 'Dogs are animals.', 'plural', 3),
  ('B', 'My father is a doctor.', null, 4),
  ('B', 'My parents are both doctors.', null, 5),
  ('B', 'Jack has a long nose. (not the long nose)', null, 6),
  ('B', 'Sandra is a nurse. (not Sandra is nurse)', null, 7),
  ('B', 'Would you like to be an English teacher?', null, 8),
  ('C', 'I''ve seen some good movies recently. (not I''ve seen good movies)', null, 0),
  ('C', 'Some friends of mine are coming to stay at the weekend.', null, 1),
  ('C', 'I need some new sunglasses. (= a new pair of sunglasses)', null, 2),
  ('C', 'I love bananas. (not some bananas)', null, 3),
  ('C', 'My aunt is a writer. She writes books. (not some books)', null, 4),
  ('C', 'Some children learn very quickly. (but not all children)', null, 5),
  ('C', 'Tomorrow there will be rain in some places, but most of the country will be dry.', null, 6)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 71.1-71.4; 71.1/71.2 renumbered from the
-- book's item 3 / item 2 — both have two worked examples)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '71.1', 'What are these things? Choose from the box and write a sentence: bird(s), flower(s), game(s), insect(s), language(s), planet(s), river(s), tool(s), vegetable(s).', 0
from units where slug = 'unit-71';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-71' where es.title = '71.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'carrots and onions: {0}', 'vegetable(s)'),
  (2, 'a tulip: {0}', 'flower(s)'),
  (3, 'Earth, Mars and Jupiter: {0}', 'planet(s)'),
  (4, 'chess: {0}', 'game(s)'),
  (5, 'a hammer, a saw and a screwdriver: {0}', 'tool(s)'),
  (6, 'the Nile, the Rhine and the Mekong: {0}', 'river(s)'),
  (7, 'a mosquito: {0}', 'insect(s)'),
  (8, 'Hindi, Arabic and Swahili: {0}', 'language(s)')
) as v(n, template, hint)
where es.title = '71.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '71.1'
join (values
  (1, 'They''re vegetables.'), (2, 'It''s a flower.'), (3, 'They''re planets.'), (4, 'It''s a game.'),
  (5, 'They''re tools.'), (6, 'They''re rivers.'), (7, 'It''s an insect.'), (8, 'They''re languages.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '71.2', 'Read about what these people do. What are their jobs? Choose from: chef, interpreter, journalist, nurse, plumber, surgeon, tour guide, waiter.', 1
from units where slug = 'unit-71';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-71' where es.title = '71.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Gary works in a restaurant. He brings the food to the tables. {0}', 'waiter'),
  (2, 'Jane writes articles for a newspaper. {0}', 'journalist'),
  (3, 'Kevin works in a hospital. He operates on people. {0}', 'surgeon'),
  (4, 'Jonathan cooks in a restaurant. {0}', 'chef'),
  (5, 'Dave installs and repairs water pipes. {0}', 'plumber'),
  (6, 'Anna shows visitors round her city and tells them about it. {0}', 'tour guide'),
  (7, 'Lisa translates what people are saying from one language into another, so that they can understand each other. {0}', 'interpreter')
) as v(n, template, hint)
where es.title = '71.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '71.2'
join (values
  (1, 'He''s a waiter.'), (2, 'She''s a journalist.'), (3, 'He''s a surgeon.'), (4, 'He''s a chef.'),
  (5, 'He''s a plumber.'), (6, 'She''s a tour guide.'), (7, 'She''s an interpreter.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '71.3', 'Which is right?', 2
from units where slug = 'unit-71';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-71' where es.title = '71.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Are you {0}?', 'careful driver / a careful driver'),
  (2, 'I went to the library and borrowed {0}.', 'books / some books'),
  (3, 'Mark works in a bookshop. He sells {0}.', 'books / some books'),
  (4, 'I''ve been walking for hours. I''ve got {0}.', 'sore feet / some sore feet'),
  (5, 'I don''t feel very well. I''ve got {0}.', 'sore throat / a sore throat'),
  (6, 'What {0}! Thank you very much.', 'lovely present / a lovely present'),
  (7, 'I met {0} in a cafe yesterday. They were from China.', 'students / some students'),
  (8, 'It might rain. Don''t go out {0}.', 'without umbrella / without an umbrella'),
  (9, '{0} learn languages more easily than others.', 'People / Some people')
) as v(n, template, hint)
where es.title = '71.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '71.3'
join (values
  (1, 'a careful driver'), (2, 'some books'), (3, 'books'), (4, 'sore feet'),
  (5, 'a sore throat'), (6, 'a lovely present'), (7, 'some students'),
  (8, 'without an umbrella'), (9, 'Some people')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '71.4', 'Put in a/an or some where necessary. If no word is necessary, leave the space empty.', 3
from units where slug = 'unit-71';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-71' where es.title = '71.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When I was {0} child, I used to be very shy.', null),
  (2, '{0} birds, for example the penguin, cannot fly.', null),
  (3, 'Would you like to be {0} actor?', null),
  (4, 'Questions, questions, questions! You''re always asking {0} questions!', 'no word needed'),
  (5, 'I didn''t expect to see you. What {0} surprise!', null),
  (6, 'Do you like staying in {0} hotels?', 'no word needed'),
  (7, 'Tomorrow is a holiday. {0} shops will be open, but most of them will be closed.', null),
  (8, 'Those are {0} nice shoes. Where did you get them?', 'no word needed'),
  (9, 'You need {0} visa to visit {1} countries, but not all of them.', null),
  (10, 'Kate is {0} teacher. Her parents were {1} teachers too.', 'second blank: no word needed'),
  (11, 'I don''t believe him. He''s {0} liar. He''s always telling {1} lies.', 'second blank: no word needed')
) as v(n, template, hint)
where es.title = '71.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '71.4'
join (values
  (1, 0, 'a'), (2, 0, 'Some'), (3, 0, 'an'), (4, 0, ''), (5, 0, 'a'), (6, 0, ''),
  (7, 0, 'Some'), (8, 0, ''), (9, 0, 'a'), (9, 1, 'some'),
  (10, 0, 'a'), (10, 1, ''), (11, 0, 'a'), (11, 1, '')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 72: a/an and the
-- ============================================================

delete from units where slug = 'unit-72';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 72, 'unit-72', 'a/an and the', null,
  'We use a/an the first time we mention something, and the after that, once it is clear what we mean. We also use the when it is clear which specific thing or person we are talking about, and a/an to say what kind of thing something is.', 3
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'a/an the first time; the after that',
  'We use a/an when we say something for the first time, and the after that, once it is clear what we are talking about: I had a sandwich and an apple for lunch. The sandwich wasn''t very good, but the apple was nice. Compare: A man and a woman were sitting opposite me. The man was American, but I think the woman was British. When we were on holiday, we stayed at a hotel. Sometimes we ate at the hotel and sometimes we went to a restaurant.', 0
from units where slug = 'unit-72';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'the for a specific thing; a/an for what kind of thing',
  'We use the when we are thinking of a specific thing: Tim sat down on a chair (maybe one of many chairs in the room), but Tim sat down on the chair nearest the door (a specific chair). Do you have a car? (not a specific car) — I cleaned the car yesterday (= my car). We use a/an when we say what kind of thing or person we mean: We stayed at a very cheap hotel (a type of hotel) — The hotel where we stayed was very cheap (a specific hotel).', 1
from units where slug = 'unit-72';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'the when it is clear which one we mean',
  'We use the when it is clear which thing or person we mean. For example, in a room we talk about the light / the floor / the ceiling / the door / the carpet etc.: Can you turn off the light, please? (= the light in this room). I took a taxi to the station (= the station in that town). (in a shop) I''d like to speak to the manager, please (= the manager of this shop). We also say (go to) the bank / the post office, and (go to) the doctor / the dentist: I have to go to the bank and then I''m going to the post office. Clare isn''t well. She''s gone to the doctor. Compare the and a: I have to go to the bank today — Is there a bank near here? I don''t like going to the dentist — My sister is a dentist.', 2
from units where slug = 'unit-72';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'once a week, £1.50 a kilo',
  'We say once a week / three times a day / £1.50 a kilo etc.: I go to the cinema about once a month. ''How much are those potatoes?'' ''£1.50 a kilo.'' Helen works eight hours a day, six days a week.', 3
from units where slug = 'unit-72';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-72'
join (values
  ('A', 'I had a sandwich and an apple for lunch.', null, 0),
  ('A', 'The sandwich wasn''t very good, but the apple was nice.', null, 1),
  ('A', 'A man and a woman were sitting opposite me. The man was American, but I think the woman was British.', null, 2),
  ('A', 'When we were on holiday, we stayed at a hotel. Sometimes we ate at the hotel and sometimes we went to a restaurant.', null, 3),
  ('B', 'Tim sat down on a chair.', 'maybe one of many chairs in the room', 0),
  ('B', 'Tim sat down on the chair nearest the door.', 'a specific chair', 1),
  ('B', 'Do you have a car?', 'not a specific car', 2),
  ('B', 'I cleaned the car yesterday.', '= my car', 3),
  ('B', 'We stayed at a very cheap hotel.', 'a type of hotel', 4),
  ('B', 'The hotel where we stayed was very cheap.', 'a specific hotel', 5),
  ('C', 'Can you turn off the light, please?', '= the light in this room', 0),
  ('C', 'I took a taxi to the station.', '= the station in that town', 1),
  ('C', 'I''d like to speak to the manager, please.', '= the manager of this shop', 2),
  ('C', 'I have to go to the bank and then I''m going to the post office.', null, 3),
  ('C', 'Clare isn''t well. She''s gone to the doctor.', null, 4),
  ('C', 'I have to go to the bank today.', null, 5),
  ('C', 'Is there a bank near here?', null, 6),
  ('C', 'My sister is a dentist.', null, 7),
  ('D', 'I go to the cinema about once a month.', null, 0),
  ('D', '''How much are those potatoes?'' ''£1.50 a kilo.''', null, 1),
  ('D', 'Helen works eight hours a day, six days a week.', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 72.1-72.3; 72.4 skipped — open-ended, "Example
-- answers" for personal habitual-frequency facts)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '72.1', 'Put in a/an or the.', 0
from units where slug = 'unit-72';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-72' where es.title = '72.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'This morning I bought a book and {0} magazine. {1} book is in my bag, but I can''t remember where I put {2} magazine.', null),
  (2, 'I saw {0} accident this morning. {1} car crashed into {2} tree. {3} driver of {4} car wasn''t hurt, but {5} car was badly damaged.', null),
  (3, 'There are two cars parked outside: {0} blue one and {1} grey one. {2} blue one belongs to my neighbours. I don''t know who {3} owner of {4} grey one is.', null),
  (4, 'My friends live in {0} old house in {1} small village. There is {2} beautiful garden behind {3} house. I would like to have {4} garden like that.', null)
) as v(n, template, hint)
where es.title = '72.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '72.1'
join (values
  (1, 0, 'a'), (1, 1, 'The'), (1, 2, 'the'),
  (2, 0, 'an'), (2, 1, 'A'), (2, 2, 'a'), (2, 3, 'The'), (2, 4, 'the'), (2, 5, 'the'),
  (3, 0, 'a'), (3, 1, 'a'), (3, 2, 'The'), (3, 3, 'the'), (3, 4, 'the'),
  (4, 0, 'an'), (4, 1, 'a'), (4, 2, 'a'), (4, 3, 'the'), (4, 4, 'a')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '72.2', 'Put in a/an or the.', 1
from units where slug = 'unit-72';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-72' where es.title = '72.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: This house is very nice. Does it have {0} garden? b: It''s a beautiful day. Let''s sit in {1} garden. c: I like living in this house, but it''s a shame that {2} garden is so small.', null),
  (2, 'a: Can you recommend {0} good restaurant? b: We had dinner in {1} very nice restaurant. c: We had dinner in {2} best restaurant in town.', null),
  (3, 'a: What''s {0} name of that man we met yesterday? b: We stayed at a very nice hotel — I can''t remember {1} name now. c: My neighbour has {2} French name, but in fact she''s English, not French.', null),
  (4, 'a: Did Paula get {0} job she applied for? b: It''s not easy to get {1} job at the moment. c: Do you enjoy your work? Is it {2} interesting job?', null),
  (5, 'a: ''Are you going away next week?'' ''No, {0} week after next.'' b: I''m going away for {1} week in September. c: Gary has a part-time job. He works three mornings {2} week.', null)
) as v(n, template, hint)
where es.title = '72.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '72.2'
join (values
  (1, 0, 'a'), (1, 1, 'the'), (1, 2, 'the'),
  (2, 0, 'a'), (2, 1, 'a'), (2, 2, 'the'),
  (3, 0, 'the'), (3, 1, 'the'), (3, 2, 'a'),
  (4, 0, 'the'), (4, 1, 'a'), (4, 2, 'an'),
  (5, 0, 'the'), (5, 1, 'a'), (5, 2, 'a')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '72.3', 'Put in a/an or the where necessary.', 2
from units where slug = 'unit-72';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-72' where es.title = '72.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'How often do you go to {0}?', 'dentist'),
  (2, 'Can you close {0}, please?', 'door'),
  (3, 'I have {0}. I need your help.', 'problem'),
  (4, 'How far is it from here to {0}?', 'station'),
  (5, 'I''m going to {0}. I won''t be long.', 'post office'),
  (6, 'Paul plays tennis. He''s {0}.', 'very good player'),
  (7, 'There isn''t {0} near where I live.', 'airport'),
  (8, '{0} is 70 miles away.', 'nearest airport'),
  (9, 'There were no chairs, so we sat on {0}.', 'floor'),
  (10, 'Have you finished with {0} I lent you?', 'book'),
  (11, 'Chris has just got {0}.', 'job in a bank'),
  (12, 'We live in {0}.', 'small apartment in the city centre'),
  (13, 'There''s {0} I live in.', 'shop at the end of the street')
) as v(n, template, hint)
where es.title = '72.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '72.3'
join (values
  (1, 'the dentist'), (2, 'the door'), (3, 'a problem'), (4, 'the station'),
  (5, 'the post office'), (6, 'a very good player'), (7, 'an airport'),
  (8, 'The nearest airport'), (9, 'the floor'), (10, 'the book'),
  (11, 'a job in a bank'), (12, 'a small apartment in the city centre'),
  (13, 'a shop at the end of the street')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 73: the 1
-- ============================================================

delete from units where slug = 'unit-73';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 73, 'unit-73', 'the 1', null,
  'We use the when there is only one of something (the sun, the capital, the end of the month) and with superlatives. We say the world/the sky/the sea but space/Earth without the; TV but the radio; and breakfast/lunch/dinner without the, unless there is an adjective (a big lunch).', 4
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'the when there is only one of something',
  'We use the when there is only one of something: Have you ever crossed the equator? (there is only one equator). Our apartment is on the tenth floor. Buenos Aires is the capital of Argentina. I''m going away at the end of this month. We use the + superlative (best, oldest etc.): What''s the longest river in Europe? Compare the and a/an: The sun is a star (= one of many stars). The hotel where we stayed was a very old hotel. We live in an apartment on the tenth floor. What''s the best way to learn a language?', 0
from units where slug = 'unit-73';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'the same',
  'We say the same: Your sweater is the same colour as mine (not is same colour). ''Are these keys the same?'' ''No, they''re different.''', 1
from units where slug = 'unit-73';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'the world, the sun, the sky, the sea — but space, Earth',
  'We say: the world, the universe, the sun, the moon, the earth, the sky, the sea, the ground, the country (= not a town). I love to look at the stars in the sky (not in sky). Do you live in a town or in the country? The earth goes round the sun, and the moon goes round the earth. We also use Earth (without the) when we think of it as a planet in space (like Mars, Jupiter etc.): Which is the planet nearest Earth? We say space (without the) when we mean ''space in the universe''. Compare: There are millions of stars in space (not in the space). I tried to park my car, but the space was too small.', 2
from units where slug = 'unit-73';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'the cinema, the theatre — but TV, the radio, the internet',
  'We say (go to) the cinema, the theatre: I go to the cinema a lot, but I haven''t been to the theatre for ages. We say TV/television (without the), but the radio: I watch TV a lot, but I don''t listen to the radio much. But: Can you turn off the television, please? (the television = the TV set). We say the internet: The internet has changed the way we live.', 3
from units where slug = 'unit-73';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'breakfast/lunch/dinner — but a big lunch',
  'We usually say breakfast/lunch/dinner (without the): What did you have for breakfast? We had lunch in a very nice restaurant. But we say a big lunch, a wonderful dinner, an early breakfast etc.: We had a very nice lunch (not We had very nice lunch).', 4
from units where slug = 'unit-73';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'F', 'size 43, platform 5, room 126 (without the)',
  'We say size 43, platform 5 etc. (without the): Our train leaves from platform 5 (not the platform 5). Do you have these shoes in size 43? (not the size 43). In the same way, we say: room 126, page 29, vitamin A, section B etc.', 5
from units where slug = 'unit-73';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-73'
join (values
  ('A', 'Have you ever crossed the equator?', 'there is only one equator', 0),
  ('A', 'Our apartment is on the tenth floor.', null, 1),
  ('A', 'Buenos Aires is the capital of Argentina.', null, 2),
  ('A', 'I''m going away at the end of this month.', null, 3),
  ('A', 'What''s the longest river in Europe?', null, 4),
  ('A', 'The sun is a star.', '= one of many stars', 5),
  ('A', 'What''s the best way to learn a language?', null, 6),
  ('B', 'Your sweater is the same colour as mine. (not is same colour)', null, 0),
  ('B', '''Are these keys the same?'' ''No, they''re different.''', null, 1),
  ('C', 'I love to look at the stars in the sky. (not in sky)', null, 0),
  ('C', 'Do you live in a town or in the country?', null, 1),
  ('C', 'The earth goes round the sun, and the moon goes round the earth.', null, 2),
  ('C', 'Which is the planet nearest Earth?', null, 3),
  ('C', 'There are millions of stars in space. (not in the space)', null, 4),
  ('C', 'I tried to park my car, but the space was too small.', null, 5),
  ('D', 'I go to the cinema a lot, but I haven''t been to the theatre for ages.', null, 0),
  ('D', 'I watch TV a lot, but I don''t listen to the radio much.', null, 1),
  ('D', 'Can you turn off the television, please?', '= the TV set', 2),
  ('D', 'The internet has changed the way we live.', null, 3),
  ('E', 'What did you have for breakfast?', null, 0),
  ('E', 'We had lunch in a very nice restaurant.', null, 1),
  ('E', 'We had a very nice lunch. (not We had very nice lunch)', null, 2),
  ('F', 'Our train leaves from platform 5. (not the platform 5)', null, 0),
  ('F', 'Do you have these shoes in size 43? (not the size 43)', null, 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 73.1-73.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '73.1', 'Put in the or a where necessary. If no word is necessary, leave the space empty.', 0
from units where slug = 'unit-73';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-73' where es.title = '73.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A: Our apartment is on the tenth floor. B: Is it? I hope there''s {0} lift.', null),
  (2, 'A: Did you have {0} nice holiday? B: Yes, it was {1} best holiday I''ve ever had.', null),
  (3, 'A: Where''s {0} nearest shop? B: There''s one at {1} end of this street.', null),
  (4, 'A: It''s {0} lovely day, isn''t it? B: Yes, there isn''t {1} cloud in {2} sky.', null),
  (5, 'A: We spent all our money because we stayed at {0} most expensive hotel in town. B: Why didn''t you stay at {1} cheaper hotel?', null),
  (6, 'A: Would you like to travel in {0} space? B: Yes, I''d love to go to {1} moon.', 'first blank: no word needed'),
  (7, 'A: What did you think of {0} movie last night? B: It was OK, but I thought {1} ending was a bit strange.', null),
  (8, 'A: What''s Jupiter? Is it {0} star? B: No, it''s {1} planet. It''s {2} largest planet in {3} solar system.', null)
) as v(n, template, hint)
where es.title = '73.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '73.1'
join (values
  (1, 0, 'a'),
  (2, 0, 'a'), (2, 1, 'the'),
  (3, 0, 'the'), (3, 1, 'the'),
  (4, 0, 'a'), (4, 1, 'a'), (4, 2, 'the'),
  (5, 0, 'the'), (5, 1, 'a'),
  (6, 0, ''), (6, 1, 'the'),
  (7, 0, 'the'), (7, 1, 'the'),
  (8, 0, 'a'), (8, 1, 'a'), (8, 2, 'the'), (8, 3, 'the')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '73.2', 'Which is right? (For the, see also Unit 72.)', 1
from units where slug = 'unit-73';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-73' where es.title = '73.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sarah spends most of her free time watching {0}.', 'TV / the TV'),
  (2, 'Do you ever listen to {0}?', 'radio / the radio'),
  (3, '{0} was on, but nobody was watching it.', 'Television / The television'),
  (4, 'Have you had {0} yet?', 'dinner / the dinner'),
  (5, 'It''s confusing when two people have {0}.', 'same name / the same name'),
  (6, 'What do you want {0}?', 'for breakfast / for the breakfast'),
  (7, 'Fruit is an important source of {0}.', 'vitamin C / the vitamin C'),
  (8, 'This computer is not connected to {0}.', 'internet / the internet'),
  (9, 'I lay down on {0} and looked up at {1}.', 'ground / the ground ... sky / the sky'),
  (10, '{0} to London leaves from {1}.', 'Next train / The next train ... platform 3 / the platform 3')
) as v(n, template, hint)
where es.title = '73.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '73.2'
join (values
  (1, 0, 'TV'), (2, 0, 'the radio'), (3, 0, 'The television'), (4, 0, 'dinner'),
  (5, 0, 'the same name'), (6, 0, 'for breakfast'), (7, 0, 'vitamin C'), (8, 0, 'the internet'),
  (9, 0, 'the ground'), (9, 1, 'the sky'),
  (10, 0, 'The next train'), (10, 1, 'platform 3')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '73.3', 'Put in the or a where necessary. (For a and the see also Units 71-72.)', 2
from units where slug = 'unit-73';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-73' where es.title = '73.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m fed up with doing {0} every day.', 'same thing'),
  (2, 'Room 25 is on {0}.', 'second floor'),
  (3, 'It was {0}. It was {1}.', 'very hot day ... hottest day of the year'),
  (4, 'We had lunch in {0} by {1}.', 'nice restaurant ... sea'),
  (5, 'What''s on at {0} this week?', 'cinema'),
  (6, 'I had {0} this morning.', 'big breakfast'),
  (7, 'You''ll find {0} you need at {1} of page 15.', 'information ... top')
) as v(n, template, hint)
where es.title = '73.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '73.3'
join (values
  (1, 0, 'the same thing'), (2, 0, 'the second floor'),
  (3, 0, 'a very hot day'), (3, 1, 'the hottest day of the year'),
  (4, 0, 'a nice restaurant'), (4, 1, 'the sea'),
  (5, 0, 'the cinema'), (6, 0, 'a big breakfast'),
  (7, 0, 'the information'), (7, 1, 'the top')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '73.4', 'Complete the sentences. Choose from the box and use the where necessary: breakfast, cinema, gate, Gate 24, lunch, question, question 3, sea.', 3
from units where slug = 'unit-73';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-73' where es.title = '73.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There was no wind, so {0} was very calm.', 'sea'),
  (2, 'Most of the questions in the test were OK, but I couldn''t answer {0}.', 'question 3'),
  (3, '''I''m going to {0} tonight.'' ''Are you? What are you going to see?''', 'cinema'),
  (4, 'I''m sorry, but could you repeat {0}, please?', 'question'),
  (5, 'I didn''t have {0} this morning because I was in a hurry.', 'breakfast'),
  (6, '(Airport announcement) Flight AB123 to Rome is now boarding at {0}.', 'Gate 24'),
  (7, 'I forgot to shut {0}. Can you shut it for me?', 'gate')
) as v(n, template, hint)
where es.title = '73.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '73.4'
join (values
  (1, 'the sea'), (2, 'question 3'), (3, 'the cinema'), (4, 'the question'),
  (5, 'breakfast'), (6, 'Gate 24'), (7, 'the gate')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
