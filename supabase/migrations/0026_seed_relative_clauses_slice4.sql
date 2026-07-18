-- Marco 4 (slice 25): seeds the fourth slice of the "Relative clauses"
-- module — unit 95 (Relative clauses 4: extra information clauses (1)).
--
-- Sourced from pdf/Modulos/Relative clauses.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 95.1 ("Make one sentence from two ... Type 2") gives two short source
-- sentences per item; asked for the whole combined sentence as the answer
-- (same "safer to ask for the whole answer" precedent as 90.2/0022),
-- since several items restructure word order beyond a simple scaffold
-- (e.g. item 5's "Our teacher was very kind" + "I have forgotten her
-- name" becomes "Our teacher, whose name I have forgotten, was very
-- kind" — the inserted clause splits the original sentence in two).
--
-- 95.3 ("Are these sentences OK? Correct them ... If the sentence is
-- correct, write 'OK'.") is graded the same way the book itself frames
-- it: the blank's correct answer is literally "OK" for the two
-- already-correct items, and the corrected sentence for the rest — this
-- is a direct, faithful mapping of the book's own instruction rather than
-- an adapted convention.
--
-- Safe to re-run: unit 95 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 95: Relative clauses 4: extra information clauses (1)
-- ============================================================

delete from units where slug = 'unit-95';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 95, 'unit-95', 'Relative clauses 4: extra information clauses (1)', null,
  'There are two types of relative clause. Type 1 clauses tell us which person or thing the speaker means (the woman who lives next door to me) and use no commas; Type 2 clauses give extra information about someone/something already identified (My brother Ben, who lives in Hong Kong, is an architect) and always use commas. In Type 2 clauses you cannot use that instead of who/which, and you cannot leave out who/which even when it is the object.', 3
from modules where slug = 'relative-clauses';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'two types of relative clause',
  'There are two types of relative clause. Compare: Type 1 — The woman who lives next door to me is a doctor. Grace works for a company that makes furniture. We stayed at the hotel (that) you recommended. Type 2 — My brother Ben, who lives in Hong Kong, is an architect. Anna told me about her new job, which she''s enjoying a lot. We stayed at the Park Hotel, which a friend of ours recommended. In Type 1 examples, the relative clauses tell you which person or thing (or what kind of person or thing) the speaker means: ''The woman who lives next door to me'' tells us which woman. ''A company that makes furniture'' tells us what kind of company. ''The hotel (that) you recommended'' tells us which hotel. We do not use commas with these clauses: We know a lot of people who live in London. In Type 2 examples, the relative clauses do not tell you which person or thing the speaker means — we already know which thing or person is meant: ''My brother Ben'', ''Anna''s new job'' and ''the Park Hotel''. The relative clauses in these sentences give us extra information about the person or thing. We use commas (,) with these clauses: My brother Ben, who lives in Hong Kong, is an architect.', 0
from units where slug = 'unit-95';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'who/which/that in both types',
  'In both types of relative clause we use who for people and which for things. But: in Type 1 you can use that (Do you know anyone who/that speaks French and Italian? Grace works for a company which/that makes furniture) — in Type 2 you cannot use that (John, who speaks French and Italian, works as a tour guide — not that speaks; Anna told me about her new job, which she''s enjoying a lot). In Type 1 you can leave out who/which/that when it is the object (see Unit 93): We stayed at the hotel (that/which) you recommended. This morning I met somebody (who/that) I hadn''t seen for ages. In Type 2 you cannot leave out who or which: We stayed at the Park Hotel, which a friend of ours recommended. This morning I met Chris, who I hadn''t seen for ages. We do not often use whom in Type 1 clauses (see Unit 94B), but you can use whom for people in Type 2 when it is the object: This morning I met Chris, whom I hadn''t seen for ages.', 1
from units where slug = 'unit-95';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'whose and where in both types',
  'In both types of relative clause you can use whose and where: We helped some people whose car had broken down. Lisa, whose car had broken down, was in a very bad mood. What''s the name of the place where you went on holiday? Kate has just been to Sweden, where her daughter lives.', 2
from units where slug = 'unit-95';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-95'
join (values
  ('A', 'The woman who lives next door to me is a doctor.', 'Type 1', 0),
  ('A', 'My brother Ben, who lives in Hong Kong, is an architect.', 'Type 2', 1),
  ('A', 'Grace works for a company that makes furniture.', 'Type 1', 2),
  ('A', 'Anna told me about her new job, which she''s enjoying a lot.', 'Type 2', 3),
  ('A', 'We stayed at the hotel (that) you recommended.', 'Type 1', 4),
  ('A', 'We stayed at the Park Hotel, which a friend of ours recommended.', 'Type 2', 5),
  ('A', 'We know a lot of people who live in London.', 'no commas', 6),
  ('B', 'Do you know anyone who/that speaks French and Italian?', 'Type 1, that is possible', 0),
  ('B', 'John, who speaks French and Italian, works as a tour guide.', 'Type 2, not that speaks', 1),
  ('B', 'We stayed at the hotel (that/which) you recommended.', 'Type 1, can leave out', 2),
  ('B', 'We stayed at the Park Hotel, which a friend of ours recommended.', 'Type 2, cannot leave out which', 3),
  ('B', 'This morning I met Chris, who I hadn''t seen for ages.', null, 4),
  ('B', 'This morning I met Chris, whom I hadn''t seen for ages.', null, 5),
  ('C', 'We helped some people whose car had broken down.', null, 0),
  ('C', 'Lisa, whose car had broken down, was in a very bad mood.', null, 1),
  ('C', 'What''s the name of the place where you went on holiday?', null, 2),
  ('C', 'Kate has just been to Sweden, where her daughter lives.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 95.1-95.3; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '95.1', 'Make one sentence from two. Use the information in brackets to make a relative clause (Type 2). You will need to use who/whom/whose/which/where.', 0
from units where slug = 'unit-95';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-95' where es.title = '95.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We drove to the airport. (The airport was not far from the city.) {0}', null),
  (2, 'Kate''s husband is an airline pilot. (I have never met Kate''s husband.) {0}', null),
  (3, 'Lisa is away from home a lot. (Lisa''s job involves a lot of travelling.) {0}', null),
  (4, 'Paul and Emily have a daughter, Alice. (Alice has just started school.) {0}', null),
  (5, 'The new stadium will hold 90,000 spectators. (The stadium will be finished next month.) {0}', null),
  (6, 'My brother lives in Alaska. (Alaska is the largest state in the US.) {0}', null),
  (7, 'Our teacher was very kind. (I have forgotten her name.) {0}', null),
  (8, 'We enjoyed our visit to the museum. (We saw a lot of interesting things in the museum.) {0}', null)
) as v(n, template, hint)
where es.title = '95.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '95.1'
join (values
  (1, 'We drove to the airport, which was not far from the city.', array[]::text[]),
  (2, 'Kate''s husband, who I''ve never met, is an airline pilot.', array['Kate''s husband, whom I''ve never met, is an airline pilot.']::text[]),
  (3, 'Lisa, whose job involves a lot of travelling, is away from home a lot.', array[]::text[]),
  (4, 'Paul and Emily have a daughter, Alice, who has just started school.', array[]::text[]),
  (5, 'The new stadium, which will be finished next month, will hold 90,000 spectators.', array[]::text[]),
  (6, 'My brother lives in Alaska, which is the largest state in the US.', array[]::text[]),
  (7, 'Our teacher, whose name I have forgotten, was very kind.', array[]::text[]),
  (8, 'We enjoyed our visit to the museum, where we saw a lot of interesting things.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '95.2', 'Read the information and complete the sentences. Use a relative clause of Type 1 or Type 2. Use commas where necessary.', 1
from units where slug = 'unit-95';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-95' where es.title = '95.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The strike at the factory has now ended. (The strike began ten days ago.) The strike at the factory {0}', null),
  (2, 'I was looking for a book this morning. (I''ve found it now.) I''ve found {0}', null),
  (3, 'I''ve had my car for 15 years. (This car has never broken down.) My car {0}', null),
  (4, 'A lot of people applied for the job. (Few of them had the necessary qualifications.) Few of {0}', null),
  (5, 'Amy showed me a picture of her son. (Her son is a police officer.) Amy showed me {0}', null)
) as v(n, template, hint)
where es.title = '95.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '95.2'
join (values
  (1, 'which began ten days ago, has now ended.', array[]::text[]),
  (2, 'the book I was looking for this morning.', array['the book that I was looking for this morning.', 'the book which I was looking for this morning.']::text[]),
  (3, 'which I''ve had for 15 years, has never broken down.', array[]::text[]),
  (4, 'the people who applied for the job had the necessary qualifications.', array['the people that applied for the job had the necessary qualifications.']::text[]),
  (5, 'a picture of her son, who is a police officer.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '95.3', 'Are these sentences OK? Correct them (and put in commas) where necessary. If the sentence is correct, write OK.', 2
from units where slug = 'unit-95';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-95' where es.title = '95.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My office that is on the second floor is very small. {0}', null),
  (2, 'The office that I''m using at the moment is very small. {0}', null),
  (3, 'Sarah''s father that used to be in the army now works for a TV company. {0}', null),
  (4, 'The doctor that examined me couldn''t find anything wrong. {0}', null),
  (5, 'The sun that is one of millions of stars in the universe provides us with heat and light. {0}', null)
) as v(n, template, hint)
where es.title = '95.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '95.3'
join (values
  (1, 'My office, which is on the second floor, is very small.', array[]::text[]),
  (2, 'OK', array['The office I''m using at the moment is very small.', 'The office which I''m using at the moment is very small.']::text[]),
  (3, 'Sarah''s father, who used to be in the army, now works for a TV company.', array[]::text[]),
  (4, 'OK', array['The doctor who examined me couldn''t find anything wrong.']::text[]),
  (5, 'The sun, which is one of millions of stars in the universe, provides us with heat and light.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
