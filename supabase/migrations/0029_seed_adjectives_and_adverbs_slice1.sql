-- Marco 4 (slice 28): seeds the first slice of the "Adjectives and
-- adverbs" module — units 98 (Adjectives ending in -ing and -ed) and 99
-- (Adjectives: a nice new house, you look tired).
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- Grepped unit-number headers across the whole file before assuming its
-- range (same check applied to every oversized PDF since Modals.pdf): this
-- file spans units 98-112 (15 units, confirmed no "113" header). Following
-- the -ing-and-to / Articles-and-nouns / Pronouns-and-determiners /
-- Relative-clauses precedent, kept as ONE module (`adjectives-and-adverbs`),
-- seeded across multiple migration slices. The module row uses
-- `on conflict (slug) do nothing` so later slices can extend it safely.
-- Slicing thematically in pairs of closely-related units (98-99, 100-101,
-- 102-103, 105-106, 107-108, 109-110, 111-112) with unit 104 alone, per
-- Igor's request to size each slice by judgment rather than a fixed rule.
--
-- 98.1 ("Complete the sentences for each situation. Use the word in
-- brackets + -ing or -ed") has multi-part items (a/b/c) sharing one
-- bracketed word — flattened into individual single-blank exercise items,
-- keeping the situation context on the first sub-item of each group.
--
-- 98.2 ("Choose the correct word") items 10-12 (renumbered 9-11) each have
-- TWO blanks in the same sentence, unlike the rest of the exercise.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('adjectives-and-adverbs', 'Adjectives and adverbs', 12)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 98: Adjectives ending in -ing and -ed (boring/bored etc.)
-- ============================================================

delete from units where slug = 'unit-98';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 98, 'unit-98', 'Adjectives ending in -ing and -ed (boring/bored etc.)', null,
  'Many adjectives end in -ing and -ed, for example boring and bored. Somebody is bored (or gets bored) if something is boring: Jane is bored because her job is boring. (not Jane is boring) The -ing adjective describes the thing or situation itself; the -ed adjective describes how somebody feels about it. If a person is boring, that means they make other people bored.', 0
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'boring and bored',
  'Study this example situation: Jane has been doing the same job for a very long time. Every day she does exactly the same thing again and again. She doesn''t enjoy her job any more and would like to do something different. Jane''s job is boring. Jane is bored with her job. Somebody is bored or gets bored if something (or somebody else) is boring. If something is boring, you get bored with it. So: Jane is bored because her job is boring. Jane''s job is boring, so Jane is bored. (not Jane is boring) If a person is boring, this means that they make other people bored: Paul always talks about the same things. He''s really boring.', 0
from units where slug = 'unit-98';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'comparing -ing and -ed adjectives',
  'Compare adjectives ending in -ing and -ed: My job is boring/interesting/tiring/satisfying/depressing (etc.) — I''m bored with my job. / I''m not interested in my job any more. / I get very tired doing my job. / I''m not satisfied with my job. / My job makes me depressed. (etc.) In these examples, the -ing adjective tells you about the job; the -ed adjective tells you how somebody feels (about the job). Compare these examples: Julia thinks politics is interesting. Did you meet anyone interesting at the party? It was surprising that he passed the exam. The movie was disappointing. We expected it to be better. The news was shocking. Julia is interested in politics. (not interesting in politics) Are you interested in buying a car? I''m trying to sell mine. Everybody was surprised that he passed the exam. We were disappointed with the movie. We expected it to be better. I was shocked when I heard the news.', 1
from units where slug = 'unit-98';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-98'
join (values
  ('A', 'Jane''s job is boring.', null, 0),
  ('A', 'Jane is bored with her job.', null, 1),
  ('A', 'Jane is bored because her job is boring.', null, 2),
  ('A', 'Jane''s job is boring, so Jane is bored.', 'not Jane is boring', 3),
  ('A', 'Paul always talks about the same things. He''s really boring.', null, 4),
  ('B', 'I''m bored with my job.', 'my job is boring', 0),
  ('B', 'I''m not interested in my job any more.', 'my job is interesting', 1),
  ('B', 'I get very tired doing my job.', 'my job is tiring', 2),
  ('B', 'I''m not satisfied with my job.', 'my job is satisfying', 3),
  ('B', 'My job makes me depressed.', 'my job is depressing', 4),
  ('B', 'Julia thinks politics is interesting.', null, 5),
  ('B', 'Julia is interested in politics.', 'not interesting in politics', 6),
  ('B', 'Are you interested in buying a car? I''m trying to sell mine.', null, 7),
  ('B', 'Did you meet anyone interesting at the party?', null, 8),
  ('B', 'It was surprising that he passed the exam.', null, 9),
  ('B', 'Everybody was surprised that he passed the exam.', null, 10),
  ('B', 'The movie was disappointing. We expected it to be better.', null, 11),
  ('B', 'We were disappointed with the movie. We expected it to be better.', null, 12),
  ('B', 'The news was shocking.', null, 13),
  ('B', 'I was shocked when I heard the news.', null, 14)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 98.1-98.3; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '98.1', 'Complete the sentences for each situation. Use the word in brackets + -ing or -ed.', 0
from units where slug = 'unit-98';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-98' where es.title = '98.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Donna teaches young children. It''s a very hard job, but she enjoys it. She enjoys her job, but it''s often {0}.', '(exhaust...)'),
  (2, 'At the end of a day''s work, she is often {0}.', '(exhaust...)'),
  (3, 'It''s been raining all day. I hate this weather. This weather is {0}.', '(depress...)'),
  (4, 'This weather makes me {0}.', '(depress...)'),
  (5, 'It''s silly to get {0} because of the weather.', '(depress...)'),
  (6, 'Clare is going to Mexico next month. She''s never been there before. It will be an {0} experience for her.', '(excit...)'),
  (7, 'Going to new places is always {0}.', '(excit...)'),
  (8, 'She is really {0} about going to Mexico.', '(excit...)')
) as v(n, template, hint)
where es.title = '98.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '98.1'
join (values
  (1, 'exhausting'), (2, 'exhausted'), (3, 'depressing'), (4, 'depressed'),
  (5, 'depressed'), (6, 'exciting'), (7, 'exciting'), (8, 'excited')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '98.2', 'Choose the correct word.', 1
from units where slug = 'unit-98';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-98' where es.title = '98.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m not particularly {0} in football.', '(interesting / interested)'),
  (2, 'The new project sounds {0}. I''m looking forward to working on it.', '(exciting / excited)'),
  (3, 'It can be {0} when you have to ask people for money.', '(embarrassing / embarrassed)'),
  (4, 'Do you easily get {0}?', '(embarrassing / embarrassed)'),
  (5, 'I''d never expected to get the job. I was {0} when I was offered it.', '(amazing / amazed)'),
  (6, 'She''s learnt very fast. She''s made {0} progress.', '(amazing / amazed)'),
  (7, 'I didn''t find the situation funny. I was not {0}.', '(amusing / amused)'),
  (8, 'I''m {0} in joining the club. How much does it cost?', '(interesting / interested)'),
  (9, 'It was a really {0} experience. Everybody was very {1}.', '(terrifying / terrified) ... (shocking / shocked)'),
  (10, 'Why do you always look so {0}? Is your life really so {1}?', '(boring / bored) ... (boring / bored)'),
  (11, 'He''s one of the most {0} people I''ve ever met. He never stops talking and he never says anything {1}.', '(boring / bored) ... (interesting / interested)')
) as v(n, template, hint)
where es.title = '98.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '98.2'
join (values
  (1, 0, 'interested'), (2, 0, 'exciting'), (3, 0, 'embarrassing'), (4, 0, 'embarrassed'),
  (5, 0, 'amazed'), (6, 0, 'amazing'), (7, 0, 'amused'), (8, 0, 'interested'),
  (9, 0, 'terrifying'), (9, 1, 'shocked'),
  (10, 0, 'bored'), (10, 1, 'boring'),
  (11, 0, 'boring'), (11, 1, 'interesting')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '98.3', 'Complete each sentence using a word from the box: amusing/amused, annoying/annoyed, boring/bored, confusing/confused, disgusting/disgusted, exciting/excited, exhausting/exhausted, interesting/interested, surprising/surprised.', 2
from units where slug = 'unit-98';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-98' where es.title = '98.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Some people get {0} very easily. They always need something new.', null),
  (2, 'The teacher''s explanation was {0}. Nobody understood it.', null),
  (3, 'The kitchen hadn''t been cleaned for ages. It was really {0}.', null),
  (4, 'I don''t go to art galleries very often. I''m not very {0} in art.', null),
  (5, 'There''s no need to get {0} just because I''m a few minutes late.', null),
  (6, 'The lecture was {0}. I fell asleep.', null),
  (7, 'I''ve been working very hard all day and now I''m {0}.', null),
  (8, 'I''m starting a new job next week. I''m very {0} about it.', null),
  (9, 'Steve is good at telling funny stories. He can be very {0}.', null),
  (10, 'Helen is a very {0} person. She knows a lot, she''s travelled a lot and she''s done lots of different things.', null)
) as v(n, template, hint)
where es.title = '98.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '98.3'
join (values
  (1, 'bored'), (2, 'confusing'), (3, 'disgusting'), (4, 'interested'), (5, 'annoyed'),
  (6, 'boring'), (7, 'exhausted'), (8, 'excited'), (9, 'amusing'), (10, 'interesting')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 99: Adjectives: a nice new house, you look tired
-- ============================================================

delete from units where slug = 'unit-99';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 99, 'unit-99', 'Adjectives: a nice new house, you look tired', null,
  'When two or more adjectives are used together, opinion adjectives (nice, beautiful) usually go before fact adjectives (new, round, wooden), and fact adjectives usually follow the order size/age, shape, colour, origin, material. Adjectives are used after be/get/become/seem and after look/feel/sound/taste/smell — but to say how somebody does something you need an adverb instead (drive carefully, not drive careful).', 1
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'opinion before fact',
  'Sometimes we use two or more adjectives together: My brother lives in a nice new house. In the kitchen there was a beautiful large round wooden table. Adjectives like new/large/round/wooden are fact adjectives. They give us information about age, size, colour etc. Adjectives like nice/beautiful are opinion adjectives. They tell us what the speaker thinks of something or somebody. Opinion adjectives usually go before fact adjectives: a nice long summer holiday, an interesting young man, delicious hot vegetable soup, a beautiful large round wooden table.', 0
from units where slug = 'unit-99';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'order of fact adjectives',
  'Sometimes we use two or more fact adjectives together. Usually (not always) we put fact adjectives in this order: (1) how big?, (2) how old?, (3) what colour?, (4) where from?, (5) what is it made of?, then the noun. For example: a tall young man (1 2), a large wooden table (1 5), big blue eyes (1 3), an old Russian song (2 4), a small black plastic bag (1 3 5), an old white cotton shirt (2 3 5). Adjectives of size and length (big/small/tall/short/long etc.) usually go before adjectives of shape and width (round/fat/thin/slim/wide etc.): a large round table, a tall thin girl, a long narrow street. When there are two or more colour adjectives, we use and: a black and white dress, a red, white and green flag. This does not usually happen with other adjectives before a noun: a long black dress (not a long and black dress).', 1
from units where slug = 'unit-99';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'adjectives after be/get/seem and look/feel/sound/taste/smell',
  'We use adjectives after be/get/become/seem: Be careful! I''m tired and I''m getting hungry. As the film went on, it became more and more boring. Your friend seems very nice. We also use adjectives to say how somebody/something looks, feels, sounds, tastes or smells: You look tired. / I feel tired. / She sounds tired. The dinner smells good. This tea tastes a bit strange. But to say how somebody does something you must use an adverb (see Units 100-101): Drive carefully! (not Drive careful) Suzanne plays the piano very well. (not plays ... very good)', 2
from units where slug = 'unit-99';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'the first two days, the next few weeks',
  'We say ''the first two days'', ''the next few weeks'', ''the last ten minutes'' etc.: I didn''t enjoy the first two days of the course. (not the two first days) They''ll be away for the next few weeks. (not the few next weeks)', 3
from units where slug = 'unit-99';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-99'
join (values
  ('A', 'My brother lives in a nice new house.', null, 0),
  ('A', 'In the kitchen there was a beautiful large round wooden table.', null, 1),
  ('A', 'a nice long summer holiday', 'opinion + fact', 2),
  ('A', 'an interesting young man', 'opinion + fact', 3),
  ('A', 'delicious hot vegetable soup', 'opinion + fact', 4),
  ('B', 'a tall young man', '1 2', 0),
  ('B', 'a large wooden table', '1 5', 1),
  ('B', 'big blue eyes', '1 3', 2),
  ('B', 'an old Russian song', '2 4', 3),
  ('B', 'a small black plastic bag', '1 3 5', 4),
  ('B', 'an old white cotton shirt', '2 3 5', 5),
  ('B', 'a large round table', 'size before shape', 6),
  ('B', 'a tall thin girl', 'size before shape', 7),
  ('B', 'a long narrow street', 'size before shape', 8),
  ('B', 'a black and white dress', 'two colours use and', 9),
  ('B', 'a red, white and green flag', 'two colours use and', 10),
  ('B', 'a long black dress', 'not a long and black dress', 11),
  ('C', 'Be careful!', null, 0),
  ('C', 'I''m tired and I''m getting hungry.', null, 1),
  ('C', 'As the film went on, it became more and more boring.', null, 2),
  ('C', 'Your friend seems very nice.', null, 3),
  ('C', 'You look tired. / I feel tired. / She sounds tired.', null, 4),
  ('C', 'The dinner smells good.', null, 5),
  ('C', 'This tea tastes a bit strange.', null, 6),
  ('C', 'Drive carefully!', 'not Drive careful', 7),
  ('C', 'Suzanne plays the piano very well.', 'not plays ... very good', 8),
  ('D', 'I didn''t enjoy the first two days of the course.', 'not the two first days', 0),
  ('D', 'They''ll be away for the next few weeks.', 'not the few next weeks', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 99.1-99.4; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '99.1', 'Put the adjectives in brackets in the correct position.', 0
from units where slug = 'unit-99';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-99' where es.title = '99.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'an unusual ring {0}', '(gold)'),
  (2, 'an old house {0}', '(beautiful)'),
  (3, 'red gloves {0}', '(leather)'),
  (4, 'an American film {0}', '(old)'),
  (5, 'pink flowers {0}', '(tiny)'),
  (6, 'a long face {0}', '(thin)'),
  (7, 'big clouds {0}', '(black)'),
  (8, 'a sunny day {0}', '(lovely)'),
  (9, 'an ugly dress {0}', '(yellow)'),
  (10, 'a wide avenue {0}', '(long)'),
  (11, 'important ideas {0}', '(new)'),
  (12, 'a new sweater {0}', '(green / nice)'),
  (13, 'a metal box {0}', '(black / small)'),
  (14, 'long hair {0}', '(black / beautiful)'),
  (15, 'an old painting {0}', '(interesting / French)'),
  (16, 'a large umbrella {0}', '(red / yellow)'),
  (17, 'a big cat {0}', '(black / white / fat)')
) as v(n, template, hint)
where es.title = '99.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '99.1'
join (values
  (1, 'an unusual gold ring'), (2, 'a beautiful old house'), (3, 'red leather gloves'),
  (4, 'an old American film'), (5, 'tiny pink flowers'), (6, 'a long thin face'),
  (7, 'big black clouds'), (8, 'a lovely sunny day'), (9, 'an ugly yellow dress'),
  (10, 'a long wide avenue'), (11, 'important new ideas'), (12, 'a nice new green sweater'),
  (13, 'a small black metal box'), (14, 'beautiful long black hair'), (15, 'an interesting old French painting'),
  (16, 'a large red and yellow umbrella'), (17, 'a big fat black and white cat')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '99.2', 'Complete each sentence with a verb (in the correct form) and an adjective from the boxes: feel, look, seem, smell, sound, taste; awful, nervous, interesting, nice, upset, wet.', 1
from units where slug = 'unit-99';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-99' where es.title = '99.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can''t eat this. I''ve just tried it and it {0}.', null),
  (2, 'It''s normal to {0} before an exam or an interview.', null),
  (3, 'What beautiful flowers! They {0} too.', null),
  (4, 'You {0}. Have you been out in the rain?', null),
  (5, 'James told me about his new job. It {0} — much better than his old job.', null)
) as v(n, template, hint)
where es.title = '99.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '99.2'
join (values
  (1, 'tastes awful', array['tasted awful']::text[]),
  (2, 'feel nervous', array[]::text[]),
  (3, 'smell nice', array[]::text[]),
  (4, 'look wet', array[]::text[]),
  (5, 'sounds interesting', array['sounded interesting']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '99.3', 'Put in the correct word.', 2
from units where slug = 'unit-99';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-99' where es.title = '99.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I usually feel {0} when the sun is shining.', '(happy / happily)'),
  (2, 'The children were playing {0} in the garden.', '(happy / happily)'),
  (3, 'You look {0}! Are you all right?', '(terrible / terribly)'),
  (4, 'There''s no point in doing a job if you don''t do it {0}.', '(proper / properly)'),
  (5, 'The soup tastes {0}. Can you give me the recipe?', '(good / well)'),
  (6, 'Please hurry up! You''re always so {0}.', '(slow / slowly)'),
  (7, 'A customer in the restaurant was behaving {0}.', '(bad / badly)'),
  (8, 'The customer became {0} when the manager asked him to leave.', '(violent / violently)')
) as v(n, template, hint)
where es.title = '99.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '99.3'
join (values
  (1, 'happy'), (2, 'happily'), (3, 'terrible'), (4, 'properly'),
  (5, 'good'), (6, 'slow'), (7, 'badly'), (8, 'violent')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '99.4', 'Write the following in another way using the first ... / the next ... / the last ... .', 3
from units where slug = 'unit-99';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-99' where es.title = '99.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'yesterday and the day before yesterday {0}', null),
  (2, 'the first week and the second week of May {0}', null),
  (3, 'tomorrow and a few days after that {0}', null),
  (4, 'questions 1, 2 and 3 in the exam {0}', null),
  (5, 'next year and the year after {0}', null),
  (6, 'the last day of our holiday and the two days before that {0}', null)
) as v(n, template, hint)
where es.title = '99.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '99.4'
join (values
  (1, 'the last two days', array[]::text[]),
  (2, 'the first two weeks of May', array[]::text[]),
  (3, 'the next few days', array[]::text[]),
  (4, 'the first three questions', array['the first three questions in the exam']::text[]),
  (5, 'the next two years', array[]::text[]),
  (6, 'the last three days of our holiday', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
