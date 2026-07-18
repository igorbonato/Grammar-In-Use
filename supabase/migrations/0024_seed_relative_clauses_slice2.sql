-- Marco 4 (slice 23): seeds the second slice of the "Relative clauses"
-- module — unit 93 (Relative clauses 2: clauses with and without
-- who/that/which).
--
-- Sourced from pdf/Modulos/Relative clauses.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode where -layout scrambled
-- 93.3's word-order items) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 93.1 ("In some of these sentences you need who or that. Correct the
-- sentences where necessary.") reuses the empty-string "no word needed"
-- convention introduced for the Articles and nouns module (commit e793d03,
-- most recently reused in 88.1/0021): several items are grammatically
-- fine with the relative pronoun omitted (object relative clauses), so
-- correct_answer = '' with who/that/which as accepted_alternatives; other
-- items are subject relative clauses where the pronoun is required, so
-- correct_answer is the pronoun itself. Has TWO pre-filled worked examples
-- (one needing correction, one already OK) — Key starts numbering at
-- item 3, same recurring gotcha as unit 92.4 in 0023.
--
-- 93.2's Key gives "I/we" as interchangeable for items where the situation
-- doesn't specify a single speaker vs. group — picked "I" as the primary
-- correct_answer (matches the singular "you" framing of each situation)
-- and listed "we" and that/which/who/whom variants as
-- accepted_alternatives.
--
-- 93.4 continues the same empty-string convention: several items are
-- complete without that/what already, so correct_answer = '' — three of
-- those (items 3/7/9 in the book) also note "that is also correct" in the
-- Key, so those get accepted_alternatives = ['that'].
--
-- Safe to re-run: unit 93 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 93: Relative clauses 2: clauses with and without who/that/which
-- ============================================================

delete from units where slug = 'unit-93';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 93, 'unit-93', 'Relative clauses 2: clauses with and without who/that/which', null,
  'You must use who/that/which when it is the subject of the relative clause (the woman who lives next door). But when who/that/which is the object of the clause, you can leave it out (the woman I wanted to see or the woman who I wanted to see). Prepositions in relative clauses normally go at the end (the woman Tom is talking to), not before who/that/which. What = the thing(s) that: What they said was true.', 1
from modules where slug = 'relative-clauses';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'who/that/which as the subject',
  'Look at these example sentences from Unit 92: The woman who lives next door to me is a doctor. (or The woman that lives ...) — ''The woman lives next door to me''; who (= the woman) is the subject. Where are the keys that were on the table? (or ... the keys which were ...) — ''The keys were on the table''; that (= the keys) is the subject. You must use who/that/which when it is the subject of the relative clause. You cannot leave out who/that/which in these examples.', 0
from units where slug = 'unit-93';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'who/that/which as the object (can be left out)',
  'Sometimes who/that/which is the object of the verb. For example: The woman who I wanted to see was away on holiday. — ''I wanted to see the woman''; who (= the woman) is the object, I is the subject. Did you find the keys that you lost? — ''you lost the keys''; that (= the keys) is the object, you is the subject. When who/that/which is the object, you can leave it out. So you can say: The woman I wanted to see was away. or The woman who I wanted to see ... Did you find the keys you lost? or ... the keys that you lost? The dress Lisa bought doesn''t fit her very well. or The dress that Lisa bought ... Is there anything I can do? or ... anything that I can do? Note that we say: the keys you lost (not the keys you lost them), the dress Lisa bought (not the dress Lisa bought it).', 1
from units where slug = 'unit-93';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'prepositions in relative clauses',
  'Note the position of prepositions (to/in/for etc.) in relative clauses: Tom is talking to a woman. Do you know her? (2 sentences) Do you know the woman Tom is talking to? (or ... the woman who/that Tom is talking to) I slept in a bed. It wasn''t comfortable. (2 sentences) The bed I slept in wasn''t comfortable. (or The bed that/which I slept in ...) Are these the books you were looking for? or Are these the books that/which you were ... The man I was sitting next to on the plane talked all the time. or The man who/that I was sitting next to ... Note that we say: the books you were looking for (not the books you were looking for them), the man I was sitting next to (not the man I was sitting next to him).', 2
from units where slug = 'unit-93';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'what = the thing(s) that',
  'We say: Everything (that) they said was true. (not Everything what they said) I gave her all the money (that) I had. (not all the money what I had) What = the thing(s) that: What they said was true. (= The things that they said)', 3
