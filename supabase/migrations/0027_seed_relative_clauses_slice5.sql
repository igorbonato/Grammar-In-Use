-- Marco 4 (slice 26): seeds the fifth slice of the "Relative clauses"
-- module — unit 96 (Relative clauses 5: extra information clauses (2)).
--
-- Sourced from pdf/Modulos/Relative clauses.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 96.2 ("Use the information in the first sentence to complete the
-- second one") has TWO pre-filled worked examples, not just one — item 1
-- for the first half of the exercise (all of / most of etc. + whom/which)
-- and item 9 for the second half ("Now use the ... of which ..."), each
-- introducing a different pattern. Confirmed via the Key, which skips
-- straight from item 8 to item 10. Same recurring gotcha as several
-- exercises since unit 52.1/0010; renumbered items 2-8 and 10-11 into a
-- single 1-9 sequence in this migration's DB rows.
--
-- Safe to re-run: unit 96 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 96: Relative clauses 5: extra information clauses (2)
-- ============================================================

delete from units where slug = 'unit-96';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 96, 'unit-96', 'Relative clauses 5: extra information clauses (2)', null,
  'In extra information clauses, a preposition can go directly before whom (for people) or which (for things): Mr Lee, to whom I spoke at the meeting, is interested in our proposal. You can also say all of whom, most of which, none of which, both of whom, the name of which etc. We use which (not what) to refer back to a whole previous clause: Sarah couldn''t meet us, which was a shame.', 4
from modules where slug = 'relative-clauses';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'preposition + whom/which',
  'You can use a preposition + whom (for people) and which (for things). So you can say: to whom, with whom, about whom etc.; of which, without which, from which etc. Mr Lee, to whom I spoke at the meeting, is interested in our proposal. Fortunately we had a good map, without which we would have got lost. In spoken English we often keep the preposition after the verb in the relative clause: Katherine told me she works for a company called ''Latoma'', which I''d never heard of before. We do not use whom when the preposition is in this position: Mr Lee, who I spoke to at the meeting, is interested in our proposal. (not Mr Lee, whom I spoke to ...) For prepositions in relative clauses, see also Unit 93C.', 0
from units where slug = 'unit-96';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'all of / most of etc. + whom/which',
  'You can say: Helen has three brothers, all of whom are married. They asked me a lot of questions, most of which I couldn''t answer. In the same way you can say: many of whom, some of whom, neither of whom etc. (for people); none of which, both of which, one of which etc. (for things). Martin tried on three jackets, none of which fitted him. Two men, neither of whom I had seen before, came into the office. They have three cars, two of which they rarely use. Sue has a lot of friends, many of whom she was at school with. You can also say: the cause of which, the name of which etc. The house was damaged in a fire, the cause of which was never established. We stayed at a beautiful hotel, the name of which I don''t remember now.', 1
from units where slug = 'unit-96';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'which (not what)',
  'Study this example: Joe got the job. This surprised everybody. (2 sentences) Joe got the job, which surprised everybody. (1 sentence) In this example, which = ''the fact that Joe got the job''. We use which (not what) in sentences like these: Sarah couldn''t meet us, which was a shame. (not what was a shame) The weather was good, which we hadn''t expected. (not what we hadn''t expected) For what and that, see Units 92D and 93D.', 2
from units where slug = 'unit-96';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-96'
join (values
  ('A', 'Mr Lee, to whom I spoke at the meeting, is interested in our proposal.', null, 0),
  ('A', 'Fortunately we had a good map, without which we would have got lost.', null, 1),
  ('A', 'Katherine told me she works for a company called ''Latoma'', which I''d never heard of before.', null, 2),
  ('A', 'Mr Lee, who I spoke to at the meeting, is interested in our proposal.', 'not Mr Lee, whom I spoke to ...', 3),
  ('B', 'Helen has three brothers, all of whom are married.', null, 0),
  ('B', 'They asked me a lot of questions, most of which I couldn''t answer.', null, 1),
  ('B', 'Martin tried on three jackets, none of which fitted him.', null, 2),
  ('B', 'Two men, neither of whom I had seen before, came into the office.', null, 3),
  ('B', 'They have three cars, two of which they rarely use.', null, 4),
  ('B', 'Sue has a lot of friends, many of whom she was at school with.', null, 5),
  ('B', 'The house was damaged in a fire, the cause of which was never established.', null, 6),
  ('B', 'We stayed at a beautiful hotel, the name of which I don''t remember now.', null, 7),
  ('C', 'Joe got the job. This surprised everybody.', '2 sentences', 0),
  ('C', 'Joe got the job, which surprised everybody.', '1 sentence', 1),
  ('C', 'Sarah couldn''t meet us, which was a shame.', 'not what was a shame', 2),
  ('C', 'The weather was good, which we hadn''t expected.', 'not what we hadn''t expected', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 96.1-96.3; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '96.1', 'Complete the sentences. Use a preposition + whom or which. Choose a preposition from: after, for, in, of, of, to, with, without.', 0
from units where slug = 'unit-96';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-96' where es.title = '96.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The accident, {0} two people were injured, happened late last night.', null),
  (2, 'I share an office with my boss, {0} I get on really well.', null),
  (3, 'The wedding, {0} only family members were invited, was a lovely occasion.', null),
  (4, 'Ben showed me his new car, {0} he''s very proud.', null),
  (5, 'Sarah showed us a picture of her son, {0} she''s very proud.', null),
  (6, 'Laura bought a very nice leather bag, {0} she paid twenty pounds.', null),
  (7, 'We had lunch, {0} we went for a long walk.', null)
) as v(n, template, hint)
where es.title = '96.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '96.1'
join (values
  (1, 'in which'), (2, 'with whom'), (3, 'to which'), (4, 'of which'),
  (5, 'of whom'), (6, 'for which'), (7, 'after which')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '96.2', 'Use the information in the first sentence to complete the second one. Use all of / most of etc., then the ... of which ... .', 1
from units where slug = 'unit-96';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-96' where es.title = '96.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Most of the information we were given was useless. We were given a lot of information, {0}', null),
  (2, 'None of the ten people who applied for the job was suitable. Ten people applied for the job, {0}', null),
  (3, 'My neighbours have two cars. They never use one of them. My neighbours have two cars, {0}', null),
  (4, 'James won a lot of money. He gave half of it to his parents. James won £100,000, {0}', null),
  (5, 'Both of Julia''s sisters are lawyers. Julia has two sisters, {0}', null),
  (6, 'Jane replied to neither of the emails I sent her. I sent Jane two emails, {0}', null),
  (7, 'I went to a party — I knew only a few of the people there. There were a lot of people at the party, {0}', null),
  (8, 'We drove along the road. The sides of the road were lined with trees. We drove along the road, {0}', null),
  (9, 'The aim of the company''s new business plan is to save money. The company has a new business plan, {0}', null)
) as v(n, template, hint)
where es.title = '96.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '96.2'
join (values
  (1, 'most of which was useless.'),
  (2, 'none of whom was suitable.'),
  (3, 'one of which they never use.'),
  (4, 'half of which he gave to his parents.'),
  (5, 'both of whom are lawyers.'),
  (6, 'neither of which she replied to.'),
  (7, 'only a few of whom I knew.'),
  (8, 'the sides of which were lined with trees.'),
  (9, 'the aim of which is to save money.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '96.3', 'Complete the sentences. Choose from the box and use which: this is good news, this makes it hard to contact her, this was a shame, this means we can''t go away tomorrow, she apologised for this, this makes it difficult to sleep sometimes, this was very kind of her, this meant I had to wait two hours at the airport.', 2
from units where slug = 'unit-96';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-96' where es.title = '96.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The street I live in is noisy at night, {0}', null),
  (2, 'Kate let me stay at her house, {0}', null),
  (3, 'Jane doesn''t have a phone, {0}', null),
  (4, 'Alex passed his exams, {0}', null),
  (5, 'My flight was delayed, {0}', null),
  (6, 'Our car has broken down, {0}', null),
  (7, 'Amy was twenty minutes late, {0}', null)
) as v(n, template, hint)
where es.title = '96.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '96.3'
join (values
  (1, 'which makes it difficult to sleep sometimes.', array[]::text[]),
  (2, 'which was very kind of her.', array[]::text[]),
  (3, 'which makes it hard to contact her.', array[]::text[]),
  (4, 'which is good news.', array[]::text[]),
  (5, 'which meant I had to wait two hours at the airport.', array[]::text[]),
  (6, 'which means we can''t go away tomorrow.', array[]::text[]),
  (7, 'which she apologised for.', array['for which she apologised.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
