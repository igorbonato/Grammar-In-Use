-- Additional exercise 30: "Pronouns and determiners" (Units 82-91).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- "Which alternatives are correct?" (lettered A/B/C, some items
-- accepting two letters) follows the same convention as exercise 16.
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 30' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 30',
  'Which alternatives are correct? Sometimes only one alternative is correct, and sometimes two alternatives are possible.', 0
from units u where u.slug = 'unit-82';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-82','unit-83','unit-84','unit-85','unit-86','unit-87','unit-88','unit-89','unit-90','unit-91')
where es.title = 'Additional exercise 30' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Chris and I have known {0} for quite a long time. Which is correct — A us, B each other, or C ourselves?'),
  (2, '''How often do the buses run?'' ''{0} twenty minutes.'' Which is correct — A All, B Each, or C Every?'),
  (3, 'I shouted for help, but {0} came. Which is correct — A nobody, B no-one, or C anybody?'),
  (4, 'Last night we went out with some friends of {0}. Which is correct — A us, B our, or C ours?'),
  (5, 'It didn''t take us a long time to get here. {0} traffic. Which is correct — A It wasn''t much, B There wasn''t much, or C It wasn''t a lot?'),
  (6, 'Can I have {0} milk in my coffee, please? Which is correct — A a little, B any, or C some?'),
  (7, 'Sometimes I find it difficult to {0}. Which is correct — A concentrate, B concentrate me, or C concentrate myself?'),
  (8, 'There''s {0} on at the cinema that I want to see, so there''s no point in going. Which is correct — A something, B anything, or C nothing?'),
  (9, 'I drink {0} water every day. Which is correct — A much, B a lot of, or C lots of?'),
  (10, '{0} in the city centre are open on Sunday. Which is correct — A Most of shops, B Most of the shops, or C The most of the shops?'),
  (11, 'There were about twenty people in the photo. I didn''t recognise {0} of them. Which is correct — A any, B none, or C either?'),
  (12, 'I''ve been waiting {0} for Sarah to phone. Which is correct — A all morning, B the whole morning, or C all the morning?'),
  (13, 'I can''t afford to buy anything in this shop. {0} so expensive. Which is correct — A All is, B Everything is, or C All are?')
) as v(n, template)
where es.title = 'Additional exercise 30';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 30' and es.kind = 'additional'
join (values
  (1, 'each other', array[]::text[]),
  (2, 'Every', array[]::text[]),
  (3, 'nobody', array['no-one']::text[]),
  (4, 'ours', array[]::text[]),
  (5, 'There wasn''t much', array[]::text[]),
  (6, 'a little', array['some']::text[]),
  (7, 'concentrate', array[]::text[]),
  (8, 'nothing', array[]::text[]),
  (9, 'a lot of', array['lots of']::text[]),
  (10, 'Most of the shops', array[]::text[]),
  (11, 'any', array[]::text[]),
  (12, 'all morning', array['the whole morning']::text[]),
  (13, 'Everything is', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
