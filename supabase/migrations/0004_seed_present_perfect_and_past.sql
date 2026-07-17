-- Marco 4 (slice 2): seeds the full "Present perfect and past" module —
-- units 7-18 (Present perfect 1/2, present perfect continuous, present
-- perfect continuous vs. simple, how long/for/since, present perfect vs.
-- past, past perfect, past perfect continuous, have/have got, used to).
--
-- Sourced from pdf/Modulos/Present perfect and past.pdf (extracted via
-- `pdftotext -layout`, same workaround as the previous module — pdftoppm/
-- poppler isn't available locally) and cross-checked against
-- pdf/Key to Exercises.pdf. A handful of open-ended exercises (own-answer
-- items like 8.3, 14.4, 18.4, and one item in 16.2) don't fit this app's
-- exact-match grading and are left out; each unit's header comment below
-- notes the specific omissions. The "Additional exercises" for this module
-- were not seeded this round (out of scope for this batch).
--
-- Consolidated from supabase/seed/unit-7.sql .. unit-18.sql into a single
-- migration, same as 0003_seed_present_and_past.sql, so Supabase's
-- GitHub-linked CI/CD applies it automatically on push.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('present-perfect', 'Present perfect and past', 1)
on conflict (slug) do nothing;

delete from units where slug = 'unit-7';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 7, 'unit-7', 'Present perfect 1', 'I have done',
  'have/has + past participle is the present perfect simple. It describes a past action with a result or connection now.', 0
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Form: have/has + past participle',
  'have lost / has lost etc. is the present perfect simple. The past participle often ends in -ed (finished, decided), but many verbs are irregular (lost, done, written).', 0
from units where slug = 'unit-7';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'New information with a result now',
  'When we say "something has happened", this is usually new information, and there is a connection with now — the action in the past has a result now.', 1
from units where slug = 'unit-7';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'just, already and yet',
  'just = a short time ago. already = sooner than expected. yet = until now, used in questions and negative sentences to show we''re expecting something to happen.', 2
from units where slug = 'unit-7';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'Past simple is also possible',
  'You can often use the past simple (did, went, had etc.) instead of the present perfect in these same examples.', 3
from units where slug = 'unit-7';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-7'
join (values
  ('A', 'Tom can''t find his key. He''s lost his key. (= He has lost ...)', 'result now', 0),
  ('A', 'he has lost his key = he lost it and he doesn''t have it now', 'meaning', 1),
  ('B', 'Ow! I''ve cut my finger.', 'new information', 0),
  ('B', 'The road is closed. There''s been an accident.', 'new information', 1),
  ('B', 'He told me his name, but I''ve forgotten it. (= I can''t remember it now)', 'result now', 2),
  ('B', 'James is on holiday. He has gone to Italy. (= he is there now or on his way there)', 'gone (to)', 3),
  ('B', 'Amy is back home now. She has been to Italy. (= she has now come back)', 'been (to)', 4),
  ('C', '''Are you hungry?'' ''No, I''ve just had lunch.''', 'just', 0),
  ('C', '''Don''t forget to pay the bill.'' ''I''ve already paid it.''', 'already', 1),
  ('C', 'Has it stopped raining yet?', 'yet — question', 2),
  ('C', 'I''ve written the email, but I haven''t sent it yet.', 'yet — negative', 3),
  ('D', 'Ben isn''t here. He''s gone out. or He went out.', 'either tense possible', 0)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / we / they / you', 'have', 'finished / lost / done / been', 0 from units where slug = 'unit-7'
union all
select id, 'positive', 'he / she / it', 'has', 'finished / lost / done / been', 1 from units where slug = 'unit-7'
union all
select id, 'negative', null, null, 'Subject + haven''t/hasn''t + past participle', 0 from units where slug = 'unit-7'
union all
select id, 'question', null, null, 'Have/Has + subject + past participle?', 0 from units where slug = 'unit-7';

-- ============================================================
-- Exercises (main, split into the book's own 7.1-7.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '7.1', 'Read the situations and complete the sentences using the present perfect. Choose from: break, disappear, go up, grow, improve, lose, shrink, stop.', 0
from units where slug = 'unit-7';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-7' where es.title = '7.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Maria''s English wasn''t very good. Now it is better. Her English {0}.', null),
  (2, 'My bag was here, but it isn''t here any more. My bag {0}.', null),
  (3, 'Lisa can''t walk and her leg is in plaster. Lisa {0}.', null),
  (4, 'Last week the bus fare was £1.80. Now it is £2. The bus fare {0}.', null),
  (5, 'Dan didn''t have a beard before. Now he has a beard. Dan {0}.', null),
  (6, 'It was raining ten minutes ago. It isn''t raining now. It {0}.', null),
  (7, 'I washed my sweater, and now it''s too small for me. My sweater {0}.', null)
) as v(n, template, hint)
where es.title = '7.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '7.1'
join (values
  (1, 0, 'has improved'), (2, 0, 'has disappeared'), (3, 0, 'has broken her leg'),
  (4, 0, 'has gone up'), (5, 0, 'has grown a beard'), (6, 0, 'has stopped'), (7, 0, 'has shrunk')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '7.2', 'Put in been or gone.', 1
from units where slug = 'unit-7';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-7' where es.title = '7.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Hello! I''ve just {0} to the shops. I''ve bought lots of things.', null),
  (2, 'Tom has just {0} out. He''ll be back in about an hour.', null),
  (3, 'Alice isn''t here at the moment. I don''t know where she''s {0}.', null),
  (4, 'You''re very late. Where have you {0}?', null)
) as v(n, template, hint)
where es.title = '7.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '7.2'
join (values
  (1, 0, 'been'), (2, 0, 'gone'), (3, 0, 'gone'), (4, 0, 'been')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '7.3', 'Complete the sentences using the present perfect.', 2
from units where slug = 'unit-7';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-7' where es.title = '7.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can''t find my bag. {0} it anywhere?', 'you / see'),
  (2, 'I can''t log on to the website. {0} my password.', 'I / forget'),
  (3, 'I sent Joe an email this morning, but {0}.', 'he / not / reply'),
  (4, 'Is the meeting still going on, or {0}?', 'it / finish'),
  (5, '{0}. It''s colder now.', 'the weather / change'),
  (6, '{0} the form. Could you sign it now, please?', 'you / not / sign'),
  (7, 'Are your friends still here, or {0} home?', 'they / go'),
  (8, 'Paul doesn''t know what he''s going to do. {0}.', 'he / not / decide / yet'),
  (9, '''Do you know where Julia is?'' ''Yes, {0}.''', 'I / just / see / her'),
  (10, '''When is David going away?'' ''{0}.''', 'he / already / go'),
  (11, '{0}? — Not yet. It starts next week.', 'your course / start / yet')
) as v(n, template, hint)
where es.title = '7.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '7.3'
join (values
  (1, 0, 'Have you seen it'), (2, 0, 'I''ve forgotten'), (3, 0, 'he hasn''t replied'),
  (4, 0, 'has it finished'), (5, 0, 'The weather has changed'), (6, 0, 'You haven''t signed'),
  (7, 0, 'have they gone'), (8, 0, 'He hasn''t decided yet'), (9, 0, 'I''ve just seen her'),
  (10, 0, 'He''s already gone'), (11, 0, 'Has your course started yet')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '7.4', 'Read the situations and write sentences with just, already or yet.', 3
from units where slug = 'unit-7';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-7' where es.title = '7.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Joe goes out. Five minutes later, the phone rings. Caller: ''Can I speak to Joe?'' You: I''m afraid {0}.', 'go out'),
  (2, 'You are eating in a restaurant. The waiter starts to take your plate away. You: Wait a minute! {0}.', 'not / finish'),
  (3, 'Your friend says ''Shall I phone to reserve a table?'' You: No, {0}.', 'do it'),
  (4, 'You know Lisa is looking for a place to live. You ask her: {0}?', 'find'),
  (5, 'A friend asks where you''re going for your holiday. You: {0}.', 'not / decide'),
  (6, 'Laura went out, but returned a few minutes ago. Somebody asks ''Is Laura still out?'' You: No, {0}.', 'come back')
) as v(n, template, hint)
where es.title = '7.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '7.4'
join (values
  (1, 0, 'he''s just gone out', array['he has just gone out', 'he just went out']::text[]),
  (2, 0, 'I haven''t finished yet', array['I didn''t finish yet']::text[]),
  (3, 0, 'I''ve already done it', array['I have already done it', 'I already did it', 'I did it already']::text[]),
  (4, 0, 'Have you found a place to live yet', array['Did you find a place to live yet']::text[]),
  (5, 0, 'I haven''t decided yet', array['I didn''t decide yet']::text[]),
  (6, 0, 'she''s just come back', array['she has just come back', 'she just came back']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 8 (Present perfect 2), sourced from
-- pdf/Modulos/Present perfect and past.pdf (extracted via `pdftotext -layout`)
-- and cross-checked against pdf/Key to Exercises.pdf.
--
-- Note: 8.3 ("Write four sentences about yourself") is open-ended with no
-- single correct answer, so it's left out — doesn't fit this app's exact-
-- match grading.
--
-- Safe to re-run: deletes unit-8 first (cascades) before re-inserting.

delete from units where slug = 'unit-8';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 8, 'unit-8', 'Present perfect 2', 'I have done',
  'We use the present perfect for a period of time that continues from the past until now — someone''s life, "recently", "so far", "today" — and for saying it''s the first/second time something has happened.', 1
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'A period of time that continues until now',
  'When we talk about a period of time that continues from the past until now (a person''s life, ever, never), we use the present perfect. been (to) means visited.', 0
from units where slug = 'unit-8';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'recently, in the last few days, so far, this year...',
  'We also use the present perfect with periods that are not finished at the time of speaking: recently, in the last few days, so far, today, this year.', 1
from units where slug = 'unit-8';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'It''s the first/second time ... has happened',
  'We use the present perfect after "It''s the (first/second) time..." — not the present simple.', 2
from units where slug = 'unit-8';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-8'
join (values
  ('A', 'Have you ever been to China?', 'life period', 0),
  ('A', 'We''ve never had a car.', 'life period', 1),
  ('A', 'It''s a really boring movie. It''s the most boring movie I''ve ever seen.', 'life period', 2),
  ('A', 'I''ve never been to Canada. Have you been there?', 'been (to) = visited', 3),
  ('B', 'Have you heard anything from Ben recently?', 'recently', 0),
  ('B', 'Everything is going well. There haven''t been any problems so far.', 'so far', 1),
  ('B', 'I''ve drunk four cups of coffee today.', 'today — unfinished', 2),
  ('B', 'Have you had a holiday this year?', 'this year — unfinished', 3),
  ('C', 'It''s the first time he has driven a car. (not drives)', 'first time', 0),
  ('C', 'Sarah has lost her passport again. This is the second time this has happened. (not happens)', 'second time', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 8.1, 8.2, 8.4 — 8.3 skipped, open-ended)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '8.1', 'You ask people about things they have done. Write questions with ever.', 0
from units where slug = 'unit-8';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-8' where es.title = '8.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'be / California?'),
  (2, '{0}', 'run / marathon?'),
  (3, '{0}', 'speak / famous person?'),
  (4, 'What''s {0}?', 'most beautiful place / visit?')
) as v(n, template, hint)
where es.title = '8.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '8.1'
join (values
  (1, 0, 'Have you ever been to California?', array[]::text[]),
  (2, 0, 'Have you ever run a marathon?', array[]::text[]),
  (3, 0, 'Have you ever spoken to a famous person?', array[]::text[]),
  (4, 0, 'the most beautiful place you''ve ever visited', array['the most beautiful place you have ever visited']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '8.2', 'Complete B''s answers. Some sentences are positive and some negative. Use these verbs: be, be, eat, happen, have, have, meet, play, read, see, try.', 1
from units where slug = 'unit-8';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-8' where es.title = '8.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Are you hungry? Yes. I {0} much today.', null),
  (2, 'Can you play chess? Yes, but {0} for ages.', null),
  (3, 'Are you enjoying your holiday? Yes, it''s the best holiday {0} for a long time.', null),
  (4, 'What''s that book about? I don''t know. {0} it.', null),
  (5, 'Is Brussels an interesting place? I don''t know. {0} there.', null),
  (6, 'I hear your car broke down again yesterday. Yes, it''s the second time {0} this month.', null),
  (7, 'Do you like caviar? I don''t know. {0} it.', null),
  (8, 'Mike was late for work again today. Again? {0} late every day this week.', null),
  (9, 'Who''s that woman by the door? I don''t know. {0} her before.', null)
) as v(n, template, hint)
where es.title = '8.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '8.2'
join (values
  (1, 0, 'haven''t eaten', array[]::text[]),
  (2, 0, 'I haven''t played', array['I haven''t played it']::text[]),
  (3, 0, 'I''ve had', array['I have had']::text[]),
  (4, 0, 'I haven''t read', array['I haven''t read it']::text[]),
  (5, 0, 'I''ve never been', array['I haven''t been']::text[]),
  (6, 0, 'it''s happened', array['it has happened', 'that''s happened', 'that has happened']::text[]),
  (7, 0, 'I''ve never tried', array['I haven''t tried', 'I''ve never eaten', 'I haven''t eaten']::text[]),
  (8, 0, 'He''s been', array['He has been']::text[]),
  (9, 0, 'I''ve never seen', array['I haven''t seen']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '8.4', 'Read the situations and complete the sentences.', 2
from units where slug = 'unit-8';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-8' where es.title = '8.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Some children at the zoo are looking at a giraffe. They''ve never seen one before. It''s the first time {0}.', null),
  (2, 'Sue is riding a horse. She doesn''t look very confident or comfortable. {0} before.', null),
  (3, 'Joe and Lisa are on holiday in Japan. They''ve been to Japan once before. This is the second time {0}.', null),
  (4, 'Emily is staying at the Prince Hotel. She stayed there a few years ago. It''s not the first {0} this hotel.', null),
  (5, 'Ben is playing tennis for the first time. He''s a complete beginner. {0} before.', null)
) as v(n, template, hint)
where es.title = '8.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '8.4'
join (values
  (1, 0, 'they''ve seen a giraffe', array['they have seen a giraffe']::text[]),
  (2, 0, 'She''s never ridden a horse', array['She has never ridden a horse']::text[]),
  (3, 0, 'they''ve been to Japan', array['they have been to Japan']::text[]),
  (4, 0, 'time she''s stayed at', array['time she has stayed at', 'time Emily has stayed at']::text[]),
  (5, 0, 'He''s never played tennis', array['He has never played tennis']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 9 (Present perfect continuous),
-- sourced from pdf/Modulos/Present perfect and past.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 9.1: this is a picture-only exercise (4 "earlier vs. now" scenes)
-- with no textual description of items 2-4 in the source PDF — genuinely
-- image-dependent. Per the placeholder convention, the hint field carries
-- [PLACEHOLDER_IMG: ...] for these; the answers themselves are known from
-- the Key.
--
-- Safe to re-run: deletes unit-9 first (cascades) before re-inserting.

delete from units where slug = 'unit-9';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 9, 'unit-9', 'Present perfect continuous', 'I have been doing',
  'have/has been + -ing is the present perfect continuous, used for an activity that has recently stopped or is still happening, often with how long, for and since.', 2
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'An activity that has recently stopped or just stopped',
  'have/has been + -ing is the present perfect continuous. We use it for an activity that has recently stopped or just stopped, often explaining a present result (being tired, out of breath, etc.).', 0
from units where slug = 'unit-9';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'How long — still happening, or repeated',
  'We use the present perfect continuous especially with how long, for and since, for an activity that is still happening or has just stopped. It''s also used for repeated actions over a period.', 1
from units where slug = 'unit-9';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'I am doing vs. I have been doing',
  'I am doing (present continuous) describes what''s happening right now. I have been doing (present perfect continuous) looks back at an activity over a period leading up to now.', 2
from units where slug = 'unit-9';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-9'
join (values
  ('A', 'Is it raining? No, but the ground is wet. It''s been raining. (= It has been ...)', 'recently stopped', 0),
  ('A', 'Why are you out of breath? Have you been running?', 'result now', 1),
  ('A', 'Paul is very tired. He''s been working hard.', 'result now', 2),
  ('A', 'Where have you been? I''ve been looking for you.', 'just stopped', 3),
  ('B', 'How long has it been raining? It''s been raining for two hours.', 'still happening', 0),
  ('B', 'How long have you been learning English?', 'still happening', 1),
  ('B', 'Ben is watching TV. He''s been watching TV all day.', 'still happening', 2),
  ('B', 'Silvia is a very good tennis player. She''s been playing since she was eight.', 'repeated action', 3),
  ('C', 'Don''t disturb me now. I''m working.', 'present continuous — now', 0),
  ('C', 'I''ve been working hard. Now I''m going to have a break.', 'present perfect continuous — period leading to now', 1),
  ('C', 'We need an umbrella. It''s raining.', 'present continuous — now', 2),
  ('C', 'The ground is wet. It''s been raining.', 'present perfect continuous — result of a period', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / we / they / you', 'have been', 'doing / working / learning', 0 from units where slug = 'unit-9'
union all
select id, 'positive', 'he / she / it', 'has been', 'doing / working / learning', 1 from units where slug = 'unit-9'
union all
select id, 'negative', null, null, 'Subject + haven''t/hasn''t been + verb-ing', 0 from units where slug = 'unit-9'
union all
select id, 'question', null, null, 'Have/Has + subject + been + verb-ing?', 0 from units where slug = 'unit-9';

-- ============================================================
-- Exercises (main, split into the book's own 9.1-9.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '9.1', 'What have these people been doing or what has been happening?', 0
from units where slug = 'unit-9';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-9' where es.title = '9.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}.', '[PLACEHOLDER_IMG: "earlier" vs. "now" illustration of a woman, implying she has just been watching TV]'),
  (2, '{0}.', '[PLACEHOLDER_IMG: "earlier" vs. "now" illustration of a group of people, implying they have just been playing tennis]'),
  (3, '{0}.', '[PLACEHOLDER_IMG: "earlier" vs. "now" illustration of a man, implying he has just been running]')
) as v(n, template, hint)
where es.title = '9.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '9.1'
join (values
  (1, 0, 'She''s been watching TV', array['She has been watching TV']::text[]),
  (2, 0, 'They''ve been playing tennis', array['They have been playing tennis']::text[]),
  (3, 0, 'He''s been running', array['He has been running']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '9.2', 'Write a question for each situation.', 1
from units where slug = 'unit-9';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-9' where es.title = '9.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m sorry I''m late, Ben. {0}', 'you / wait / long?'),
  (2, 'Why are you so dirty? {0}', 'what / you / do?'),
  (3, 'Hi, Anna. {0}', 'how long / you / work / here?'),
  (4, 'You sell phones? {0}', 'how long / you / do / that?')
) as v(n, template, hint)
where es.title = '9.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '9.2'
join (values
  (1, 0, 'Have you been waiting long?'), (2, 0, 'What have you been doing?'),
  (3, 0, 'How long have you been working here?'), (4, 0, 'How long have you been doing that?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '9.3', 'Read the situations and complete the sentences.', 2
from units where slug = 'unit-9';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-9' where es.title = '9.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We are waiting for the bus. We started waiting 20 minutes ago. {0} for 20 minutes.', null),
  (2, 'I''m learning Japanese. I started classes in December. {0} since December.', null),
  (3, 'Jessica is working in a hotel. She started working there on 18 January. {0} since 18 January.', null),
  (4, 'Our friends always go to Italy for their holidays. The first time was years ago. {0} for years.', null)
) as v(n, template, hint)
where es.title = '9.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '9.3'
join (values
  (1, 0, 'We''ve been waiting', array['We have been waiting']::text[]),
  (2, 0, 'I''ve been learning Japanese', array['I have been learning Japanese']::text[]),
  (3, 0, 'She''s been working there', array['She has been working there']::text[]),
  (4, 0, 'They''ve been going there', array['They have been going there', 'They''ve been going to Italy']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '9.4', 'Put the verb into the present continuous (am/is/are + -ing) or present perfect continuous (have/has been + -ing).', 3
from units where slug = 'unit-9';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-9' where es.title = '9.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Hi, Tom. {0} for you. I need to ask you something.', 'I / look'),
  (2, 'Why {0} at me like that? Stop it!', 'you / look'),
  (3, 'Rachel is a teacher. {0} for ten years.', 'she / teach'),
  (4, '{0} about what you said and I''ve decided to take your advice.', 'I / think'),
  (5, '''Is Paul on holiday this week?'' ''No, {0}.''', 'he / work'),
  (6, 'Sarah is very tired. {0} very hard recently.', 'she / work'),
  (7, 'It''s dangerous to use your phone when {0}.', 'you / drive'),
  (8, 'Laura {0} in South America for the last three months.', 'travel')
) as v(n, template, hint)
where es.title = '9.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '9.4'
join (values
  (1, 0, 'I''ve been looking', array['I have been looking']::text[]),
  (2, 0, 'are you looking', array[]::text[]),
  (3, 0, 'She''s been teaching', array['She has been teaching']::text[]),
  (4, 0, 'I''ve been thinking', array['I have been thinking']::text[]),
  (5, 0, 'he''s working', array['he is working']::text[]),
  (6, 0, 'She''s been working', array['She has been working']::text[]),
  (7, 0, 'you''re driving', array['you are driving']::text[]),
  (8, 0, 'has been travelling', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 10 (Present perfect continuous and
-- simple), sourced from pdf/Modulos/Present perfect and past.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-10 first (cascades) before re-inserting.

delete from units where slug = 'unit-10';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 10, 'unit-10', 'Present perfect continuous and simple', 'I have been doing and I have done',
  'Use the continuous (have/has been + -ing) to focus on the ongoing activity, whether or not it''s finished. Use the simple (have/has + past participle) to focus on the completed result, or how much/many/times.', 3
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'The activity (continuous) vs. the finished result (simple)',
  'has been painting is the present perfect continuous — we''re thinking of the activity, whether or not it''s finished. has painted is the present perfect simple — a completed action, thinking about the result.', 0
from units where slug = 'unit-10';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'More examples of the same contrast',
  'The continuous often explains a present state (dirty hands, feeling unwell) from an unfinished or recent activity; the simple states a completed change or result.', 1
from units where slug = 'unit-10';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'How long (continuous) vs. how much/many/times (simple)',
  'We use the continuous to say how long something still happening has been going on. We use the simple to say how much, how many, or how many times for completed actions.', 2
from units where slug = 'unit-10';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'Verbs not normally used in the continuous',
  'Verbs like know are not normally used in continuous forms (not I''ve been knowing). But want and mean can be used in the present perfect continuous.', 3
from units where slug = 'unit-10';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-10'
join (values
  ('A', 'There is paint on Kate''s clothes. She has been painting her bedroom.', 'continuous — activity', 0),
  ('A', 'The bedroom was green. Now it is yellow. She has painted her bedroom.', 'simple — result', 1),
  ('B', 'My hands are very dirty. I''ve been repairing my bike.', 'continuous', 0),
  ('B', 'My bike is OK again now. I''ve repaired it. (= I''ve finished repairing it)', 'simple', 1),
  ('B', 'Joe has been eating too much recently. He should eat less.', 'continuous', 2),
  ('B', 'Somebody has eaten all the chocolates. The box is empty.', 'simple', 3),
  ('C', 'How long have you been reading that book?', 'continuous — how long', 0),
  ('C', 'How many pages of that book have you read?', 'simple — how many', 1),
  ('C', 'They''ve been playing tennis since 2 o''clock.', 'continuous — how long', 2),
  ('C', 'They''ve played tennis three times this week.', 'simple — how many times', 3),
  ('D', 'I''ve known about the problem for a long time. (not I''ve been knowing)', 'state verb', 0),
  ('D', 'I''ve been meaning to phone Anna, but I keep forgetting.', 'want/mean exception', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 10.1-10.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '10.1', 'Read the situation and complete the sentences. Use the verbs in brackets.', 0
from units where slug = 'unit-10';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-10' where es.title = '10.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Rachel is from Australia. She is travelling round Europe. She began her trip three months ago. She {0} for three months. She {1} six countries so far.', 'travel ... visit'),
  (2, 'Patrick is a tennis player. He began playing tennis when he was 10. This year he won the national championship again. {0} the national championship four times. {1} since he was ten.', 'win ... play'),
  (3, 'When they left college, Lisa and Sue started making films together. They still make films. {0} films since they left college. {1} five films since they left college.', 'make ... make')
) as v(n, template, hint)
where es.title = '10.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '10.1'
join (values
  (1, 0, 'she''s been travelling', array['she has been travelling']::text[]), (1, 1, 'She''s visited', array['She has visited']::text[]),
  (2, 0, 'He''s won', array['He has won']::text[]), (2, 1, 'He''s been playing tennis', array['He has been playing tennis', 'He''s been playing']::text[]),
  (3, 0, 'They''ve been making', array['They have been making']::text[]), (3, 1, 'They''ve made', array['They have made']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '10.2', 'Ask questions using the words in brackets. Use the present perfect simple or continuous.', 1
from units where slug = 'unit-10';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-10' where es.title = '10.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'wait / long?'),
  (2, '{0}', 'catch / any fish?'),
  (3, '{0}', 'how many people / invite?'),
  (4, '{0}', 'how long / teach?'),
  (5, '{0} {1}', 'how many books / write? ... how long / write / books?'),
  (6, '{0} {1}', 'how long / save? ... how much money / save?')
) as v(n, template, hint)
where es.title = '10.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '10.2'
join (values
  (1, 0, 'Have you been waiting long?', array[]::text[]),
  (2, 0, 'Have you caught any fish?', array[]::text[]),
  (3, 0, 'How many people have you invited?', array[]::text[]),
  (4, 0, 'How long have you been teaching?', array[]::text[]),
  (5, 0, 'How many books have you written?', array[]::text[]), (5, 1, 'How long have you been writing books?', array['How long have you been writing']::text[]),
  (6, 0, 'How long have you been saving?', array['How long have you been saving money?']::text[]), (6, 1, 'How much money have you saved?', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '10.3', 'Put the verb into the present perfect simple or continuous.', 2
from units where slug = 'unit-10';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-10' where es.title = '10.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Look! {0} that window.', 'somebody / break'),
  (2, 'You look tired. {0} hard?', 'you / work'),
  (3, '''{0} in a factory?'' ''No, never.''', 'you / ever / work'),
  (4, 'Where''s Lisa? Where {0}?', 'she / go'),
  (5, 'This is a very old book. {0} it since I was a child.', 'I / have'),
  (6, '''Have you been busy?'' ''No, {0} TV.''', 'I / watch'),
  (7, 'My brother is an actor. {0} in several films.', 'he / appear'),
  (8, '''Sorry I''m late.'' ''That''s all right. {0} long.''', 'I / not / wait'),
  (9, 'Are you OK? You look as if {0}.', 'you / cry'),
  (10, '''Is it still raining?'' ''No, {0}.''', 'it / stop'),
  (11, 'The children are tired now. {0} in the garden.', 'they / play'),
  (12, '{0} my phone. {1} it?', 'I / lose ... you / see'),
  (13, '{0} the book you lent me, but {1} it yet. It''s really interesting.', 'I / read ... I / not / finish'),
  (14, '{0} the book you lent me, so you can have it back now.', 'I / read')
) as v(n, template, hint)
where es.title = '10.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '10.3'
join (values
  (1, 0, 'Somebody''s broken', array['Somebody has broken']::text[]),
  (2, 0, 'Have you been working', array[]::text[]),
  (3, 0, 'Have you ever worked', array[]::text[]),
  (4, 0, 'has she gone', array[]::text[]),
  (5, 0, 'I''ve had', array['I have had']::text[]),
  (6, 0, 'I''ve been watching', array['I have been watching']::text[]),
  (7, 0, 'He''s appeared', array['He has appeared']::text[]),
  (8, 0, 'I haven''t been waiting', array[]::text[]),
  (9, 0, 'you''ve been crying', array['you have been crying']::text[]),
  (10, 0, 'it''s stopped', array['it has stopped']::text[]),
  (11, 0, 'They''ve been playing', array['They have been playing']::text[]),
  (12, 0, 'I''ve lost', array['I have lost']::text[]), (12, 1, 'Have you seen', array[]::text[]),
  (13, 0, 'I''ve been reading', array['I have been reading']::text[]), (13, 1, 'I haven''t finished', array[]::text[]),
  (14, 0, 'I''ve read', array['I have read']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 11 ("How long have you (been) ...?"),
-- sourced from pdf/Modulos/Present perfect and past.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-11 first (cascades) before re-inserting.

delete from units where slug = 'unit-11';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 11, 'unit-11', 'How long have you (been) ...?', null,
  'We use the present perfect (not the present simple) to talk about something that began in the past and still continues now — especially with how long.', 4
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Present perfect for something that began in the past and still continues',
  'We use the present perfect (not the present simple) for a state or situation that started in the past and is still true now — "How long have they been married?", not "How long are they married?".', 0
from units where slug = 'unit-11';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Simple (known/had) vs. continuous (been learning/waiting)',
  'I''ve known / I''ve had / I''ve lived is the present perfect simple. I''ve been learning / I''ve been waiting is the present perfect continuous. With how long, the continuous is more usual, except for state verbs like know and like.', 1
from units where slug = 'unit-11';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'live and work: either form, but always needs the simple',
  'You can use either the continuous or the simple with live and work. But with always, we use the simple (I''ve always lived ..., not I''ve always been living ...).', 2
from units where slug = 'unit-11';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'I haven''t (done something) since/for ...',
  'We use the present perfect simple to say how long it''s been since something last happened — "I haven''t seen Tom since Monday" (Monday was the last time I saw him).', 3
from units where slug = 'unit-11';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-11'
join (values
  ('A', 'They have been married for 20 years.', 'still true now', 0),
  ('A', 'How long have they been married? (not How long are they married?)', 'question form', 1),
  ('A', 'We''ve known each other for a long time. (not We know)', 'still true now', 2),
  ('A', 'She hasn''t been waiting very long.', 'still true now, negative', 3),
  ('B', 'I''ve been learning English since January.', 'continuous — how long', 0),
  ('B', 'How long have you known Jane? (not have you been knowing)', 'state verb — simple only', 1),
  ('B', 'I''ve had these shoes for ages. (not I''ve been having)', 'state verb — simple only', 2),
  ('C', 'Julia has been living in this house for a long time. or Julia has lived ...', 'either form', 0),
  ('C', 'I''ve always lived in the country. (not always been living)', 'always + simple', 1),
  ('D', 'I haven''t seen Tom since Monday. (= Monday was the last time I saw him)', 'last time', 0),
  ('D', 'Sarah hasn''t phoned for ages. (= the last time she phoned was ages ago)', 'last time', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 11.1-11.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '11.1', 'Which is right?', 0
from units where slug = 'unit-11';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-11' where es.title = '11.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I like your house. How long {0} here?', 'do you live / have you lived'),
  (2, 'You''ll need an umbrella if you go out now. {0}.', 'It''s raining / It''s been raining'),
  (3, 'The weather {0} awful since I arrived here.', 'is / has been'),
  (4, 'I''m sorry I''m late. {0} long?', 'Are you waiting / Have you been waiting'),
  (5, 'We''ve moved. {0} in New Street now.', 'We''re living / We''ve been living'),
  (6, 'I met Maria only recently. {0} her very long.', 'I don''t know / I haven''t known'),
  (7, 'Lisa is in Germany. {0} there on a business trip.', 'She''s / She''s been'),
  (8, 'That''s a very old bike. How long {0} it?', 'do you have / have you had'),
  (9, 'I''m not feeling good. {0} ill all day.', 'I''m feeling / I''ve been feeling')
) as v(n, template, hint)
where es.title = '11.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '11.1'
join (values
  (1, 0, 'have you lived'), (2, 0, 'It''s raining'), (3, 0, 'has been'), (4, 0, 'Have you been waiting'),
  (5, 0, 'We''re living'), (6, 0, 'I haven''t known'), (7, 0, 'She''s'), (8, 0, 'have you had'), (9, 0, 'I''ve been feeling')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '11.2', 'Read the situations and write questions using the words in brackets.', 1
from units where slug = 'unit-11';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-11' where es.title = '11.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'how long / you / know / Katherine?'),
  (2, '{0}', 'how long / sister / in Australia?'),
  (3, '{0}', 'how long / you / teach / English?'),
  (4, '{0}', 'how long / you / have / that jacket?'),
  (5, '{0}', 'how long / Joe / work / airport?'),
  (6, '{0}', 'you / always / live / in Chicago?')
) as v(n, template, hint)
where es.title = '11.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '11.2'
join (values
  (1, 0, 'How long have you known Katherine?', array[]::text[]),
  (2, 0, 'How long has your sister been in Australia?', array[]::text[]),
  (3, 0, 'How long have you been teaching English?', array['How long have you taught English?']::text[]),
  (4, 0, 'How long have you had that jacket?', array[]::text[]),
  (5, 0, 'How long has Joe been working at the airport?', array['How long has Joe worked at the airport?']::text[]),
  (6, 0, 'Have you always lived in Chicago?', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '11.3', 'Complete B''s answers to A''s questions.', 2
from units where slug = 'unit-11';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-11' where es.title = '11.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Is Paul married? Yes, {0} married for ten years.', null),
  (2, 'Is Amy married? Yes, {0} married to a German guy.', null),
  (3, 'Do you still play tennis? No, I {0} tennis for years.', null),
  (4, 'Are you waiting for the bus? Yes, {0} for about 20 minutes.', null),
  (5, 'You know Mel, don''t you? Yes, {0} each other a long time.', null),
  (6, 'Jack is never ill, is he? No, he {0} ill since I''ve known him.', null),
  (7, 'Martin lives in Italy, doesn''t he? Yes, he {0} in Milan.', null),
  (8, 'Sue lives in Berlin, doesn''t she? Yes, {0} in Berlin for many years.', null),
  (9, 'Is Joe watching TV? Yes, {0} TV all evening.', null),
  (10, 'Do you watch TV a lot? No, I {0} TV since last weekend.', null),
  (11, 'Do you have a headache? Yes, I {0} a headache all morning.', null),
  (12, 'Do you go to the cinema a lot? No, I {0} to the cinema for ages.', null),
  (13, 'Would you like to go to New York one day? Yes, {0} to go to New York.', 'use always / want')
) as v(n, template, hint)
where es.title = '11.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '11.3'
join (values
  (1, 0, 'he''s been', array['he has been']::text[]),
  (2, 0, 'she''s', array['she is']::text[]),
  (3, 0, 'haven''t played', array[]::text[]),
  (4, 0, 'I''ve been waiting', array['I have been waiting']::text[]),
  (5, 0, 'we''ve known', array['we have known']::text[]),
  (6, 0, 'hasn''t been', array[]::text[]),
  (7, 0, 'lives', array['is living']::text[]),
  (8, 0, 'she''s lived', array['she has lived', 'she''s been living', 'she has been living']::text[]),
  (9, 0, 'he''s been watching', array['he has been watching']::text[]),
  (10, 0, 'haven''t watched', array[]::text[]),
  (11, 0, 'I''ve had', array['I have had']::text[]),
  (12, 0, 'haven''t been', array[]::text[]),
  (13, 0, 'I''ve always wanted', array['I have always wanted']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 12 (for and since. when...? and how
-- long...?), sourced from pdf/Modulos/Present perfect and past.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-12 first (cascades) before re-inserting.

delete from units where slug = 'unit-12';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 12, 'unit-12', 'for and since. when...? and how long...?', null,
  'We use for + a period of time, and since + the start of a period, to say how long something has been happening.', 5
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'for + a period vs. since + a starting point',
  'We use for + a period of time (two hours, a week, ages) and since + the start of a period (8 o''clock, Monday, 2001) to say how long something has been happening.', 0
from units where slug = 'unit-12';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Leaving out for; not for + all',
  'We often leave out for in positive sentences, but not usually in negatives. You can use in instead of for in negative sentences. We don''t use for before all (all day, all my life).', 1
from units where slug = 'unit-12';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'when...? (past simple) vs. how long...? (present perfect)',
  'when...? asks about a point in time and takes the past simple. how long...? asks about a duration up to now and takes the present perfect.', 2
from units where slug = 'unit-12';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'It''s ... since ... / It''s been ... since ...',
  'We say "it''s a long time / six months since something happened" or "it''s been ..." — both mean the same, giving how long it has been since a past event.', 3
from units where slug = 'unit-12';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-12'
join (values
  ('A', 'We''ve been waiting for two hours.', 'for + period', 0),
  ('A', 'We''ve been waiting since 8 o''clock.', 'since + start point', 1),
  ('A', 'Sally has been working here for six months. (not since six months)', 'for + period', 2),
  ('A', 'Sally has been working here since April. (= from April until now)', 'since + start point', 3),
  ('B', 'They''ve been married for ten years. or They''ve been married ten years.', 'for often optional', 0),
  ('B', 'They haven''t had a holiday for ten years. (you need for)', 'for required in negatives', 1),
  ('B', 'They haven''t had a holiday in ten years. (= for ten years)', 'in instead of for', 2),
  ('B', 'I''ve lived here all my life. (not for all my life)', 'no for before all', 3),
  ('C', 'When did it start raining? It started raining an hour ago / at 1 o''clock.', 'when + past simple', 0),
  ('C', 'How long has it been raining? It''s been raining for an hour / since 1 o''clock.', 'how long + present perfect', 1),
  ('D', 'It''s two years since I last saw Joe. or It''s been two years since ...', 'time since last event', 0),
  ('D', 'How long is it since Mrs Hill died? or How long has it been since ...', 'time since last event', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 12.1-12.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '12.1', 'Write for or since.', 0
from units where slug = 'unit-12';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-12' where es.title = '12.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Paul has lived in Brazil {0} ten years.', null),
  (2, 'I''m tired of waiting. We''ve been sitting here {0} an hour.', null),
  (3, 'Kevin has been looking for a job {0} he left school.', null),
  (4, 'I haven''t been to a party {0} ages.', null),
  (5, 'I wonder where Joe is. I haven''t seen him {0} last week.', null),
  (6, 'Jane is away on holiday. She''s been away {0} Friday.', null),
  (7, 'The weather is dry. It hasn''t rained {0} a few weeks.', null)
) as v(n, template, hint)
where es.title = '12.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '12.1'
join (values
  (1, 0, 'for'), (2, 0, 'for'), (3, 0, 'since'), (4, 0, 'for'), (5, 0, 'since'), (6, 0, 'since'), (7, 0, 'for')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '12.2', 'Look at each answer and choose the right question.', 1
from units where slug = 'unit-12';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-12' where es.title = '12.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'Answer: ''About five years.'' — How long have you had this car? / When did you buy this car?'),
  (2, '{0}', 'Answer: ''Only a few minutes.'' — How long have you been waiting? / When did you get here?'),
  (3, '{0}', 'Answer: ''September.'' — How long have you been doing your course? / When did your course start?'),
  (4, '{0}', 'Answer: ''Last week.'' — How long has Anna been in London? / When did Anna arrive in London?'),
  (5, '{0}', 'Answer: ''A long time.'' — How long have you known each other? / When did you first meet each other?')
) as v(n, template, hint)
where es.title = '12.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '12.2'
join (values
  (1, 0, 'How long have you had this car?'),
  (2, 0, 'How long have you been waiting?'),
  (3, 0, 'When did your course start?'),
  (4, 0, 'When did Anna arrive in London?'),
  (5, 0, 'How long have you known each other?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '12.3', 'Read the situations and complete the sentences.', 2
from units where slug = 'unit-12';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-12' where es.title = '12.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Mark is unwell. He became ill on Sunday. He has {0} Sunday.', null),
  (2, 'Sarah is married. She''s been married for a year. She got {0}.', null),
  (3, 'You have a headache. It started when you woke up. I''ve {0} I woke up.', null),
  (4, 'Sue is in a meeting at work. It''s been going on since 9 o''clock. The meeting {0} at 9 o''clock.', null),
  (5, 'You''re working in a hotel. You started working there six months ago. I''ve been {0}.', null),
  (6, 'Kate is learning Japanese. She''s been doing this for a long time. Kate started {0}.', null)
) as v(n, template, hint)
where es.title = '12.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '12.3'
join (values
  (1, 0, 'been ill since', array['been unwell since']::text[]),
  (2, 0, 'married a year ago', array[]::text[]),
  (3, 0, 'had a headache since', array[]::text[]),
  (4, 0, 'started', array['began']::text[]),
  (5, 0, 'working in a hotel for six months', array['working there for six months']::text[]),
  (6, 0, 'learning Japanese a long time ago', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '12.4', 'Complete B''s sentences, then write them again using It''s ... since ... .', 3
from units where slug = 'unit-12';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-12' where es.title = '12.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Have you seen Lisa recently? No, {0}.', null),
  (2, 'Do you still go swimming regularly? No, {0}.', null),
  (3, 'Do you still ride a bike these days? No, {0}.', null),
  (4, 'Now with It''s ... since ... : Have you seen Lisa recently? No, {0}.', null),
  (5, 'Now with It''s ... since ... : Do you still go swimming regularly? No, {0}.', null),
  (6, 'Now with It''s ... since ... : Do you still ride a bike these days? No, {0}.', null)
) as v(n, template, hint)
where es.title = '12.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '12.4'
join (values
  (1, 0, 'I haven''t seen Lisa for about a month', array['I haven''t seen her for about a month']::text[]),
  (2, 0, 'I haven''t been swimming for a long time', array[]::text[]),
  (3, 0, 'I haven''t ridden a bike for ages', array[]::text[]),
  (4, 0, 'it''s about a month since I last saw Lisa', array['it''s about a month since I saw her', 'it''s been about a month since I last saw Lisa']::text[]),
  (5, 0, 'it''s a long time since I last went swimming', array['it''s been a long time since I went swimming']::text[]),
  (6, 0, 'it''s ages since I last rode a bike', array['it''s been ages since I rode a bike']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 13 (Present perfect and past 1),
-- sourced from pdf/Modulos/Present perfect and past.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-13 first (cascades) before re-inserting.

delete from units where slug = 'unit-13';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 13, 'unit-13', 'Present perfect and past 1', 'I have done and I did',
  'The present perfect (has happened) tells us about the situation now. The past simple (happened) tells us only about the past, without saying anything about now.', 6
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Present perfect (situation now) vs. past simple (just the past event)',
  'Tom has lost his key = he doesn''t have it now (present perfect, about now). He lost his key = a past event; we don''t know if he has it now or not (past simple, only about the past).', 0
from units where slug = 'unit-13';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'New/recent happenings vs. things that are not new',
  'You can often use the present perfect for new or recent happenings (usually the past simple also works). But use the past simple, not the present perfect, for things that are not recent or new — historical facts, for example.', 1
from units where slug = 'unit-13';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Present perfect to introduce news, then past simple to continue',
  'We use the present perfect to give new information. But once we continue talking about it, we normally switch to the past simple.', 2
from units where slug = 'unit-13';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-13'
join (values
  ('A', 'Tom is looking for his key. He can''t find it. He has lost his key. (present perfect)', 'situation now', 0),
  ('A', 'Has he lost his key? No, he has found it.', 'situation now', 1),
  ('A', 'He lost his key (past simple), but now he has found it. (present perfect)', 'contrast', 2),
  ('A', 'They''ve gone away. They''ll be back on Friday. (they are away now)', 'situation now', 3),
  ('A', 'It has stopped raining now, so we don''t need the umbrella. (it isn''t raining now)', 'situation now', 4),
  ('B', 'I''ve repaired the washing machine. It''s working OK now.', 'recent — either tense usually works', 0),
  ('B', 'Mozart was a composer. He wrote more than 600 pieces of music. (not has been ... has written)', 'not recent — past simple', 1),
  ('B', 'My mother grew up in Italy. (not has grown)', 'not recent — past simple', 2),
  ('B', 'Somebody has invented a new type of washing machine.', 'new information', 3),
  ('B', 'Who invented the telephone? (not has invented)', 'historical fact — past simple', 4),
  ('C', 'a: Ow! I''ve burnt myself. b: How did you do that? (not have you done)', 'switch to past simple', 0),
  ('C', 'a: Look! Somebody has spilt something on the sofa. b: Well, it wasn''t me. I didn''t do it.', 'switch to past simple', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 13.1-13.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '13.1', 'Complete the sentences. Use the present perfect where possible. Otherwise use the past simple.', 0
from units where slug = 'unit-13';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-13' where es.title = '13.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The office is empty now. Everybody {0} home.', 'go'),
  (2, 'I meant to call you last night, but I {0}.', 'forget'),
  (3, 'Helen {0} to New York for a holiday, but she''s back home in London now.', 'go'),
  (4, 'Are you OK? Yes, I {0} a headache before, but it''s OK now.', 'have'),
  (5, 'Can you help us? Our car {0} down.', 'break')
) as v(n, template, hint)
where es.title = '13.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '13.1'
join (values
  (1, 0, 'has gone'), (2, 0, 'forgot'), (3, 0, 'went'), (4, 0, 'had'), (5, 0, 'has broken')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '13.2', 'Are the underlined parts of these sentences OK? Correct them where necessary.', 1
from units where slug = 'unit-13';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-13' where es.title = '13.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My mother {0} in Italy.', null),
  (2, 'How many plays {0}?', null),
  (3, '{0} his name. Is it Joe or Jack?', null),
  (4, '{0} paper?', null),
  (5, 'Drugs {0} a big problem everywhere.', null),
  (6, '{0} the car, but now it''s dirty again.', null),
  (7, '{0}? (asking where somebody was born)', null),
  (8, 'Ellie {0} shopping. She''ll be back in about an hour.', null),
  (9, 'Albert Einstein {0} the theory of relativity.', null)
) as v(n, template, hint)
where es.title = '13.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '13.2'
join (values
  (1, 0, 'grew up'), (2, 0, 'did William Shakespeare write'), (3, 0, 'I''ve forgotten'),
  (4, 0, 'Who invented'), (5, 0, 'have become'), (6, 0, 'We washed'), (7, 0, 'Where were you born'),
  (8, 0, 'has gone'), (9, 0, 'was the scientist who developed')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '13.3', 'Put the verb into the correct form, present perfect or past simple.', 2
from units where slug = 'unit-13';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-13' where es.title = '13.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I studied German at school, but {0} most of it now.', 'I / forget'),
  (2, 'The police {0} three people, but later they let them go.', 'arrest'),
  (3, 'What do you think of my English? Do you think {0}?', 'it / improve'),
  (4, 'Are you ready to go? {0} your coffee?', 'you / finish'),
  (5, '{0} for a job as a tour guide, but I wasn''t successful.', 'I / apply'),
  (6, 'Where''s my bike? {0} outside the house, but it''s not there now.', 'it / be'),
  (7, 'Quick! We need to call an ambulance. {0} an accident.', 'there / be'),
  (8, 'a: I''ve found my phone. b: Oh, good. Where {0} it? a: {1} at the bottom of my bag.', 'you / find ... It / be'),
  (9, 'a: Ben won''t be able to play tennis for a while. {0} his arm. b: Oh. How {1}? a: {2} off a ladder.', 'He / break ... that / happen ... He / fall')
) as v(n, template, hint)
where es.title = '13.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '13.3'
join (values
  (1, 0, 'I''ve forgotten', array['I have forgotten']::text[]),
  (2, 0, 'arrested', array[]::text[]),
  (3, 0, 'it''s improved', array['it has improved']::text[]),
  (4, 0, 'Have you finished', array[]::text[]),
  (5, 0, 'I applied', array[]::text[]),
  (6, 0, 'It was', array[]::text[]),
  (7, 0, 'There''s been', array['There has been']::text[]),
  (8, 0, 'did you find', array[]::text[]), (8, 1, 'It was', array[]::text[]),
  (9, 0, 'He''s broken', array['He has broken', 'He broke']::text[]), (9, 1, 'did that happen', array[]::text[]), (9, 2, 'He fell', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 14 (Present perfect and past 2),
-- sourced from pdf/Modulos/Present perfect and past.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Note: 14.4 ("Write sentences about yourself") is open-ended, left out —
-- doesn't fit this app's exact-match grading.
--
-- Safe to re-run: deletes unit-14 first (cascades) before re-inserting.

delete from units where slug = 'unit-14';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 14, 'unit-14', 'Present perfect and past 2', 'I have done and I did',
  'Don''t use the present perfect for a finished time (yesterday, last year, ten minutes ago) — use a past tense. Use the present perfect for a period that continues until now (today, this week, since 2010).', 7
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Not with a finished time',
  'We do not use the present perfect with a finished time expression (yesterday, last year, ten minutes ago). We use a past tense instead, and always use the past to ask When...? or What time...? .', 0
from units where slug = 'unit-14';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Unfinished period (present perfect) vs. finished period (past simple)',
  'We use the present perfect for a period of time that continues until now (today, this week, since 2010). We use the past simple for a finished time in the past (yesterday, last week, from 2010 to 2014).', 1
from units where slug = 'unit-14';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-14'
join (values
  ('A', 'It was very cold yesterday. (not has been)', 'finished time', 0),
  ('A', 'Paul and Lucy arrived ten minutes ago. (not have arrived)', 'finished time', 1),
  ('A', 'Did you eat a lot of sweets when you were a child? (not have you eaten)', 'finished time', 2),
  ('A', 'When did your friends arrive? (not have ... arrived)', 'when...? + past simple', 3),
  ('B', 'It hasn''t rained this week.', 'unfinished — present perfect', 0),
  ('B', 'It didn''t rain last week.', 'finished — past simple', 1),
  ('B', 'I''ve been working here since 2010. (I still work here now)', 'unfinished — present perfect', 2),
  ('B', 'Jack lived in New York for ten years. Now he lives in Los Angeles.', 'finished — past simple', 3),
  ('B', 'I''ve never ridden a horse. (in my life)', 'unfinished period — present perfect', 4),
  ('B', 'I never rode a bike when I was a child.', 'finished period — past simple', 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 14.1-14.3 — 14.4 skipped, open-ended)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '14.1', 'Are the underlined parts of these sentences OK? Correct them where necessary.', 0
from units where slug = 'unit-14';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-14' where es.title = '14.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} a lot of sweets when you were a child?', null),
  (2, '{0}. You must come and see it.', null),
  (3, '{0} last week.', null),
  (4, '{0} yesterday evening?', null),
  (5, '{0} in 1999.', null),
  (6, 'I''m looking for Mike. {0}?', null),
  (7, '''{0}?'' ''Yes, many times.''', null),
  (8, 'I''m very hungry. {0} much today.', null),
  (9, '{0}?', null)
) as v(n, template, hint)
where es.title = '14.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '14.1'
join (values
  (1, 0, 'Did you eat'), (2, 0, 'I''ve bought a new car'), (3, 0, 'I bought a new car'),
  (4, 0, 'Where were you'), (5, 0, 'Maria left school'), (6, 0, 'Have you seen him'),
  (7, 0, 'Have you been to Paris'), (8, 0, 'I haven''t eaten'), (9, 0, 'When was this bridge built')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '14.2', 'Make sentences from the words in brackets. Use the present perfect or past simple.', 1
from units where slug = 'unit-14';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-14' where es.title = '14.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'the weather / be / cold / recently'),
  (2, '{0}', 'it / cold / last week'),
  (3, '{0}', 'I / not / eat / any fruit yesterday'),
  (4, '{0}', 'I / not / eat / any fruit today'),
  (5, '{0}', 'Emily / earn / a lot of money / this year'),
  (6, '{0}', 'she / not / earn / so much / last year'),
  (7, '{0}', 'you / have / a holiday recently?')
) as v(n, template, hint)
where es.title = '14.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '14.2'
join (values
  (1, 0, 'The weather has been cold recently.'), (2, 0, 'It was cold last week.'),
  (3, 0, 'I didn''t eat any fruit yesterday.'), (4, 0, 'I haven''t eaten any fruit today.'),
  (5, 0, 'Emily has earned a lot of money this year.'), (6, 0, 'She didn''t earn so much last year.'),
  (7, 0, 'Have you had a holiday recently?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '14.3', 'Put the verb into the correct form, present perfect or past simple.', 2
from units where slug = 'unit-14';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-14' where es.title = '14.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m tired. {0} well last night.', 'I / not / sleep'),
  (2, '{0} a bus drivers'' strike last week, so {1} no buses.', 'There / be ... there / be'),
  (3, 'Edward {0} in a bank for 15 years. Then {1} it up. Now he works as a gardener.', 'work ... he / give'),
  (4, 'Mary lives in Dublin. {0} there all her life.', 'She / live'),
  (5, 'My grandfather {0} before I was born. {1} him.', 'die ... I / never / meet'),
  (6, 'I don''t know Karen''s husband. {0} him.', 'I / never / meet'),
  (7, 'It''s nearly lunchtime, and {0} Martin all morning. I wonder where he is.', 'I / not / see'),
  (8, 'a: {0} to the cinema last night? b: Yes, but the movie {1} awful.', 'you / go ... be'),
  (9, 'a: {0} very warm here since we arrived. b: Yes, {1} 35 degrees yesterday.', 'It / be ... it / be'),
  (10, 'a: Where do you live? b: In Boston. a: How long {0} there? b: Five years. a: Where {1} before that? b: In Chicago. a: And how long {2} in Chicago? b: Two years.', 'you / live ... you / live ... you / live')
) as v(n, template, hint)
where es.title = '14.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '14.3'
join (values
  (1, 0, 'I didn''t sleep', array[]::text[]),
  (2, 0, 'There was', array[]::text[]), (2, 1, 'there were', array[]::text[]),
  (3, 0, 'worked', array[]::text[]), (3, 1, 'he gave', array[]::text[]),
  (4, 0, 'She''s lived', array['She has lived']::text[]),
  (5, 0, 'died', array[]::text[]), (5, 1, 'I never met', array[]::text[]),
  (6, 0, 'I''ve never met', array['I have never met']::text[]),
  (7, 0, 'I haven''t seen', array[]::text[]),
  (8, 0, 'Did you go', array[]::text[]), (8, 1, 'was', array[]::text[]),
  (9, 0, 'It''s been', array['It has been']::text[]), (9, 1, 'it was', array[]::text[]),
  (10, 0, 'have you lived', array['have you been living']::text[]), (10, 1, 'did you live', array[]::text[]), (10, 2, 'did you live', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 15 (Past perfect), sourced from
-- pdf/Modulos/Present perfect and past.pdf (extracted via `pdftotext -layout`)
-- and cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-15 first (cascades) before re-inserting.

delete from units where slug = 'unit-15';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 15, 'unit-15', 'Past perfect', 'I had done',
  'had + past participle is the past perfect. We use it for something that happened before another point in the past — the story''s starting point is a past simple event, and things before it use had.', 8
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Something that happened before another past point',
  'When we talk about the past and want to refer to something earlier still, we use the past perfect (had + past participle) — "When Sarah arrived at the party, Paul had already gone home."', 0
from units where slug = 'unit-15';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Present perfect (have seen) vs. past perfect (had seen)',
  'have seen is the present perfect, relative to now. had seen is the past perfect, relative to a point in the past — the same relationship, shifted one step back.', 1
from units where slug = 'unit-15';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Past simple (left) vs. past perfect (had left)',
  'Past simple describes what happened at the reference point. Past perfect describes what had already happened before it.', 2
from units where slug = 'unit-15';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-15'
join (values
  ('A', 'When Sarah arrived at the party, Paul had already gone home.', 'earlier than the reference point', 0),
  ('A', 'When we got home last night, we found that somebody had broken into the flat.', 'earlier than the reference point', 1),
  ('A', 'Karen didn''t come to the cinema with us. She''d already seen the movie.', 'earlier than the reference point', 2),
  ('A', 'The people sitting next to me on the plane were nervous. They hadn''t flown before. or They''d never flown before.', 'earlier than the reference point', 3),
  ('B', 'Who is that woman? I''ve seen her before, but I can''t remember where.', 'present perfect', 0),
  ('B', 'I wasn''t sure who she was. I''d seen her before, but I couldn''t remember where.', 'past perfect', 1),
  ('C', 'a: Was Tom there when you arrived? b: Yes, but he left soon afterwards.', 'past simple', 0),
  ('C', 'a: Was Tom there when you arrived? b: No, he''d already left.', 'past perfect', 1),
  ('C', 'Kate wasn''t at home when I phoned. She was at her mother''s house.', 'past simple', 2),
  ('C', 'Kate had just got home when I phoned. She''d been at her mother''s house.', 'past perfect', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / we / they / you / he / she / it', 'had', 'gone / seen / finished', 0 from units where slug = 'unit-15'
union all
select id, 'negative', null, null, 'Subject + hadn''t + past participle', 0 from units where slug = 'unit-15'
union all
select id, 'question', null, null, 'Had + subject + past participle?', 0 from units where slug = 'unit-15';

-- ============================================================
-- Exercises (main, split into the book's own 15.1-15.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '15.1', 'Read the situations and write sentences using the words in brackets.', 0
from units where slug = 'unit-15';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-15' where es.title = '15.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You went back to your home town recently after many years. It wasn''t the same as before. It {0}.', 'It / change / a lot'),
  (2, 'Somebody sang a song. You didn''t know it. I {0}.', 'I / not / hear / it / before'),
  (3, 'I invited Rachel to the party, but she couldn''t come. {0}.', 'She / arrange / to do something else'),
  (4, 'You went to the cinema last night. You got to the cinema late. {0}.', 'The film / already / start'),
  (5, 'Last year we went to Mexico. It was our first time there. We {0}.', 'We / not / be / there / before'),
  (6, 'I met Daniel last week. It was good to see him again after such a long time. {0}.', 'I / not / see / him for five years'),
  (7, 'I offered my friends something to eat, but they weren''t hungry. {0}.', 'They / just / have / lunch'),
  (8, 'Sam played tennis yesterday. He wasn''t very good at it because it was his first game ever. {0}.', 'He / never / play / before')
) as v(n, template, hint)
where es.title = '15.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '15.1'
join (values
  (1, 0, 'had changed a lot', array[]::text[]),
  (2, 0, 'hadn''t heard it before', array[]::text[]),
  (3, 0, 'She''d arranged to do something else', array['She had arranged to do something else']::text[]),
  (4, 0, 'The film had already started', array[]::text[]),
  (5, 0, 'hadn''t been there before', array[]::text[]),
  (6, 0, 'I hadn''t seen him for five years', array[]::text[]),
  (7, 0, 'They''d just had lunch', array['They had just had lunch']::text[]),
  (8, 0, 'He''d never played before', array['He had never played before']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '15.2', 'Use the sentences on the left to complete the paragraphs on the right, using the past perfect where needed.', 1
from units where slug = 'unit-15';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-15' where es.title = '15.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I went to Laura''s house this morning and rang her doorbell, but {0} no answer. {1} out.', '(a) Laura went out this morning. (b) I rang her doorbell. (c) There was no answer.'),
  (2, 'I met Joe a few days ago. {0} holiday. {1} very well.', '(a) Joe came back from holiday a few days ago. (b) I met him the same day. (c) He looked very well.'),
  (3, 'Yesterday James {0} from Amy. {1} surprised. {2} lots of emails, but {3}.', '(a) James sent Amy lots of emails. (b) She never replied to them. (c) Yesterday he got a phone call from her. (d) He was surprised.')
) as v(n, template, hint)
where es.title = '15.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '15.2'
join (values
  (1, 0, 'there was', array[]::text[]), (1, 1, 'She''d gone', array['She had gone']::text[]),
  (2, 0, 'He''d just come back from', array['He had just come back from']::text[]), (2, 1, 'He looked', array[]::text[]),
  (3, 0, 'got a phone call', array[]::text[]), (3, 1, 'He was', array[]::text[]),
    (3, 2, 'He''d sent her', array['He had sent her']::text[]), (3, 3, 'she''d never replied to them', array['she had never replied to them', 'she never replied to them']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '15.3', 'Put the verb into the correct form, past perfect (I had done) or past simple (I did).', 2
from units where slug = 'unit-15';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-15' where es.title = '15.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I felt very tired when I got home, so {0} straight to bed.', 'I / go'),
  (2, 'The house was very quiet when I got home. Everybody {0} to bed.', 'go'),
  (3, 'Mark travels a lot. When I first met him, {0} round the world.', 'he / already / travel'),
  (4, 'Sorry I''m late. The car {0} down on my way here.', 'break'),
  (5, 'We were driving along the road when {0} a car which {1} down, so {2} to help.', 'we / see ... break ... we / stop')
) as v(n, template, hint)
where es.title = '15.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '15.3'
join (values
  (1, 0, 'I went', array[]::text[]),
  (2, 0, 'had gone', array[]::text[]),
  (3, 0, 'he''d already travelled', array['he had already travelled']::text[]),
  (4, 0, 'broke', array[]::text[]),
  (5, 0, 'we saw', array[]::text[]), (5, 1, 'had broken', array[]::text[]), (5, 2, 'we stopped', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 16 (Past perfect continuous),
-- sourced from pdf/Modulos/Present perfect and past.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Note: 16.2 item 5 ("Now make your own sentence") is open-ended, left out.
--
-- Safe to re-run: deletes unit-16 first (cascades) before re-inserting.

delete from units where slug = 'unit-16';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 16, 'unit-16', 'Past perfect continuous', 'I had been doing',
  'had been + -ing is the past perfect continuous, used for an activity that was already in progress (or had just stopped) before another point in the past.', 9
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'An activity in progress before a past point',
  'had been + -ing is the past perfect continuous. It describes an activity that was happening (or had just stopped) before the time we''re talking about, often explaining a state at that time.', 0
from units where slug = 'unit-16';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'have been -ing (present perfect continuous) vs. had been -ing (past perfect continuous)',
  'have been -ing looks back from now; had been -ing looks back from a point in the past — the same relationship, one step further back.', 1
from units where slug = 'unit-16';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'was -ing (past continuous) vs. had been -ing',
  'was -ing describes what was happening at that moment. had been -ing explains what led up to a state at that moment (the cause, before the moment itself).', 2
from units where slug = 'unit-16';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'State verbs stay out of the continuous, even in the past perfect',
  'Verbs like know are not normally used in continuous forms, including had been + -ing — "we had known each other for years", not "had been knowing".', 3
from units where slug = 'unit-16';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-16'
join (values
  ('A', 'The sun was shining, but the ground was very wet. It had been raining.', 'led up to a state', 0),
  ('A', 'My hands were dirty because I''d been repairing my bike.', 'led up to a state', 1),
  ('A', 'Tom was tired when he got home. He''d been working hard all day.', 'led up to a state', 2),
  ('A', 'We''d been playing tennis for about half an hour when it started to rain heavily.', 'in progress before an interruption', 3),
  ('B', 'I hope the bus comes soon. I''ve been waiting for 20 minutes. (before now)', 'present perfect continuous', 0),
  ('B', 'At last the bus came. I''d been waiting for 20 minutes. (before the bus came)', 'past perfect continuous', 1),
  ('C', 'It wasn''t raining when we went out. The sun was shining. But it had been raining, so the ground was wet.', 'was + had been contrast', 0),
  ('C', 'Katherine was lying on the sofa. She was tired because she''d been working hard.', 'was + had been contrast', 1),
  ('D', 'We were good friends. We had known each other for years. (not had been knowing)', 'state verb', 0),
  ('D', 'A few years ago Lisa cut her hair really short. I was surprised because she''d always had long hair. (not she''d been having)', 'state verb', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / we / you / they / he / she / it', 'had been', 'doing / working / playing', 0 from units where slug = 'unit-16'
union all
select id, 'negative', null, null, 'Subject + hadn''t been + verb-ing', 0 from units where slug = 'unit-16'
union all
select id, 'question', null, null, 'Had + subject + been + verb-ing?', 0 from units where slug = 'unit-16';

-- ============================================================
-- Exercises (main, split into the book's own 16.1-16.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '16.1', 'Read the situations and make sentences using the words in brackets.', 0
from units where slug = 'unit-16';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-16' where es.title = '16.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The children came into the house. They had a football and they were both very tired. {0}.', 'They / play / football'),
  (2, 'I was disappointed when I had to cancel my holiday. {0}.', 'I / look / forward to it'),
  (3, 'Anna woke up in the middle of the night. She was frightened and didn''t know where she was. {0}.', 'She / have / a bad dream'),
  (4, 'When I got home, Mark was sitting in front of the TV. He had just turned it off. {0}.', 'He / watch / a film'),
  (5, 'The people waiting at the bus stop were getting impatient. The bus was very late. {0}.', 'They / wait / a long time')
) as v(n, template, hint)
where es.title = '16.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '16.1'
join (values
  (1, 0, 'They''d been playing football', array['They had been playing football']::text[]),
  (2, 0, 'I''d been looking forward to it', array['I had been looking forward to it']::text[]),
  (3, 0, 'She''d been having a bad dream', array['She had been having a bad dream']::text[]),
  (4, 0, 'He''d been watching a film', array['He had been watching a film']::text[]),
  (5, 0, 'They''d been waiting a long time', array['They had been waiting a long time']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '16.2', 'Read the situations and complete the sentences.', 1
from units where slug = 'unit-16';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-16' where es.title = '16.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I had arranged to meet Tom in a restaurant. I arrived and waited for him to come. {0} for 20 minutes when {1} that {2} in the wrong restaurant.', 'I / wait ... I / realise ... I / be'),
  (2, 'Sarah worked in a company for a long time. The company no longer exists. At the time the company {0} out of business, Sarah {1} there for twelve years.', 'go ... work'),
  (3, 'I went to a concert. Soon after the orchestra began playing, something strange happened. The orchestra {0} for about ten minutes when a man in the audience suddenly {1} shouting.', 'play ... start')
) as v(n, template, hint)
where es.title = '16.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '16.2'
join (values
  (1, 0, 'I''d been waiting', array['I had been waiting']::text[]), (1, 1, 'I realised', array[]::text[]), (1, 2, 'I was', array[]::text[]),
  (2, 0, 'went', array[]::text[]), (2, 1, 'had been working', array['had worked']::text[]),
  (3, 0, 'had been playing', array[]::text[]), (3, 1, 'started', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '16.3', 'Which is right?', 2
from units where slug = 'unit-16';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-16' where es.title = '16.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'At the end of our journey we were extremely tired. {0} for more than 24 hours.', 'We were travelling / We''d been travelling'),
  (2, 'James was on his hands and knees on the floor. {0} for his contact lens.', 'He was looking / He''d been looking'),
  (3, 'Sue was sitting on the ground. She was out of breath. {0}.', 'She was running / She''d been running'),
  (4, 'John and I went for a walk. {0} very fast and I had difficulty keeping up with him.', 'He was walking / He''d been walking'),
  (5, 'I was sad when I sold my car. {0} for a very long time.', 'I''ve had it / I''d had it'),
  (6, 'I was sad when my local cafe closed. {0} there for many years.', 'I was going / I''d been going'),
  (7, 'I''m running a marathon next month. {0} for it every day.', 'I''ve been training / I''d been training'),
  (8, 'I had arranged to meet Kate, but I was late. When I finally arrived, {0} for me. She was annoyed because {1} such a long time.', 'she was waiting / she''d been waiting'),
  (9, 'Joe and I work for the same company. He joined the company before me. When I started a few years ago, {0} there.', 'he was already working / he''d already been working'),
  (10, 'I started working at the company a few years ago. At the time I started, Joe {0} there for two years.', 'was already working / had already been working'),
  (11, 'Joe still works for the company. {0} there a long time now.', 'He''s been working / He''d been working')
) as v(n, template, hint)
where es.title = '16.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '16.3'
join (values
  (1, 0, 'We''d been travelling', array['We had been travelling']::text[]),
  (2, 0, 'He was looking', array[]::text[]),
  (3, 0, 'She''d been running', array['She had been running']::text[]),
  (4, 0, 'He was walking', array[]::text[]),
  (5, 0, 'I''d had it', array['I had had it']::text[]),
  (6, 0, 'I''d been going', array['I had been going']::text[]),
  (7, 0, 'I''ve been training', array['I have been training']::text[]),
  (8, 0, 'she was waiting', array[]::text[]), (8, 1, 'she''d been waiting', array['she had been waiting']::text[]),
  (9, 0, 'he was already working', array[]::text[]),
  (10, 0, 'had already been working', array[]::text[]),
  (11, 0, 'He''s been working', array['He has been working']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 17 (have and have got), sourced from
-- pdf/Modulos/Present perfect and past.pdf (extracted via `pdftotext -layout`)
-- and cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 17.1: the book's matching format (1-8 matched to a-h) is combined
-- into single sentences here, same approach as unit-6's 6.2.
--
-- Safe to re-run: deletes unit-17 first (cascades) before re-inserting.

delete from units where slug = 'unit-17';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 17, 'unit-17', 'have and have got', null,
  'have and have got mean the same thing for possession, relationships and illnesses. For actions and experiences (have breakfast, have a shower), only have is used, and continuous forms are possible.', 10
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'have / have got (possession, relationships, illnesses)',
  'You can use have or have got with no difference in meaning, for possession, relationships, illnesses, appointments etc. We don''t use continuous forms with this meaning. For the past, we normally use had (without got).', 0
from units where slug = 'unit-17';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Questions and negatives',
  'There are three possible forms: Do you have...? / Have you got...? / Have you...? (less usual), and I don''t have / I haven''t got / I haven''t (less usual). In the past, we use did/didn''t.', 1
from units where slug = 'unit-17';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'have breakfast / have a shower / have a good time',
  'We also use have (but not have got) for things we do or experience — breakfast, a shower, a break, a chat, a good time. These CAN be used in continuous forms, and use do/does/did in questions and negatives.', 2
from units where slug = 'unit-17';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-17'
join (values
  ('A', 'They have a new car. or They''ve got a new car.', 'possession', 0),
  ('A', 'I have a headache. or I''ve got a headache.', 'illness', 1),
  ('A', 'Lisa had long hair when she was a child. (not Lisa had got)', 'past — had only', 2),
  ('B', 'Do you have any questions? or Have you got any questions?', 'question forms', 0),
  ('B', 'Does she have a car? or Has she got a car?', 'question forms', 1),
  ('B', 'Did you have a car when you were living in Paris?', 'past question', 2),
  ('C', 'Sometimes I have (= eat) a sandwich for my lunch. (not I''ve got)', 'action, not possession', 0),
  ('C', 'We''re enjoying our holiday. We''re having a great time.', 'continuous is possible', 1),
  ('C', 'Did you have trouble finding somewhere to stay? (not Had you)', 'do/does/did in questions', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 17.1-17.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '17.1', 'Which goes with which? Combine the sentences.', 0
from units where slug = 'unit-17';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-17' where es.title = '17.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Rachel is an only child. {0}.', null),
  (2, 'We''ve got plenty of time. {0}.', null),
  (3, 'You''ve got a really good voice. {0}.', null),
  (4, 'I don''t feel very well this morning. {0}.', null),
  (5, 'Laura studied at university. {0}.', null),
  (6, 'I''ve got a question. {0}.', null),
  (7, 'James has got a lot of experience. {0}.', null)
) as v(n, template, hint)
where es.title = '17.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '17.1'
join (values
  (1, 0, 'She''s got no brothers or sisters', array['She has got no brothers or sisters']::text[]),
  (2, 0, 'There''s no need to hurry', array[]::text[]),
  (3, 0, 'I wish I could sing as well as you', array[]::text[]),
  (4, 0, 'I''ve got a sore throat', array['I have a sore throat']::text[]),
  (5, 0, 'She''s got a degree in physics', array['She has a degree in physics']::text[]),
  (6, 0, 'Maybe you can answer it', array[]::text[]),
  (7, 0, 'I think he should get the job', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '17.2', 'Complete the sentences using have.', 1
from units where slug = 'unit-17';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-17' where es.title = '17.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'They can''t pay their bills. {0} any money.', null),
  (2, 'We got wet in the rain yesterday. {0} an umbrella.', null),
  (3, 'Jack {0} a car. He can''t afford one and he can''t drive anyway.', null),
  (4, '''Excuse me, {0} a pen I could borrow?'' ''Yes, sure. Here you are.''', null),
  (5, 'I was very busy yesterday. {0} time to go shopping.', null),
  (6, '''Tell me about Jack. {0} a job?'' ''Yes, he works at the hospital.''', null),
  (7, 'When you worked in your last job, {0} your own office?', null),
  (8, '''Where''s the remote control?'' ''I don''t know. {0} it.''', null),
  (9, '''Tom {0} a motorbike, {1} he?'' ''Yes, that''s right. A long time ago.''', null)
) as v(n, template, hint)
where es.title = '17.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '17.2'
join (values
  (1, 0, 'don''t have', array['haven''t got']::text[]),
  (2, 0, 'didn''t have', array[]::text[]),
  (3, 0, 'doesn''t have', array['hasn''t got']::text[]),
  (4, 0, 'do you have', array['have you got']::text[]),
  (5, 0, 'I didn''t have', array[]::text[]),
  (6, 0, 'Does he have', array['Has he got']::text[]),
  (7, 0, 'did you have', array[]::text[]),
  (8, 0, 'I don''t have', array['I haven''t got']::text[]),
  (9, 0, 'had', array[]::text[]), (9, 1, 'didn''t', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '17.3', 'Are the underlined words OK? Change them where necessary.', 2
from units where slug = 'unit-17';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-17' where es.title = '17.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} when she was a child.', null),
  (2, 'I couldn''t contact you because {0}.', null),
  (3, '''Are you feeling OK?'' ''No, {0}.''', null),
  (4, 'I''m not working right now. {0}.', null),
  (5, 'I felt really tired. {0}.', null),
  (6, 'It''s a small town. {0}.', null),
  (7, 'Was your trip OK? {0} any problems?', null),
  (8, 'My friend called me when {0}.', null),
  (9, 'The last time I saw Steve, {0}.', null),
  (10, 'We don''t need to hurry. {0}.', null),
  (11, 'How often {0}?', null)
) as v(n, template, hint)
where es.title = '17.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '17.3'
join (values
  (1, 0, 'Lisa had long hair', array[]::text[]),
  (2, 0, 'I didn''t have my phone', array['I hadn''t got my phone']::text[]),
  (3, 0, 'I have a cold', array['I''ve got a cold']::text[]),
  (4, 0, 'I''m having a break', array[]::text[]),
  (5, 0, 'I didn''t have any energy', array[]::text[]),
  (6, 0, 'It doesn''t have many shops', array['It hasn''t got many shops']::text[]),
  (7, 0, 'Did you have', array[]::text[]),
  (8, 0, 'I was having breakfast', array[]::text[]),
  (9, 0, 'he had a beard', array[]::text[]),
  (10, 0, 'We have plenty of time', array['We''ve got plenty of time']::text[]),
  (11, 0, 'do you have a shower', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '17.4', 'Complete the sentences. Use an expression with have in the correct form. Choose from: have a baby, have a break, have a chat, have trouble, have a shower, have a look, have lunch, have a party, have a nice time, have a holiday.', 3
from units where slug = 'unit-17';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-17' where es.title = '17.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'David starts work at 8 o''clock and {0} at 10.30.', null),
  (2, 'We {0} last week. We invited lots of people.', null),
  (3, 'There''s something wrong with my bike. Can you {0} at it for me?', null),
  (4, 'Joe is away on holiday at the moment. I hope {0}.', null),
  (5, 'I met some friends in the supermarket yesterday. We stopped and {0}.', null),
  (6, '''{0} finding the book you wanted?'' ''No, I found it OK.''', null),
  (7, 'Suzanne {0} a few weeks ago. It''s her second child.', null),
  (8, '{0} when the light went out suddenly.', null),
  (9, 'I''d like to go away somewhere. {0} for a long time.', null)
) as v(n, template, hint)
where es.title = '17.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '17.4'
join (values
  (1, 0, 'has a break', array[]::text[]),
  (2, 0, 'had a party', array[]::text[]),
  (3, 0, 'have a look', array[]::text[]),
  (4, 0, 'he''s having a nice time', array['he is having a nice time']::text[]),
  (5, 0, 'had a chat', array[]::text[]),
  (6, 0, 'Did you have trouble', array[]::text[]),
  (7, 0, 'had a baby', array[]::text[]),
  (8, 0, 'I was having a shower', array[]::text[]),
  (9, 0, 'I haven''t had a holiday', array['I haven''t had a break']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Present perfect and past" / Unit 18 (used to (do)), the last unit of
-- this module, sourced from pdf/Modulos/Present perfect and past.pdf
-- (extracted via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf.
--
-- Note: 18.4 ("Write sentences about yourself") is open-ended, left out.
--
-- Safe to re-run: deletes unit-18 first (cascades) before re-inserting.

delete from units where slug = 'unit-18';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 18, 'unit-18', 'used to (do)', null,
  'used to + infinitive describes something that happened repeatedly or was true in the past, but not any more. There is no present form — for now, use the present simple.', 11
from modules where slug = 'present-perfect';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'used to = happened often in the past, not any more',
  'She used to travel a lot = she travelled often in the past, but she doesn''t do this any more.', 0
from units where slug = 'unit-18';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Repeated actions and past states that are no longer true',
  'We use used to for repeated past actions, and also for things that were true but aren''t any more (a building''s former use, an old opinion, a past feeling).', 1
from units where slug = 'unit-18';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'No present form',
  '"I used to do something" is past — there is no present form (you cannot say "I use to do"). To talk about the present, use the present simple (I do).', 2
from units where slug = 'unit-18';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'Questions and negatives',
  'The question form is did (you) use to...? The negative is didn''t use to... (used not to... is also possible).', 3
from units where slug = 'unit-18';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'used to do vs. was doing',
  'I used to watch TV a lot (repeated, over a long past period, not any more) is different from I was watching TV when Rob called (in the middle of one specific action).', 4
from units where slug = 'unit-18';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'F', 'used to do vs. am used to doing',
  'Don''t confuse these — I used to live alone (I lived alone in the past, but not any more) vs. I am used to living alone (I live alone now, and it doesn''t bother me because I''m accustomed to it).', 5
from units where slug = 'unit-18';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-18'
join (values
  ('A', 'She used to travel a lot. She used to go away two or three times a year.', 'repeated in the past', 0),
  ('B', 'I used to play tennis a lot, but I don''t play very much now.', 'repeated action', 0),
  ('B', 'This building is now a furniture shop. It used to be a cinema.', 'past state, no longer true', 1),
  ('B', 'Lisa used to have very long hair when she was a child.', 'past state, no longer true', 2),
  ('C', 'We used to live in a small village, but now we live in a city.', 'present simple for now', 0),
  ('C', 'There used to be four cinemas in the town. Now there is only one.', 'present simple for now', 1),
  ('D', 'Did you use to eat a lot of sweets when you were a child?', 'question', 0),
  ('D', 'I didn''t use to like him. (or I used not to like him.)', 'negative', 1),
  ('E', 'I used to watch TV a lot. (= I watched TV often in the past, but I don''t do this any more)', 'used to', 0),
  ('E', 'I was watching TV when Rob called. (= I was in the middle of watching TV)', 'past continuous', 1),
  ('F', 'I used to live alone. (= I lived alone in the past, but I no longer live alone.)', 'used to', 0),
  ('F', 'I am used to living alone. (= I live alone, and it''s not a problem for me.)', 'be used to', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / we / you / they / he / she / it', 'used to', 'play / live / be', 0 from units where slug = 'unit-18'
union all
select id, 'negative', null, null, 'Subject + didn''t use to (or used not to) + verb', 0 from units where slug = 'unit-18'
union all
select id, 'question', null, null, 'Did + subject + use to + verb?', 0 from units where slug = 'unit-18';

-- ============================================================
-- Exercises (main, split into the book's own 18.1-18.3 — 18.4 skipped, open-ended)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '18.1', 'Complete the sentences with used to + a suitable verb.', 0
from units where slug = 'unit-18';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-18' where es.title = '18.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sophie {0} a motorbike, but last year she sold it and bought a car.', null),
  (2, 'Our friends moved to Spain a few years ago. They {0} in Paris.', null),
  (3, 'Jackie {0} my best friend, but we aren''t friends any more.', null),
  (4, 'I rarely eat ice cream now, but I {0} it when I was a child.', null),
  (5, 'It only takes me about 40 minutes to get to work now that the new road is open. It {0} more than an hour.', null),
  (6, 'There {0} a hotel near the airport, but it closed a long time ago.', null),
  (7, 'I {0} in a factory. It wasn''t my favourite job.', null)
) as v(n, template, hint)
where es.title = '18.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '18.1'
join (values
  (1, 0, 'used to have', array['used to ride']::text[]),
  (2, 0, 'used to live', array[]::text[]),
  (3, 0, 'used to be', array[]::text[]),
  (4, 0, 'used to eat', array['used to like', 'used to love']::text[]),
  (5, 0, 'used to take', array[]::text[]),
  (6, 0, 'used to be', array[]::text[]),
  (7, 0, 'used to work', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '18.2', 'Complete the sentences. Choose from: did, didn''t, to, use, used, used to, used to be, used to have, be able.', 1
from units where slug = 'unit-18';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-18' where es.title = '18.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We {0} to watch TV a lot, but we don''t have a TV any more.', null),
  (2, 'Lisa works in a shop now. She {0} a receptionist in a hotel.', null),
  (3, 'What games {0} you use to play when you were a child?', null),
  (4, 'I {0} like big cities, but now I prefer the countryside.', null),
  (5, 'In your last job, how many hours a day did you {0} to work?', null),
  (6, 'I don''t travel very much these days, but I used {0}.', null),
  (7, 'I used {0} to run ten kilometres, but I can''t run that far now.', null),
  (8, 'These days I eat more than before. I {0} use to eat as much.', null)
) as v(n, template, hint)
where es.title = '18.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '18.2'
join (values
  (1, 0, 'used'), (2, 0, 'used to be'), (3, 0, 'did'), (4, 0, 'used to'),
  (5, 0, 'use'), (6, 0, 'to'), (7, 0, 'be able'), (8, 0, 'didn''t')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '18.3', 'Compare what Karen said ten years ago and what she says today. Write about how Karen has changed, using used to / didn''t use to / never used to.', 2
from units where slug = 'unit-18';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-18' where es.title = '18.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'Ten years ago: ''I''m very lazy.'' Today: ''I work very hard these days.'''),
  (2, '{0}', 'Ten years ago: ''I don''t like cheese.'' Today: ''I eat lots of cheese now.'''),
  (3, '{0}', 'Ten years ago: ''I play the piano.'' Today: ''I haven''t played the piano for a long time.'''),
  (4, '{0}', 'Ten years ago: ''I never drink tea.'' Today: ''Tea''s great! I like it now.'''),
  (5, '{0}', 'Ten years ago: ''I have a dog.'' Today: ''My dog died two years ago.''')
) as v(n, template, hint)
where es.title = '18.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '18.3'
join (values
  (1, 0, 'She used to be very lazy, but she works very hard these days.', array[]::text[]),
  (2, 0, 'She didn''t use to like cheese, but she eats lots of cheese now.', array['She used not to like cheese, but she eats lots of cheese now.']::text[]),
  (3, 0, 'She used to play the piano, but she hasn''t played the piano for a long time.', array['She used to play the piano, but she hasn''t played it for a long time.']::text[]),
  (4, 0, 'She didn''t use to drink tea, but she likes it now.', array['She used not to drink tea, but she likes it now.']::text[]),
  (5, 0, 'She used to have a dog, but it died two years ago.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
