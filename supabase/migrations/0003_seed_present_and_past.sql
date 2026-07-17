-- Marco 4 (slice 1): seeds units 2-6 of "Present and past", plus the
-- "Units 1-6" additional exercise. Sourced from the real book content in
-- pdf/Modulos/Present and past.pdf (extracted via `pdftotext -layout`,
-- since pdftoppm/poppler isn't available locally for the Read tool to
-- render PDF pages directly). Exercises are split into the book's own
-- sub-exercises (2.1-2.5, 3.1-3.4, etc.) rather than one combined set per
-- unit, and answers are cross-checked against pdf/Key to Exercises.pdf and
-- pdf/Key to Additional exercises.pdf.
--
-- Consolidated from supabase/seed/unit-2.sql .. unit-6.sql and
-- additional-present-past-1-6.sql into a single migration so Supabase's
-- GitHub-linked CI/CD applies it automatically on push, instead of being
-- run by hand in the SQL editor like unit-1.sql was.
--
-- The 'present-past' module row is upserted here (not assumed to already
-- exist) so this migration doesn't silently no-op if it ever runs against
-- a database where unit-1.sql hasn't been applied yet.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('present-past', 'Present and past', 0)
on conflict (slug) do nothing;

delete from units where slug = 'unit-2';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 2, 'unit-2', 'Present simple', 'I do',
  'The present simple is formed with the base form of the verb (I/we/you/they), or the base form + -s/-es (he/she/it); do/does is used to make questions and negatives.', 1
from modules where slug = 'present-past';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'A fact about a person vs. what they are doing right now',
  'drive(s)/work(s)/do(es) etc. is the present simple. We use it for what is generally true, not necessarily for what is happening at this moment.', 0
from units where slug = 'unit-2';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Things that happen all the time or are true in general',
  'We use the present simple to talk about things that happen repeatedly, or that are true in general, not just now.', 1
from units where slug = 'unit-2';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Questions and negatives with do/does',
  'We use do/does to make present simple questions and negative sentences, followed by the infinitive (without to).', 2
from units where slug = 'unit-2';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'Saying how often we do things',
  'The present simple is used with frequency expressions (every morning, how often, very often, two or three times a year) to say how often something happens.', 3
from units where slug = 'unit-2';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'I promise / I apologise etc.',
  'Sometimes we do something by saying something (promising, suggesting, apologising). These verbs are used in the present simple, not the continuous.', 4
