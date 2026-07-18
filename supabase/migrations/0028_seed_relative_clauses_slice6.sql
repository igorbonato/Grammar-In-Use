-- Marco 4 (slice 27): seeds the sixth and final slice of the "Relative
-- clauses" module — unit 97 (-ing and -ed clauses: the woman talking to
-- Tom, the boy injured in the accident).
--
-- Sourced from pdf/Modulos/Relative clauses.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode where -layout scrambled
-- 97.2/97.3's scaffold-vs-completion ordering) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- This completes the "Relative clauses" module: the PDF's unit headers
-- stop at 97 (confirmed via a full-file grep sweep at the start of this
-- slice sequence, same check applied to every module since Modals.pdf) —
-- units 92-97, 6 units across six slices (0023-0028, one unit per slice
-- per Igor's request partway through this module).
--
-- 97.3 has TWO pre-filled worked examples (item 1 uses an -ing clause,
-- item 2 an -ed clause) — confirmed via the Key, which starts numbering
-- at item 3. Items 9 and 10 (renumbered 7 and 8 here) are the only
-- two-blank items in this exercise.
--
-- 97.4 ("Use the words in brackets to make sentences with There is /
-- There was etc.") drops the book's own "There" scaffold and asks for the
-- whole answer sentence instead, same 38.4/39.2/90.2 precedent used
-- throughout this project for scaffolded full-sentence answers.
--
-- Safe to re-run: unit 97 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 97: -ing and -ed clauses (the woman talking to Tom, the boy
-- injured in the accident)
-- ============================================================

delete from units where slug = 'unit-97';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 97, 'unit-97', '-ing and -ed clauses (the woman talking to Tom, the boy injured in the accident)', null,
  'An -ing clause can replace a relative clause with an active meaning, saying what somebody/something is doing (or does in general): the woman talking to Tom, the road connecting the two villages. An -ed clause replaces a relative clause with a passive meaning, using a past participle (regular -ed, or irregular like stolen/made/built): the boy injured in the accident, the money stolen in the robbery. Both can follow there is / there was: There were some children swimming in the river.', 5
from modules where slug = 'relative-clauses';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', '-ing clauses',
  'A clause is a part of a sentence. Some clauses begin with -ing. For example: Who is the woman talking to Tom? (''talking to Tom'' is an -ing clause describing ''the woman''.) We use -ing clauses to say what somebody (or something) is (or was) doing at a particular time: Who is the woman talking to Tom? (the woman is talking to Tom) Police investigating the crime are looking for three men. (police are investigating the crime) Who were those people waiting outside? (they were waiting) I was woken up by a bell ringing. (a bell was ringing) You can also use an -ing clause to say what happens all the time, not just at a particular time: The road connecting the two villages is very narrow. (the road connects the two villages) I have a large room overlooking the garden. (the room overlooks the garden) Can you think of the name of a flower beginning with T? (the name begins with T)', 0
from units where slug = 'unit-97';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', '-ed clauses',
  'Some clauses begin with -ed (injured, painted etc.). For example: The boy injured in the accident was taken to hospital. (''injured in the accident'' is an -ed clause describing ''the boy''.) -ed clauses have a passive meaning: The boy injured in the accident was taken to hospital. (he was injured in the accident) George showed me some pictures painted by his father. (they were painted by his father) The gun used in the robbery has been found. (the gun was used in the robbery) Injured/painted/used are past participles. Most past participles end in -ed, but many are irregular (stolen/made/built etc.): The police never found the money stolen in the robbery. Most of the goods made in this factory are exported.', 1
from units where slug = 'unit-97';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'there is / there was + -ing/-ed clauses',
  'You can use there is / there was (etc.) + -ing and -ed clauses: There were some children swimming in the river. Is there anybody waiting? There was a big red car parked outside the house. We use left in this way, with the meaning ''not used, still there'': We''ve eaten nearly all the chocolates. There are only a few left.', 2
from units where slug = 'unit-97';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-97'
join (values
  ('A', 'Who is the woman talking to Tom?', 'the woman is talking to Tom', 0),
  ('A', 'Police investigating the crime are looking for three men.', 'police are investigating the crime', 1),
  ('A', 'Who were those people waiting outside?', 'they were waiting', 2),
  ('A', 'I was woken up by a bell ringing.', 'a bell was ringing', 3),
  ('A', 'The road connecting the two villages is very narrow.', 'the road connects the two villages', 4),
  ('A', 'I have a large room overlooking the garden.', 'the room overlooks the garden', 5),
  ('A', 'Can you think of the name of a flower beginning with T?', 'the name begins with T', 6),
  ('B', 'The boy injured in the accident was taken to hospital.', 'he was injured in the accident', 0),
  ('B', 'George showed me some pictures painted by his father.', 'they were painted by his father', 1),
  ('B', 'The gun used in the robbery has been found.', 'the gun was used in the robbery', 2),
  ('B', 'The police never found the money stolen in the robbery.', null, 3),
  ('B', 'Most of the goods made in this factory are exported.', null, 4),
  ('C', 'There were some children swimming in the river.', null, 0),
  ('C', 'Is there anybody waiting?', null, 1),
  ('C', 'There was a big red car parked outside the house.', null, 2),
  ('C', 'We''ve eaten nearly all the chocolates. There are only a few left.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 97.1-97.4; each renumbered from 1, dropping
-- the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '97.1', 'Make one sentence from two. Complete the sentence using an -ing clause.', 0
from units where slug = 'unit-97';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-97' where es.title = '97.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A taxi was taking us to the airport. It broke down. The {0}', null),
  (2, 'There''s a path at the end of this street. The path leads to the river. At the end of the street there''s {0}', null),
  (3, 'A factory has just opened in the town. It employs 500 people. {0} has just opened in the town.', null),
  (4, 'A man was sitting next to me on the plane. He was asleep most of the time. The {0} was asleep most of the time.', null),
  (5, 'The company sent me a brochure. It contained the information I needed. The company sent me a {0}', null)
) as v(n, template, hint)
where es.title = '97.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '97.1'
join (values
  (1, 'taxi taking us to the airport broke down.'),
  (2, 'a path leading to the river.'),
  (3, 'A factory employing 500 people'),
  (4, 'man sitting next to me on the plane'),
  (5, 'brochure containing the information I needed.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '97.2', 'Complete the sentence with an -ed clause. Choose from: damaged in the storm, made at the meeting, injured in the accident, involved in the project, stolen from the museum, surrounded by trees.', 1
from units where slug = 'unit-97';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-97' where es.title = '97.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The paintings {0} haven''t been found yet.', null),
  (2, 'We''ve repaired the gate {0}', null),
  (3, 'Most of the suggestions {0} were not practical.', null),
  (4, 'Our friends live in a beautiful house {0}', null),
  (5, 'Everybody {0} worked very well.', null)
) as v(n, template, hint)
where es.title = '97.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '97.2'
join (values
  (1, 'stolen from the museum'),
  (2, 'damaged in the storm.'),
  (3, 'made at the meeting'),
  (4, 'surrounded by trees.'),
  (5, 'involved in the project')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '97.3', 'Complete the sentences. Use the following verbs in the correct form: blow, call, cause, invite, live, offer, paint, read, ring, sit, study, work.', 2
from units where slug = 'unit-97';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-97' where es.title = '97.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Some of the people {0} to the party can''t come.', null),
  (2, 'Somebody {0} Jack phoned while you were out.', null),
  (3, 'Life must be very unpleasant for people {0} near busy airports.', null),
  (4, 'A few days after the interview, I received an email {0} me the job.', null),
  (5, 'The building was badly damaged in a fire {0} by an electrical fault.', null),
  (6, 'Did you see the picture of the trees {0} down in the storm?', null),
  (7, 'The waiting room was empty except for an old man {0} in the corner {1} a magazine.', null),
  (8, 'Ian has a brother {0} in a bank in London and a sister {1} economics at university in Manchester.', null)
) as v(n, template, hint)
where es.title = '97.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '97.3'
join (values
  (1, 0, 'invited'),
  (2, 0, 'called'),
  (3, 0, 'living'),
  (4, 0, 'offering'),
  (5, 0, 'caused'),
  (6, 0, 'blown'),
  (7, 0, 'sitting'), (7, 1, 'reading'),
  (8, 0, 'working'), (8, 1, 'studying')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '97.4', 'Use the words in brackets to make sentences with There is / There was etc.', 3
from units where slug = 'unit-97';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-97' where es.title = '97.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can hear footsteps. {0}', '(somebody / come)'),
  (2, 'I''ve spent all the money I had. {0}', '(nothing / leave)'),
  (3, 'The train was full. {0}', '(a lot of people / travel)'),
  (4, 'We were the only guests at the hotel. {0}', '(nobody else / stay there)'),
  (5, 'The piece of paper was blank. {0}', '(nothing / write / on it)'),
  (6, 'The college offers English courses in the evening. {0}', '(a course / begin / next Monday)')
) as v(n, template, hint)
where es.title = '97.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '97.4'
join (values
  (1, 'There''s somebody coming.'),
  (2, 'There''s nothing left.'),
  (3, 'There were a lot of people travelling.'),
  (4, 'There was nobody else staying there.'),
  (5, 'There was nothing written on it.'),
  (6, 'There''s a course beginning next Monday.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
