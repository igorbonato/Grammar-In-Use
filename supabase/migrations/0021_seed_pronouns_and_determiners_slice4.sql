-- Marco 4 (slice 20): seeds the fourth slice of the "Pronouns and
-- determiners" module — units 88-89 (all/all of, most/most of, no/none of
-- etc.; either/either of).
--
-- Sourced from pdf/Modulos/Pronouns and determiners.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode where -layout scrambled
-- multi-column exercises — see 89.3 note below) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Unit 88's theory sections B and C are drawn from two-column diagrams in
-- the book (words + "of" + the/this/that/these/those/my ... ; words + of +
-- it/us/you/them) — rendered here as prose, keeping every word/example the
-- diagrams list.
--
-- 88.1 reuses the "no word needed" empty-answer convention introduced for
-- the Articles and nouns module (commit e793d03): several items expect no
-- word before the noun at all, encoded as correct_answer = ''.
--
-- 89.3 is a two-column "complete the sentence" exercise; -layout
-- extraction scattered the trailing clauses ("can play well.", "had it.")
-- away from their items. Reconstructed the correct pairing by cross-
-- checking against the Key's per-item answers (2 either of them, 3 both of
-- them, 4 Neither of us, 5 neither of them) until each fixed clause made
-- grammatical sense with its blank.
--
-- 89.2 item 4 (originally item 5 in the book): the Key lists "both / both
-- the / both of the cars" for the second blank, but the template already
-- has the fixed word "cars" right after the blank — "both of the cars"
-- would duplicate it. Kept "both" as the answer and "both the" as the only
-- alternative, treating "both of the cars" as the Key restating the whole
-- clause for clarity rather than a literal fit (same padding pattern noted
-- for unit 68.3 in an earlier module).
--
-- 88.3 ("Use your own ideas to complete these sentences") is skipped as
-- open-ended — the Key itself labels it "Example answers" for genuinely
-- personal completions, same policy as every prior module.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 88: all / all of, most / most of, no / none of etc.
-- ============================================================

delete from units where slug = 'unit-88';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 88, 'unit-88', 'all / all of most / most of no / none of etc.', null,
  'Words like all, some, any, most, much, many, (a) little, (a) few and no can go directly before a noun (all cars, most weekends). To point to a specific group, use of + the/this/that/these/those/my ... (some of the people, most of my time) — except all and half, which don''t need of. Before it/us/you/them, of is always needed (all of us, half of it).', 6
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'all some any most much many (a) little (a) few no + noun',
  'You can use these words with a noun (some food / few books etc.): All cars have wheels. Some cars can go faster than others. Many people drive too fast. I go away most weekends. I feel really tired. I''ve got no energy. We do not say ''all of cars'', ''some of people'' etc. (see Section B): Some people learn more easily than others. (not Some of people)', 0
from units where slug = 'unit-88';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'all half some any most much many (a) little (a) few none + of',
  'You can use these words with of (some of / most of etc.) before the/this/that/these/those/my ... etc.: some of the people, some of those people (but not some of people); most of my time, most of the time (but not most of time). Some of the people I work with are very strange. None of this money is mine. Have you read any of these books? I was ill yesterday. I spent most of the day in bed. You don''t need of after all or half. So you can say: All my friends live near here. or All of my friends ... Half this money is mine. or Half of this money ... Compare: All flowers are beautiful. (= all flowers in general) All (of) these flowers are beautiful. (= a specific group of flowers) Most problems have a solution. (= most problems in general) We were able to solve most of the problems we had. (= a specific group of problems)', 1
from units where slug = 'unit-88';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'all of / some of / none of etc. + it/us/you/them',
  'You can use all of / some of / any of / most of / none of etc. + it/us/you/them: a: Do you like this music? b: Some of it. Not all of it. a: How many of these people do you know? b: None of them. / A few of them. Do any of you want to come to a party tonight? (said to more than 2 people) We say: all of us / all of you / half of it / half of them etc. You need of before it/us/you/them: All of us were late. (not all us) I haven''t finished the book yet. I''ve only read half of it. (not half it)', 2