from units where slug = 'unit-93';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-93'
join (values
  ('A', 'The woman who lives next door to me is a doctor. or The woman that lives ...', null, 0),
  ('A', 'Where are the keys that were on the table? or ... the keys which were ...', null, 1),
  ('B', 'The woman who I wanted to see was away on holiday.', null, 0),
  ('B', 'Did you find the keys that you lost?', null, 1),
  ('B', 'The woman I wanted to see was away. or The woman who I wanted to see ...', null, 2),
  ('B', 'Did you find the keys you lost? or ... the keys that you lost?', null, 3),
  ('B', 'The dress Lisa bought doesn''t fit her very well. or The dress that Lisa bought ...', null, 4),
  ('B', 'Is there anything I can do? or ... anything that I can do?', null, 5),
  ('B', 'the keys you lost', 'not the keys you lost them', 6),
  ('B', 'the dress Lisa bought', 'not the dress Lisa bought it', 7),
  ('C', 'Do you know the woman Tom is talking to?', 'or ... the woman who/that Tom is talking to', 0),
  ('C', 'The bed I slept in wasn''t comfortable.', 'or The bed that/which I slept in ...', 1),
  ('C', 'Are these the books you were looking for? or Are these the books that/which you were ...', null, 2),
  ('C', 'The man I was sitting next to on the plane talked all the time.', 'or The man who/that I was sitting next to ...', 3),
  ('C', 'the books you were looking for', 'not the books you were looking for them', 4),
  ('C', 'the man I was sitting next to', 'not the man I was sitting next to him', 5),
  ('D', 'Everything (that) they said was true.', 'not Everything what they said', 0),
  ('D', 'I gave her all the money (that) I had.', 'not all the money what I had', 1),
  ('D', 'What they said was true.', '= The things that they said', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 93.1-93.4; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '93.1', 'In some of these sentences you need who or that. Correct the sentences where necessary.', 0
from units where slug = 'unit-93';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-93' where es.title = '93.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The people {0} we met last night were very friendly.', null),
  (2, 'The people {0} work in the office are very friendly.', null),
  (3, 'I like the people {0} I work with.', null),
  (4, 'What have you done with the money {0} I gave you?', null),
  (5, 'What happened to the money {0} was on the table?', null),
  (6, 'What''s the worst film {0} you''ve ever seen?', null),
  (7, 'What''s the best thing {0} has ever happened to you?', null)
) as v(n, template, hint)
where es.title = '93.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '93.1'
join (values
  (1, '', array['who', 'that']::text[]),
  (2, 'who', array['that']::text[]),
  (3, '', array['who', 'that']::text[]),
  (4, '', array['that', 'which']::text[]),
  (5, 'that', array['which']::text[]),
  (6, '', array['that', 'which']::text[]),
  (7, 'that', array['which']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '93.2', 'What do you say in these situations? Complete each sentence with a relative clause.', 1
from units where slug = 'unit-93';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-93' where es.title = '93.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A friend is wearing a dress. You like it. You tell her: I like the dress {0}.', null),
  (2, 'A friend is going to the cinema. You want to know the name of the film. You say: What''s the name of the film {0}?', null),
  (3, 'You wanted to visit a museum, but it was shut. You tell a friend: The museum {0} was shut.', null),
  (4, 'You invited people to your party. Some of them couldn''t come. You tell someone: Some of the people {0} couldn''t come.', null),
  (5, 'Your friend had to do some work. You want to know if she has finished. You say: Have you finished the work {0}?', null),
  (6, 'You rented a car. It broke down after a few miles. You tell a friend: Unfortunately the car {0} broke down after a few miles.', null)
) as v(n, template, hint)
where es.title = '93.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '93.2'
join (values
  (1, 'you''re wearing', array['that you''re wearing', 'which you''re wearing']::text[]),
  (2, 'you''re going to see', array['that you''re going to see', 'which you''re going to see']::text[]),
  (3, 'I wanted to visit', array['we wanted to visit', 'that I wanted to visit', 'that we wanted to visit', 'which I wanted to visit', 'which we wanted to visit']::text[]),
  (4, 'I invited to the party', array['we invited to the party', 'who we invited to the party', 'whom we invited to the party', 'that we invited to the party']::text[]),
  (5, 'you had to do', array['that you had to do', 'which you had to do']::text[]),
  (6, 'I rented', array['we rented', 'that I rented', 'that we rented', 'which I rented', 'which we rented']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '93.3', 'These sentences all have a relative clause with a preposition. Put the words in the correct order.', 2
from units where slug = 'unit-93';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-93' where es.title = '93.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We couldn''t go to {0}.', '(we / invited / to / were / the wedding)'),
  (2, 'What''s the name of {0}?', '(the hotel / about / me / told / you)'),
  (3, 'Unfortunately I didn''t get {0}.', '(applied / I / the job / for)'),
  (4, 'Did you enjoy {0}?', '(you / the concert / to / went)'),
  (5, 'Gary is a good person to know. He''s {0}.', '(on / rely / can / somebody / you)'),
  (6, 'Who were {0} in the restaurant yesterday?', '(the people / with / were / you)')
) as v(n, template, hint)
where es.title = '93.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '93.3'
join (values
  (1, 'the wedding we were invited to'),
  (2, 'the hotel you told me about'),
  (3, 'the job I applied for'),
  (4, 'the concert you went to'),
  (5, 'somebody you can rely on'),
  (6, 'the people you were with')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '93.4', 'Put in that or what where necessary. If the sentence is already complete, leave the space empty.', 3
from units where slug = 'unit-93';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-93' where es.title = '93.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'She gives her children everything {0} they want.', null),
  (2, 'Tell me {0} you want and I''ll try to get it for you.', null),
  (3, 'Why do you blame me for everything {0} goes wrong?', null),
  (4, 'I won''t be able to do much, but I''ll do {0} I can.', null),
  (5, 'I won''t be able to do much, but I''ll do the best {0} I can.', null),
  (6, 'I don''t agree with {0} you said.', null),
  (7, 'I don''t trust him. I don''t believe anything {0} he says.', null)
) as v(n, template, hint)
where es.title = '93.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '93.4'
join (values
  (1, '', array['that']::text[]),
  (2, 'what', array[]::text[]),
  (3, 'that', array[]::text[]),
  (4, 'what', array[]::text[]),
  (5, '', array['that']::text[]),
  (6, 'what', array[]::text[]),
  (7, '', array['that']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
