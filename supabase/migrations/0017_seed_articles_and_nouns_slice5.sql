-- Marco 4 (slice 16): seeds the fifth and final slice of the "Articles and
-- nouns" module — units 79-81 (Singular and plural, Noun + noun (a bus
-- driver / a headache), -'s (your sister's name) and of ... (the name of
-- the book)). This completes the module (units 69-81, all five slices).
--
-- Sourced from pdf/Modulos/Articles and nouns.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (re-extracted without -layout for the relevant pages, same workaround as
-- the last three slices).
--
-- 79.5 has TWO worked examples (items 1 and 2, same gotcha as 69.2/69.3/
-- 71.1/71.2/77.2 in prior slices) — confirmed via the Key, which starts
-- numbering at item 3. 79.1, 79.2, 79.4, 80.1, 80.2, 80.3, 80.4, 81.1,
-- 81.3 and 81.4 each have the usual single worked example. All renumbered
-- from 1 in this migration's DB rows.
--
-- 81.1 ("it is more natural to use -'s or -'... change where necessary")
-- uses the "OK convention" from unit-3's 3.1 again: several of its items
-- are already natural as given.
--
-- Unit title 81 is genuinely two joined topics in one book chapter —
-- confirmed via `pdftotext -layout`'s own page header, which prints "-'s
-- (your sister's name) and of ... (the name of the book)" split across two
-- lines before the "81" heading. Kept as a single unit (matching the
-- book), covering both -'s and of ... in one set of theory sections.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 79: Singular and plural
-- ============================================================

delete from units where slug = 'unit-79';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 79, 'unit-79', 'Singular and plural', null,
  'Some nouns are always plural (trousers, glasses, scissors) and take a plural verb; -ics words (athletics, politics) are not usually plural; and means/series/species can be singular or plural. Group nouns (government, family, team, police) often take a plural verb. We say people, not persons, and we use a singular verb for a sum of money, a period of time or a distance.', 10
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'plural nouns with two parts (trousers, glasses, scissors)',
  'Sometimes we use a plural noun for one thing that has two parts: trousers (two legs), pyjamas, glasses, binoculars, scissors — also jeans/tights/shorts/pants (top and bottom). These words are plural, so they take a plural verb: My trousers are too long (not My trousers is). You can also use a pair of + these words: Those are nice jeans, or That''s a nice pair of jeans (not a nice jeans). I need some new glasses, or I need a new pair of glasses.', 0
from units where slug = 'unit-79';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', '-ics words (not usually plural); means/series/species (either)',
  'Some nouns end in -ics, but are not usually plural: athletics, gymnastics, economics, politics, physics, electronics, maths (= mathematics). Gymnastics is my favourite sport (not Gymnastics are). News is not plural: I have some news for you. It''s good news! Some words that end in -s can be singular or plural: means — a means of transport, many means of transport; series — a TV series, two TV series; species — a species of fish, 200 species of fish.', 1
from units where slug = 'unit-79';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'group nouns (government, family, team) often take a plural verb',
  'Some singular nouns are often used with a plural verb: audience, committee, company, family, firm, government, staff, team. These nouns are all groups of people. We often think of them as a number of people (= they), not as one thing (= it), so we often use a plural verb: The government (= they) have decided to increase taxes. The staff at the company (= they) are not happy with their working conditions. In the same way, we often use a plural verb after the name of a company or a sports team: Shell have increased the price of petrol. Italy are playing Brazil next Sunday. You can also use a singular verb (The government wants ... / Shell has ... etc.). We use a plural verb with police: The police are investigating the crime, but haven''t arrested anyone yet (not The police is ... hasn''t). Note that we say a police officer / a policeman / a policewoman (not a police).', 2
from units where slug = 'unit-79';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'people, not persons',
  'We do not often use the plural of person (persons). We normally use people (a plural word): He''s a nice person, but They are nice people (not nice persons). Many people don''t have enough to eat (not Many people doesn''t).', 3
from units where slug = 'unit-79';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'a sum of money/period of time/distance: singular verb',
  'We think of a sum of money, a period of time, a distance etc. as one thing, so we use a singular verb: Fifty thousand pounds (= it) was stolen in the robbery (not were stolen). Three years (= it) is a long time to be without a job (not Three years are). Two miles isn''t very far to walk.', 4
from units where slug = 'unit-79';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-79'
join (values
  ('A', 'My trousers are too long. (not My trousers is)', null, 0),
  ('A', 'Those are nice jeans. or That''s a nice pair of jeans. (not a nice jeans)', null, 1),
  ('A', 'I need some new glasses. or I need a new pair of glasses.', null, 2),
  ('B', 'Gymnastics is my favourite sport. (not Gymnastics are)', null, 0),
  ('B', 'I have some news for you. It''s good news!', null, 1),
  ('B', 'a means of transport', 'singular', 2),
  ('B', 'many means of transport', 'plural', 3),
  ('B', 'a TV series', 'singular', 4),
  ('B', 'two TV series', 'plural', 5),
  ('B', 'a species of fish', 'singular', 6),
  ('B', '200 species of fish', 'plural', 7),
  ('C', 'The government have decided to increase taxes.', null, 0),
  ('C', 'The staff at the company are not happy with their working conditions.', null, 1),
  ('C', 'Shell have increased the price of petrol.', null, 2),
  ('C', 'Italy are playing Brazil next Sunday.', null, 3),
  ('C', 'The police are investigating the crime, but haven''t arrested anyone yet.', null, 4),
  ('C', 'a police officer / a policeman / a policewoman', 'not a police', 5),
  ('D', 'He''s a nice person.', null, 0),
  ('D', 'They are nice people. (not nice persons)', null, 1),
  ('D', 'Many people don''t have enough to eat. (not Many people doesn''t)', null, 2),
  ('E', 'Fifty thousand pounds was stolen in the robbery. (not were stolen)', null, 0),
  ('E', 'Three years is a long time to be without a job. (not Three years are)', null, 1),
  ('E', 'Two miles isn''t very far to walk.', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 79.1-79.5)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '79.1', 'Complete the sentences. Choose from the box: a, are, doesn''t, don''t, it, pair, some, them.', 0
from units where slug = 'unit-79';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-79' where es.title = '79.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The trousers you bought for me {0} fit me.', null),
  (2, 'The jacket you bought for me {0} fit me.', null),
  (3, 'I need {0} scissors to cut this piece of material.', null),
  (4, 'I can''t find my binoculars. Have you seen {0}?', null),
  (5, 'I went shopping and bought a {0} of jeans.', null),
  (6, 'Where {0} my sunglasses?', null),
  (7, 'I went shopping and bought {0} pair of pyjamas.', null),
  (8, 'I don''t know much about politics. I''m not interested in {0}.', null)
) as v(n, template, hint)
where es.title = '79.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '79.1'
join (values
  (1, 'don''t'), (2, 'doesn''t'), (3, 'some'), (4, 'them'),
  (5, 'pair'), (6, 'are'), (7, 'a'), (8, 'it')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '79.2', 'Complete the sentences. Use a word from section B (news, series etc.).', 1
from units where slug = 'unit-79';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-79' where es.title = '79.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The bicycle is a {0} of transport.', null),
  (2, 'A lot of American TV {0} are shown in other countries.', null),
  (3, 'The tiger is an endangered {0}.', null),
  (4, 'There will be a {0} of meetings to discuss the problem.', null),
  (5, 'Fortunately the {0} wasn''t as bad as we expected.', null),
  (6, 'How many {0} of bird are there in the world?', null),
  (7, 'I didn''t have my phone, so I had no {0} of contacting you.', null)
) as v(n, template, hint)
where es.title = '79.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '79.2'
join (values
  (1, 'means'), (2, 'series'), (3, 'species'), (4, 'series'),
  (5, 'news'), (6, 'species'), (7, 'means')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '79.3', 'Choose the correct form of the verb, singular or plural. In three sentences either the singular or plural verb is possible.', 2
from units where slug = 'unit-79';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-79' where es.title = '79.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My new glasses {0} fit very well.', 'doesn''t / don''t'),
  (2, 'The police {0} to interview two men about the robbery.', 'want / wants'),
  (3, 'Physics {0} my favourite subject at school.', 'was / were'),
  (4, 'It''s a nice place to visit. The people {0} very friendly.', 'is / are'),
  (5, 'Germany {0} playing Spain tomorrow night. Are you going to watch it?', 'is or are — both acceptable'),
  (6, '{0} the police know how the accident happened?', 'Does / Do'),
  (7, 'Where {0} your family live?', 'do or does — both acceptable'),
  (8, 'Most people {0} music.', 'enjoy / enjoys'),
  (9, 'I like this cafe. The staff here {0} really friendly and efficient.', 'is or are — both acceptable')
) as v(n, template, hint)
where es.title = '79.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '79.3'
join (values
  (1, 'don''t', array[]::text[]), (2, 'want', array[]::text[]), (3, 'was', array[]::text[]),
  (4, 'are', array[]::text[]), (5, 'is', array['are']::text[]), (6, 'Do', array[]::text[]),
  (7, 'do', array['does']::text[]), (8, 'enjoy', array[]::text[]), (9, 'is', array['are']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '79.4', 'Complete the sentences. Use is or isn''t, and choose from the box: a lot to carry, enough money, too hot, long enough.', 3
from units where slug = 'unit-79';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-79' where es.title = '79.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Thirty degrees {0} for Tom. He doesn''t like hot weather.', null),
  (2, 'Ten dollars {0}. We need more than that.', null),
  (3, 'Four days {0} for a holiday. You need at least a week.', null),
  (4, 'Twenty kilos {0}. Are you sure you can manage?', null)
) as v(n, template, hint)
where es.title = '79.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '79.4'
join (values
  (1, 'is too hot'), (2, 'isn''t enough money'), (3, 'isn''t long enough'), (4, 'is a lot to carry')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '79.5', 'Are these sentences OK? Correct them where necessary.', 4
from units where slug = 'unit-79';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-79' where es.title = '79.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Susan was wearing {0}.', 'no article needed'),
  (2, 'I like Martin and Jane. {0}', 'not persons'),
  (3, 'I''m going to buy some new {0}.', 'always plural, OK as given'),
  (4, 'There was {0} directing traffic in the street.', 'not "a police"'),
  (5, '{0} scissors {1} very sharp.', 'This/These ... isn''t/aren''t'),
  (6, 'The company {0} decided to open a new factory.', 'have or has — both OK'),
  (7, 'This plant is {0}.', 'species can be singular'),
  (8, 'Twelve hours {0} a long time to be on a plane.', 'not are')
) as v(n, template, hint)
where es.title = '79.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '79.5'
join (values
  (1, 0, 'black jeans', array[]::text[]),
  (2, 0, 'They''re very nice people.', array[]::text[]),
  (3, 0, 'pyjamas', array[]::text[]),
  (4, 0, 'a police officer', array['a policeman', 'a policewoman']::text[]),
  (5, 0, 'These', array[]::text[]), (5, 1, 'aren''t', array[]::text[]),
  (6, 0, 'have', array['has']::text[]),
  (7, 0, 'a very rare species', array[]::text[]),
  (8, 0, 'is', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 80: Noun + noun (a bus driver / a headache)
-- ============================================================

delete from units where slug = 'unit-80';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 80, 'unit-80', 'Noun + noun (a bus driver / a headache)', null,
  'You can use two nouns together (noun + noun) so the first noun acts like an adjective: a bus driver, income tax, an apple tree. The first noun is normally singular even when the meaning is plural: a car park, a three-hour journey (not a three hours journey).', 11
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'noun + noun: the first noun is like an adjective',
  'You can use two nouns together (noun + noun) to mean one thing/person/idea etc.: a bus driver, income tax, the city centre, an apple tree. The first noun is like an adjective — it tells us what kind of thing/person/idea etc.: a bus driver = the driver of a bus; income tax = tax that you pay on your income; the city centre = the centre of the city; an apple tree = a tree that has apples; a Paris hotel = a hotel in Paris; my life story = the story of my life. So you can say: a television camera, a television programme, a television studio, a television producer (things or people to do with television); language problems, marriage problems, health problems, work problems (different kinds of problems). Sometimes the first word ends in -ing: a frying pan (= a pan for frying), a washing machine, a swimming pool.', 0
from units where slug = 'unit-80';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'more than two nouns together',
  'Sometimes there are more than two nouns together: I waited at the hotel reception desk. We watched the World Swimming Championships on TV. If you want to play table tennis (= a game), you need a table tennis table (= a table).', 1
from units where slug = 'unit-80';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'one word or two?',
  'When two nouns are together like this, sometimes we write them as one word and sometimes as two separate words. For example: a headache, toothpaste, a weekend, a car park, a road sign. There are no clear rules for this. If you are not sure, write two words.', 2
from units where slug = 'unit-80';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'a coffee cup vs. a cup of coffee',
  'Note the difference between: a coffee cup (maybe empty) and a cup of coffee (= a cup with coffee in it); a shopping bag (maybe empty) and a bag of shopping (= a bag full of shopping).', 3
from units where slug = 'unit-80';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'the first noun stays singular (a three-hour journey)',
  'When we use noun + noun, the first noun is like an adjective. It is normally singular, but the meaning is often plural — for example, a car park is a place to park cars, an apple tree is a tree that has apples. In the same way we say: a three-hour journey (= a journey that takes three hours), a ten-pound note (= a note with the value of ten pounds), a four-week course, a six-mile walk, two 14-year-old girls. Compare: It was a four-week course (not a four weeks course), but The course lasted four weeks.', 4
from units where slug = 'unit-80';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-80'
join (values
  ('A', 'a bus driver', '= the driver of a bus', 0),
  ('A', 'income tax', '= tax that you pay on your income', 1),
  ('A', 'the city centre', '= the centre of the city', 2),
  ('A', 'an apple tree', '= a tree that has apples', 3),
  ('A', 'a Paris hotel', '= a hotel in Paris', 4),
  ('A', 'my life story', '= the story of my life', 5),
  ('A', 'a frying pan', '= a pan for frying', 6),
  ('A', 'a washing machine', null, 7),
  ('A', 'a swimming pool', null, 8),
  ('B', 'I waited at the hotel reception desk.', null, 0),
  ('B', 'We watched the World Swimming Championships on TV.', null, 1),
  ('B', 'If you want to play table tennis, you need a table tennis table.', null, 2),
  ('C', 'a headache', null, 0),
  ('C', 'toothpaste', null, 1),
  ('C', 'a weekend', null, 2),
  ('C', 'a car park', null, 3),
  ('C', 'a road sign', null, 4),
  ('D', 'a coffee cup', 'maybe empty', 0),
  ('D', 'a cup of coffee', '= a cup with coffee in it', 1),
  ('D', 'a shopping bag', 'maybe empty', 2),
  ('D', 'a bag of shopping', '= a bag full of shopping', 3),
  ('E', 'a three-hour journey', '= a journey that takes three hours', 0),
  ('E', 'a ten-pound note', '= a note with the value of ten pounds', 1),
  ('E', 'a four-week course', null, 2),
  ('E', 'a six-mile walk', null, 3),
  ('E', 'two 14-year-old girls', null, 4),
  ('E', 'It was a four-week course. (not a four weeks course)', null, 5),
  ('E', 'The course lasted four weeks.', null, 6)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 80.1-80.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '80.1', 'What do we call these things and people?', 0
from units where slug = 'unit-80';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-80' where es.title = '80.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A ticket to travel by train is a {0}.', null),
  (2, 'A machine you use to get a ticket is a {0}.', null),
  (3, 'The staff at a hotel are the {0}.', null),
  (4, 'The results of your exams are your {0}.', null),
  (5, 'A horse that runs in races is a {0}.', null),
  (6, 'A race for horses is a {0}.', null),
  (7, 'Shoes for running are {0}.', null),
  (8, 'A shop that sells shoes is a {0}.', null),
  (9, 'The window of a shop is a {0}.', null),
  (10, 'A person who cleans windows is a {0}.', null),
  (11, 'A scandal involving a construction company is {0}.', null),
  (12, 'Workers at a car factory are {0}.', null),
  (13, 'A scheme for the improvement of a road is a {0}.', null),
  (14, 'A department store in New York is a {0}.', null)
) as v(n, template, hint)
where es.title = '80.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '80.1'
join (values
  (1, 'train ticket'), (2, 'ticket machine'), (3, 'hotel staff'), (4, 'exam results'),
  (5, 'race horse'), (6, 'horse race'), (7, 'running shoes'), (8, 'shoe shop'),
  (9, 'shop window'), (10, 'window cleaner'), (11, 'a construction company scandal'),
  (12, 'car factory workers'), (13, 'road improvement scheme'), (14, 'New York department store')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '80.2', 'Answer the questions using two of the following words each time: belt, birthday, card, credit, driver, forecast, machine, number, party, ring, room, truck, washing, weather, wedding.', 1
from units where slug = 'unit-80';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-80' where es.title = '80.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You should wear this when you''re driving. {0}', null),
  (2, 'You can use this to pay for things. {0}', null),
  (3, 'This will tell you if it''s going to rain or not. {0}', null),
  (4, 'This is useful if you have a lot of dirty clothes. {0}', null),
  (5, 'This is something you might wear if you''re married. {0}', null),
  (6, 'If you''re staying at a hotel, you need to remember this. {0}', null),
  (7, 'This is a way to celebrate getting older. {0}', null),
  (8, 'This person transports things by road. {0}', null)
) as v(n, template, hint)
where es.title = '80.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '80.2'
join (values
  (1, 'a seat belt'), (2, 'a credit card'), (3, 'the weather forecast'), (4, 'a washing machine'),
  (5, 'a wedding ring'), (6, 'your room number'), (7, 'a birthday party'), (8, 'a truck driver')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '80.3', 'Put the words in the right order.', 2
from units where slug = 'unit-80';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-80' where es.title = '80.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Jack likes sport. He plays for his {0}.', 'team / school / football'),
  (2, 'Anna works for a {0}.', 'company / production / film'),
  (3, 'Many people invest in a {0}.', 'life / policy / insurance'),
  (4, 'You can get a map at the {0}.', 'information / office / tourist')
) as v(n, template, hint)
where es.title = '80.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '80.3'
join (values
  (1, 'school football team'), (2, 'film production company'),
  (3, 'life insurance policy'), (4, 'tourist information office')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '80.4', 'Which is correct?', 3
from units where slug = 'unit-80';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-80' where es.title = '80.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s only a {0} flight from London to Madrid.', 'two-hour / two hours'),
  (2, 'It took only {0} to fly to Madrid.', 'two hour / two hours'),
  (3, 'I don''t have any change. I only have a {0} note.', 'twenty-pound / twenty pounds'),
  (4, 'I looked down and there were two {0} notes on the ground.', 'ten-pound / ten pounds'),
  (5, 'At work in the morning we usually have a {0} break for coffee.', '15-minute / 15 minutes'),
  (6, 'There are {0} in an hour.', '60-minute / 60 minutes'),
  (7, 'My office is on the tenth floor of a {0} building.', 'twelve-storey / twelve storeys'),
  (8, 'I work {0} a week. Saturday and Sunday are free.', 'five-day / five days'),
  (9, '{0} hotels are the most expensive.', 'Five-star / Five stars'),
  (10, 'Sam''s daughter is {0}.', 'six-year-old / six years old'),
  (11, 'Sam has a {0} daughter.', 'six-year-old / six-years-old')
) as v(n, template, hint)
where es.title = '80.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '80.4'
join (values
  (1, 'two-hour'), (2, 'two hours'), (3, 'twenty-pound'), (4, 'ten-pound'),
  (5, '15-minute'), (6, '60 minutes'), (7, 'twelve-storey'), (8, 'five days'),
  (9, 'Five-star'), (10, 'six years old'), (11, 'six-year-old')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 81: -'s (your sister's name) and of ... (the name of the book)
-- ============================================================

delete from units where slug = 'unit-81';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 81, 'unit-81', '-''s (your sister''s name) and of ... (the name of the book)', null,
  'We use -''s mostly for people and animals (Tom''s computer, the cat''s tail); for things and ideas we normally use of (the name of the book, the top of the hill). Either -''s or of is often possible for organisations and places (the government''s decision / the decision of the government). We also use -''s with time words and periods of time (yesterday''s newspaper, three weeks'' holiday).', 12
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', '-''s mostly for people and animals',
  'We use -''s (apostrophe + s) mostly for people or animals: Tom''s computer isn''t working (not the computer of Tom). How old are Chris''s children? (not the children of Chris). What''s your sister''s name? What''s Tom''s sister''s name? Be careful. Don''t step on the cat''s tail. You can use -''s without a noun after it: This isn''t my book. It''s my sister''s (= my sister''s book). We do not use -''s after a long group of words — so we say my friend''s mother, but the mother of the man we met yesterday (not the man we met yesterday''s mother). Note that we say a woman''s hat (= a hat for a woman), a boy''s name (= a name for a boy), a bird''s egg (= an egg laid by a bird) etc.', 0
from units where slug = 'unit-81';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'singular -''s vs. plural -s''',
  'With a singular noun we use -''s: my sister''s room (= her room, one sister), Mr Carter''s house (= his house). With a plural noun (sisters, friends etc.) we put an apostrophe ('') after s: my sisters'' room (= their room, two or more sisters), the Carters'' house (= their house, Mr and Mrs Carter). If a plural noun does not end in -s (men/women/children/people) we use -''s: the men''s changing room, a children''s book (= a book for children). You can use -''s after more than one noun: Jack and Karen''s children, Mr and Mrs Carter''s house.', 1
from units where slug = 'unit-81';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'of ... for things and ideas',
  'For things, ideas etc., we normally use of: the temperature of the water (not the water''s temperature), the name of the book, the owner of the restaurant. We say the beginning/end/middle of ..., the top/bottom of ..., the front/back/side of ...: the beginning of the month (not the month''s beginning), the top of the hill, the back of the car.', 2
from units where slug = 'unit-81';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'organisations and places: -''s or of',
  'You can usually use -''s or of ... for an organisation (= a group of people). So you can say: the government''s decision or the decision of the government; the company''s success or the success of the company. We also use -''s for places: the city''s streets, the world''s population, Italy''s prime minister.', 3
from units where slug = 'unit-81';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', '-''s with time words and periods of time',
  'We use -''s with time words (yesterday / next week etc.): Do you still have yesterday''s newspaper? Next week''s meeting has been cancelled. In the same way, you can say today''s / tomorrow''s / this evening''s / Monday''s etc. We also use -''s (or -s'' with plural words) with periods of time: I''ve got a week''s holiday starting on Monday. Julia has got three weeks'' holiday. I live near the station — it''s only ten minutes'' walk.', 4
from units where slug = 'unit-81';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-81'
join (values
  ('A', 'Tom''s computer isn''t working. (not the computer of Tom)', null, 0),
  ('A', 'How old are Chris''s children? (not the children of Chris)', null, 1),
  ('A', 'It''s my sister''s. (= my sister''s book)', null, 2),
  ('A', 'my friend''s mother', 'short group of words, uses -''s', 3),
  ('A', 'the mother of the man we met yesterday', 'long group of words, uses of', 4),
  ('A', 'a woman''s hat', '= a hat for a woman', 5),
  ('A', 'a bird''s egg', '= an egg laid by a bird', 6),
  ('B', 'my sister''s room', '= her room, one sister', 0),
  ('B', 'my sisters'' room', '= their room, two or more sisters', 1),
  ('B', 'the men''s changing room', null, 2),
  ('B', 'a children''s book', '= a book for children', 3),
  ('B', 'Jack and Karen''s children', null, 4),
  ('C', 'the temperature of the water', 'not the water''s temperature', 0),
  ('C', 'the name of the book', null, 1),
  ('C', 'the beginning of the month', 'not the month''s beginning', 2),
  ('C', 'the top of the hill', null, 3),
  ('D', 'the government''s decision', 'or the decision of the government', 0),
  ('D', 'the company''s success', 'or the success of the company', 1),
  ('D', 'the world''s population', null, 2),
  ('D', 'Italy''s prime minister', null, 3),
  ('E', 'Do you still have yesterday''s newspaper?', null, 0),
  ('E', 'Next week''s meeting has been cancelled.', null, 1),
  ('E', 'I''ve got a week''s holiday starting on Monday.', null, 2),
  ('E', 'Julia has got three weeks'' holiday.', null, 3),
  ('E', 'it''s only ten minutes'' walk', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 81.1-81.4; 81.1 uses the "OK convention"
-- from unit-3's 3.1)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '81.1', 'In some of these sentences, it is more natural to use -''s or -''. Change the underlined parts where necessary.', 0
from units where slug = 'unit-81';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-81' where es.title = '81.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Is this {0}?', 'the umbrella of your friend'),
  (2, 'Write your name at {0}.', 'OK — no change needed'),
  (3, 'I''ve never met {0}.', 'the daughter of James'),
  (4, 'How old is {0}?', 'the son of Helen and Andy'),
  (5, 'We don''t know {0}.', 'OK — no change needed'),
  (6, 'I don''t know {0}.', 'OK — no change needed'),
  (7, '{0} are here.', 'the friends of your children'),
  (8, 'What is {0}?', 'OK — no change needed'),
  (9, '{0} is very small.', 'the garden of our neighbours'),
  (10, '{0} is very long.', 'the hair of David'),
  (11, 'I work on {0}.', 'OK — no change needed'),
  (12, 'I couldn''t go to {0}.', 'the party of my best friend'),
  (13, 'George is {0}.', 'OK — no change needed'),
  (14, 'Have you seen {0}?', 'the car of the parents of Ben'),
  (15, 'What is {0}?', 'OK — no change needed'),
  (16, 'Do you agree with {0}?', 'either form is OK')
) as v(n, template, hint)
where es.title = '81.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '81.1'
join (values
  (1, 'your friend''s umbrella', array[]::text[]),
  (2, 'the top of the page', array[]::text[]),
  (3, 'James''s daughter', array[]::text[]),
  (4, 'Helen and Andy''s son', array[]::text[]),
  (5, 'the cause of the problem', array[]::text[]),
  (6, 'the words of this song', array[]::text[]),
  (7, 'Your children''s friends', array[]::text[]),
  (8, 'the cost of a new washing machine', array[]::text[]),
  (9, 'Our neighbours'' garden', array[]::text[]),
  (10, 'David''s hair', array[]::text[]),
  (11, 'the ground floor of the building', array[]::text[]),
  (12, 'my best friend''s party', array[]::text[]),
  (13, 'the brother of somebody I knew at college', array[]::text[]),
  (14, 'Ben''s parents'' car', array[]::text[]),
  (15, 'the meaning of this expression', array[]::text[]),
  (16, 'the policy of the government', array['the government''s policy']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '81.2', 'Which is right?', 1
from units where slug = 'unit-81';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-81' where es.title = '81.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s my {0} birthday tomorrow.', 'father / father''s / fathers'''),
  (2, 'Those {0} look nice. Shall we buy some?', 'apples / apple''s / apples'''),
  (3, '{0} clothes are expensive.', 'Children / Children''s / Childrens'''),
  (4, 'Zurich is {0} largest city.', 'Switzerland / Switzerland''s / Switzerlands'''),
  (5, 'Your {0} parents are your grandparents.', 'parents / parent''s / parents'''),
  (6, 'I took a lot of {0} when I was on holiday.', 'photos / photo''s / photos'''),
  (7, 'This isn''t my coat. It''s {0}.', 'someone else / someone else''s / someone elses'''),
  (8, 'Have you read any of {0} poems?', 'Shakespeare / Shakespeare''s / Shakespeares''')
) as v(n, template, hint)
where es.title = '81.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '81.2'
join (values
  (1, 'father''s'), (2, 'apples'), (3, 'Children''s'), (4, 'Switzerland''s'),
  (5, 'parents'''), (6, 'photos'), (7, 'someone else''s'), (8, 'Shakespeare''s')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '81.3', 'Read each sentence and write a new sentence beginning with the underlined words.', 2
from units where slug = 'unit-81';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-81' where es.title = '81.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The storm last week caused a lot of damage. {0}', 'begin with "Last..."'),
  (2, 'The only cinema in the town has closed down. {0}', 'begin with "The town''s..."'),
  (3, 'The weather in Britain is very changeable. {0}', 'begin with "Britain''s..."'),
  (4, 'Tourism is the main industry in the region. {0}', 'begin with "The region''s..."')
) as v(n, template, hint)
where es.title = '81.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '81.3'
join (values
  (1, 'Last week''s storm caused a lot of damage.'),
  (2, 'The town''s only cinema has closed down.'),
  (3, 'Britain''s weather is very changeable.'),
  (4, 'The region''s main industry is tourism.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '81.4', 'Use the information given to complete the sentences.', 3
from units where slug = 'unit-81';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-81' where es.title = '81.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'If I leave my house at 8.40 and walk to the centre, I get there at 9 o''clock. So it''s {0} from my house to the centre. (walk)', null),
  (2, 'I''m going on holiday on the 12th. I have to be back at work on the 26th. So I''ve got {0}. (holiday)', null),
  (3, 'I went to sleep at 3 o''clock this morning and woke up an hour later. After that I couldn''t sleep. So last night I only had {0}. (sleep)', null)
) as v(n, template, hint)
where es.title = '81.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '81.4'
join (values
  (1, 'twenty minutes'' walk', array[]::text[]),
  (2, 'two weeks'' holiday', array['fourteen days'' holiday', 'a fortnight''s holiday']::text[]),
  (3, 'an hour''s sleep', array['one hour''s sleep']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