from units where slug = 'unit-88';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'some/most etc. alone, without a noun',
  'We also use some/most etc. alone, without a noun: Some cars have four doors and some have two. A few of the shops were open, but most (of them) were closed. Half this money is mine, and half (of it) is yours. (not the half)', 3
from units where slug = 'unit-88';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-88'
join (values
  ('A', 'All cars have wheels.', null, 0),
  ('A', 'Some cars can go faster than others.', null, 1),
  ('A', 'Many people drive too fast.', null, 2),
  ('A', 'I go away most weekends.', null, 3),
  ('A', 'I feel really tired. I''ve got no energy.', null, 4),
  ('A', 'Some people learn more easily than others.', 'not Some of people', 5),
  ('B', 'some of the people, some of those people', 'but not some of people', 0),
  ('B', 'most of my time, most of the time', 'but not most of time', 1),
  ('B', 'Some of the people I work with are very strange.', null, 2),
  ('B', 'None of this money is mine.', null, 3),
  ('B', 'Have you read any of these books?', null, 4),
  ('B', 'I was ill yesterday. I spent most of the day in bed.', null, 5),
  ('B', 'All my friends live near here. or All of my friends ...', null, 6),
  ('B', 'Half this money is mine. or Half of this money ...', null, 7),
  ('B', 'All flowers are beautiful.', '= all flowers in general', 8),
  ('B', 'All (of) these flowers are beautiful.', '= a specific group of flowers', 9),
  ('B', 'Most problems have a solution.', '= most problems in general', 10),
  ('B', 'We were able to solve most of the problems we had.', '= a specific group of problems', 11),
  ('C', '''Do you like this music?'' ''Some of it. Not all of it.''', null, 0),
  ('C', '''How many of these people do you know?'' ''None of them. / A few of them.''', null, 1),
  ('C', 'Do any of you want to come to a party tonight?', 'said to more than 2 people', 2),
  ('C', 'All of us were late.', 'not all us', 3),
  ('C', 'I haven''t finished the book yet. I''ve only read half of it.', 'not half it', 4),
  ('D', 'Some cars have four doors and some have two.', null, 0),
  ('D', 'A few of the shops were open, but most (of them) were closed.', null, 1),
  ('D', 'Half this money is mine, and half (of it) is yours.', 'not the half', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 88.1, 88.2, 88.4; 88.3 skipped as
-- open-ended. Each renumbered from 1, dropping the book's own worked
-- example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '88.1', 'Put in of where necessary. Leave the space empty if the sentence is already complete.', 0
from units where slug = 'unit-88';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-88' where es.title = '88.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There were problems at the airport and some {0} flights were cancelled.', null),
  (2, 'Some {0} the films I''ve seen recently have been very violent.', null),
  (3, 'Joe never goes to museums. He says that all {0} museums are boring.', null),
  (4, 'I think some {0} people watch too much TV.', null),
  (5, 'Do you want any {0} these magazines or can I throw them away?', null),
  (6, 'Kate has lived in London most {0} her life.', null),
  (7, 'Joe has lived in Chicago all {0} his life.', null),
  (8, 'Most {0} days I get up before 7 o''clock.', null),
  (9, 'I usually have a little {0} sugar in my coffee.', null),
  (10, 'They won the lottery a few years ago, but they''ve spent most {0} the money.', null)
) as v(n, template, hint)
where es.title = '88.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '88.1'
join (values
  (1, '', array[]::text[]),
  (2, 'of', array[]::text[]),
  (3, '', array[]::text[]),
  (4, '', array[]::text[]),
  (5, 'of', array[]::text[]),
  (6, 'of', array[]::text[]),
  (7, '', array['of']::text[]),
  (8, '', array[]::text[]),
  (9, '', array[]::text[]),
  (10, 'of', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '88.2', 'Choose from the list and complete the sentences. Use of (some of / most of etc.) where necessary. Choose from: accidents, birds, cars, European countries, her friends, her opinions, my dinner, my spare time, the buildings, the players, the population, these books.', 1
from units where slug = 'unit-88';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-88' where es.title = '88.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I spend much {0} gardening.', null),
  (2, 'Many {0} are caused by bad driving.', null),
  (3, 'It''s a historic town. Many {0} are over 400 years old.', null),
  (4, 'When Emily got married, she kept it a secret. She didn''t tell any {0}.', null),
  (5, 'Not many people live in the north of the country. Most {0} live in the south.', null),
  (6, 'Not all {0} can fly. For example, the penguin can''t fly.', null),
  (7, 'Our team played badly and lost the game. None {0} played well.', null),
  (8, 'Emma and I have different ideas. I don''t agree with many {0}.', null),
  (9, 'Sarah travels a lot in Europe. She has been to most {0}.', null),
  (10, 'I had no appetite. I could only eat half {0}.', null)
) as v(n, template, hint)
where es.title = '88.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '88.2'
join (values
  (1, 'of my spare time', array[]::text[]),
  (2, 'accidents', array[]::text[]),
  (3, 'of the buildings', array[]::text[]),
  (4, 'of her friends', array[]::text[]),
  (5, 'of the population', array[]::text[]),
  (6, 'birds', array[]::text[]),
  (7, 'of the players', array[]::text[]),
  (8, 'of her opinions', array[]::text[]),
  (9, 'European countries', array[]::text[]),
  (10, 'my dinner', array['of my dinner']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '88.4', 'Complete the sentences. Use all of / some of / none of + it/them/us (all of it / some of them etc.).', 2
from units where slug = 'unit-88';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-88' where es.title = '88.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''How many of these books have you read?'' ''{0}. Every one.''', null),
  (2, 'We all got wet in the rain because {0} had an umbrella.', null),
  (3, 'Some of this money is yours and {0} is mine.', null),
  (4, 'Many of my friends have travelled a lot, but {0} has ever been to Africa.', null),
  (5, 'Not all the tourists in the group were Spanish. {0} were French.', null),
  (6, 'I watched most of the film, but not {0}.', null),
  (7, 'He told us his life story, but {0} was true. It was all invented.', null)
) as v(n, template, hint)
where es.title = '88.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '88.4'
join (values
  (1, 'All of them'), (2, 'none of us'), (3, 'some of it'), (4, 'none of them'),
  (5, 'Some of them'), (6, 'all of it'), (7, 'none of it')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 89: either / either of
-- ============================================================

delete from units where slug = 'unit-89';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 89, 'unit-89', 'either / either of', null,
  'We use both, neither and either for two things: both restaurants (= the two together), neither restaurant (= not one and not the other), either restaurant (= one or the other, it doesn''t matter which). Before it/us/you/them you always need of (both of us, neither of them); before other nouns of is optional after both but required after neither/either when pointing to a specific pair.', 7
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'both/neither/either for two things',
  'We use both/neither/either for two things. You can use these words with a noun (both books, neither book etc.). For example, you are going out to eat. There are two possible restaurants. You say: Both restaurants are good. (not the both restaurants) Neither restaurant is expensive. We can go to either restaurant. I don''t mind. (= one or the other, it doesn''t matter which) I haven''t been to either restaurant before. (= not one or the other) You can also use both/neither/either without a noun: ''Which do you prefer, basketball or tennis?'' ''It''s hard to say. I like both.'' ''Is your friend British or American?'' ''Neither. She''s Australian.'' ''Do you want tea or coffee?'' ''Either. I don''t mind.''', 0
from units where slug = 'unit-89';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'both of ... / neither of ... / either of ...',
  'We use both of / neither of / either of + the/these/my/Tom''s ... etc. So we say ''both of the restaurants'', ''both of those restaurants'' etc. (but not both of restaurants): Both of these restaurants are good. Neither of the restaurants we went to was expensive. I haven''t been to either of those restaurants. You don''t need of after both. So you can say: Both of these restaurants are good. or Both these restaurants are good. We also use both of / neither of / either of + us/you/them: (talking to two people) Can either of you speak Russian? I asked two people how to get to the station, but neither of them knew. We say ''both of'' before us/you/them (you need to use of): Both of us were tired. (not Both us were ...) After neither of ... a verb can be singular or plural: Neither of them is at home. or Neither of them are at home.', 1
from units where slug = 'unit-89';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'both ... and ... / neither ... nor ... / either ... or ...',
  'You can say: Both Chris and Paul were late. I was both tired and hungry when I arrived home. Neither Chris nor Paul came to the party. There was an accident outside our house, but we neither saw nor heard anything. I''m not sure where Maria''s from. She''s either Spanish or Italian. Either you apologise, or I''ll never speak to you again.', 2
from units where slug = 'unit-89';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'either/neither/both (two things) vs. any/none/all (more than two)',
  'Compare either/neither/both (two things) and any/none/all (more than two): There are two good hotels here. You could stay at either of them. / There are many good hotels here. You could stay at any of them. We tried two hotels. Neither of them had a room. Both of them were full. / We tried a lot of hotels. None of them had a room. All of them were full.', 3
from units where slug = 'unit-89';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-89'
join (values
  ('A', 'Both restaurants are good.', 'not the both restaurants', 0),
  ('A', 'Neither restaurant is expensive.', null, 1),
  ('A', 'We can go to either restaurant. I don''t mind.', '= one or the other, it doesn''t matter which', 2),
  ('A', 'I haven''t been to either restaurant before.', '= not one or the other', 3),
  ('A', '''Which do you prefer, basketball or tennis?'' ''It''s hard to say. I like both.''', null, 4),
  ('A', '''Is your friend British or American?'' ''Neither. She''s Australian.''', null, 5),
  ('A', '''Do you want tea or coffee?'' ''Either. I don''t mind.''', null, 6),
  ('B', 'Both of these restaurants are good.', null, 0),
  ('B', 'Neither of the restaurants we went to was expensive.', null, 1),
  ('B', 'I haven''t been to either of those restaurants.', null, 2),
  ('B', 'Both of these restaurants are good. or Both these restaurants are good.', null, 3),
  ('B', 'Can either of you speak Russian?', 'talking to two people', 4),
  ('B', 'I asked two people how to get to the station, but neither of them knew.', null, 5),
  ('B', 'Both of us were tired.', 'not Both us were ...', 6),
  ('B', 'Neither of them is at home. or Neither of them are at home.', null, 7),
  ('C', 'Both Chris and Paul were late.', null, 0),
  ('C', 'I was both tired and hungry when I arrived home.', null, 1),
  ('C', 'Neither Chris nor Paul came to the party.', null, 2),
  ('C', 'There was an accident outside our house, but we neither saw nor heard anything.', null, 3),
  ('C', 'She''s either Spanish or Italian.', 'I''m not sure where Maria''s from', 4),
  ('C', 'Either you apologise, or I''ll never speak to you again.', null, 5),
  ('D', 'There are two good hotels here. You could stay at either of them.', null, 0),
  ('D', 'There are many good hotels here. You could stay at any of them.', null, 1),
  ('D', 'We tried two hotels. Neither of them had a room. Both of them were full.', null, 2),
  ('D', 'We tried a lot of hotels. None of them had a room. All of them were full.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 89.1-89.5; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '89.1', 'Complete the sentences with both/neither/either.', 0
from units where slug = 'unit-89';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-89' where es.title = '89.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''What day is it today — the 18th or the 19th?'' ''{0}. It''s the 20th.''', null),
  (2, 'a: Where did you go on your trip — Korea or Japan? b: We went to {0}. A week in Korea and a week in Japan.', null),
  (3, '''Shall we sit in the corner or by the window?'' ''{0}. I don''t mind.''', null),
  (4, '''Where''s Lisa? Is she at work or at home?'' ''{0}. She''s away on holiday.''', null),
  (5, '''Is it true that Kate speaks Spanish and Arabic?'' ''Yes, she speaks {0} fluently.''', null)
) as v(n, template, hint)
where es.title = '89.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '89.1'
join (values
  (1, 'Neither'), (2, 'both'), (3, 'Either'), (4, 'Neither'), (5, 'both')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '89.2', 'Complete the sentences with both/neither/either. Use of where necessary.', 1
from units where slug = 'unit-89';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-89' where es.title = '89.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'To get to the town centre, you can walk along the river or you can go along the road. You can go {0} way.', null),
  (2, 'I went to Carl''s house twice, but {0} times he wasn''t at home.', null),
  (3, '{0} Tom''s parents is English. His father is Polish and his mother is Italian.', null),
  (4, 'I saw an accident this morning. One car drove into the back of another. Fortunately {0} driver was injured, but {1} cars were badly damaged.', null),
  (5, 'I have two sisters and a brother. My brother is working, but {0} my sisters are still at school.', null)
) as v(n, template, hint)
where es.title = '89.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '89.2'
join (values
  (1, 0, 'either', array[]::text[]),
  (2, 0, 'both', array[]::text[]),
  (3, 0, 'Neither of', array[]::text[]),
  (4, 0, 'neither', array[]::text[]), (4, 1, 'both', array['both the']::text[]),
  (5, 0, 'both', array['both of']::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '89.3', 'Complete the sentences with both/neither/either + of us / of them.', 2
from units where slug = 'unit-89';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-89' where es.title = '89.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I was invited to two parties last week, but I couldn''t go to {0}.', null),
  (2, 'There were two windows in the room. It was very warm, so I opened {0}.', null),
  (3, 'Sam and I often play tennis, but {0} can play well.', null),
  (4, 'I tried two bookshops for the book I wanted to buy, but {0} had it.', null)
) as v(n, template, hint)
where es.title = '89.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '89.3'
join (values
  (1, 'either of them'), (2, 'both of them'), (3, 'Neither of us'), (4, 'neither of them')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '89.4', 'Write sentences with both ... and ... / neither ... nor ... / either ... or ... .', 3
from units where slug = 'unit-89';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-89' where es.title = '89.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was a boring movie. It was long too. The movie {0}', null),
  (2, 'Joe doesn''t have a car. Sam doesn''t have one either. {0}', null),
  (3, 'Emily speaks German and she speaks Russian too. {0}', null),
  (4, 'Ben doesn''t watch TV and he doesn''t read newspapers. Ben {0}', null),
  (5, 'Is that man''s name Richard? Or is it Robert? It''s one of the two. That man''s name {0}', null),
  (6, 'I don''t have time to go on holiday. And I don''t have the money. I have {0}', null),
  (7, 'We can leave today or we can leave tomorrow — whichever you prefer. We {0}', null)
) as v(n, template, hint)
where es.title = '89.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '89.4'
join (values
  (1, 'was both boring and long.', array[]::text[]),
  (2, 'Neither Joe nor Sam has a car.', array['Neither Joe nor Sam has got a car.']::text[]),
  (3, 'Emily speaks both German and Russian.', array[]::text[]),
  (4, 'neither watches TV nor reads newspapers.', array[]::text[]),
  (5, 'is either Richard or Robert.', array[]::text[]),
  (6, 'neither the time nor the money to go on holiday.', array[]::text[]),
  (7, 'can leave either today or tomorrow.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '89.5', 'Complete the sentences with neither/either/none/any.', 4
from units where slug = 'unit-89';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-89' where es.title = '89.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sam has two sisters, but I haven''t met {0} of them.', null),
  (2, 'Emily has four brothers, but I haven''t met {0} of them.', null),
  (3, 'There were a few shops in the street, but {0} of them was open.', null),
  (4, 'Spain, Italy, Greece, Turkey — have you been to {0} of these countries?', null),
  (5, 'I could meet you next Monday or Thursday. Would {0} of those days suit you?', null),
  (6, 'Mark and I couldn''t get into the house because {0} of us had a key.', null)
) as v(n, template, hint)
where es.title = '89.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '89.5'
join (values
  (1, 'either'), (2, 'any'), (3, 'none'), (4, 'any'), (5, 'either'), (6, 'neither')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
