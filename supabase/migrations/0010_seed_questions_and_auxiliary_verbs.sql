-- Marco 4 (slice 8): seeds the "Questions and auxiliary verbs" module —
-- units 49-52 (Questions 1, Questions 2 (do you know where ... ? / he asked
-- me where ...), I think so / I hope so etc., Question tags).
--
-- Sourced from pdf/Modulos/Questions and auxiliary verbs.pdf (extracted via
-- `pdftotext -layout`, same workaround as previous modules — pdftoppm/
-- poppler isn't available locally) and cross-checked against pdf/Key to
-- Exercises.pdf. Clean 1:1 match with the book chapter (units 49-52 only —
-- confirmed by grepping the extracted text for unit-number headers across
-- the whole file); "UNIT 53" (-ing and to ...) starts right after in the
-- Key, confirming the boundary.
--
-- Reminder: migrations are applied by pasting the full file into the
-- Supabase Studio SQL Editor by hand — there is no GitHub auto-deploy for
-- this project.
--
-- 51.3 ("Answer with So .../Neither ... or ask Tina questions") is labelled
-- "Example answers" in the Key, same pattern as 47.2 in 0009: not a
-- personal free-form exercise, but one with a real ambiguity built into the
-- instruction itself (the correct response genuinely depends on whether
-- the same thing is true for the learner, which the exercise can't know in
-- advance) — both the "So/Neither" agreement form and the "question back"
-- form are seeded as accepted alternatives for each item, since the Key
-- lists both as valid for every item.
--
-- 50.1 (three-way multiple choice, "Which is right?") and 52.1's worked
-- examples are consolidated the same way prior multiple-choice/matching
-- exercises were (38.2, 46.1, 46.4): the prompt becomes the template, the
-- correct option's full sentence becomes the answer. Note 52.1 has *two*
-- worked examples in the book (items 1 and 2 are both given), not just one
-- — the Key starts at item 3, and this migration's exercise_sentences
-- start at 1 accordingly (renumbered from the book's 3).
--
-- No exercise in this chapter was skipped as genuinely open-ended.
--
-- Additional exercise 25 (page 316) is referenced again at the end of unit
-- 50 (same one already flagged at the end of unit 47 in 0009) — deferred,
-- consistent with every module so far.
--
-- Consolidated into a single migration, same pattern as 0003-0009.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('questions-and-auxiliary-verbs', 'Questions and auxiliary verbs', 7)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 49: Questions 1
-- ============================================================

delete from units where slug = 'unit-49';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 49, 'unit-49', 'Questions 1', null,
  'In questions the subject usually comes after the first (auxiliary) verb. Present simple and past simple questions need do/does/did, unless who/what/which etc. is itself the subject of the sentence. Prepositions in wh-questions usually go at the end, not the start.', 0
from modules where slug = 'questions-and-auxiliary-verbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Word order: verb before subject',
  'In questions the subject is usually after the first verb: Tom will -> will Tom? you have -> have you? the house was -> was the house? "Is Katherine working today?" (not Is working Katherine).', 0
from units where slug = 'unit-49';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'do/does/did, and when not to use them',
  'In present simple questions we use do/does; in past simple questions we use did: Do you live near here? Did you sell your car? But we do not use do/does/did if who/what etc. is the subject of the sentence: Who wants something to eat? (not Who does want), What happened to you last night? (not What did happen).', 1
from units where slug = 'unit-49';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Prepositions at the end of wh-questions',
  'In questions beginning who/what/which/where, prepositions (in, for etc.) usually go at the end: Where are you from? Who do you want to speak to? You can use preposition + whom in formal style: To whom do you wish to speak?', 2
from units where slug = 'unit-49';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'isn''t it ... ? / didn''t you ... ? (negative questions)',
  'We use negative questions especially to show surprise ("Didn''t you hear the doorbell? I rang it three times.") or when we expect the listener to agree with us ("Haven''t we met before?"). Note the meaning of yes/no in answers to negative questions: "Don''t you want to go?" "Yes" (= Yes, I want to go); "No" (= No, I don''t want to go). We often use negative questions with Why ... ?: Why don''t we eat out tonight? (not Why we don''t eat).', 3
from units where slug = 'unit-49';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-49'
join (values
  ('A', 'Will Tom be here tomorrow?', null, 0),
  ('A', 'Have you been working hard?', null, 1),
  ('A', 'When was the house built?', null, 2),
  ('A', 'Is Katherine working today?', 'not Is working Katherine', 3),
  ('B', 'Do you live near here?', null, 0),
  ('B', 'What time does the film start?', null, 1),
  ('B', 'Did you sell your car?', null, 2),
  ('B', 'Why did the train stop?', null, 3),
  ('B', 'Who wants something to eat?', 'not Who does want', 4),
  ('B', 'What happened to you last night?', 'not What did happen', 5),
  ('B', 'How many people came to the party?', 'not did come', 6),
  ('B', 'Which bus goes to the centre?', 'not does go', 7),
  ('C', 'Where are you from?', null, 0),
  ('C', 'What was the weather like?', null, 1),
  ('C', 'Who do you want to speak to?', null, 2),
  ('C', 'Which job has Tina applied for?', null, 3),
  ('C', 'To whom do you wish to speak?', 'formal style', 4),
  ('D', 'Didn''t you hear the doorbell? I rang it three times.', 'surprise', 0),
  ('D', '"Haven''t we met before?" "Yes, I think we have."', 'expecting agreement', 1),
  ('D', 'Why don''t we eat out tonight?', 'not Why we don''t eat', 2),
  ('D', 'Why wasn''t Emma at work yesterday?', 'not Why Emma wasn''t', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 49.1-49.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '49.1', 'Ask Joe questions.', 0
from units where slug = 'unit-49';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-49' where es.title = '49.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Joe: "No, I was born in London." {0}', '(born there?)'),
  (2, 'Joe: "Yes." {0}', '(married?)'),
  (3, 'Joe: "17 years." {0}', '(how long?)'),
  (4, 'Joe: "I''m a journalist." {0}', '(what / do?)'),
  (5, 'Joe: "She''s a doctor." {0}', '(what wife / do?)'),
  (6, 'Joe: "Yes, two boys." {0}', '(children?)'),
  (7, 'Joe: "12 and 15." {0}', '(how old?)')
) as v(n, template, hint)
where es.title = '49.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '49.1'
join (values
  (1, 0, 'Were you born there?', array[]::text[]),
  (2, 0, 'Are you married?', array[]::text[]),
  (3, 0, 'How long have you been married?', array[]::text[]),
  (4, 0, 'What do you do?', array[]::text[]),
  (5, 0, 'What does your wife do?', array[]::text[]),
  (6, 0, 'Do you have any children?', array['Have you got any children?']::text[]),
  (7, 0, 'How old are they?', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '49.2', 'Make questions with who or what.', 1
from units where slug = 'unit-49';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-49' where es.title = '49.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Somebody paid the bill. {0}', null),
  (2, 'I''m worried about something. {0}', null),
  (3, 'Something happened. {0}', null),
  (4, 'Diane said something. {0}', null),
  (5, 'This book belongs to somebody. {0}', null),
  (6, 'Somebody lives in that house. {0}', null),
  (7, 'I fell over something. {0}', null),
  (8, 'Something fell off the shelf. {0}', null),
  (9, 'This word means something. {0}', null),
  (10, 'Sarah was with somebody. {0}', null),
  (11, 'I''m looking for something. {0}', null),
  (12, 'Emma reminds me of somebody. {0}', null)
) as v(n, template, hint)
where es.title = '49.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '49.2'
join (values
  (1, 0, 'Who paid the bill?', array['Who paid it?']::text[]),
  (2, 0, 'What are you worried about?', array[]::text[]),
  (3, 0, 'What happened?', array[]::text[]),
  (4, 0, 'What did she say?', array['What did Diane say?']::text[]),
  (5, 0, 'Who does it belong to?', array['Who does this book belong to?']::text[]),
  (6, 0, 'Who lives in that house?', array['Who lives there?']::text[]),
  (7, 0, 'What did you fall over?', array[]::text[]),
  (8, 0, 'What fell off the shelf?', array[]::text[]),
  (9, 0, 'What does it mean?', array['What does this word mean?']::text[]),
  (10, 0, 'Who was she with?', array['Who was Sarah with?']::text[]),
  (11, 0, 'What are you looking for?', array[]::text[]),
  (12, 0, 'Who does she remind you of?', array['Who does Emma remind you of?']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '49.3', 'Put the words in brackets in the correct order.', 2
from units where slug = 'unit-49';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-49' where es.title = '49.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', '(how / cheese / is / made?)'),
  (2, '{0}', '(why / Sue / working / isn''t / today?)'),
  (3, '{0}', '(what time / arriving / your friends / are?)'),
  (4, '{0}', '(why / was / cancelled / the meeting?)'),
  (5, '{0}', '(when / invented / paper / was?)'),
  (6, '{0}', '(where / your parents / were / born?)'),
  (7, '{0}', '(why / you / to the party / didn''t / come?)'),
  (8, '{0}', '(how / the accident / did / happen?)'),
  (9, '{0}', '(why / happy / you / aren''t?)'),
  (10, '{0}', '(how many / speak / can / languages / you?)')
) as v(n, template, hint)
where es.title = '49.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '49.3'
join (values
  (1, 0, 'How is cheese made?'),
  (2, 0, 'Why isn''t Sue working today?'),
  (3, 0, 'What time are your friends arriving?'),
  (4, 0, 'Why was the meeting cancelled?'),
  (5, 0, 'When was paper invented?'),
  (6, 0, 'Where were your parents born?'),
  (7, 0, 'Why didn''t you come to the party?'),
  (8, 0, 'How did the accident happen?'),
  (9, 0, 'Why aren''t you happy?'),
  (10, 0, 'How many languages can you speak?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '49.4', 'Write negative questions from the words in brackets. In each situation you are surprised.', 3
from units where slug = 'unit-49';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-49' where es.title = '49.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: I hope we don''t meet Luke tonight. b: Why? {0}', '(you / not / like / him?)'),
  (2, 'a: Don''t go and see that film. b: Why not? {0}', '(it / not / good?)'),
  (3, 'a: I''ll have to borrow some money. b: Why? {0}', '(you / not / have / any?)')
) as v(n, template, hint)
where es.title = '49.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '49.4'
join (values
  (1, 0, 'Don''t you like him?', array[]::text[]),
  (2, 0, 'Isn''t it good?', array[]::text[]),
  (3, 0, 'Don''t you have any?', array['Haven''t you got any?']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 50: Questions 2 (do you know where ... ? / he asked me where ...)
-- ============================================================

delete from units where slug = 'unit-50';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 50, 'unit-50', 'Questions 2 (do you know where ... ? / he asked me where ...)', null,
  'When a question is part of a longer sentence (Do you know ... ? / I don''t know ... / Can you tell me ... ?) or in reported speech, the word order changes to normal statement order (subject before verb) and do/does/did disappear. Use if or whether when there''s no other question word.', 1
from modules where slug = 'questions-and-auxiliary-verbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Embedded questions: Do you know where ... ? etc.',
  'When the question (Where has Tom gone?) is part of a longer sentence (Do you know ... ? / I don''t know ... / Can you tell me ... ? etc.), the word order changes to normal statement order: Do you know what time it is? (not is it). Be careful with do/does/did questions: Do you know what time the film starts? (not does the film start). Use if or whether where there is no other question word: I don''t know if anybody saw me. or ... whether anybody saw me.', 0
from units where slug = 'unit-50';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'He asked me where ... (reported questions)',
  'The same change in word order happens in questions in reported speech: "Where are you going?" -> The police officer asked us where we were going. "What time do the shops close?" -> Clare wanted to know what time the shops closed. In reported speech the verb usually changes to the past too.', 1
from units where slug = 'unit-50';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-50'
join (values
  ('A', 'Do you know what time it is?', 'not is it', 0),
  ('A', 'I don''t know who those people are.', null, 1),
  ('A', 'Can you tell me where I can find Louise?', null, 2),
  ('A', 'Do you have any idea how much it will cost?', null, 3),
  ('A', 'Please explain what you mean.', null, 4),
  ('A', 'I wonder why she left early.', null, 5),
  ('A', 'I don''t know if anybody saw me.', 'or ... whether anybody saw me', 6),
  ('B', 'The police officer asked us where we were going.', 'direct: "Where are you going?"', 0),
  ('B', 'Clare wanted to know what time the shops closed.', 'direct: "What time do the shops close?"', 1),
  ('B', 'She asked if I was willing to travel.', 'or whether', 2),
  ('B', 'She wanted to know what I did in my spare time.', null, 3),
  ('B', 'She asked how long I had been working in my present job.', null, 4),
  ('B', 'She asked why I had applied for the job.', 'or ... why I applied ...', 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of a job interview, with the interviewer asking "Are you willing to travel?", "Why did you apply for the job?", "What do you do in your spare time?" etc., next to the reported version told to a friend afterwards]', 0
from units where slug = 'unit-50';

-- ------------------------------------------------------------
-- Exercises (main, book's own 50.1-50.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '50.1', 'Which is right? Choose the correct alternative.', 0
from units where slug = 'unit-50';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-50' where es.title = '50.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Choose the correct question. Topic: why Amy gets up so early every day. {0}', null),
  (2, 'Choose the correct sentence. Topic: what this word means. {0}', null),
  (3, 'Choose the correct sentence. Topic: where you parked the car. {0}', null),
  (4, 'Choose the correct question. Topic: why you didn''t phone yesterday. {0}', null),
  (5, 'Choose the correct question. Topic: where Helen works. {0}', null),
  (6, 'Choose the correct question. Topic: how much it costs to park here. {0}', null),
  (7, 'Choose the correct sentence. Topic: telling somebody what you want. {0}', null)
) as v(n, template, hint)
where es.title = '50.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '50.1'
join (values
  (1, 0, 'Why does Amy get up so early every day?'),
  (2, 0, 'I want to know what this word means.'),
  (3, 0, 'I can''t remember where I parked the car.'),
  (4, 0, 'Why didn''t you phone me yesterday?'),
  (5, 0, 'Do you know where Helen works?'),
  (6, 0, 'How much does it cost to park here?'),
  (7, 0, 'Tell me what you want.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '50.2', 'Put the words in the correct order.', 1
from units where slug = 'unit-50';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-50' where es.title = '50.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', '(is / to the airport / far / it)'),
  (2, '{0}', '(wonder / is / how / old / Tom)'),
  (3, '{0}', '(they / married / been / have)'),
  (4, '{0}', '(they / married / how long / been / have / know)'),
  (5, '{0}', '(tell / the station / you / me / is / where)'),
  (6, '{0}', '(in the accident / injured / anyone / don''t / whether / know / was)'),
  (7, '{0}', '(what / tomorrow / know / time / will / arrive / you / you)')
) as v(n, template, hint)
where es.title = '50.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '50.2'
join (values
  (1, 0, 'How far is it to the airport?'),
  (2, 0, 'I wonder how old Tom is.'),
  (3, 0, 'How long have they been married?'),
  (4, 0, 'Do you know how long they have been married?'),
  (5, 0, 'Could you tell me where the station is?'),
  (6, 0, 'I don''t know whether anyone was injured in the accident.'),
  (7, 0, 'Do you know what time you will arrive tomorrow?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '50.3', 'You were visiting London and met a lot of people who asked you a lot of questions. Now you tell a friend what people asked you. Use reported speech.', 2
from units where slug = 'unit-50';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-50' where es.title = '50.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Somebody asked: "How long have you been in London?" {0}', null),
  (2, 'Somebody asked: "Have you been to London before?" {0}', null),
  (3, 'Somebody asked: "Do you like London?" {0}', null),
  (4, 'Somebody asked: "Where are you staying?" {0}', null),
  (5, 'Somebody asked: "How long are you going to stay?" {0}', null),
  (6, 'Somebody asked: "Do you think London is expensive?" {0}', null),
  (7, 'Somebody asked: "Why did you come to London?" {0}', null)
) as v(n, template, hint)
where es.title = '50.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '50.3'
join (values
  (1, 0, 'She asked me how long I''d been in London.', array['She asked me how long I had been in London.']::text[]),
  (2, 0, 'They asked me if I''d been to London before.', array['They asked me whether I''d been to London before.', 'They asked me if I had been to London before.']::text[]),
  (3, 0, 'She asked me if I liked London.', array['She asked me whether I liked London.']::text[]),
  (4, 0, 'He asked me where I was staying.', array[]::text[]),
  (5, 0, 'She asked me how long I was going to stay.', array[]::text[]),
  (6, 0, 'She asked me if I thought London was expensive.', array['She asked me whether I thought London was expensive.', 'She asked me if I thought London is expensive.']::text[]),
  (7, 0, 'They asked me why I''d come to London.', array['They asked me why I had come to London.', 'They asked me why I came to London.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 51: I think so / I hope so etc.
-- ============================================================

delete from units where slug = 'unit-51';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 51, 'unit-51', 'I think so / I hope so etc.', null,
  'Auxiliary verbs (be/have/do/can/will etc.) let you avoid repeating the main verb: "Have you locked the door?" "Yes, I have." They''re also used in short reactions (have you? isn''t she?), with so/neither to agree, and in short answers like I think so / I hope not.', 2
from modules where slug = 'questions-and-auxiliary-verbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Avoiding repetition with an auxiliary verb',
  'You can use an auxiliary verb when you don''t want to repeat something: "Have you locked the door?" "Yes, I have." (= I have locked the door). We use do/does/did for the present and past simple: "Do you like onions?" "Yes, I do." You can also use auxiliary verbs to deny what somebody says: "You''re sitting in my place." "No, I''m not."', 0
from units where slug = 'unit-51';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'have you? / isn''t she? to show interest or surprise',
  'We use have you? / isn''t she? / are they? etc. to show that we are interested in what somebody has said, or to show surprise: "I''ve just seen Steven." "Oh, have you? How is he?" "Lisa isn''t very well today." "Isn''t she? What''s wrong with her?"', 1
from units where slug = 'unit-51';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'so and neither',
  'We use auxiliary verbs with so and neither: "I''m tired." "So am I." (= I''m tired too). "I never read newspapers." "Neither do I." Notice the word order after so and neither — verb before subject: I passed the exam and so did Paul (not so Paul did). Instead of neither you can use nor, or not ... either.', 2
from units where slug = 'unit-51';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'I think so / I hope so etc.',
  'You can say I think so / I suppose so etc. when you don''t want to repeat something: "Are those people Korean?" "I think so." In the same way: I hope so, I guess so, I''m afraid so. The negative forms mostly add not/don''t: I don''t think so, I don''t expect so, I hope not, I''m afraid not, I guess not, I suppose not (not I don''t hope so).', 3
from units where slug = 'unit-51';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-51'
join (values
  ('A', '"Have you locked the door?" "Yes, I have."', '= I have locked the door', 0),
  ('A', 'Gary wasn''t working, but Laura was.', '= Laura was working', 1),
  ('A', 'Jessica could lend me the money, but she won''t.', '= she won''t lend me the money', 2),
  ('A', '"You didn''t lock the door before you left." "Yes, I did."', '= I locked the door', 3),
  ('B', '"I''ve just seen Steven." "Oh, have you? How is he?"', null, 0),
  ('B', '"It rained every day during our holiday." "Did it? What a shame!"', null, 1),
  ('B', '"James and Tanya are getting married." "Are they? Really?"', null, 2),
  ('C', '"I''m tired." "So am I."', '= I''m tired too', 0),
  ('C', '"I never read newspapers." "Neither do I."', '= I never read newspapers either', 1),
  ('C', 'Sarah can''t drive and neither can Mark.', null, 2),
  ('C', 'I passed the exam and so did Paul.', 'not so Paul did', 3),
  ('C', '"I don''t know." "Neither do I."', 'or Nor do I / I don''t either', 4),
  ('D', '"Are those people Korean?" "I think so."', '= I think they are Korean', 0),
  ('D', '"Will you be at home this evening?" "I expect so."', '= I expect I''ll be at home', 1),
  ('D', '"Is that woman American?" "I don''t think so."', null, 2),
  ('D', '"Do you think it will rain?" "I hope so. / I hope not."', 'not I don''t hope so', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 51.1-51.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '51.1', 'Complete each sentence with an auxiliary verb (do/was/could/might etc.). Sometimes the verb must be negative.', 0
from units where slug = 'unit-51';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-51' where es.title = '51.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I like hot weather, but Ann {0}.', null),
  (2, '''Is Andy here?'' ''He {0} five minutes ago, but I think he''s gone home now.''', null),
  (3, 'I haven''t travelled much, but Gary {0}.', null),
  (4, 'Lisa said she might come and see us tomorrow, but I don''t think she {0}.', null),
  (5, 'I don''t know whether to apply for the job or not. Do you think I {0}?', null),
  (6, '''Please don''t tell anybody what happened.'' ''Don''t worry. I {0}.''', null),
  (7, '''You never listen to me.'' ''Yes, I {0}!''', null),
  (8, 'I usually work on Saturdays, but last Saturday I {0}.', null),
  (9, '''Do you think it''s going to rain?'' ''It {0}. Take an umbrella in case.''', null),
  (10, '''Are you and Chris going to the party?'' ''I {0}, but Chris {1}.''', null),
  (11, '''Please help me.'' ''I''m sorry. I {0} if I {1}, but I {2}.''', null)
) as v(n, template, hint)
where es.title = '51.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '51.1'
join (values
  (1, 0, 'doesn''t', array[]::text[]),
  (2, 0, 'was', array[]::text[]),
  (3, 0, 'has', array[]::text[]),
  (4, 0, 'will', array[]::text[]),
  (5, 0, 'should', array[]::text[]),
  (6, 0, 'won''t', array[]::text[]),
  (7, 0, 'do', array[]::text[]),
  (8, 0, 'didn''t', array[]::text[]),
  (9, 0, 'might', array[]::text[]),
  (10, 0, 'am', array['''m not']::text[]), (10, 1, 'isn''t', array['is']::text[]),
  (11, 0, 'would', array[]::text[]), (11, 1, 'could', array[]::text[]), (11, 2, 'can''t', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '51.2', 'You never agree with Amy. Answer in the way shown.', 1
from units where slug = 'unit-51';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-51' where es.title = '51.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Amy: "I like football." {0}', null),
  (2, 'Amy: "I didn''t enjoy the film." {0}', null),
  (3, 'Amy: "I''m not tired." {0}', null),
  (4, 'Amy: "I thought the exam was easy." {0}', null)
) as v(n, template, hint)
where es.title = '51.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '51.2'
join (values
  (1, 0, 'Do you? I don''t.'),
  (2, 0, 'Didn''t you? I did.'),
  (3, 0, 'Aren''t you? I am.'),
  (4, 0, 'Did you? I didn''t.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '51.3', 'Tina tells you something. If the same is true for you, answer with So ... or Neither .... Otherwise, ask Tina a question.', 2
from units where slug = 'unit-51';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-51' where es.title = '51.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Tina: "I watched TV last night." {0}', null),
  (2, 'Tina: "I won''t be at home tomorrow." {0}', null),
  (3, 'Tina: "I like reading." {0}', null),
  (4, 'Tina: "I''d like to live somewhere else." {0}', null),
  (5, 'Tina: "I can''t go out tonight." {0}', null),
  (6, 'Tina: "I''m looking forward to the weekend." {0}', null)
) as v(n, template, hint)
where es.title = '51.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '51.3'
join (values
  (1, 0, 'So did I.', array['Did you? What did you watch?']::text[]),
  (2, 0, 'Neither will I.', array['Won''t you? Where will you be?']::text[]),
  (3, 0, 'So do I.', array['Do you? What sort of books do you like?']::text[]),
  (4, 0, 'So would I.', array['Would you? Where would you like to live?']::text[]),
  (5, 0, 'Neither can I.', array['Can''t you? Why not?']::text[]),
  (6, 0, 'So am I.', array['Are you? Are you doing something nice?']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '51.4', 'What do you say to Sam? Use I think so, I hope not etc.', 3
from units where slug = 'unit-51';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-51' where es.title = '51.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You need more money. Sam: "Do you think you''ll get a pay rise?" {0}', '(hope)'),
  (2, 'You''re going to a party. You can''t stand John. Sam: "Will John be at the party?" {0}', '(hope)'),
  (3, 'You''re not sure whether Amy is married, but she probably isn''t. Sam: "Is Amy married?" {0}', '(think)'),
  (4, 'Jane has lived in Italy for many years. Sam: "Does Jane speak Italian?" {0}', '(suppose)'),
  (5, 'You have to leave Sam''s party early. Sam: "Do you have to leave already?" {0}', '(afraid)'),
  (6, 'You''re not sure what time the film begins, but it''s probably 7.30. Sam: "What time is the film? 7.30?" {0}', '(think)'),
  (7, 'You are the receptionist at a hotel. The hotel is full. Sam: "Do you have a room for tonight?" {0}', '(afraid)')
) as v(n, template, hint)
where es.title = '51.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '51.4'
join (values
  (1, 0, 'I hope so.'), (2, 0, 'I hope not.'), (3, 0, 'I don''t think so.'), (4, 0, 'I suppose so.'),
  (5, 0, 'I''m afraid so.'), (6, 0, 'I think so.'), (7, 0, 'I''m afraid not.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 52: Question tags (do you? isn't it? etc.)
-- ============================================================

delete from units where slug = 'unit-52';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 52, 'unit-52', 'Question tags (do you? isn''t it? etc.)', null,
  'Question tags are mini-questions added to the end of a sentence (isn''t it? / have you? etc.), using an auxiliary verb. Normally a positive sentence takes a negative tag and a negative sentence takes a positive tag. Whether the voice goes up or down changes the meaning — a real question vs. expecting agreement.', 3
from modules where slug = 'questions-and-auxiliary-verbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'What question tags are',
  'Question tags are mini-questions added to the end of a sentence: "You haven''t seen Lisa today, have you?" "It was a good film, wasn''t it?" In question tags we use an auxiliary verb (have/was/will etc.); for the present and past simple we use do/does/did: "Karen plays the piano, doesn''t she?"', 0
from units where slug = 'unit-52';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Positive sentence + negative tag, negative sentence + positive tag',
  'Normally we use a negative question tag after a positive sentence, and a positive question tag after a negative sentence: Kate will be here soon, won''t she? Kate won''t be late, will she? Notice the meaning of yes and no in answer to a negative sentence: "You''re not going out this morning, are you?" "Yes" (= Yes, I am going out); "No" (= No, I am not going out).', 1
from units where slug = 'unit-52';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Voice up or down changes the meaning',
  'The meaning of a question tag depends on how you say it. If your voice goes down, you''re not really asking a question — you expect the listener to agree: "It''s a nice day, isn''t it?" "Yes, beautiful." If the voice goes up, it''s a real question: "You haven''t seen Kate today, have you?" "No, I haven''t." You can also use a negative sentence + positive tag (voice going up) to ask for things or information: "You couldn''t do me a favour, could you?"', 2
from units where slug = 'unit-52';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'shall we / will you / aren''t I — special cases',
  'After Let''s ... the question tag is shall we: Let''s go for a walk, shall we? After Don''t ... the question tag is will you: Don''t be late, will you? After I''m ... the negative question tag is aren''t I (= am I not?): "I''m right, aren''t I?"', 3
from units where slug = 'unit-52';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-52'
join (values
  ('A', 'You haven''t seen Lisa today, have you?', null, 0),
  ('A', 'It was a good film, wasn''t it?', null, 1),
  ('A', 'Karen plays the piano, doesn''t she?', null, 2),
  ('A', 'You didn''t lock the door, did you?', null, 3),
  ('B', 'Kate will be here soon, won''t she?', null, 0),
  ('B', 'Kate won''t be late, will she?', null, 1),
  ('B', 'There was a lot of traffic, wasn''t there?', null, 2),
  ('B', 'They don''t like us, do they?', null, 3),
  ('B', 'Joe should pass the exam, shouldn''t he?', null, 4),
  ('B', 'You haven''t eaten yet, have you?', null, 5),
  ('C', '"It''s a nice day, isn''t it?" "Yes, beautiful."', 'expecting agreement — voice goes down', 0),
  ('C', '"Paul doesn''t look well today, does he?" "No, he looks very tired."', null, 1),
  ('C', '"You haven''t seen Kate today, have you?" "No, I haven''t."', 'real question — voice goes up', 2),
  ('C', '"You couldn''t do me a favour, could you?"', 'asking for something, voice goes up', 3),
  ('D', 'Let''s go for a walk, shall we?', null, 0),
  ('D', 'Don''t be late, will you?', null, 1),
  ('D', '"I''m right, aren''t I?" "Yes, you are."', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: two dialogue panels — "You haven''t seen Lisa today, have you?" "No, I haven''t." and "It was a good film, wasn''t it?" "Yes, it was great." — illustrating question tags]', 0
from units where slug = 'unit-52';

-- ------------------------------------------------------------
-- Exercises (main, book's own 52.1-52.3; items 1 and 2 of 52.1 are both
-- the book's worked examples, so this migration's numbering starts at the
-- book's item 3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '52.1', 'Complete these sentences with a question tag.', 0
from units where slug = 'unit-52';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-52' where es.title = '52.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You travel a lot, {0}?', null),
  (2, 'You weren''t listening, {0}?', null),
  (3, 'Sarah doesn''t know Ann, {0}?', null),
  (4, 'Jack''s on holiday, {0}?', null),
  (5, 'It didn''t take long to get here, {0}?', null),
  (6, 'You can speak German, {0}?', null),
  (7, 'They won''t mind if I take a picture, {0}?', null),
  (8, 'There are a lot of people here, {0}?', null),
  (9, 'Let''s go and have coffee, {0}?', null),
  (10, 'This isn''t very interesting, {0}?', null),
  (11, 'I''m too impatient, {0}?', null),
  (12, 'You wouldn''t tell anyone, {0}?', null),
  (13, 'Helen has lived here a long time, {0}?', null),
  (14, 'I shouldn''t have lost my temper, {0}?', null),
  (15, 'He''d never met her before, {0}?', null),
  (16, 'Don''t forget to call me, {0}?', null)
) as v(n, template, hint)
where es.title = '52.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '52.1'
join (values
  (1, 0, 'don''t you'), (2, 0, 'were you'), (3, 0, 'does she'), (4, 0, 'isn''t he'),
  (5, 0, 'did it'), (6, 0, 'can''t you'), (7, 0, 'will they'), (8, 0, 'aren''t there'),
  (9, 0, 'shall we'), (10, 0, 'is it'), (11, 0, 'aren''t I'), (12, 0, 'would you'),
  (13, 0, 'hasn''t she'), (14, 0, 'should I'), (15, 0, 'had he'), (16, 0, 'will you')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '52.2', 'In these situations you expect your friend to agree with you. Use a question tag in your sentences.', 1
from units where slug = 'unit-52';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-52' where es.title = '52.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''re with a friend outside a restaurant. You''re looking at the prices, which are very high. You say: {0}', '(expensive)'),
  (2, 'You and a colleague have just finished a training course. You really enjoyed it. You say to your colleague: {0}', '(great)'),
  (3, 'Your friend''s hair is much shorter than when you last met. You say to her/him: {0}', '(have / your hair / cut)'),
  (4, 'You''re listening to a woman singing. You like her voice very much. You say to your friend: {0}', '(a good voice)'),
  (5, 'You''re trying on a jacket in a shop. You look in the mirror and you don''t like what you see. You say to your friend: {0}', '(not / look / right)'),
  (6, 'You and a friend are walking over a small wooden bridge. The bridge is old and some parts are broken. You say: {0}', '(not / very safe)')
) as v(n, template, hint)
where es.title = '52.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '52.2'
join (values
  (1, 0, 'It''s very expensive, isn''t it?', array['It''s expensive, isn''t it?']::text[]),
  (2, 0, 'The course was great, wasn''t it?', array[]::text[]),
  (3, 0, 'You''ve had your hair cut, haven''t you?', array['You had your hair cut, didn''t you?']::text[]),
  (4, 0, 'She has a good voice, doesn''t she?', array['She has a good voice, hasn''t she?', 'She''s got a good voice, hasn''t she?']::text[]),
  (5, 0, 'It doesn''t look right, does it?', array[]::text[]),
  (6, 0, 'This bridge isn''t very safe, is it?', array['This bridge doesn''t look very safe, does it?']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '52.3', 'In these situations you are asking for information, asking people to do things etc.', 2
from units where slug = 'unit-52';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-52' where es.title = '52.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You have to move a heavy table. You want Joe to help you with it. Ask him. {0}', null),
  (2, 'You''re looking for Sarah. Perhaps Lisa knows where she is. Ask her. {0}', null),
  (3, 'You want to borrow a tennis racket. Perhaps Helen has one. Ask her. {0}', null),
  (4, 'Anna has a car and you need a lift to the station. Perhaps she''ll take you. Ask her. {0}', null),
  (5, 'You''re looking for your keys. Perhaps Robert has seen them. Ask him. {0}', null)
) as v(n, template, hint)
where es.title = '52.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '52.3'
join (values
  (1, 0, 'Joe, you couldn''t help me with this table, could you?', array['Joe, you couldn''t help me, could you?']::text[]),
  (2, 0, 'Lisa, you don''t know where Sarah is, do you?', array['Lisa, you haven''t seen Sarah, have you?']::text[]),
  (3, 0, 'Helen, you don''t have a tennis racket, do you?', array['Helen, you haven''t got a tennis racket, have you?']::text[]),
  (4, 0, 'Anna, you couldn''t take me to the station, could you?', array['Anna, you couldn''t give me a lift to the station, could you?']::text[]),
  (5, 0, 'Robert, you haven''t seen my keys, have you?', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