from units where slug = 'unit-2';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-2'
join (values
  ('A', 'He is not driving a bus. (He is asleep.)', 'not now', 0),
  ('A', 'He drives a bus. He is a bus driver.', 'general fact', 1),
  ('B', 'Nurses look after patients in hospitals.', 'general truth', 0),
  ('B', 'I usually go away at weekends.', 'repeated', 1),
  ('B', 'The earth goes round the sun.', 'general truth', 2),
  ('B', 'The cafe opens at 7.30 in the morning.', 'repeated', 3),
  ('C', 'I come from Canada. Where do you come from?', 'question', 0),
  ('C', 'I don''t go away very often.', 'negative', 1),
  ('C', 'What does this word mean? (not What means this word?)', 'question', 2),
  ('C', 'Rice doesn''t grow in cold climates.', 'negative', 3),
  ('D', 'I get up at 8 o''clock every morning.', 'frequency', 0),
  ('D', 'How often do you go to the dentist?', 'frequency question', 1),
  ('D', 'Julie doesn''t drink tea very often.', 'frequency negative', 2),
  ('E', 'I promise I won''t be late. (not I''m promising)', 'performative', 0),
  ('E', '''What do you suggest I do?'' ''I suggest that you ...''', 'performative', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / we / you / they', null, 'drive / work / do', 0 from units where slug = 'unit-2'
union all
select id, 'positive', 'he / she / it', null, 'drives / works / does', 1 from units where slug = 'unit-2'
union all
select id, 'negative', null, null, 'I/we/you/they don''t drive/work/do; he/she/it doesn''t drive/work/do', 0 from units where slug = 'unit-2'
union all
select id, 'question', null, null, 'Do I/we/you/they drive/work/do?; Does he/she/it drive/work/do?', 0 from units where slug = 'unit-2';

insert into theory_spelling_notes (unit_id, rule, example, order_index)
select id, v.rule, v.example, v.order_index
from units, (values
  ('Most verbs', 'work → works, start → starts', 0),
  ('Ends in -s, -ss, -sh, -ch, -x, -o', 'miss → misses, watch → watches, go → goes', 1),
  ('Consonant + -y', 'study → studies, try → tries', 2),
  ('Vowel + -y', 'play → plays, enjoy → enjoys', 3)
) as v(rule, example, order_index)
where units.slug = 'unit-2';

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Alex asleep in bed, contrasted with him driving a bus — "he is not driving a bus (he is asleep) but he drives a bus / he is a bus driver"]', 0
from units where slug = 'unit-2';

-- ============================================================
-- Exercises (main, split into the book's own 2.1-2.5)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '2.1', 'Complete the sentences using the following verbs: cause(s), close(s), connect(s), go(es), live(s), speak(s), take(s).', 0
from units where slug = 'unit-2';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-2' where es.title = '2.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ben and Jack {0} to the same school.', null),
  (2, 'Bad driving {0} many accidents.', null),
  (3, 'The museum {0} at 4 o''clock on Sundays.', null),
  (4, 'My parents {0} in a very small flat.', null),
  (5, 'The Olympic Games {0} place every four years.', null),
  (6, 'The Panama Canal {0} the Atlantic and Pacific oceans.', null)
) as v(n, template, hint)
where es.title = '2.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '2.1'
join (values
  (1, 0, 'go'), (2, 0, 'causes'), (3, 0, 'closes'), (4, 0, 'live'), (5, 0, 'take'), (6, 0, 'connects')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '2.2', 'Put the verb into the correct form.', 1
from units where slug = 'unit-2';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-2' where es.title = '2.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'What time {0} here?', 'the banks / close'),
  (2, 'I have a car, but I {0} it much.', 'not / use'),
  (3, 'Where {0} from? Is she Spanish?', 'Maria / come'),
  (4, '''What {0}?'' ''I''m an electrician.''', 'you / do'),
  (5, 'Look at this sentence. What {0}?', 'this word / mean'),
  (6, 'David isn''t very fit. He {0} any sport.', 'not / do'),
  (7, 'It {0} me an hour to get to work in the morning. How long {1} you?', 'take ... it / take')
) as v(n, template, hint)
where es.title = '2.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '2.2'
join (values
  (1, 0, 'do the banks close'),
  (2, 0, 'don''t use'),
  (3, 0, 'does Maria come'),
  (4, 0, 'do you do'),
  (5, 0, 'does this word mean'),
  (6, 0, 'doesn''t do'),
  (7, 0, 'takes'), (7, 1, 'does it take')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '2.3', 'Complete the sentences using these verbs. Sometimes you need the negative: believe, eat, flow, go, grow, make, rise, tell, translate.', 2
from units where slug = 'unit-2';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-2' where es.title = '2.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The sun {0} in the east.', null),
  (2, 'Bees {0} honey.', null),
  (3, 'Vegetarians {0} meat.', null),
  (4, 'An atheist {0} in God.', null),
  (5, 'An interpreter {0} from one language into another.', null),
  (6, 'Liars are people who {0} the truth.', null),
  (7, 'The River Amazon {0} into the Atlantic Ocean.', null)
) as v(n, template, hint)
where es.title = '2.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '2.3'
join (values
  (1, 0, 'rises'), (2, 0, 'make'), (3, 0, 'don''t eat'), (4, 0, 'doesn''t believe'),
  (5, 0, 'translates'), (6, 0, 'don''t tell'), (7, 0, 'flows')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '2.4', 'You ask Lisa questions about herself and her family. Write the questions.', 3
from units where slug = 'unit-2';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-2' where es.title = '2.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'Perhaps Lisa''s sister plays tennis too — ask Lisa'),
  (2, '{0}', 'You know Lisa goes to the cinema a lot — ask how often'),
  (3, '{0}', 'You know Lisa''s brother works — ask what he does'),
  (4, '{0}', 'You''re not sure whether Lisa speaks Spanish — ask her'),
  (5, '{0}', 'You don''t know where Lisa''s grandparents live — ask Lisa')
) as v(n, template, hint)
where es.title = '2.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '2.4'
join (values
  (1, 0, 'Does your sister play tennis?'),
  (2, 0, 'How often do you go to the cinema?'),
  (3, 0, 'What does your brother do?'),
  (4, 0, 'Do you speak Spanish?'),
  (5, 0, 'Where do your grandparents live?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '2.5', 'Complete using: I agree, I apologise, I insist, I promise, I recommend, I suggest.', 4
from units where slug = 'unit-2';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-2' where es.title = '2.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I won''t tell anybody what you said. {0}.', null),
  (2, '(In a restaurant) You must let me pay for the meal. {0}.', null),
  (3, '{0} for what I said. I shouldn''t have said it.', null),
  (4, 'The new restaurant in Baker Street is very good. {0} it.', null),
  (5, 'I think you''re absolutely right. {0} with you.', null)
) as v(n, template, hint)
where es.title = '2.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '2.5'
join (values
  (1, 0, 'I promise'), (2, 0, 'I insist'), (3, 0, 'I apologise'), (4, 0, 'I recommend'), (5, 0, 'I agree')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Present and past" / Unit 3 (Present continuous and present simple 1),
-- sourced from pdf/Modulos/Present and past.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 3.1 and 3.2: the book's "Are the underlined verbs OK?" format
-- (3.1) isolates just the verb phrase as the correction target; where the
-- key says "OK", the blank's correct answer is simply the original verb
-- phrase unchanged. Exercise 3.2 uses two sub-items (a/b) per number — each
-- is seeded as its own sentence.
--
-- Safe to re-run: deletes unit-3 first (cascades) before re-inserting.
-- Run this in the Supabase SQL Editor after unit-1.sql (module already exists).

delete from units where slug = 'unit-3';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 3, 'unit-3', 'Present continuous and present simple 1', 'I am doing and I do',
  'Compare the present continuous, used for things happening at or around the time of speaking, with the present simple, used for things in general or things that happen repeatedly.', 2
from modules where slug = 'present-past';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Continuous (now, temporary) vs. simple (general, repeated, permanent)',
  'We use the continuous for things happening at or around the time of speaking, and for temporary situations. We use the simple for things in general, things that happen repeatedly, and permanent situations.', 0
from units where slug = 'unit-3';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'I always do vs. I''m always doing',
  'I always do something = I do it every time. I''m always doing something = I do it too often, or more often than normal (usually a complaint).', 1
from units where slug = 'unit-3';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-3'
join (values
  ('A', 'The water is boiling. Be careful.', 'continuous — happening now', 0),
  ('A', 'Water boils at 100 degrees Celsius.', 'simple — general truth', 1),
  ('A', 'Let''s go out. It isn''t raining now.', 'continuous — now', 2),
  ('A', 'It doesn''t rain very much in summer.', 'simple — general', 3),
  ('A', 'I''m living with some friends until I find a place of my own.', 'continuous — temporary', 4),
  ('A', 'My parents live in London. They have lived there all their lives.', 'simple — permanent', 5),
  ('B', 'I always go to work by car. (not I''m always going)', 'regular habit', 0),
  ('B', 'I''ve lost my keys again. I''m always losing them.', 'complaint — too often', 1),
  ('B', 'Paul is never satisfied. He''s always complaining.', 'annoying habit', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: timeline diagrams contrasting "I am doing" (continuous, framed around now — past/now/future arrow with the action centred on "now") and "I do" (simple, a repeated action marked at multiple points across past/now/future)]', 0
from units where slug = 'unit-3';

-- ============================================================
-- Exercises (main, split into the book's own 3.1-3.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '3.1', 'Are the underlined verbs OK? Correct them where necessary.', 0
from units where slug = 'unit-3';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-3' where es.title = '3.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ben {0} to find a job, but he hasn''t had any luck yet.', null),
  (2, 'Martina {0} her mother every day.', null),
  (3, 'The moon {0} round the earth in about 27 days.', null),
  (4, 'Can you hear those people? {0} about?', null),
  (5, '{0} in your spare time?', null),
  (6, 'Sarah is a vegetarian. {0} meat.', null),
  (7, 'I must go now. {0} late.', null),
  (8, '''Come on! It''s time to leave.'' ''OK, {0}.''', null),
  (9, 'Paul is never late. {0} work on time.', null),
  (10, 'They don''t get on well. {0}.', null)
) as v(n, template, hint)
where es.title = '3.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '3.1'
join (values
  (1, 0, 'is trying', array[]::text[]),
  (2, 0, 'phones', array[]::text[]),
  (3, 0, 'goes', array[]::text[]),
  (4, 0, 'What are they talking', array[]::text[]),
  (5, 0, 'What do you do', array[]::text[]),
  (6, 0, 'She doesn''t eat', array[]::text[]),
  (7, 0, 'It''s getting', array['It is getting']::text[]),
  (8, 0, 'I''m coming', array['I am coming']::text[]),
  (9, 0, 'He always starts', array[]::text[]),
  (10, 0, 'They''re always arguing', array['They are always arguing']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '3.2', 'Put the verb into the correct form, present continuous or present simple.', 1
from units where slug = 'unit-3';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-3' where es.title = '3.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''{0} to the radio?'' ''No, you can turn it off.''', 'you / listen'),
  (2, '''{0} to the radio a lot?'' ''No, not very often.''', 'you / listen'),
  (3, 'The River Nile {0} into the Mediterranean.', 'flow'),
  (4, 'The river {0} very fast today — much faster than usual.', 'flow'),
  (5, 'I''m not very active. {0} any sport.', 'I / not / do'),
  (6, 'What {0} at weekends?', 'you / usually / do'),
  (7, 'Rachel is in New York right now. {0} at the Park Hotel.', 'She / stay'),
  (8, '{0} there when she''s in New York.', 'She / always / stay')
) as v(n, template, hint)
where es.title = '3.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '3.2'
join (values
  (1, 0, 'Are you listening', array[]::text[]),
  (2, 0, 'Do you listen', array[]::text[]),
  (3, 0, 'flows', array[]::text[]),
  (4, 0, 'is flowing', array['''s flowing']::text[]),
  (5, 0, 'I don''t do', array[]::text[]),
  (6, 0, 'do you usually do', array[]::text[]),
  (7, 0, 'She''s staying', array['She is staying']::text[]),
  (8, 0, 'She always stays', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '3.3', 'Put the verb into the correct form, present continuous or present simple.', 2
from units where slug = 'unit-3';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-3' where es.title = '3.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Julia is good at languages. {0} four languages very well.', 'She / speak'),
  (2, 'Are you ready yet? {0} for you.', 'Everybody / wait'),
  (3, 'I''ve never heard this word. How {0} it?', 'you / pronounce'),
  (4, 'Kate {0} this week. She''s on holiday.', 'not / work'),
  (5, 'I think my English {0} slowly. It''s better than it was.', 'improve'),
  (6, 'Nicola {0} in Manchester. She has never lived anywhere else.', 'live'),
  (7, 'Can we stop walking soon? {0} to get tired.', 'I / start'),
  (8, 'Sam and Tina are in Madrid right now. {0} a friend of theirs.', 'They / visit'),
  (9, '''What {0}?'' ''He''s an architect.''', 'your father / do'),
  (10, 'It took me an hour to get to work this morning. Most days {0} so long.', 'it / not / take'),
  (11, '{0} to drive. My driving test is next month. My father {1} me.', 'I / learn ... teach')
) as v(n, template, hint)
where es.title = '3.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '3.3'
join (values
  (1, 0, 'She speaks', array[]::text[]),
  (2, 0, 'Everybody''s waiting', array['Everybody is waiting']::text[]),
  (3, 0, 'do you pronounce', array[]::text[]),
  (4, 0, 'isn''t working', array['is not working']::text[]),
  (5, 0, 'is improving', array[]::text[]),
  (6, 0, 'lives', array[]::text[]),
  (7, 0, 'I''m starting', array['I am starting']::text[]),
  (8, 0, 'They''re visiting', array['They are visiting']::text[]),
  (9, 0, 'does your father do', array[]::text[]),
  (10, 0, 'it doesn''t take', array[]::text[]),
  (11, 0, 'I''m learning', array['I am learning']::text[]), (11, 1, 'is teaching', array['''s teaching']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '3.4', 'Finish B''s sentences. Use always -ing.', 3
from units where slug = 'unit-3';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-3' where es.title = '3.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: The car has broken down again. b: That car is useless. {0}', null),
  (2, 'a: Look! You''ve made the same mistake again. b: Oh no, not again! {0}', null),
  (3, 'a: Oh, I''ve left my phone at home again. b: Typical! {0}', null)
) as v(n, template, hint)
where es.title = '3.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '3.4'
join (values
  (1, 0, 'It''s always breaking down.', array['It is always breaking down.']::text[]),
  (2, 0, 'I''m always making the same mistake.', array['I am always making that mistake.']::text[]),
  (3, 0, 'You''re always leaving your phone at home.', array['You are always leaving your phone at home.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present and past" / Unit 4 (Present continuous and present simple 2),
-- sourced from pdf/Modulos/Present and past.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 4.2: the book's items are picture prompts, but each picture's
-- caption/dialogue plus its bracketed word prompt already fully determine
-- the target sentence (confirmed against the Key), so no image placeholder
-- is needed here — unlike unit-1's 1.1, which depends on the picture itself.
--
-- Safe to re-run: deletes unit-4 first (cascades) before re-inserting.
-- Run this in the Supabase SQL Editor after unit-1.sql (module already exists).

delete from units where slug = 'unit-4';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 4, 'unit-4', 'Present continuous and present simple 2', 'I am doing and I do',
  'Some verbs (like, want, know, believe, understand...) describe states rather than actions and are not normally used in the continuous, even when talking about now.', 3
from modules where slug = 'present-past';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Verbs not normally used in the continuous (state verbs)',
  'Verbs like like, want, need, prefer, know, realise, understand, recognise, believe, suppose, remember, mean, belong, fit, contain, consist and seem describe states, not actions — we don''t say "I am wanting" or "they are liking". We say "I want" and "they like".', 0
from units where slug = 'unit-4';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'think: believe vs. consider',
  'When think means "believe" or "have an opinion", we do not use the continuous. When think means "consider" (actively weighing something), the continuous is possible.', 1
from units where slug = 'unit-4';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'see, hear, smell, taste, look, feel',
  'We normally use the present simple, not the continuous, with see/hear/smell/taste. For look and feel (how somebody looks or feels now), either the simple or the continuous is possible.', 2
from units where slug = 'unit-4';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'am/is/are being',
  'We use am/is/are being to say how a person is behaving right now (something they can control) — not for a permanent characteristic, and not for states like illness that a person can''t control.', 3
from units where slug = 'unit-4';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-4'
join (values
  ('A', 'I''m hungry. I want something to eat. (not I''m wanting)', 'state verb', 0),
  ('A', 'Do you understand what I mean?', 'state verb', 1),
  ('A', 'Anna doesn''t seem very happy right now.', 'state verb', 2),
  ('B', 'I think Mary is Canadian, but I''m not sure. (not I''m thinking)', 'believe/opinion', 0),
  ('B', 'What do you think of my idea?', 'believe/opinion', 1),
  ('B', 'I''m thinking about what happened.', 'consider', 2),
  ('B', 'Nicky is thinking of giving up her job.', 'consider', 3),
  ('C', 'Do you see that man over there? (not are you seeing)', 'simple only', 0),
  ('C', 'The room smells. Let''s open a window.', 'simple only', 1),
  ('C', 'You look well today. or You''re looking well today.', 'simple or continuous', 2),
  ('C', 'I usually feel tired in the morning. (not I''m usually feeling)', 'simple — habitual', 3),
  ('D', 'I can''t understand why he''s being so selfish. He isn''t usually like that.', 'behaving now', 0),
  ('D', '''The path is icy. Don''t slip.'' ''Don''t worry. I''m being very careful.''', 'behaving now', 1),
  ('D', 'He never thinks about other people. He''s very selfish. (generally, not only now)', 'general trait', 2),
  ('D', 'Sam is ill. (not is being ill)', 'not controllable', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 4.1-4.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '4.1', 'Put the verb into the correct form, present continuous or present simple.', 0
from units where slug = 'unit-4';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-4' where es.title = '4.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Alan says he''s 90 years old, but nobody {0} him.', 'believe'),
  (2, 'She told me her name, but {0} it now.', 'I / not / remember'),
  (3, 'Don''t put the dictionary away. {0} it.', 'I / use'),
  (4, 'Don''t put the dictionary away. {0} it.', 'I / need'),
  (5, 'Air {0} mainly of nitrogen and oxygen.', 'consist'),
  (6, 'Who is that man? What {0}?', 'he / want'),
  (7, 'Who is that man? Why {0} at us?', 'he / look'),
  (8, 'Who is that man? {0} him?', 'you / recognise'),
  (9, '{0} of selling my car. Would you be interested in buying it?', 'I / think'),
  (10, 'I can''t make up my mind. What {0} I should do?', 'you / think'),
  (11, 'Gary wasn''t well earlier, but {0} OK now.', 'he / seem')
) as v(n, template, hint)
where es.title = '4.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '4.1'
join (values
  (1, 0, 'believes', array[]::text[]),
  (2, 0, 'I don''t remember', array['I do not remember', 'I can''t remember']::text[]),
  (3, 0, 'I''m using', array['I am using']::text[]),
  (4, 0, 'I need', array[]::text[]),
  (5, 0, 'consists', array[]::text[]),
  (6, 0, 'does he want', array[]::text[]),
  (7, 0, 'is he looking', array[]::text[]),
  (8, 0, 'Do you recognise', array[]::text[]),
  (9, 0, 'I''m thinking', array['I am thinking']::text[]),
  (10, 0, 'do you think', array[]::text[]),
  (11, 0, 'he seems', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '4.2', 'Use the words in brackets to make sentences.', 1
from units where slug = 'unit-4';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-4' where es.title = '4.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Are you OK? You look worried. {0}', 'I / think'),
  (2, '{0}', 'who / this umbrella / belong to?'),
  (3, '{0}', 'this / smell / good'),
  (4, 'Excuse me. {0}', 'anybody / sit / there? (reply: ''No, it''s free.'')'),
  (5, '{0}', 'these gloves / not / fit / me (reply: ''They''re too small.'')')
) as v(n, template, hint)
where es.title = '4.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '4.2'
join (values
  (1, 0, 'I''m thinking.'),
  (2, 0, 'Who does this umbrella belong to?'),
  (3, 0, 'This smells good.'),
  (4, 0, 'Is anybody sitting there?'),
  (5, 0, 'These gloves don''t fit me.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '4.3', 'Are the underlined verbs OK? Correct them where necessary.', 2
from units where slug = 'unit-4';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-4' where es.title = '4.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} hungry. Is there anything to eat?', null),
  (2, 'I''ve never eaten that fruit. What {0} like?', null),
  (3, 'I''m not sure what she does. {0} she works in a shop.', null),
  (4, 'Look over there. What {0}?', null),
  (5, 'You''re very quiet. What {0} about?', null)
) as v(n, template, hint)
where es.title = '4.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '4.3'
join (values
  (1, 0, 'I''m feeling', array['I feel']::text[]),
  (2, 0, 'does it taste', array[]::text[]),
  (3, 0, 'I think', array[]::text[]),
  (4, 0, 'do you see', array[]::text[]),
  (5, 0, 'are you thinking', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '4.4', 'Complete the sentences. Use is/are being (continuous) or is/are (simple).', 3
from units where slug = 'unit-4';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-4' where es.title = '4.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''ll like Sophie when you meet her. She {0} very nice.', null),
  (2, 'Sarah {0} very nice to me at the moment. I wonder why.', null),
  (3, 'They {0} very happy. They''ve just got married.', null),
  (4, 'You''re normally very patient, so why {0} so unreasonable about waiting ten more minutes?', null),
  (5, 'Would you like something to eat? {0} hungry?', null)
) as v(n, template, hint)
where es.title = '4.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '4.4'
join (values
  (1, 0, 'is', array['''s']::text[]),
  (2, 0, 'is being', array['''s being']::text[]),
  (3, 0, 'are', array['''re']::text[]),
  (4, 0, 'are you being', array[]::text[]),
  (5, 0, 'Are you', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present and past" / Unit 5 (Past simple), sourced from
-- pdf/Modulos/Present and past.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-5 first (cascades) before re-inserting.
-- Run this in the Supabase SQL Editor after unit-1.sql (module already exists).

delete from units where slug = 'unit-5';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 5, 'unit-5', 'Past simple', 'I did',
  'The past simple is formed with the -ed ending for regular verbs, or an irregular past form; questions and negatives use did/didn''t + infinitive, and the past of be is was/were.', 4
from modules where slug = 'present-past';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Talking about finished past actions',
  'lived/started/wrote/was/died are all past simple — used to describe completed actions and states in the past, like the events of somebody''s life.', 0
from units where slug = 'unit-5';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Regular -ed forms and irregular verbs',
  'Regular verbs end in -ed in the past simple. Many common verbs are irregular and have their own past form instead.', 1
from units where slug = 'unit-5';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Questions and negatives with did/didn''t',
  'In questions and negative sentences we use did/didn''t + the infinitive (without to) — enjoy/see/go etc, not the past form of the main verb.', 2
from units where slug = 'unit-5';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'The past of be: was/were',
  'be is irregular in the past: I/he/she/it was, we/you/they were. Questions and negatives (wasn''t/weren''t, Was/Were...?) don''t use did.', 3
from units where slug = 'unit-5';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-5'
join (values
  ('A', 'He lived from 1756 to 1791.', 'finished past', 0),
  ('A', 'He started composing at the age of five.', 'finished past', 1),
  ('A', 'He wrote more than 600 pieces of music.', 'finished past', 2),
  ('A', 'He was only 35 years old when he died.', 'finished past', 3),
  ('B', 'I work in a travel agency now. Before that I worked in a department store.', 'regular -ed', 0),
  ('B', 'They invited us to their party, but we decided not to go.', 'regular -ed', 1),
  ('B', 'Mozart wrote more than 600 pieces of music.', 'irregular: write → wrote', 2),
  ('B', 'We saw Alice in town a few days ago.', 'irregular: see → saw', 3),
  ('B', 'I went to the cinema three times last week.', 'irregular: go → went', 4),
  ('B', 'It was cold, so I shut the window.', 'irregular: shut → shut', 5),
  ('C', 'I enjoyed the party a lot. Did you enjoy it?', 'question', 0),
  ('C', 'How many people did they invite to the wedding?', 'question', 1),
  ('C', 'I didn''t buy anything because I didn''t have any money.', 'negative', 2),
  ('C', 'What did you do at the weekend? (not What did you at the weekend?)', 'do as main verb', 3),
  ('D', 'I was annoyed because they were late.', 'was/were', 0),
  ('D', 'Was the weather good when you were on holiday?', 'was/were question', 1),
  ('D', 'They weren''t able to come because they were so busy.', 'were negative', 2),
  ('D', 'I wasn''t hungry, so I didn''t eat anything.', 'was negative', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / he / she / it', 'was', 'late', 0 from units where slug = 'unit-5'
union all
select id, 'positive', 'we / you / they', 'were', 'late', 1 from units where slug = 'unit-5'
union all
select id, 'negative', null, null, 'Subject + was/were + not (wasn''t/weren''t)', 0 from units where slug = 'unit-5'
union all
select id, 'question', null, null, 'Was/Were + subject ... ?', 0 from units where slug = 'unit-5';

insert into theory_spelling_notes (unit_id, rule, example, order_index)
select id, v.rule, v.example, v.order_index
from units, (values
  ('Most verbs', 'work → worked, start → started', 0),
  ('Ends in silent -e', 'like → liked, decide → decided', 1),
  ('Short vowel + consonant', 'stop → stopped, plan → planned', 2),
  ('Consonant + -y', 'study → studied, try → tried', 3)
) as v(rule, example, order_index)
where units.slug = 'unit-5';

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: portrait illustration of Wolfgang Amadeus Mozart, referenced in the introductory example about his life dates and compositions]', 0
from units where slug = 'unit-5';

-- ============================================================
-- Exercises (main, split into the book's own 5.1-5.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '5.1', 'Yesterday was a typical working day for Laura. Write what she did or didn''t do yesterday.', 0
from units where slug = 'unit-5';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-5' where es.title = '5.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'She {0} a big breakfast.', null),
  (2, '{0}.', 'How did she get to work?'),
  (3, '{0} to get to work.', 'how long?'),
  (4, '{0} at 8.45.', 'start work'),
  (5, '{0} lunch.', 'never has lunch'),
  (6, '{0} at 5 o''clock.', 'finish work'),
  (7, '{0} tired when {1} home.', 'be ... get'),
  (8, '{0} a meal yesterday evening.', 'cook'),
  (9, '{0} out yesterday evening.', 'doesn''t usually go out'),
  (10, '{0} at 11 o''clock.', 'go to bed'),
  (11, '{0} well last night.', 'always sleeps well')
) as v(n, template, hint)
where es.title = '5.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '5.1'
join (values
  (1, 0, 'had', array[]::text[]),
  (2, 0, 'She walked to work', array[]::text[]),
  (3, 0, 'It took her about half an hour', array['It took her half an hour']::text[]),
  (4, 0, 'She started work', array[]::text[]),
  (5, 0, 'She didn''t have any lunch', array['She didn''t eat any lunch']::text[]),
  (6, 0, 'She finished work', array[]::text[]),
  (7, 0, 'She was', array[]::text[]), (7, 1, 'she got', array[]::text[]),
  (8, 0, 'She cooked', array['She made']::text[]),
  (9, 0, 'She didn''t go', array[]::text[]),
  (10, 0, 'She went to bed', array[]::text[]),
  (11, 0, 'She slept', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '5.2', 'Complete the sentences using the following verbs in the correct form: buy, catch, cost, fall, hurt, sell, spend, teach, throw, write.', 1
from units where slug = 'unit-5';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-5' where es.title = '5.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''How did you learn to drive?'' ''My father {0} me.''', null),
  (2, 'We couldn''t afford to keep our car, so we {0} it.', null),
  (3, 'Dave {0} down the stairs this morning and {1} his leg.', null),
  (4, 'Joe {0} the ball to Sue, who {1} it.', null),
  (5, 'Kate {0} a lot of money yesterday. She {1} a dress which {2} £100.', null)
) as v(n, template, hint)
where es.title = '5.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '5.2'
join (values
  (1, 0, 'taught'),
  (2, 0, 'sold'),
  (3, 0, 'fell'), (3, 1, 'hurt'),
  (4, 0, 'threw'), (4, 1, 'caught'),
  (5, 0, 'spent'), (5, 1, 'bought'), (5, 2, 'cost')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '5.3', 'You ask James about his holiday in the US. Write your questions.', 2
from units where slug = 'unit-5';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-5' where es.title = '5.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'How {0}? By car?', 'James: Yes, we hired a car in San Francisco.'),
  (2, 'It''s a long way to drive. How long {0}?', 'James: Two weeks. We stopped at a lot of places along the way.'),
  (3, 'Where {0}? In hotels?', 'James: Yes, small hotels or motels.'),
  (4, '{0} good?', 'James: Yes, but it was very hot — sometimes too hot.'),
  (5, '{0} the Grand Canyon?', 'James: Of course. It was wonderful.')
) as v(n, template, hint)
where es.title = '5.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '5.3'
join (values
  (1, 0, 'did you travel', array['did you go']::text[]),
  (2, 0, 'did it take you', array['was your trip', 'were you there']::text[]),
  (3, 0, 'did you stay', array[]::text[]),
  (4, 0, 'Was the weather', array[]::text[]),
  (5, 0, 'Did you go to', array['Did you see', 'Did you visit']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '5.4', 'Complete the sentences. Put the verb into the correct form, positive or negative.', 3
from units where slug = 'unit-5';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-5' where es.title = '5.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I knew Sarah was busy, so I {0} her.', 'disturb'),
  (2, 'We were very tired, so we {0} the party early.', 'leave'),
  (3, 'It was hard carrying the bags. They {0} really heavy.', 'be'),
  (4, 'The bed was very uncomfortable. I {0} well.', 'sleep'),
  (5, 'This watch wasn''t expensive. It {0} much.', 'cost'),
  (6, 'The window was open and a bird {0} into the room.', 'fly'),
  (7, 'I was in a hurry, so I {0} time to call you.', 'have'),
  (8, 'I didn''t like the hotel. The room {0} very clean.', 'be')
) as v(n, template, hint)
where es.title = '5.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '5.4'
join (values
  (1, 0, 'didn''t disturb'), (2, 0, 'left'), (3, 0, 'were'), (4, 0, 'didn''t sleep'),
  (5, 0, 'didn''t cost'), (6, 0, 'flew'), (7, 0, 'didn''t have'), (8, 0, 'wasn''t')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Present and past" / Unit 6 (Past continuous), sourced from
-- pdf/Modulos/Present and past.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 6.2: the book format is a matching exercise (1-7 matched to a-g),
-- which doesn't fit this app's fill-in-the-blank model. Each pair has been
-- turned into a single combined sentence with the second clause as the
-- blank, preserving the exact same content and grading. Note on 6.3: the
-- two picture-story items are fully reconstructable from the surrounding
-- narration text and the Key, so no image placeholder is needed there.
--
-- Safe to re-run: deletes unit-6 first (cascades) before re-inserting.
-- Run this in the Supabase SQL Editor after unit-1.sql (module already exists).

delete from units where slug = 'unit-6';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 6, 'unit-6', 'Past continuous', 'I was doing',
  'was/were + -ing is the past continuous, used for an action already in progress at a particular time in the past.', 5
from modules where slug = 'present-past';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'An action in progress at a particular past time',
  'was/were + -ing is the past continuous. "They were playing tennis" (at 10.30) means they were in the middle of playing — they had started, but not finished.', 0
from units where slug = 'unit-6';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Started before, not finished at that time',
  'I was doing something = I was in the middle of doing it at a certain time; the action or situation started before this time but had not finished.', 1
from units where slug = 'unit-6';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Past continuous (in progress) vs. past simple (complete action)',
  'I was doing (past continuous) describes being in the middle of an action; I did (past simple) describes a complete action, from start to finish.', 2
from units where slug = 'unit-6';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'One action interrupting another',
  'We use the past continuous for a longer background action, and the past simple for a shorter action that happened in the middle of it. But when one thing happened after another, we use the past simple for both.', 3
from units where slug = 'unit-6';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'State verbs stay in the simple, even in the past',
  'Verbs like know and want (see Unit 4 for the full list) are not normally used in continuous forms, including was/were + -ing.', 4
from units where slug = 'unit-6';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-6'
join (values
  ('A', 'They started at 10 o''clock and finished at 11.30.', 'action span', 0),
  ('A', 'At 10.30 they were playing tennis.', 'in progress at 10.30', 1),
  ('B', 'This time last year I was living in Hong Kong.', 'in progress', 0),
  ('B', 'What were you doing at 10 o''clock last night?', 'in progress question', 1),
  ('B', 'I waved to Helen, but she wasn''t looking.', 'in progress, negative', 2),
  ('C', 'We were walking home when I met Dan. (in the middle of walking home)', 'in progress', 0),
  ('C', 'We walked home after the party last night. (= all the way, completely)', 'complete action', 1),
  ('C', 'Kate was watching TV when we arrived.', 'in progress', 2),
  ('C', 'Kate watched TV a lot when she was ill last year.', 'complete/habitual', 3),
  ('D', 'Matt phoned while we were having dinner.', 'interruption', 0),
  ('D', 'It was raining when I got up.', 'background', 1),
  ('D', 'I hurt my back while I was working in the garden.', 'interruption', 2),
  ('D', 'I was walking along the road when I saw Dan. So I stopped, and we talked for a while.', 'sequence — both simple', 3),
  ('E', 'We were good friends. We knew each other well. (not we were knowing)', 'state verb', 0),
  ('E', 'I was enjoying the party, but Chris wanted to go home. (not was wanting)', 'state verb', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'he / she / it', 'was', 'playing', 0 from units where slug = 'unit-6'
union all
select id, 'positive', 'we / you / they', 'were', 'working', 1 from units where slug = 'unit-6'
union all
select id, 'negative', null, null, 'Subject + was/were + not + verb-ing', 0 from units where slug = 'unit-6'
union all
select id, 'question', null, null, 'Was/Were + subject + verb-ing?', 0 from units where slug = 'unit-6';

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Karen and Joe playing tennis from 10:00 to 11:30, with a clock showing 10:30 to illustrate "they were playing tennis" as an action in progress]', 0
from units where slug = 'unit-6';

-- ============================================================
-- Exercises (main, split into the book's own 6.1-6.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '6.1', 'Complete the sentences. Choose from: was looking, was wearing, wasn''t listening, weren''t looking, was snowing, was working, were sitting, were you going.', 0
from units where slug = 'unit-6';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-6' where es.title = '6.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''What did he say?'' ''I don''t know. {0}.''', null),
  (2, 'We {0} at the back of the theatre. We couldn''t hear very well.', null),
  (3, 'This time last year Steve {0} on a farm.', null),
  (4, 'They didn''t see me. They {0} in my direction.', null),
  (5, 'The weather was bad. It was very cold and it {0}.', null),
  (6, 'I saw you in your car. {0}?', null),
  (7, 'I saw Kate a few minutes ago. {0} for you.', null)
) as v(n, template, hint)
where es.title = '6.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '6.1'
join (values
  (1, 0, 'I wasn''t listening'), (2, 0, 'were sitting'), (3, 0, 'was working'), (4, 0, 'weren''t looking'),
  (5, 0, 'was snowing'), (6, 0, 'Where were you going'), (7, 0, 'She was looking')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '6.2', 'Which goes with which? Combine the sentences.', 1
from units where slug = 'unit-6';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-6' where es.title = '6.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We fell asleep {0}.', null),
  (2, 'Amy learnt Italian {0}.', null),
  (3, 'Tom didn''t come out with us {0}.', null),
  (4, 'The car began to make a strange noise {0}.', null),
  (5, 'The TV was on {0}.', null),
  (6, 'When I first met Jessica {0}.', null)
) as v(n, template, hint)
where es.title = '6.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '6.2'
join (values
  (1, 0, 'while we were watching a film'),
  (2, 0, 'when she was living in Rome'),
  (3, 0, 'because he wasn''t feeling well'),
  (4, 0, 'when I was driving home'),
  (5, 0, 'but nobody was watching it'),
  (6, 0, 'she was working in a clothes shop')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '6.3', 'Put the verb into the correct form, past continuous or past simple.', 2
from units where slug = 'unit-6';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-6' where es.title = '6.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I saw Sue in town yesterday, but she {0} me. She {1} the other way.', 'not/see ... look'),
  (2, '{0} home yesterday when a man {1} out into the road in front of me. I {2} quite fast, but luckily I {3} to stop in time, and I {4} him.', 'cycle ... step ... go ... manage ... not/hit')
) as v(n, template, hint)
where es.title = '6.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '6.3'
join (values
  (1, 0, 'didn''t see'), (1, 1, 'was looking'),
  (2, 0, 'was cycling'), (2, 1, 'stepped'), (2, 2, 'was going'), (2, 3, 'managed'), (2, 4, 'didn''t hit')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '6.4', 'Put the verb into the correct form, past continuous or past simple.', 3
from units where slug = 'unit-6';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-6' where es.title = '6.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''What {0} at this time yesterday?'' ''I was asleep.''', 'you / do'),
  (2, '''{0} out last night?'' ''No, I was too tired.''', 'you / go'),
  (3, 'How fast {0} when the accident {1}?', 'you / drive ... happen'),
  (4, 'Sam {0} a picture of me while I {1}.', 'take ... not / look'),
  (5, 'We were in a very difficult position. We {0} what to do, so we {1} nothing.', 'not / know ... do'),
  (6, 'I haven''t seen Alan for ages. When I last {0} him, he {1} to find a job.', 'see ... try'),
  (7, 'I {0} along the street when suddenly I {1} something behind me. Somebody {2} me. I was scared and I {3} to run.', 'walk ... hear ... follow ... start'),
  (8, 'When I was young, I {0} to be a pilot. Later I {1} my mind.', 'want ... change'),
  (9, 'Last night I {0} a plate when I {1} the washing up. Fortunately it {2}.', 'drop ... do ... not / break')
) as v(n, template, hint)
where es.title = '6.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '6.4'
join (values
  (1, 0, 'were you doing', array[]::text[]),
  (2, 0, 'Did you go', array[]::text[]),
  (3, 0, 'were you driving', array[]::text[]), (3, 1, 'happened', array[]::text[]),
  (4, 0, 'took', array[]::text[]), (4, 1, 'wasn''t looking', array['was not looking']::text[]),
  (5, 0, 'didn''t know', array[]::text[]), (5, 1, 'did', array[]::text[]),
  (6, 0, 'saw', array[]::text[]), (6, 1, 'was trying', array[]::text[]),
  (7, 0, 'was walking', array[]::text[]), (7, 1, 'heard', array[]::text[]), (7, 2, 'was following', array[]::text[]), (7, 3, 'started', array[]::text[]),
  (8, 0, 'wanted', array[]::text[]), (8, 1, 'changed', array[]::text[]),
  (9, 0, 'dropped', array[]::text[]), (9, 1, 'was doing', array[]::text[]), (9, 2, 'didn''t break', array['did not break']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds the "Present and past (Units 1-6)" additional exercise from
-- pdf/Additional exercises.pdf (the book's Exercise 5 in that appendix's
-- global numbering; TOC entry "Present and past (Units 1-6) — Exercises
-- 5-8"). Per CLAUDE.md's business rule, additional exercises attach to the
-- units they test via exercise_set_units instead of forming their own menu
-- — this one tests all of units 1-6, so it's linked to all six.
--
-- The three OTHER exercises grouped under the same TOC line in the source
-- PDF ("Which is correct?", "Complete each question...", "Use your own
-- ideas...") were left out of this batch: despite the TOC label, their
-- content already draws on present perfect (units 7+), which isn't seeded
-- yet — seeding them now would reference units that don't exist. Revisit
-- once units 7+ (Present perfect and past module) are seeded.
--
-- Answers cross-checked against pdf/Key to Additional exercises.pdf.
--
-- Safe to re-run: deletes the exercise_set by title first. Run this in the
-- Supabase SQL Editor after unit-1.sql through unit-6.sql have all been run.

delete from exercise_sets where title = 'Additional exercise 1' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, source_ref, order_index)
select u.id, 'additional', 'Additional exercise 1',
  'Put the verb into the correct form: present simple (I do), present continuous (I am doing), past simple (I did) or past continuous (I was doing).',
  'Additional exercises, Exercise 5 (Present and past, Units 1-6)', 0
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1', 'unit-2', 'unit-3', 'unit-4', 'unit-5', 'unit-6')
where es.title = 'Additional exercise 1' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} hungry. Let''s go and have something to eat.', 'I / get'),
  (2, 'What {0} in your spare time? Do you have any hobbies?', 'you / do'),
  (3, 'The weather was horrible when {0}. It was cold and {1} hard.', 'we / arrive ... it / rain'),
  (4, 'Louise usually {0} me on Fridays, but {1} last Friday.', 'phone ... she / not / phone'),
  (5, 'a: When I last saw you, {0} of moving to a new flat. b: That''s right, but in the end {1} to stay where I was.', 'you / think ... I / decide'),
  (6, 'Why {0} at me like that? What''s the matter?', 'you / look'),
  (7, 'It''s usually dry here at this time of the year. {0} much.', 'it / not / rain'),
  (8, 'I waved to Ben, but he didn''t see me. {0} in my direction.', 'he / not / look'),
  (9, 'Lisa was busy when {0} to see her yesterday. She had an exam today and {1} for it. {2} to disturb her, so {3} very long.', 'we / go ... she / prepare ... we / not / want ... we / not / stay'),
  (10, 'When I first {0} Tom what happened, {1} me. {2} that {3}.', 'tell ... he / not / believe ... he / think ... I / joke')
) as v(n, template, hint)
where es.title = 'Additional exercise 1' and es.kind = 'additional';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 1' and es.kind = 'additional'
join (values
  (1, 0, 'I''m getting', array['I am getting']::text[]),
  (2, 0, 'do you do', array[]::text[]),
  (3, 0, 'we arrived', array[]::text[]), (3, 1, 'it was raining', array[]::text[]),
  (4, 0, 'phones', array[]::text[]), (4, 1, 'she didn''t phone', array[]::text[]),
  (5, 0, 'you were thinking', array[]::text[]), (5, 1, 'I decided', array[]::text[]),
  (6, 0, 'are you looking', array[]::text[]),
  (7, 0, 'It doesn''t rain', array[]::text[]),
  (8, 0, 'He wasn''t looking', array[]::text[]),
  (9, 0, 'we went', array[]::text[]), (9, 1, 'she was preparing', array[]::text[]),
    (9, 2, 'We didn''t want', array[]::text[]), (9, 3, 'we didn''t stay', array[]::text[]),
  (10, 0, 'told', array[]::text[]), (10, 1, 'he didn''t believe', array[]::text[]),
    (10, 2, 'He thought', array[]::text[]), (10, 3, 'I was joking', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
