-- Marco 4 (slice 24): seeds the third slice of the "Relative clauses"
-- module — unit 94 (Relative clauses 3: whose/whom/where).
--
-- Sourced from pdf/Modulos/Relative clauses.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 94.1 ("You met these people at a party ... complete the sentences using
-- who or whose") is picture-based (six numbered portraits with speech
-- captions), but same as 91.1 in 0022, every item is fully derivable from
-- its caption text alone — no theory_images placeholder needed. Rephrased
-- each picture+caption pair into a short self-contained situation sentence
-- since there's no way to seed the actual portraits.
--
-- 94.2 ("write a sentence with whom (more formal) and without whom (less
-- formal)") is the first two-blank exercise this module — each item asks
-- for both a formal and informal phrasing of the same relative clause, so
-- blank_index 0 = more formal, blank_index 1 = less formal.
--
-- 94.4 ("Use your own ideas to complete these sentences") is skipped as
-- open-ended — the Key itself labels it "Example answers" for genuinely
-- personal completions, same policy as every prior module.
--
-- Safe to re-run: unit 94 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 94: Relative clauses 3: whose/whom/where
-- ============================================================

delete from units where slug = 'unit-94';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 94, 'unit-94', 'Relative clauses 3: whose/whom/where', null,
  'whose replaces his/her/their/its in a relative clause and is used mostly for people (a widow is a woman whose husband is dead). whom is a formal alternative to who/that when it is the object of the clause, and is the only option directly after a preposition (with whom you can relax). where introduces a relative clause about a place (the town where I grew up). that can also replace when after words like the day, the year, the reason.', 2
from modules where slug = 'relative-clauses';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'whose',
  'Study this example situation: When we were driving home, we saw some people standing by the road. Their car had broken down, so we stopped to help them. We helped some people whose car had broken down. (= their car had broken down) We use whose mostly for people: A widow is a woman whose husband is dead. (her husband is dead) I met someone whose brother I went to school with. (I went to school with his/her brother) Compare who and whose: I met a man who knows you. (he knows you) I met a man whose sister knows you. (his sister knows you) Do not confuse whose and who''s. The pronunciation is the same, but who''s = who is or who has: I have a friend who''s learning Arabic. (who''s = who is) I have a friend who''s just started learning Arabic. (who''s = who has) I have a friend whose sister is learning Arabic.', 0
from units where slug = 'unit-94';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'whom',
  'Whom is possible instead of who when it is the object of the verb (see Unit 93B): George is a person whom I admire very much. (I admire him) You can also use a preposition + whom (to whom / from whom / with whom etc.): It''s important to have friends with whom you can relax. (you can relax with them) Whom is a formal word and we do not often use it in spoken English. We usually prefer to say: a person I admire a lot or a person who/that I admire a lot; friends you can relax with or friends who/that you can relax with.', 1
from units where slug = 'unit-94';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'where',
  'We use where in a relative clause to talk about a place: I recently went back to the town where I grew up. (I grew up there) The restaurant where we had lunch was near the airport. I would like to live in a place where there is plenty of sunshine.', 2
from units where slug = 'unit-94';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'the day, the time, the reason ...',
  'We say ''the day we got married'', ''the year I was born'', ''the last time they met'' etc.: I can''t meet you on Friday. That''s the day I''m going away. The last time I saw her, she looked great. You can also use that: The last time that I saw her, she looked great. We say ''the reason I''m calling you'', ''the reason she didn''t get the job'' etc.: The reason I''m calling you is to ask your advice. You can also use that: The reason that I''m calling you ... or The reason why I''m calling you ...', 3
