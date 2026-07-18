-- Additional exercises 2-4: "Present and past" (Units 1-14, Appendix 2).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`, which keeps the per-group "Units X" subtitle
-- correctly aligned — plain -layout offsets it by a row, same issue
-- as the Study Guide's STUDY UNIT column). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Per CLAUDE.md's rule, additional exercises attach to their tested
-- unit(s) via exercise_set_units rather than forming their own menu
-- — linked here to all of units 1-14, matching this exercise group's
-- own printed subtitle (a cumulative review, not scoped to one unit).
--
-- Exercise 2 ("Which is correct?") has no A/B lettering in the book —
-- each item is an inline "X / Y" choice — adapted the same way as
-- every other "which is correct" exercise this project: the blank's
-- correct answer is the full correct phrase.
-- Exercise 4 ("Use your own ideas...") looked open-ended by
-- instruction wording, but the Key gives one fixed grammar pattern
-- per item (same "check the Key, not the instruction" lesson as
-- 47.2/51.3/59.1 elsewhere) — seeded normally, item 1 dropped as the
-- book's own example (Key starts at item 2).
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 2', 'Additional exercise 3', 'Additional exercise 4') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 2', 'Which is correct?', 0
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10','unit-11','unit-12','unit-13','unit-14')
where es.title = 'Additional exercise 2' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Lisa {0} to work yesterday. She wasn''t feeling well.'),
  (2, 'Look! That man over there {0} the same sweater as you.'),
  (3, 'I {0} to New Zealand last year.'),
  (4, 'I {0} from Jess recently. I hope she''s OK.'),
  (5, 'I wonder why James {0} so nice to me today. He isn''t usually like that.'),
  (6, 'Jane had a book open in front of her, but she {0} it.'),
  (7, 'I wasn''t very busy. I {0} much to do.'),
  (8, '{0} to get dark. Shall I turn on the light?'),
  (9, 'After leaving school, Mark {0} in a hotel for a while.'),
  (10, 'When Sue heard the news, she {0} very pleased.'),
  (11, 'This is a nice hotel, isn''t it? Is this the first time {0} here?'),
  (12, 'I need a new job. {0} the same job for too long.'),
  (13, '''Anna has gone out.'' ''Oh, has she? What time {0}?'''),
  (14, '''You look tired.'' ''Yes, {0} basketball.'''),
  (15, 'Where {0} from? Are you American?'),
  (16, 'I''d like to see Tina again. It''s a long time {0}.'),
  (17, 'Robert and Maria have been married {0}.')
) as v(n, template)
where es.title = 'Additional exercise 2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 2' and es.kind = 'additional'
join (values
  (1, 'didn''t go'),
  (2, 'is wearing'),
  (3, 'went'),
  (4, 'haven''t heard'),
  (5, 'is being'),
  (6, 'wasn''t reading'),
  (7, 'didn''t have'),
  (8, 'It''s beginning'),
  (9, 'worked'),
  (10, 'wasn''t'),
  (11, 'you''ve stayed'),
  (12, 'I''ve been doing'),
  (13, 'did she go'),
  (14, 'I''ve been playing'),
  (15, 'do you come'),
  (16, 'since I saw her'),
  (17, 'for 20 years')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 3', 'Complete each question using a suitable verb.', 1
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10','unit-11','unit-12','unit-13','unit-14')
where es.title = 'Additional exercise 3' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'a: Where {0}? b: Just to the shop at the end of the street. I''ll only be ten minutes.'),
  (2, 'a: {0} TV every day? b: No, only if there''s something special on.'),
  (3, 'a: Your house is lovely. How long {0} here? b: Nearly ten years.'),
  (4, 'a: How was your parents'' holiday? {0} a nice time? b: Yes, they really enjoyed it.'),
  (5, 'a: {0} Sarah recently? b: Yes, we had lunch together a few days ago.'),
  (6, 'a: Can you describe the woman you saw? What {0}? b: A red sweater and black jeans.'),
  (7, 'a: I''m sorry to keep you waiting. {0} long? b: No, only about ten minutes.'),
  (8, 'a: How long {0} to get from here to the airport? b: Usually about 45 minutes. It depends on the traffic.'),
  (9, 'a: {0} this song before? b: No, this is the first time. I like it.'),
  (10, 'a: {0} to the United States? b: No, never, but I went to Canada a few years ago.')
) as v(n, template)
where es.title = 'Additional exercise 3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 3' and es.kind = 'additional'
join (values
  (1, 'are you going', array[]::text[]),
  (2, 'Do you watch', array[]::text[]),
  (3, 'have you lived', array['have you been living', 'have you been']::text[]),
  (4, 'Did they have', array[]::text[]),
  (5, 'Have you seen', array[]::text[]),
  (6, 'was she wearing', array[]::text[]),
  (7, 'Have you been waiting', array['Have you been here']::text[]),
  (8, 'does it take', array[]::text[]),
  (9, 'Have you heard', array[]::text[]),
  (10, 'Have you been', array['Have you ever been']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 4', 'Use your own ideas to complete B''s sentences.', 2
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10','unit-11','unit-12','unit-13','unit-14')
where es.title = 'Additional exercise 4' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'a: How well do you know Ben? b: Very well. We {0} since we were children.'),
  (2, 'a: Did you enjoy your holiday? b: Yes, it was really good. It''s the best holiday {0}.'),
  (3, 'a: Is David still here? b: No, I''m afraid he isn''t. {0} about ten minutes ago.'),
  (4, 'a: I like your suit. I haven''t seen it before. b: It''s new. It''s the first time {0}.'),
  (5, 'a: How did you cut your knee? b: I slipped and fell when {0} tennis.'),
  (6, 'a: Do you ever go swimming? b: Not these days. I haven''t {0} a long time.'),
  (7, 'a: How often do you go to the cinema? b: Very rarely. It''s nearly a year {0} to the cinema.'),
  (8, 'a: I bought some new shoes. Do you like them? b: Yes, they''re very nice. Where {0} them?')
) as v(n, template)
where es.title = 'Additional exercise 4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 4' and es.kind = 'additional'
join (values
  (1, '''ve known each other', array['have known each other', '''ve been friends', 'have been friends']::text[]),
  (2, 'I''ve ever had', array['I''ve ever been on', 'I''ve had for ages']::text[]),
  (3, 'He went', array['He went home', 'He went out', 'He left']::text[]),
  (4, 'I''ve worn it', array[]::text[]),
  (5, 'I was playing', array[]::text[]),
  (6, 'been swimming for', array[]::text[]),
  (7, 'since I''ve been', array['since I went', 'since I last went']::text[]),
  (8, 'did you buy', array['did you get']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
