-- Marco 4 (slice 19): seeds the third slice of the "Pronouns and
-- determiners" module — units 86-87 (no/none/any, much/many/little/few/a
-- lot/plenty).
--
-- Sourced from pdf/Modulos/Pronouns and determiners.pdf (extracted via
-- `pdftotext -layout`, and re-extracted in plain mode where the -layout
-- version scrambled a two-column exercise — see 86.2 note below) and
-- cross-checked against pdf/Key to Exercises.pdf (plain mode, same
-- workaround as prior slices).
--
-- 86.2 is a two-column exercise in the book (answer each question first
-- with none-style words, then again with any-style words); -layout
-- extraction interleaved the two columns' text out of order. Re-extracting
-- in plain mode recovered the correct reading order. Modelled as 10
-- separate full-sentence-answer items (renumbered 1-10), the book's items 1
-- and 7 being worked examples for the two halves.
--
-- 87.1 ("change much to many/a lot where necessary, or write OK") is
-- authored as a single-word blank on "much" itself for every item,
-- including the "OK" ones (correct_answer = 'much', hint = 'OK — no change
-- needed') rather than leaving those items without any blank at all. This
-- diverges slightly from 84.4's precedent in the prior slice, where "OK"
-- items had no {0} placeholder at all (so nothing was actually gradable)
-- — here every item keeps a real, gradable input.
--
-- Additional exercise 30 (page 320) is cross-referenced at the end of both
-- units 82, 86 and (later) 90 in this same module — deferred, consistent
-- with every module so far.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 86: no/none/any
-- ============================================================

delete from units where slug = 'unit-86';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 86, 'unit-86', 'no/none/any', null,
  'We use no + noun to mean ''not a'' or ''not any'' (There was no bus). We use none without a noun, or none of + a noun phrase (None of the tickets were sold). Nothing/nobody/no-one/nowhere can begin a sentence or stand alone as an answer, and mean the same as not + anything/anybody/anyone/anywhere — but we don''t use a negative verb together with them.', 4
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'no and none',
  'We use no + noun (no bus, no shops etc.). no = not a or not any: We had to walk home. There was no bus. (= There wasn''t a bus.) Sarah will have no trouble finding a job. (= Sarah won''t have any trouble ...) There were no shops open. (= There weren''t any shops open.) You can use no + noun at the beginning of a sentence: No reason was given for the change of plan. We use none without a noun: ''How much money do you have?'' ''None.'' (= no money) All the tickets have been sold. There are none left. (= no tickets left) Or we use none of ...: This money is all yours. None of it is mine. Compare no, none and any: I have no luggage. ''How much luggage do you have?'' ''None.'' or ''I don''t have any.'' After none of + plural (none of the students, none of them etc.) the verb can be singular or plural: None of the students were happy. or None of the students was happy.', 0
from units where slug = 'unit-86';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'nothing, nobody/no-one, nowhere',
  'You can use these words at the beginning of a sentence or alone (as answers to questions): ''What''s going to happen?'' ''Nobody knows. / No-one knows.'' ''What happened?'' ''Nothing.'' ''Where are you going?'' ''Nowhere. I''m staying here.'' You can also use these words after a verb, especially after be and have: The house is empty. There''s nobody living there. We had nothing to eat. nothing/nobody etc. = not + anything/anybody etc.: I said nothing. = I didn''t say anything. Jane told nobody about her plans. = Jane didn''t tell anybody about her plans. They have nowhere to live. = They don''t have anywhere to live. With nothing/nobody etc., we do not use a negative verb (isn''t, didn''t etc.): I said nothing. (not I didn''t say nothing)', 1
from units where slug = 'unit-86';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'after nobody/no-one you can use they/them/their',
  'Nobody is perfect, are they? (= is he or she perfect?) No-one did what I asked them to do. (= him or her) Nobody in the class did their homework. (= his or her homework)', 2
from units where slug = 'unit-86';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'no- and any- (= it doesn''t matter which/what/who)',
  'Sometimes any/anything/anybody etc. means ''it doesn''t matter which/what/who''. Compare no- and any-: There was no bus, so we walked home. You can take any bus. They all go to the centre. (= it doesn''t matter which bus) ''What do you want to eat?'' ''Nothing. I''m not hungry.'' I''m so hungry. I could eat anything. (= it doesn''t matter what) It''s a difficult job. Nobody wants to do it. It''s a very easy job. Anybody can do it. (= it doesn''t matter who)', 3
from units where slug = 'unit-86';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-86'
join (values
  ('A', 'We had to walk home. There was no bus.', '= There wasn''t a bus.', 0),
  ('A', 'Sarah will have no trouble finding a job.', '= Sarah won''t have any trouble ...', 1),
  ('A', 'There were no shops open.', '= There weren''t any shops open.', 2),
  ('A', 'No reason was given for the change of plan.', null, 3),
  ('A', '''How much money do you have?'' ''None.''', '= no money', 4),
  ('A', 'All the tickets have been sold. There are none left.', '= no tickets left', 5),
  ('A', 'This money is all yours. None of it is mine.', null, 6),
  ('A', 'I have no luggage.', null, 7),
  ('A', '''How much luggage do you have?'' ''None.'' or ''I don''t have any.''', null, 8),
  ('A', 'None of the students were happy. or None of the students was happy.', null, 9),
  ('B', '''What''s going to happen?'' ''Nobody knows. / No-one knows.''', null, 0),
  ('B', '''What happened?'' ''Nothing.''', null, 1),
  ('B', '''Where are you going?'' ''Nowhere. I''m staying here.''', null, 2),
  ('B', 'The house is empty. There''s nobody living there.', null, 3),
  ('B', 'We had nothing to eat.', null, 4),
  ('B', 'I said nothing.', '= I didn''t say anything', 5),
  ('B', 'Jane told nobody about her plans.', '= Jane didn''t tell anybody about her plans', 6),
  ('B', 'They have nowhere to live.', '= They don''t have anywhere to live', 7),
  ('B', 'I said nothing. (not I didn''t say nothing)', null, 8),
  ('C', 'Nobody is perfect, are they?', '= is he or she perfect?', 0),
  ('C', 'No-one did what I asked them to do.', '= him or her', 1),
  ('C', 'Nobody in the class did their homework.', '= his or her homework', 2),
  ('D', 'There was no bus, so we walked home.', null, 0),
  ('D', 'You can take any bus. They all go to the centre.', '= it doesn''t matter which bus', 1),
  ('D', '''What do you want to eat?'' ''Nothing. I''m not hungry.''', null, 2),
  ('D', 'I''m so hungry. I could eat anything.', '= it doesn''t matter what', 3),
  ('D', 'It''s a difficult job. Nobody wants to do it.', null, 4),
  ('D', 'It''s a very easy job. Anybody can do it.', '= it doesn''t matter who', 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 86.1-86.4; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '86.1', 'Complete these sentences with no, none or any.', 0
from units where slug = 'unit-86';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-86' where es.title = '86.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We had to walk home. There were {0} taxis.', null),
  (2, 'We had to walk home. There weren''t {0} taxis.', null),
  (3, '''How many eggs do we have?'' ''{0}. Shall I get some?''', null),
  (4, 'There''s nowhere to cross the river. There''s {0} bridge.', null),
  (5, 'We took a few pictures, but {0} of them were very good.', null),
  (6, '''Did you take lots of pictures?'' ''No, I didn''t take {0}.''', null),
  (7, 'I had to do what I did. I had {0} alternative.', null),
  (8, 'I don''t like {0} of this furniture. It''s horrible.', null),
  (9, 'We cancelled the party because {0} of the people we invited were able to come.', null),
  (10, 'Everyone knows they are getting married. It''s {0} secret.', null),
  (11, 'The two books are exactly the same. There isn''t {0} difference.', null),
  (12, '''Do you know where Chris is?'' ''I''m sorry. I have {0} idea.''', null)
) as v(n, template, hint)
where es.title = '86.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '86.1'
join (values
  (1, 'no'), (2, 'any'), (3, 'None'), (4, 'no'), (5, 'none'), (6, 'any'),
  (7, 'no'), (8, 'any'), (9, 'none'), (10, 'no'), (11, 'any'), (12, 'no')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '86.2', 'Answer these questions using none/nobody/nothing/nowhere. Then answer the same questions using any/anybody/anything/anywhere.', 1
from units where slug = 'unit-86';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-86' where es.title = '86.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Who are you waiting for? {0}', 'Answer using nobody/no-one.'),
  (2, 'How much bread did you buy? {0}', 'Answer using none.'),
  (3, 'Where are you going? {0}', 'Answer using nowhere.'),
  (4, 'How many books have you read this year? {0}', 'Answer using none.'),
  (5, 'How much does it cost to get into the museum? {0}', 'Answer using nothing.'),
  (6, 'Who are you waiting for? {0}', 'Answer using anybody/anyone.'),
  (7, 'How much bread did you buy? {0}', 'Answer using any.'),
  (8, 'Where are you going? {0}', 'Answer using anywhere.'),
  (9, 'How many books have you read this year? {0}', 'Answer using any.'),
  (10, 'How much does it cost to get into the museum? {0}', 'Answer using anything.')
) as v(n, template, hint)
where es.title = '86.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '86.2'
join (values
  (1, 'Nobody. I''m just standing here.', array['No-one. I''m just standing here.']::text[]),
  (2, 'None. We already have enough.', array[]::text[]),
  (3, 'Nowhere. I''m staying here.', array[]::text[]),
  (4, 'None. I don''t read books.', array[]::text[]),
  (5, 'Nothing. It''s free.', array[]::text[]),
  (6, 'I''m not waiting for anybody.', array['I''m not waiting for anyone.']::text[]),
  (7, 'I didn''t buy any.', array['I didn''t buy any bread.']::text[]),
  (8, 'I''m not going anywhere.', array[]::text[]),
  (9, 'I haven''t read any.', array['I haven''t read any books.']::text[]),
  (10, 'It doesn''t cost anything.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '86.3', 'Complete these sentences with no- or any- + -body/-thing/-where.', 2
from units where slug = 'unit-86';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-86' where es.title = '86.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The bus was completely empty. There was {0} on it.', null),
  (2, '''Where did you go for your holidays?'' ''{0}. I didn''t go away.''', null),
  (3, '''Can you smell gas?'' ''No, I can''t smell {0}.''', null),
  (4, 'Everybody seemed satisfied. {0} complained.', null),
  (5, 'Let''s go away. We can go {0} you like.', null),
  (6, 'The town is still the same as it was years ago. {0} has changed.', null),
  (7, '''What did you buy?'' ''{0}. I couldn''t find {1} I wanted.''', null),
  (8, 'There was complete silence in the room. {0} said {1}.', null)
) as v(n, template, hint)
where es.title = '86.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '86.3'
join (values
  (1, 0, 'nobody', array['no-one']::text[]),
  (2, 0, 'Nowhere', array[]::text[]),
  (3, 0, 'anything', array[]::text[]),
  (4, 0, 'Nobody', array['No-one']::text[]),
  (5, 0, 'anywhere', array[]::text[]),
  (6, 0, 'Nothing', array[]::text[]),
  (7, 0, 'Nothing', array[]::text[]), (7, 1, 'anything', array[]::text[]),
  (8, 0, 'Nobody', array['No-one']::text[]), (8, 1, 'anything', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '86.4', 'Which is right?', 3
from units where slug = 'unit-86';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-86' where es.title = '86.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The accident looked bad, but fortunately {0} was seriously injured.', '(nobody / anybody)'),
  (2, 'I looked out of the window, but I couldn''t see {0}.', '(no-one / anyone)'),
  (3, 'The exam is very easy. {0} can pass it.', '(Nobody / Anybody)'),
  (4, '''What''s in that box?'' ''{0}. It''s empty.''', '(Nothing / Anything)'),
  (5, 'The future is uncertain. {0} is possible.', '(Nothing / Anything)'),
  (6, 'I don''t know {0} about economics.', '(nothing / anything)'),
  (7, 'I''ll try and answer {0} questions you ask me.', '(no / any)'),
  (8, '''Who were you talking to just now?'' ''{0}. I wasn''t talking to {1}.''', '(No-one / Anyone) ... (no-one / anyone)')
) as v(n, template, hint)
where es.title = '86.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '86.4'
join (values
  (1, 0, 'nobody'), (2, 0, 'anyone'), (3, 0, 'Anybody'), (4, 0, 'Nothing'),
  (5, 0, 'Anything'), (6, 0, 'anything'), (7, 0, 'any'),
  (8, 0, 'No-one'), (8, 1, 'anyone')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 87: much, many, little, few, a lot, plenty
-- ============================================================

delete from units where slug = 'unit-87';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 87, 'unit-87', 'much, many, little, few, a lot, plenty', null,
  'We use much and little with uncountable nouns, and many and few with plural nouns; a lot of / lots of / plenty of work with both. Little and few (without ''a'') mean ''not much/not many'', while a little and a few mean ''some, a small amount/number''.', 5
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'much/little (uncountable), many/few (plural), a lot of/lots of/plenty of (both)',
  'We use much and little with uncountable nouns: little money, much luck, much time, little energy. We use many and few with plural nouns: few children, many friends, many people, few cars. We use a lot of / lots of / plenty of with both uncountable and plural nouns: a lot of luck, lots of time, plenty of money; a lot of friends, lots of people, plenty of ideas. plenty = more than enough: There''s no need to hurry. We''ve got plenty of time. There''s plenty to do in this town.', 0
from units where slug = 'unit-87';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'much is unusual in positive sentences',
  'Much is unusual in positive sentences (especially in spoken English). Compare: We didn''t spend much money. but We spent a lot of money. Do you see David much? but I see David a lot. But we use too much / so much / as much in positive sentences: We spent too much money. We use many and a lot of in all kinds of sentences: Many people drive too fast. or A lot of people drive too fast. Do you know many people? or Do you know a lot of people? There aren''t many tourists here. or There aren''t a lot of tourists here. Note that we say many years / many weeks / many days: We''ve lived here for many years. (not usually a lot of years)', 1
from units where slug = 'unit-87';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'little = not much, few = not many',
  'little = not much, few = not many: Gary is very busy with his job. He has little time for other things. (= not much time, less time than he would like) Vicky doesn''t like living in London. She has few friends there. (= not many friends, not as many as she would like) We often use very little and very few: Gary has very little time for other things. Vicky has very few friends in London.', 2
from units where slug = 'unit-87';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'a little = some, a few = some',
  'a little = some, a small amount: Let''s go and have coffee. We have a little time before the train leaves. (a little time = some time, enough time to have a coffee) ''Do you speak English?'' ''A little.'' (so we can talk a bit) a few = some, a small number: I enjoy my life here. I have a few friends and we meet quite often. (a few friends = not many, but enough to have a good time) ''When was the last time you saw Clare?'' ''A few days ago.'' (= 3 or 4 days ago)', 3
from units where slug = 'unit-87';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'little vs a little, few vs a few',
  'Compare little and a little, few and a few: He spoke little English, so it was difficult to communicate with him. He spoke a little English, so we were able to communicate with him. She''s lucky. She has few problems. (= not many problems) Things are not going so well for her. She has a few problems. (= some problems) We say only a little (not only little) and only a few (not only few): Hurry! We only have a little time. (= some, but not much time) The village was small. There were only a few houses. (= some but not many houses)', 4
from units where slug = 'unit-87';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-87'
join (values
  ('A', 'little money, much luck, much time, little energy', null, 0),
  ('A', 'few children, many friends, many people, few cars', null, 1),
  ('A', 'a lot of luck, lots of time, plenty of money', null, 2),
  ('A', 'a lot of friends, lots of people, plenty of ideas', null, 3),
  ('A', 'There''s no need to hurry. We''ve got plenty of time.', null, 4),
  ('A', 'There''s plenty to do in this town.', null, 5),
  ('B', 'We didn''t spend much money. but We spent a lot of money.', null, 0),
  ('B', 'Do you see David much? but I see David a lot.', null, 1),
  ('B', 'We spent too much money.', null, 2),
  ('B', 'Many people drive too fast. or A lot of people drive too fast.', null, 3),
  ('B', 'Do you know many people? or Do you know a lot of people?', null, 4),
  ('B', 'There aren''t many tourists here. or There aren''t a lot of tourists here.', null, 5),
  ('B', 'We''ve lived here for many years.', 'not usually a lot of years', 6),
  ('C', 'Gary is very busy with his job. He has little time for other things.', '= not much time, less time than he would like', 0),
  ('C', 'Vicky doesn''t like living in London. She has few friends there.', '= not many friends, not as many as she would like', 1),
  ('C', 'Gary has very little time for other things.', null, 2),
  ('C', 'Vicky has very few friends in London.', null, 3),
  ('D', 'Let''s go and have coffee. We have a little time before the train leaves.', '= some time, enough time to have a coffee', 0),
  ('D', '''Do you speak English?'' ''A little.''', 'so we can talk a bit', 1),
  ('D', 'I enjoy my life here. I have a few friends and we meet quite often.', '= not many, but enough to have a good time', 2),
  ('D', '''When was the last time you saw Clare?'' ''A few days ago.''', '= 3 or 4 days ago', 3),
  ('E', 'He spoke little English, so it was difficult to communicate with him.', null, 0),
  ('E', 'He spoke a little English, so we were able to communicate with him.', null, 1),
  ('E', 'She''s lucky. She has few problems.', '= not many problems', 2),
  ('E', 'Things are not going so well for her. She has a few problems.', '= some problems', 3),
  ('E', 'Hurry! We only have a little time.', '= some, but not much time', 4),
  ('E', 'The village was small. There were only a few houses.', '= some but not many houses', 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 87.1-87.5; each renumbered from 1, dropping
-- the book's own worked example at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '87.1', 'In some of these sentences much is incorrect or unnatural. Put in the right word — much, many or a lot (of).', 0
from units where slug = 'unit-87';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-87' where es.title = '87.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My mother drinks {0} tea.', null),
  (2, 'Be quick. We don''t have {0} time.', 'OK — no change needed'),
  (3, 'It cost {0} to repair the car.', null),
  (4, 'Did it cost {0} to repair the car?', 'OK — no change needed'),
  (5, 'You have {0} luggage. Let me help you.', null),
  (6, 'There wasn''t {0} traffic this morning.', 'OK — no change needed'),
  (7, 'I don''t know {0} people in this town.', null),
  (8, 'Do you eat {0} fruit?', 'OK — no change needed'),
  (9, 'Mike likes travelling. He travels {0}.', null)
) as v(n, template, hint)
where es.title = '87.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '87.1'
join (values
  (1, 'a lot of', array[]::text[]),
  (2, 'much', array[]::text[]),
  (3, 'a lot', array[]::text[]),
  (4, 'much', array[]::text[]),
  (5, 'a lot of', array[]::text[]),
  (6, 'much', array[]::text[]),
  (7, 'many', array['a lot of']::text[]),
  (8, 'much', array[]::text[]),
  (9, 'a lot', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '87.2', 'Complete the sentences using plenty of ... or plenty to ... . Choose from: hotels, learn, money, room, see, time.', 1
from units where slug = 'unit-87';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-87' where es.title = '87.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'He has no financial problems. He has {0}.', null),
  (2, 'Come and sit with us. There''s {0}.', null),
  (3, 'She knows a lot, but she still has {0}.', null),
  (4, 'It''s an interesting town to visit. There {0}.', null),
  (5, 'I''m sure we''ll find somewhere to stay. {0}', null)
) as v(n, template, hint)
where es.title = '87.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '87.2'
join (values
  (1, 'plenty of money'), (2, 'plenty of room'), (3, 'plenty to learn'),
  (4, 'is plenty to see'), (5, 'There are plenty of hotels.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '87.3', 'Put in much/many/little/few (one word only).', 2
from units where slug = 'unit-87';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-87' where es.title = '87.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Anna is very busy these days. She has {0} free time.', null),
  (2, 'Did you take {0} pictures at the wedding?', null),
  (3, 'This is a modern city. There are {0} old buildings.', null),
  (4, 'The weather has been very dry recently. We''ve had {0} rain.', null),
  (5, 'I don''t know London well. I haven''t been there for {0} years.', null),
  (6, 'The two cars are similar. There is {0} difference between them.', null),
  (7, 'I''m not very busy today. I don''t have {0} to do.', null),
  (8, 'It''s a wonderful place to live. There are {0} better places to be.', null)
) as v(n, template, hint)
where es.title = '87.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '87.3'
join (values
  (1, 'little'), (2, 'many'), (3, 'few'), (4, 'little'),
  (5, 'many'), (6, 'little'), (7, 'much'), (8, 'few')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '87.4', 'Which is right?', 3
from units where slug = 'unit-87';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-87' where es.title = '87.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Can you lend me {0}?', '(few dollars / a few dollars)'),
  (2, 'It was the middle of the night, so there was {0}.', '(little traffic / a little traffic)'),
  (3, 'They got married {0}.', '(few years ago / a few years ago)'),
  (4, 'I can''t give you a decision yet. I need {0} to think.', '(little time / a little time)'),
  (5, 'I don''t know much Russian — {0}.', '(only few words / only a few words)'),
  (6, '{0} expected him to win.', '(Few people / A few people)')
) as v(n, template, hint)
where es.title = '87.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '87.4'
join (values
  (1, 'a few dollars'), (2, 'little traffic'), (3, 'a few years ago'),
  (4, 'a little time'), (5, 'only a few words'), (6, 'Few people')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '87.5', 'Put in little / a little / few / a few.', 4
from units where slug = 'unit-87';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-87' where es.title = '87.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Listen carefully. I''m going to give you {0} advice.', null),
  (2, 'Do you mind if I ask you {0} questions?', null),
  (3, 'It''s not a very interesting place, so {0} tourists visit.', null),
  (4, 'I don''t think Amy would be a good teacher. She has {0} patience.', null),
  (5, '''Would you like milk in your coffee?'' ''Yes, {0}, please.''', null),
  (6, 'This is a boring place to live. There''s {0} to do.', null),
  (7, 'I know Hong Kong quite well. I''ve been there {0} times.', null),
  (8, 'There were only {0} people at the meeting.', null),
  (9, '''Did you do all this work on your own?'' ''No, I had {0} help from my friends.''', null)
) as v(n, template, hint)
where es.title = '87.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '87.5'
join (values
  (1, 'a little'), (2, 'a few'), (3, 'few'), (4, 'little'), (5, 'a little'),
  (6, 'little'), (7, 'a few'), (8, 'a few'), (9, 'a little')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