from units where slug = 'unit-94';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-94'
join (values
  ('A', 'We helped some people whose car had broken down.', '= their car had broken down', 0),
  ('A', 'A widow is a woman whose husband is dead.', 'her husband is dead', 1),
  ('A', 'I met someone whose brother I went to school with.', 'I went to school with his/her brother', 2),
  ('A', 'I met a man who knows you.', 'he knows you', 3),
  ('A', 'I met a man whose sister knows you.', 'his sister knows you', 4),
  ('A', 'I have a friend who''s learning Arabic.', 'who''s = who is', 5),
  ('A', 'I have a friend who''s just started learning Arabic.', 'who''s = who has', 6),
  ('A', 'I have a friend whose sister is learning Arabic.', null, 7),
  ('B', 'George is a person whom I admire very much.', 'I admire him', 0),
  ('B', 'It''s important to have friends with whom you can relax.', 'you can relax with them', 1),
  ('B', 'a person I admire a lot or a person who/that I admire a lot', null, 2),
  ('B', 'friends you can relax with or friends who/that you can relax with', null, 3),
  ('C', 'I recently went back to the town where I grew up.', 'I grew up there', 0),
  ('C', 'The restaurant where we had lunch was near the airport.', null, 1),
  ('C', 'I would like to live in a place where there is plenty of sunshine.', null, 2),
  ('D', 'I can''t meet you on Friday. That''s the day I''m going away.', null, 0),
  ('D', 'The last time I saw her, she looked great.', null, 1),
  ('D', 'The last time that I saw her, she looked great.', null, 2),
  ('D', 'The reason I''m calling you is to ask your advice.', null, 3),
  ('D', 'The reason that I''m calling you ... or The reason why I''m calling you ...', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 94.1-94.3; 94.4 skipped as open-ended. Each
-- renumbered from 1, dropping the book's own worked example(s) at the
-- start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '94.1', 'You met these people at a party, and the next day you tell a friend about them. Complete the sentences using who or whose.', 0
from units where slug = 'unit-94';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-94' where es.title = '94.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'At the party, a man said: "My wife is an English teacher." I met a man {0}', null),
  (2, 'At the party, a woman said: "I own a restaurant." I met a woman {0}', null),
  (3, 'At the party, somebody said: "My ambition is to climb Mount Everest." I met somebody {0}', null),
  (4, 'At the party, a couple said: "We''ve just got married." I met a couple {0}', null),
  (5, 'At the party, somebody said: "My parents used to work in a circus." I met somebody {0}', null)
) as v(n, template, hint)
where es.title = '94.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '94.1'
join (values
  (1, 'whose wife is an English teacher.'),
  (2, 'who owns a restaurant.'),
  (3, 'whose ambition is to climb Everest.'),
  (4, 'who have just got married.'),
  (5, 'whose parents used to work in a circus.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '94.2', 'For each situation write a sentence with whom (more formal) and without whom (less formal).', 1
from units where slug = 'unit-94';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-94' where es.title = '94.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You needed a lawyer. A friend of yours recommended one. More formal: I went to see a lawyer {0}. Less formal: I went to see a lawyer {1}.', null),
  (2, 'You called your bank with a problem. You spoke to somebody, but he wasn''t very helpful. More formal: The person {0} wasn''t very helpful. Less formal: The person {1} wasn''t very helpful.', null),
  (3, 'Tom was in love with a woman, but she wasn''t in love with Tom. More formal: The woman {0} wasn''t in love with him. Less formal: The woman {1} wasn''t in love with him.', null)
) as v(n, template, hint)
where es.title = '94.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '94.2'
join (values
  (1, 0, 'whom a friend of mine had recommended', array['whom a friend of mine recommended']::text[]),
  (1, 1, 'a friend of mine had recommended', array['a friend of mine recommended']::text[]),
  (2, 0, 'to whom I spoke', array[]::text[]),
  (2, 1, 'I spoke to', array[]::text[]),
  (3, 0, 'with whom Tom was in love', array[]::text[]),
  (3, 1, 'Tom was in love with', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '94.3', 'Complete the sentences using who/whom/whose/where.', 2
from units where slug = 'unit-94';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-94' where es.title = '94.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A cemetery is a place {0} people are buried.', null),
  (2, 'A pacifist is a person {0} believes that all wars are wrong.', null),
  (3, 'An orphan is a child {0} parents are dead.', null),
  (4, 'What''s the name of the hotel {0} your parents are staying?', null),
  (5, 'This school is only for children {0} first language is not English.', null),
  (6, 'The person from {0} I bought my car is a friend of my father''s.', null),
  (7, 'I live in a friendly village {0} everybody knows everybody else.', null)
) as v(n, template, hint)
where es.title = '94.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '94.3'
join (values
  (1, 'where'), (2, 'who'), (3, 'whose'), (4, 'where'),
  (5, 'whose'), (6, 'whom'), (7, 'where')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
