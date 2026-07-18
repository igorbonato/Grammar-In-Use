-- Marco 4 (slice 21): seeds the fifth and final slice of the "Pronouns and
-- determiners" module — units 90-91 (all every whole; each and every).
--
-- Sourced from pdf/Modulos/Pronouns and determiners.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode where -layout scrambled
-- the trailing clauses of 91.4 — see note below) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode, since -layout's 3-column Key pages
-- garble badly, same lesson as every module since Articles and nouns).
--
-- This completes the "Pronouns and determiners" module: the PDF's unit
-- headers stop at 91 (confirmed via a full-file grep sweep, same check
-- applied to every module since the Modals.pdf discovery) — units 82-91,
-- 10 units across five slices (0018-0022).
--
-- Every exercise in both units opens with 1-2 pre-filled worked example(s)
-- in the book; each is dropped and the remaining items renumbered from 1,
-- same convention as every prior slice.
--
-- 90.2 ("Write sentences with whole") gives partial sentence-starts as
-- scaffolds for some items but none for others (items 6/9 are fully
-- open starts). Followed the 38.4/39.2 precedent (0007): dropped the
-- book's inline scaffolds and asked for the whole answer sentence instead,
-- keeping every item's shape consistent rather than mixing partial-blank
-- and full-sentence answers within one exercise.
--
-- 90.4 ("Which is right?") follows the established two-option pattern
-- (86.4/87.4 in 0020): the chosen option becomes the blank, the pair goes
-- in the hint as "(option1 / option2)".
--
-- 91.1 ("Look at the pictures and complete the sentences") turned out not
-- to need picture data at all — unlike 54.1/55.2/46.1 in earlier modules,
-- every item's text is self-contained without the picture, so no
-- theory_images placeholder was added here.
--
-- 91.4 is the second exercise in this module (after 89.3) where -layout
-- scattered short trailing clauses away from their items; even plain-mode
-- extraction left them floating as orphan lines ("in my class.",
-- "correctly.", "broke.") after the item list instead of inline. Restored
-- the item 2/3/4/5 pairing the same way as 89.3: matched each clause
-- against the Key's per-item answers (2 everyone, 3 every one, 4 Everyone,
-- 5 every one) until each fixed clause made grammatical sense with its
-- blank.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 90: all every whole
-- ============================================================

delete from units where slug = 'unit-90';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 90, 'unit-90', 'all every whole', null,
  'We do not use all alone to mean "everybody" or "everything" — use everybody/everyone/everything instead. all is used before a noun (all cars), before of + us/you/them (all of us), and after we/you/they (we were all happy). whole means complete or entire and is used mostly with singular nouns (the whole book), with the/my/a etc. before it — unlike all, which does not need an article with uncountable nouns.', 8
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'everybody/everyone/everything and all',
  'We say: Everybody was happy. or Everyone was happy. (not all were happy) He thinks he knows everything. (not knows all) Our holiday was a disaster. Everything went wrong. (not all went wrong) We do not often use all alone in this way. We do not say ''all were happy'', ''he knows all'' etc. We use all in the following ways: all + noun (all cars, all my money etc.) — All my friends were happy. all of + us/you/them — All of us were happy. we/you/they ... all ... — We were all happy. all about ... — He knows all about computers. all ... = the only thing(s) — All I''ve eaten today is a banana. (= the only thing I''ve eaten today)', 0
from units where slug = 'unit-90';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'whole and all',
  'Whole = complete, entire. We use whole mostly with singular nouns: Did you read the whole book? (= all the book, not just a part of it) Emily has lived her whole life in the same town. I was so hungry, I ate a whole packet of biscuits. (= a complete packet) We do not normally use whole with uncountable nouns (water, food, money etc.). We say: Did you spend all the money I gave you? (not the whole money) I read all the information carefully. (not the whole information) We use the/my/a etc. before whole. Compare whole and all: I read the whole book. but I read all the information.', 1
from units where slug = 'unit-90';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'every day / all day / the whole day',
  'We use every to say how often something happens (every day / every ten minutes etc.): When we were on holiday, we went to the beach every day. (not all days) The bus service is excellent. There''s a bus every ten minutes. We don''t see each other very often — about every six months. All day or the whole day = the complete day from beginning to end: We spent all day on the beach. or We spent the whole day ... Dan was very quiet. He didn''t say a word all evening. or ... the whole evening. Note that we say all day (not all the day), all week (not all the week) etc. Compare all the time and every time: They never go out. They are at home all the time. (= always, continuously) Every time I see you, you look different. (= each time, on every occasion)', 2
from units where slug = 'unit-90';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'every/everybody/everyone/everything are singular',
  'Every/everybody/everyone/everything are singular words, so we use a singular verb: Every seat in the theatre was taken. Everybody has arrived. (not have arrived) But we use they/them/their after everybody/everyone: Everybody said they enjoyed themselves. (= everybody enjoyed himself or herself)', 3
