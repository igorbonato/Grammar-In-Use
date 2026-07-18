-- Marco 4 (slice 34): seeds the seventh slice of the "Adjectives and
-- adverbs" module — units 109 (Word order 1: verb + object; place and
-- time) and 110 (Word order 2: adverbs with the verb).
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 109.1/110.1 ("Is the word order OK or not? Correct the sentences where
-- necessary") reuse the whole-sentence "OK" convention introduced for
-- 95.3/0026: correct_answer is literally "OK" for already-correct items,
-- the corrected sentence otherwise.
--
-- 110.2 flattens the book's own a/b/c sub-items (6a/6b/6c, 7a/7b, 8a/8b)
-- into one sequential 1-11 list, since this app's exercise_sentences
-- table has no sub-lettering — same approach as 98.1's a/b/c sub-items in
-- 0029.
--
-- 110.3 items 16 and 17 (renumbered 15 and 16) are the only two-blank
-- items in this slice.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 109: Word order 1: verb + object; place and time
-- ============================================================

delete from units where slug = 'unit-109';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 109, 'unit-109', 'Word order 1: verb + object; place and time', null,
  'The verb and its object normally go together, with nothing between them (not I like very much my job). If the verb has an object, place (where?) comes right after the object, and time (when?/how often?/how long?) normally comes after place: took the children to the zoo every day. Time can also go at the beginning of the sentence: On Monday I''m going to Paris.', 11
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verb + object',
  'The verb and the object normally go together. We do not usually put other words between them: I like my job very much. (not I like very much my job) Our guide spoke English fluently. (not spoke fluently English) I didn''t use my phone yesterday. Do you eat meat every day? Two more examples: I lost all my money and I also lost my passport. (not I lost also my passport) At the end of this street you''ll see a supermarket on your left. (not see on your left a supermarket)', 0
from units where slug = 'unit-109';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'place',
  'The verb and place (where?) normally go together: go home, live in a city, walk to work etc. If the verb has an object, the order is verb + object + place: Did you take the children to the zoo? (not took to the zoo the children) We put anything on the table. Did you learn English at school?', 1
from units where slug = 'unit-109';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'time',
  'Normally time (when? / how often? / how long?) goes after place: Ben walks to work every morning. (not every morning to work) I''m going to Paris on Monday. They''ve lived in the same house for a long time. Sarah gave me a lift home after the party. You really shouldn''t go to bed so late. Sometimes we put time at the beginning of the sentence: On Monday I''m going to Paris. After the party Sarah gave me a lift home. Some time words (for example, always/never/usually) go with the verb in the middle of the sentence. See Unit 110.', 2
from units where slug = 'unit-109';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-109'
join (values
  ('A', 'I like my job very much.', 'not I like very much my job', 0),
  ('A', 'Our guide spoke English fluently.', 'not spoke fluently English', 1),
  ('A', 'I lost all my money and I also lost my passport.', 'not I lost also my passport', 2),
  ('A', 'At the end of this street you''ll see a supermarket on your left.', 'not see on your left a supermarket', 3),
  ('B', 'Did you take the children to the zoo?', 'not took to the zoo the children', 0),
  ('B', 'We put anything on the table.', null, 1),
  ('B', 'Did you learn English at school?', null, 2),
  ('C', 'Ben walks to work every morning.', 'not every morning to work', 0),
  ('C', 'I''m going to Paris on Monday.', null, 1),
  ('C', 'They''ve lived in the same house for a long time.', null, 2),
  ('C', 'Sarah gave me a lift home after the party.', null, 3),
  ('C', 'You really shouldn''t go to bed so late.', null, 4),
  ('C', 'On Monday I''m going to Paris.', 'time at the start of the sentence', 5),
  ('C', 'After the party Sarah gave me a lift home.', 'time at the start of the sentence', 6)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 109.1-109.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '109.1', 'Is the word order OK or not? Correct the sentences where necessary.', 0
from units where slug = 'unit-109';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-109' where es.title = '109.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Joe doesn''t like very much football. {0}', null),
  (2, 'Dan won easily the race. {0}', null),
  (3, 'Tanya speaks German quite well. {0}', null),
  (4, 'Have you seen recently Chris? {0}', null),
  (5, 'I borrowed from a friend some money. {0}', null),
  (6, 'Please don''t ask that question again. {0}', null),
  (7, 'I ate quickly my breakfast and went out. {0}', null),
  (8, 'Did you invite to the party a lot of people? {0}', null),
  (9, 'Sam watches all the time TV. {0}', null),
  (10, 'Does Kevin play football every weekend? {0}', null)
) as v(n, template, hint)
where es.title = '109.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '109.1'
join (values
  (1, 'Joe doesn''t like football very much.', array[]::text[]),
  (2, 'Dan won the race easily.', array[]::text[]),
  (3, 'OK', array[]::text[]),
  (4, 'Have you seen Chris recently?', array[]::text[]),
  (5, 'I borrowed some money from a friend.', array[]::text[]),
  (6, 'OK', array[]::text[]),
  (7, 'I ate my breakfast quickly and went out.', array['I quickly ate my breakfast and went out.']::text[]),
  (8, 'Did you invite a lot of people to the party?', array[]::text[]),
  (9, 'Sam watches TV all the time.', array[]::text[]),
  (10, 'OK', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '109.2', 'Complete the sentences. Put the parts in the correct order.', 1
from units where slug = 'unit-109';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-109' where es.title = '109.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I {0}', '(a friend of mine / on my way home / met)'),
  (2, 'I {0}', '(to put / on the envelope / a stamp / forgot)'),
  (3, 'We {0}', '(a lot of fruit / bought / in the market)'),
  (4, 'They {0}', '(opposite the park / a new hotel / built)'),
  (5, 'Did you {0}', '(at school / today / a lot of things / learn)'),
  (6, 'We {0}', '(some interesting books / found / in the library)'),
  (7, 'Please {0}', '(at the top / write / of the page / your name)')
) as v(n, template, hint)
where es.title = '109.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '109.2'
join (values
  (1, 'met a friend of mine on my way home.'),
  (2, 'forgot to put a stamp on the envelope.'),
  (3, 'bought a lot of fruit in the market.'),
  (4, 'built a new hotel opposite the park.'),
  (5, 'learn a lot of things at school today?'),
  (6, 'found some interesting books in the library.'),
  (7, 'write your name at the top of the page.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '109.3', 'Complete the sentences. Put the parts in the correct order.', 2
from units where slug = 'unit-109';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-109' where es.title = '109.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I {0}', '(to the supermarket / every Friday / go)'),
  (2, 'Why {0}', '(home / did you come / so late)'),
  (3, 'Sarah {0}', '(her children / takes / every day / to school)'),
  (4, 'I haven''t {0}', '(been / recently / to the cinema)'),
  (5, 'I {0}', '(her name / after a few minutes / remembered)'),
  (6, 'We {0}', '(around the town / all morning / walked)'),
  (7, 'My brother {0}', '(has been / since April / in Canada)'),
  (8, 'I {0}', '(on Saturday night / didn''t see you / at the party)'),
  (9, 'Lisa {0}', '(her umbrella / last night / in a restaurant / left)'),
  (10, 'The moon {0}', '(round the earth / every 27 days / goes)'),
  (11, 'Anna {0}', '(Italian / for the last three years / has been teaching / in London)')
) as v(n, template, hint)
where es.title = '109.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '109.3'
join (values
  (1, 'go to the supermarket every Friday.'),
  (2, 'did you come home so late?'),
  (3, 'takes her children to school every day.'),
  (4, 'been to the cinema recently.'),
  (5, 'remembered her name after a few minutes.'),
  (6, 'walked around the town all morning.'),
  (7, 'has been in Canada since April.'),
  (8, 'didn''t see you at the party on Saturday night.'),
  (9, 'left her umbrella in a restaurant last night.'),
  (10, 'goes round the earth every 27 days.'),
  (11, 'has been teaching Italian in London for the last three years.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 110: Word order 2: adverbs with the verb
-- ============================================================

delete from units where slug = 'unit-110';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 110, 'unit-110', 'Word order 2: adverbs with the verb', null,
  'Adverbs like always/also/probably normally go in the middle of the sentence, with the verb. If the verb is one word, the adverb goes before it (always drives), except after am/is/are/was/were, where it goes after (are also hungry). If the verb has two or more parts, the adverb goes after the first part (can never remember, will probably be). all and both work the same way (we all felt ill).', 12
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'adverbs in the middle of the sentence',
  'Some adverbs (for example, always, also, probably) go with the verb in the middle of a sentence: Emily always drives to work. We were feeling very tired and we were also hungry. The meeting will probably be cancelled.', 0
from units where slug = 'unit-110';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'one-word verbs',
  'If the verb is one word (drives/cooked etc.), the adverb goes before the verb: Emily always drives to work. I almost fell as I was going down the stairs. I cleaned the house and also cooked the dinner. (not cooked also) Laura hardly ever watches television and rarely reads newspapers. ''Shall I give you my address?'' ''No, I already have it.'' Note that these adverbs (always/usually/also etc.) go before have to ...: Joe never phones me. I always have to phone him. (not I have always to phone) But adverbs go after am/is/are/was/were: We were feeling very tired and we were also hungry. (not also were) You''re always late. You''re never on time. The traffic isn''t usually as bad as it was this morning.', 1
from units where slug = 'unit-110';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'verbs with two or more words',
  'If the verb is two or more words (for example, can remember / will be cancelled), the adverb usually goes after the first verb (can/doesn''t/will etc.): I can never remember her name. Clare doesn''t usually drive to work. Are you definitely away next week? The meeting will probably be cancelled. You''ve always been very kind to me. Jack can''t cook. He can''t even boil an egg. Do you still work for the same company? The house was only built a year ago and it''s already falling down. Note that probably goes before a negative (isn''t/won''t etc.). So we say: I probably won''t see you. or I''ll probably not see you. (but not I won''t probably)', 2
from units where slug = 'unit-110';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'all and both',
  'We also use all and both with the verb in the middle of a sentence: We all felt ill after the meal. (not felt all ill) My parents are both teachers. Sarah and Jane have both applied for the job. My friends are all going out tonight.', 3
from units where slug = 'unit-110';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'always/never before a repeated is/will/did',
  'Sometimes we use is/will/did etc. instead of repeating part of a sentence (see Unit 51): Tom says he isn''t clever, but I think he is. (= he is clever) When we do this, we put always/never etc. before the verb: He always says he won''t be late, but he always is. (= he is always late) I''ve never done it and I never will. (= I will never do it)', 4
from units where slug = 'unit-110';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-110'
join (values
  ('A', 'Emily always drives to work.', null, 0),
  ('A', 'We were feeling very tired and we were also hungry.', null, 1),
  ('A', 'The meeting will probably be cancelled.', null, 2),
  ('B', 'I almost fell as I was going down the stairs.', null, 0),
  ('B', 'I cleaned the house and also cooked the dinner.', 'not cooked also', 1),
  ('B', 'Laura hardly ever watches television and rarely reads newspapers.', null, 2),
  ('B', '''No, I already have it.''', null, 3),
  ('B', 'I always have to phone him.', 'not I have always to phone', 4),
  ('B', 'We were feeling very tired and we were also hungry.', 'not also were', 5),
  ('B', 'You''re always late. You''re never on time.', null, 6),
  ('C', 'I can never remember her name.', null, 0),
  ('C', 'Clare doesn''t usually drive to work.', null, 1),
  ('C', 'The meeting will probably be cancelled.', null, 2),
  ('C', 'You''ve always been very kind to me.', null, 3),
  ('C', 'Jack can''t cook. He can''t even boil an egg.', null, 4),
  ('C', 'Do you still work for the same company?', null, 5),
  ('C', 'The house was only built a year ago and it''s already falling down.', null, 6),
  ('C', 'I probably won''t see you. or I''ll probably not see you.', 'but not I won''t probably', 7),
  ('D', 'We all felt ill after the meal.', 'not felt all ill', 0),
  ('D', 'My parents are both teachers.', null, 1),
  ('D', 'Sarah and Jane have both applied for the job.', null, 2),
  ('E', 'Tom says he isn''t clever, but I think he is.', '= he is clever', 0),
  ('E', 'He always says he won''t be late, but he always is.', '= he is always late', 1),
  ('E', 'I''ve never done it and I never will.', '= I will never do it', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 110.1-110.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise; 110.2's a/b/c sub-items flattened into one sequence)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '110.1', 'Is the word order OK or not? Correct the sentences where necessary.', 0
from units where slug = 'unit-110';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-110' where es.title = '110.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I have usually a shower in the morning. {0}', null),
  (2, 'I''m usually hungry when I get home from work. {0}', null),
  (3, 'Steve gets hardly ever angry. {0}', null),
  (4, 'I called him and I sent also an email. {0}', null),
  (5, 'You don''t listen! I have always to repeat things. {0}', null),
  (6, 'I never have worked in a factory. {0}', null),
  (7, 'I never have enough time. I''m always busy. {0}', null),
  (8, 'When I arrived, my friends already were there. {0}', null)
) as v(n, template, hint)
where es.title = '110.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '110.1'
join (values
  (1, 'I usually have a shower in the morning.', array[]::text[]),
  (2, 'OK', array[]::text[]),
  (3, 'Steve hardly ever gets angry.', array[]::text[]),
  (4, 'I called him and I also sent an email.', array[]::text[]),
  (5, 'I always have to repeat things.', array[]::text[]),
  (6, 'I''ve never worked in a factory.', array['I have never worked in a factory.']::text[]),
  (7, 'OK', array[]::text[]),
  (8, 'my friends were already there.', array['my friends were there already.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '110.2', 'Rewrite the sentences to include the word in brackets.', 1
from units where slug = 'unit-110';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-110' where es.title = '110.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Katherine is very generous. {0}', '(always)'),
  (2, 'I don''t have to work on Sundays. {0}', '(usually)'),
  (3, 'Do you watch TV in the evenings? {0}', '(always)'),
  (4, 'Martin is learning Spanish, and he is learning Japanese. Martin is learning Spanish and he {0}', '(also)'),
  (5, 'We were on holiday in Spain. {0}', '(all)'),
  (6, 'We were staying at the same hotel. {0}', '(all)'),
  (7, 'We had a great time. {0}', '(all)'),
  (8, 'The new hotel is expensive. {0}', '(probably)'),
  (9, 'It costs a lot to stay there. {0}', '(probably)'),
  (10, 'I can help you. {0}', '(probably)'),
  (11, 'I can''t help you. {0}', '(probably)')
) as v(n, template, hint)
where es.title = '110.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '110.2'
join (values
  (1, 'Katherine is always very generous.'),
  (2, 'I don''t usually have to work on Sundays.'),
  (3, 'Do you always watch TV in the evenings?'),
  (4, 'is also learning Japanese.'),
  (5, 'We were all on holiday in Spain.'),
  (6, 'We were all staying at the same hotel.'),
  (7, 'We all had a great time.'),
  (8, 'The new hotel is probably expensive.'),
  (9, 'It probably costs a lot to stay there.'),
  (10, 'I can probably help you.'),
  (11, 'I probably can''t help you.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '110.3', 'Complete the sentences. Use the words in brackets in the correct order.', 2
from units where slug = 'unit-110';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-110' where es.title = '110.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Our cat {0} under the bed.', '(usually / sleeps)'),
  (2, 'There are plenty of hotels here. {0} to find a place to stay.', '(usually / it / easy / is)'),
  (3, 'Mark and Amy {0} in Manchester.', '(both / were / born)'),
  (4, 'Lisa is a good pianist. {0} very well.', '(sing / she / also / can)'),
  (5, 'How do you go to work? {0} by bus?', '(usually / you / do / go)'),
  (6, 'I see them every day, but {0} to them.', '(never / I / have / spoken)'),
  (7, 'We haven''t moved. {0} in the same place.', '(we / still / are / living)'),
  (8, 'This shop is always busy. {0} a long time to be served.', '(have / you / always / to wait)'),
  (9, 'This could be the last time I see you. {0} again.', '(meet / never / we / might)'),
  (10, 'Thanks for the invitation, but {0} able to come to the party.', '(probably / I / be / won''t)'),
  (11, 'I''m going out for an hour. {0} here when I get back?', '(still / be / you / will)'),
  (12, 'Helen goes away a lot. {0} at home.', '(is / hardly ever / she)'),
  (13, 'If we hadn''t taken the same train, {0} each other.', '(never / met / we / would / have)'),
  (14, 'The journey took a long time today. {0} so long.', '(doesn''t / take / it / always)'),
  (15, '{0} tired, so {1} asleep.', '(all / were / we) ... (all / we / fell)'),
  (16, 'Tanya {0} that she''ll phone me, but {1}.', '(says / always) ... (does / she / never)')
) as v(n, template, hint)
where es.title = '110.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '110.3'
join (values
  (1, 0, 'usually sleeps', array[]::text[]),
  (2, 0, 'It''s usually easy', array['It is usually easy', 'Usually it''s easy', 'Usually it is easy']::text[]),
  (3, 0, 'were both born', array[]::text[]),
  (4, 0, 'She can also sing', array[]::text[]),
  (5, 0, 'Do you usually go', array[]::text[]),
  (6, 0, 'I have never spoken', array['I''ve never spoken']::text[]),
  (7, 0, 'We''re still living', array['We are still living']::text[]),
  (8, 0, 'You always have to wait', array[]::text[]),
  (9, 0, 'We might never meet', array[]::text[]),
  (10, 0, 'I probably won''t be', array[]::text[]),
  (11, 0, 'Will you still be', array[]::text[]),
  (12, 0, 'She''s hardly ever', array['She is hardly ever']::text[]),
  (13, 0, 'we would never have met', array['we''d never have met']::text[]),
  (14, 0, 'It doesn''t always take', array[]::text[]),
  (15, 0, 'We were all', array[]::text[]), (15, 1, 'we all fell', array[]::text[]),
  (16, 0, 'always says', array[]::text[]), (16, 1, 'she never does', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