from units where slug = 'unit-90';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-90'
join (values
  ('A', 'Everybody was happy. or Everyone was happy.', 'not all were happy', 0),
  ('A', 'He thinks he knows everything.', 'not knows all', 1),
  ('A', 'Our holiday was a disaster. Everything went wrong.', 'not all went wrong', 2),
  ('A', 'All my friends were happy.', 'all + noun', 3),
  ('A', 'All of us were happy.', 'all of + us/you/them', 4),
  ('A', 'We were all happy.', 'we/you/they ... all ...', 5),
  ('A', 'He knows all about computers.', 'all about ...', 6),
  ('A', 'All I''ve eaten today is a banana.', '= the only thing I''ve eaten today', 7),
  ('B', 'Did you read the whole book?', '= all the book, not just a part of it', 0),
  ('B', 'Emily has lived her whole life in the same town.', null, 1),
  ('B', 'I was so hungry, I ate a whole packet of biscuits.', '= a complete packet', 2),
  ('B', 'Did you spend all the money I gave you?', 'not the whole money', 3),
  ('B', 'I read all the information carefully.', 'not the whole information', 4),
  ('B', 'I read the whole book. but I read all the information.', null, 5),
  ('C', 'When we were on holiday, we went to the beach every day.', 'not all days', 0),
  ('C', 'There''s a bus every ten minutes.', null, 1),
  ('C', 'We don''t see each other very often — about every six months.', null, 2),
  ('C', 'We spent all day on the beach. or We spent the whole day ...', null, 3),
  ('C', 'Dan was very quiet. He didn''t say a word all evening. or ... the whole evening.', null, 4),
  ('C', 'They never go out. They are at home all the time.', '= always, continuously', 5),
  ('C', 'Every time I see you, you look different.', '= each time, on every occasion', 6),
  ('D', 'Every seat in the theatre was taken.', null, 0),
  ('D', 'Everybody has arrived.', 'not have arrived', 1),
  ('D', 'Everybody said they enjoyed themselves.', '= everybody enjoyed himself or herself', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 90.1-90.4; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '90.1', 'Complete these sentences with all, everything or everybody/everyone.', 0
from units where slug = 'unit-90';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-90' where es.title = '90.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} has their faults. Nobody is perfect.', null),
  (2, 'Nothing has changed. {0} is the same as it was.', null),
  (3, 'Kate told me {0} about her new job. It sounds interesting.', null),
  (4, 'Can {0} write their names on a piece of paper, please?', null),
  (5, 'Why are you always thinking about money? Money isn''t {0}.', null),
  (6, 'I''m really exhausted. {0} I want to do is sleep.', null),
  (7, 'When the fire alarm rang, {0} left the building immediately.', null),
  (8, 'Amy didn''t say where she was going. {0} she said was that she was going away.', null),
  (9, 'We have completely different opinions. I disagree with {0} she says.', null),
  (10, 'We all did well in the exam. {0} in our class passed.', null),
  (11, 'We all did well in the exam. {0} of us passed.', null),
  (12, 'Why are you so lazy? Why do you expect me to do {0} for you?', null)
) as v(n, template, hint)
where es.title = '90.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '90.1'
join (values
  (1, 'Everybody', array['Everyone']::text[]),
  (2, 'Everything', array[]::text[]),
  (3, 'all', array[]::text[]),
  (4, 'everybody', array['everyone']::text[]),
  (5, 'everything', array[]::text[]),
  (6, 'All', array[]::text[]),
  (7, 'everybody', array['everyone']::text[]),
  (8, 'All', array[]::text[]),
  (9, 'everything', array[]::text[]),
  (10, 'Everybody', array['Everyone']::text[]),
  (11, 'All', array[]::text[]),
  (12, 'everything', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '90.2', 'Write sentences with whole.', 1
from units where slug = 'unit-90';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-90' where es.title = '90.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Everyone in the team played well. {0}', null),
  (2, 'Paul opened a box of chocolates. He started eating. When he finished, there were no chocolates left in the box. {0}', null),
  (3, 'The police came to the house. They were looking for something. They searched everywhere, every room. {0}', null),
  (4, 'Everyone in Ed and Jane''s family plays tennis. Ed and Jane play, and so do all their children. {0}', null),
  (5, 'Sarah worked from early in the morning until late in the evening. {0}', null),
  (6, 'Jack and Lisa had a week''s holiday by the sea. It rained from the beginning of the week to the end of the week. {0}', null),
  (7, 'Sarah worked from early in the morning until late in the evening. Now write this again using all instead of whole. {0}', null),
  (8, 'Jack and Lisa had a week''s holiday by the sea. It rained from the beginning of the week to the end of the week. Now write this again using all instead of whole. {0}', null)
) as v(n, template, hint)
where es.title = '90.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '90.2'
join (values
  (1, 'The whole team played well.', array[]::text[]),
  (2, 'He ate the whole box (of chocolates).', array['He ate the whole box of chocolates.']::text[]),
  (3, 'They searched the whole house.', array[]::text[]),
  (4, 'The whole family plays tennis.', array['The whole family play tennis.']::text[]),
  (5, 'She worked the whole day.', array['Sarah worked the whole day.']::text[]),
  (6, 'It rained the whole week.', array[]::text[]),
  (7, 'Sarah worked all day.', array[]::text[]),
  (8, 'It rained all week.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '90.3', 'Complete these sentences using every with the following: five minutes, ten minutes, four hours, four years, six months.', 2
from units where slug = 'unit-90';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-90' where es.title = '90.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Tom is ill. He has some medicine. He has to take it {0}.', null),
  (2, 'The Olympic Games take place {0}.', null),
  (3, 'We live near a busy airport. A plane flies over our house {0}.', null),
  (4, 'Martin goes to the dentist for a check-up {0}.', null)
) as v(n, template, hint)
where es.title = '90.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '90.3'
join (values
  (1, 'every four hours'), (2, 'every four years'), (3, 'every five minutes'), (4, 'every six months')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '90.4', 'Which is right?', 3
from units where slug = 'unit-90';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-90' where es.title = '90.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Eve works {0} except Sunday.', '(every day / all days)'),
  (2, 'I''m tired. I''ve been working hard {0}.', '(all the day / all day)'),
  (3, 'It was a terrible fire. {0} was destroyed.', '(Whole building / The whole building)'),
  (4, 'It''s a very sad song. {0} I hear it, it makes me cry.', '(Every time / All the time)'),
  (5, 'I don''t like the weather here. It rains {0}.', '(every time / all the time)'),
  (6, 'When I was on holiday, {0} was stolen.', '(all my luggage / my whole luggage)')
) as v(n, template, hint)
where es.title = '90.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '90.4'
join (values
  (1, 'every day'), (2, 'all day'), (3, 'The whole building'),
  (4, 'Every time'), (5, 'all the time'), (6, 'all my luggage')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 91: each and every
-- ============================================================

delete from units where slug = 'unit-91';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 91, 'unit-91', 'each and every', null,
  'Each and every are similar and often interchangeable, but not exactly the same: each looks at things separately, one by one (each is more usual for a small number), while every looks at things as a group, similar in meaning to all (every is more usual for a large number). each can be used with or without a noun and for as few as two things; every needs a noun (or the phrase every one) and is used to say how often something happens (every day).', 9
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'each vs. every',
  'Each and every are similar. Often it is possible to use each or every: Each time I see you, you look different. or Every time I see you ... But each and every are not exactly the same. We use each when we think of things separately, one by one; we use every when we think of things as a group — the meaning is similar to all. Study each sentence carefully. (= study the sentences one by one) Every window in the house was open. (= all the windows in the house) Each is more usual for a small number: There were four books on the table. Each book was a different colour. (in a card game) At the beginning of the game, each player has three cards. Every is more usual for a large number: Kate loves reading. She has read every book in the library. (= all the books) I''d like to visit every country in the world. (= all the countries) Each (but not every) can be used for two things: In football, each team has eleven players. (not every team) We use every (not each) to say how often something happens: ''How often do you use your car?'' ''Every day.'' (not Each day) There''s a bus every ten minutes. (not each ten minutes)', 0
from units where slug = 'unit-91';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'each of / every one of',
  'We use each with or without a noun: None of the rooms are the same. Each room is different. or Each is different. Or you can use each one: Each one is different. We say each of (the/these/them ... etc.): Each of the books was a different colour. (not each of books) Each of them was a different colour. Read each of these sentences carefully. We use every with a noun: She''s read every book in the library. We don''t use every alone, but you can say every one: ''Have you read all these books?'' ''Yes, every one.'' We say every one of ... (but not every of): I''ve read every one of those books. (not every of those books) I''ve read every one of them.', 1
from units where slug = 'unit-91';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'each in the middle of a sentence',
  'We also use each in the middle of a sentence. For example: The students were each given a book. (= Each student was given a book.) We say a dollar each, ten pounds each etc.: These oranges are 40 pence each. (each = for one orange)', 2
from units where slug = 'unit-91';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'everyone and every one',
  'Everyone (one word) is only for people (= everybody). Everyone enjoyed the party. (= Everybody ...) Every one (two words) is for things or people: Sarah is invited to lots of parties and she goes to every one. (= to every party)', 3
from units where slug = 'unit-91';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-91'
join (values
  ('A', 'Each time I see you, you look different. or Every time I see you ...', null, 0),
  ('A', 'Study each sentence carefully.', '= study the sentences one by one', 1),
  ('A', 'Every window in the house was open.', '= all the windows in the house', 2),
  ('A', 'There were four books on the table. Each book was a different colour.', null, 3),
  ('A', 'At the beginning of the game, each player has three cards.', null, 4),
  ('A', 'Kate loves reading. She has read every book in the library.', '= all the books', 5),
  ('A', 'I''d like to visit every country in the world.', '= all the countries', 6),
  ('A', 'In football, each team has eleven players.', 'not every team', 7),
  ('A', '''How often do you use your car?'' ''Every day.''', 'not Each day', 8),
  ('A', 'There''s a bus every ten minutes.', 'not each ten minutes', 9),
  ('B', 'None of the rooms are the same. Each room is different. or Each is different.', null, 0),
  ('B', 'Each one is different.', null, 1),
  ('B', 'Each of the books was a different colour.', 'not each of books', 2),
  ('B', 'Each of them was a different colour.', null, 3),
  ('B', 'Read each of these sentences carefully.', null, 4),
  ('B', 'She''s read every book in the library.', null, 5),
  ('B', '''Have you read all these books?'' ''Yes, every one.''', null, 6),
  ('B', 'I''ve read every one of those books.', 'not every of those books', 7),
  ('B', 'I''ve read every one of them.', null, 8),
  ('C', 'The students were each given a book.', '= Each student was given a book.', 0),
  ('C', 'These oranges are 40 pence each.', 'each = for one orange', 1),
  ('D', 'Everyone enjoyed the party.', '= Everybody ...', 0),
  ('D', 'Sarah is invited to lots of parties and she goes to every one.', '= to every party', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 91.1-91.4; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '91.1', 'Complete the sentences with each or every.', 0
from units where slug = 'unit-91';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-91' where es.title = '91.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} side of a square is the same length.', null),
  (2, '{0} seat in the theatre was taken.', null),
  (3, 'There are six apartments in the building. {0} one has a balcony.', null),
  (4, 'There''s a train to London {0} hour.', null),
  (5, 'She was wearing four rings — one on {0} finger.', null),
  (6, 'Our football team is playing well. We''ve won {0} game this season.', null)
) as v(n, template, hint)
where es.title = '91.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '91.1'
join (values
  (1, 'Each'), (2, 'Every'), (3, 'Each'), (4, 'every'), (5, 'each'), (6, 'every')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '91.2', 'Put in each, each of or every.', 1
from units where slug = 'unit-91';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-91' where es.title = '91.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} parent worries about their children.', null),
  (2, 'In a game of tennis there are two or four players. {0} player has a racket.', null),
  (3, 'Nicola plays volleyball {0} Thursday evening.', null),
  (4, 'I understood most of what they said but not {0} word.', null),
  (5, 'The book is divided into five parts and {0} these has three sections.', null),
  (6, 'I get paid {0} four weeks.', null),
  (7, 'I called the office two or three times, but {0} time it was closed.', null),
  (8, 'Car seat belts save lives. {0} driver should wear one.', null),
  (9, 'A friend of mine has three children. I always give {0} them a present at Christmas.', null),
  (10, '(from an exam) Answer all five questions. Write your answer to {0} question on a separate sheet of paper.', null)
) as v(n, template, hint)
where es.title = '91.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '91.2'
join (values
  (1, 'Every'), (2, 'Each'), (3, 'every'), (4, 'every'), (5, 'each of'),
  (6, 'every'), (7, 'each'), (8, 'Every'), (9, 'each of'), (10, 'each')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '91.3', 'Complete the sentences using each.', 2
from units where slug = 'unit-91';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-91' where es.title = '91.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I had ten pounds and so did Sonia. Sonia and I {0}', null),
  (2, 'One of those postcards costs a pound. Those {0}', null),
  (3, 'The hotel was expensive. I paid 200 dollars and so did you. We {0}', null)
) as v(n, template, hint)
where es.title = '91.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '91.3'
join (values
  (1, 'had ten pounds each.', array['each had ten pounds.']::text[]),
  (2, 'postcards cost a pound each.', array['postcards cost one pound each.', 'postcards are a pound each.', 'postcards are one pound each.']::text[]),
  (3, 'paid 200 dollars each.', array['each paid 200 dollars.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '91.4', 'Put in everyone (1 word) or every one (2 words).', 3
from units where slug = 'unit-91';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-91' where es.title = '91.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I remember school very clearly. I remember {0} in my class.', null),
  (2, 'I asked her lots of questions and she answered {0} correctly.', null),
  (3, 'Amy is very popular. {0} likes her.', null),
  (4, 'I dropped a tray of glasses. Unfortunately {0} broke.', null)
) as v(n, template, hint)
where es.title = '91.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '91.4'
join (values
  (1, 'everyone'), (2, 'every one'), (3, 'Everyone'), (4, 'every one')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
