-- Marco 4 (slice 3): seeds the full "Future" module — units 19-25 (present
-- tenses for the future, I'm going to, will/shall 1 and 2, I will vs. I'm
-- going to, will be doing / will have done, when I do vs. when I've done /
-- if and when).
--
-- Sourced from pdf/Modulos/Future.pdf (extracted via `pdftotext -layout`,
-- same workaround as the previous modules — pdftoppm/poppler isn't
-- available locally) and cross-checked against pdf/Key to Exercises.pdf.
-- Open-ended own-answer exercises (19.3, 22.4) are left out, same reasoning
-- as previous modules. 24.1's "tick the true sentences" format is reframed
-- as "which is/are true — type the letter(s)" since checkboxes don't fit
-- this app's model; its first group has no recoverable answer (the source
-- PDF's tick mark isn't preserved by text extraction) and is left out too.
--
-- Consolidated from supabase/seed/unit-19.sql .. unit-25.sql into a single
-- migration, same pattern as 0003/0004, so Supabase's GitHub-linked CI/CD
-- applies it automatically on push.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('future', 'Future', 2)
on conflict (slug) do nothing;

delete from units where slug = 'unit-19';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 19, 'unit-19', 'Present tenses for the future', 'I am doing / I do',
  'We use the present continuous for personal arrangements already decided and organised, and the present simple for fixed timetables and programmes.', 0
from modules where slug = 'future';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Present continuous for arranged plans',
  'I''m doing something (tomorrow etc.) = I have already decided and arranged to do it. We don''t normally use will for what we''ve already arranged.', 0
from units where slug = 'unit-19';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Present simple for timetables and fixed programmes',
  'We use the present simple for timetables and programmes (transport, cinema times), and also for personal plans that are as fixed as a timetable (a course start date, for example).', 1
from units where slug = 'unit-19';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-19'
join (values
  ('A', 'He is playing tennis on Monday afternoon. He is meeting Kate on Friday.', 'arranged plan', 0),
  ('A', 'What are you doing on Saturday evening? (not What do you do)', 'arranged plan', 1),
  ('A', 'We do not normally use will to talk about what we have arranged: What are you doing tonight? (not What will you do)', 'not will', 2),
  ('A', 'I''m tired. I''m going to bed now. Goodnight. (not I go to bed now)', 'action about to start', 3),
  ('B', 'I have to go. My train leaves at 11.30.', 'timetable', 0),
  ('B', 'What time does the film start tonight?', 'timetable', 1),
  ('B', 'I start my new job on Monday.', 'fixed personal plan', 2),
  ('B', 'But the continuous is more usual for other personal arrangements: What time are you meeting Kate tomorrow? (not do you meet)', 'personal arrangement', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 19.1, 19.2, 19.4 — 19.3 skipped, open-ended)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '19.1', 'Ask Anna about her holiday plans.', 0
from units where slug = 'unit-19';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-19' where es.title = '19.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'Ask how long she''s going for — Anna: ''Ten days.'''),
  (2, '{0}', 'Ask when she''s leaving — Anna: ''Next Friday.'''),
  (3, '{0}', 'Ask if she''s going alone — Anna: ''No, with a friend.'''),
  (4, '{0}', 'Ask if she''s travelling by car — Anna: ''No, by train.'''),
  (5, '{0}', 'Ask where she''s staying — Anna: ''In a hotel.''')
) as v(n, template, hint)
where es.title = '19.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '19.1'
join (values
  (1, 0, 'How long are you going for?'), (2, 0, 'When are you leaving?'), (3, 0, 'Are you going alone?'),
  (4, 0, 'Are you travelling by car?'), (5, 0, 'Where are you staying?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '19.2', 'Complete the sentences.', 1
from units where slug = 'unit-19';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-19' where es.title = '19.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} a party next week. We''ve invited all our friends.', 'We / have'),
  (2, '{0} tomorrow. It''s a public holiday.', 'I / not / work'),
  (3, '{0} now. I''ve come to say goodbye.', 'I / leave'),
  (4, '''What time {0} out this evening?'' ''Seven o''clock.''', 'you / go'),
  (5, '{0} to the party tomorrow. She isn''t well.', 'Laura / not / come'),
  (6, 'I love New York. {0} there soon.', 'I / go'),
  (7, 'Ben can''t meet us on Monday. {0} late.', 'He / work')
) as v(n, template, hint)
where es.title = '19.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '19.2'
join (values
  (1, 0, 'We''re having', array['We are having']::text[]),
  (2, 0, 'I''m not working', array[]::text[]),
  (3, 0, 'I''m leaving', array[]::text[]),
  (4, 0, 'are you going', array[]::text[]),
  (5, 0, 'Laura isn''t coming', array['Laura''s not coming']::text[]),
  (6, 0, 'I''m going', array[]::text[]),
  (7, 0, 'He''s working', array['He is working']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '19.4', 'Complete the sentences. Use the present continuous or present simple.', 2
from units where slug = 'unit-19';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-19' where es.title = '19.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: {0} to Sam''s party on Saturday? b: No, I haven''t been invited.', 'you / go'),
  (2, 'a: Has Jack moved into his new apartment yet? b: Not yet, but {0} soon — probably at the end of the month.', 'he / move'),
  (3, 'a: {0} to a concert tonight. b: That''s nice. What time {1}?', 'I / go ... it / start'),
  (4, 'a: Have you seen Chris recently? b: No, but {0} for lunch next week.', 'we / meet'),
  (5, 'a: {0} anything tomorrow morning? b: No, I''m free. Why?', 'you / do'),
  (6, 'a: When {0}? b: Next Friday. And next term {1} four weeks after that.', 'this term / end ... start'),
  (7, 'a: {0} to a wedding at the weekend. b: Really? {1} married?', 'We / go ... Who / get'),
  (8, 'a: There''s football on TV later tonight. {0} it? b: No, I''m not interested.', 'you / watch'),
  (9, 'a: What time is your train tomorrow? b: It {0} at 9.35 and {1} at 12.47.', 'leave ... arrive'),
  (10, 'a: I''d like to go and see the exhibition at the museum. How long is it on for? b: {0} next week.', 'It / finish'),
  (11, 'a: Do you need the car this evening? b: No, you can have it. {0} it.', 'I / not / use')
) as v(n, template, hint)
where es.title = '19.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '19.4'
join (values
  (1, 0, 'Are you going', array[]::text[]),
  (2, 0, 'he''s moving', array['he is moving']::text[]),
  (3, 0, 'I''m going', array['I am going']::text[]), (3, 1, 'does it start', array[]::text[]),
  (4, 0, 'we''re meeting', array['we are meeting']::text[]),
  (5, 0, 'Are you doing', array[]::text[]),
  (6, 0, 'does this term end', array[]::text[]), (6, 1, 'starts', array[]::text[]),
  (7, 0, 'We''re going', array['We are going']::text[]), (7, 1, 'Who''s getting', array['Who is getting']::text[]),
  (8, 0, 'Are you watching', array[]::text[]),
  (9, 0, 'leaves', array[]::text[]), (9, 1, 'arrives', array[]::text[]),
  (10, 0, 'It finishes', array[]::text[]),
  (11, 0, 'I''m not using', array['I am not using']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Future" / Unit 20 (I'm going to (do)), sourced from
-- pdf/Modulos/Future.pdf (extracted via `pdftotext -layout`) and cross-checked
-- against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-20 first (cascades) before re-inserting.

delete from units where slug = 'unit-20';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 20, 'unit-20', 'I''m going to (do)', null,
  'am/is/are + going to + infinitive describes an intention already decided, or a prediction based on the situation now.', 1
from modules where slug = 'future';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'A decided intention',
  'I am going to do something = I have already decided to do it, I intend to do it.', 0
from units where slug = 'unit-20';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'I am doing (arranged) vs. I am going to do (decided)',
  'I am doing = it is already fixed or arranged (you''ve booked, scheduled it with someone). I am going to do something = I''ve decided to do it, but maybe haven''t arranged it with anyone yet. Often the difference is small.', 1
from units where slug = 'unit-20';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Predicting from the situation now',
  'We also use (be) going to happen when the present situation makes it clear something is about to happen — the evidence is visible now.', 2
from units where slug = 'unit-20';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'was/were going to (intended, but didn''t happen)',
  'I was going to do something = I intended to do it, but didn''t do it.', 3
from units where slug = 'unit-20';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-20'
join (values
  ('A', '''Are you going to eat anything?'' ''No, I''m not hungry.''', 'decided intention', 0),
  ('A', 'This cheese smells horrible. I''m not going to eat it.', 'decided intention', 1),
  ('B', 'I''m leaving next week. I''ve booked my flight.', 'arranged', 0),
  ('B', 'I don''t want to stay here. Tomorrow I''m going to look for somewhere else to stay.', 'decided, not necessarily arranged', 1),
  ('C', 'Look at those black clouds! It''s going to rain. (we can see the clouds now)', 'evidence now', 0),
  ('C', 'I feel terrible. I think I''m going to be sick. (I feel terrible now)', 'evidence now', 1),
  ('D', 'We were going to travel by train, but then we decided to drive instead.', 'intended, didn''t happen', 0),
  ('D', 'I thought it was going to rain, but it didn''t.', 'intended, didn''t happen', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I', 'am going to', 'eat / buy / watch', 0 from units where slug = 'unit-20'
union all
select id, 'positive', 'he / she / it', 'is going to', 'eat / buy / watch', 1 from units where slug = 'unit-20'
union all
select id, 'positive', 'we / you / they', 'are going to', 'eat / buy / watch', 2 from units where slug = 'unit-20'
union all
select id, 'negative', null, null, 'Subject + am/is/are + not + going to + verb', 0 from units where slug = 'unit-20'
union all
select id, 'question', null, null, 'Am/Is/Are + subject + going to + verb?', 0 from units where slug = 'unit-20';

-- ============================================================
-- Exercises (main, split into the book's own 20.1-20.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '20.1', 'Write questions with going to.', 0
from units where slug = 'unit-20';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-20' where es.title = '20.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'Your friend is going to a wedding next week — what / wear?'),
  (2, '{0}', 'Your friend has just bought a new table — where / put?'),
  (3, '{0}', 'Your friend has decided to have a party — who / invite?'),
  (4, '{0}', 'Your friend has bought some fish for dinner — how / cook?')
) as v(n, template, hint)
where es.title = '20.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '20.1'
join (values
  (1, 0, 'What are you going to wear?'), (2, 0, 'Where are you going to put it?'),
  (3, 0, 'Who are you going to invite?'), (4, 0, 'How are you going to cook it?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '20.2', 'Complete the sentences using I''m going to ... / I''m not going to ... . Choose from: complain, learn, run, say, try, wash, not accept, not eat, not tell.', 1
from units where slug = 'unit-20';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-20' where es.title = '20.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I haven''t been trying hard enough. From now on {0} harder.', null),
  (2, 'I have to make a speech tomorrow, but I don''t know what {0}.', null),
  (3, '''The car is very dirty.'' ''I know. {0} it.''', null),
  (4, 'I''ve been offered a job, but {0} it. The pay is too low.', null),
  (5, '{0} a language, but I haven''t decided yet which one.', null),
  (6, 'One day {0} in a marathon. It''s my ambition.', null),
  (7, 'The food in this restaurant is awful. {0}.', null),
  (8, 'Ben doesn''t need to know what happened, so {0} him.', null)
) as v(n, template, hint)
where es.title = '20.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '20.2'
join (values
  (1, 0, 'I''m going to try'), (2, 0, 'I''m going to say'), (3, 0, 'I''m going to wash'),
  (4, 0, 'I''m not going to accept'), (5, 0, 'I''m going to learn'), (6, 0, 'I''m going to run'),
  (7, 0, 'I''m going to complain'), (8, 0, 'I''m not going to tell')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '20.3', 'What is going to happen in these situations? Use the words in brackets.', 2
from units where slug = 'unit-20';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-20' where es.title = '20.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It is 8.30. Tom is leaving home. He has to be at work at 8.45, but the journey takes 30 minutes. {0}.', 'late'),
  (2, 'There is a hole in the bottom of the boat. A lot of water is coming in through the hole. {0}.', 'sink'),
  (3, 'Amy and Ben are driving. The tank is nearly empty. It''s a long way to the nearest petrol station. {0}.', 'run out'),
  (4, 'Sarah''s car was badly damaged in an accident. Now it has to be repaired. {0} to repair the car.', 'cost a lot')
) as v(n, template, hint)
where es.title = '20.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '20.3'
join (values
  (1, 0, 'He''s going to be late', array['He is going to be late']::text[]),
  (2, 0, 'The boat is going to sink', array[]::text[]),
  (3, 0, 'They''re going to run out of petrol', array['They are going to run out of petrol']::text[]),
  (4, 0, 'It''s going to cost a lot', array['It is going to cost a lot of money']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '20.4', 'Complete the sentences with was/were going to. Choose from: be, buy, give up, phone, play, say, travel.', 3
from units where slug = 'unit-20';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-20' where es.title = '20.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I {0} some new clothes yesterday, but I didn''t have time to go to the shops.', null),
  (2, 'Tom and I {0} tennis last week, but he''d hurt his knee and had to cancel.', null),
  (3, 'I {0} Jane, but I sent her an email instead.', null),
  (4, 'I thought the exam {0} hard, but it was easier than I expected.', null),
  (5, 'Peter {0} his job, but in the end he decided to stay where he was.', null),
  (6, 'I''m sorry I interrupted you. What {0}?', 'you / say')
) as v(n, template, hint)
where es.title = '20.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '20.4'
join (values
  (1, 0, 'was going to buy'), (2, 0, 'were going to play'), (3, 0, 'was going to phone'),
  (4, 0, 'was going to be'), (5, 0, 'was going to give up'), (6, 0, 'were you going to say')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Future" / Unit 21 (will and shall 1), sourced from
-- pdf/Modulos/Future.pdf (extracted via `pdftotext -layout`) and cross-checked
-- against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-21 first (cascades) before re-inserting.

delete from units where slug = 'unit-21';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 21, 'unit-21', 'will and shall 1', null,
  'We use I''ll... to announce a decision made at the moment of speaking — offering, agreeing, promising, or refusing (won''t). Not for things already arranged.', 2
from modules where slug = 'future';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'I''ll... = a decision made right now',
  'We use I''ll... (= I will) when we''ve just decided to do something — announcing the decision as we make it. We don''t use the present simple for this.', 0
from units where slug = 'unit-21';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Offering, agreeing, promising, refusing',
  'We often use I''ll to offer, agree to, or promise something. won''t is used to say that somebody (or something) refuses to do something.', 1
from units where slug = 'unit-21';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Not for things already arranged',
  'We don''t use will for what has already been decided or arranged before now — compare a decision made in advance (present continuous) with one made on the spot (I''ll...).', 2
from units where slug = 'unit-21';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'shall I...? / shall we...?',
  'We use shall mostly in questions with I and we, to ask if it''s OK to do something or to ask for a suggestion.', 3
from units where slug = 'unit-21';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-21'
join (values
  ('A', 'Oh, I left the door open. I''ll go and shut it.', 'decision now', 0),
  ('A', '''What would you like to drink?'' ''I''ll have orange juice, please.''', 'decision now', 1),
  ('A', 'I can see you''re busy, so I won''t stay long. (= I will not stay long)', 'won''t = will not', 2),
  ('B', 'That bag looks heavy. I''ll help you with it. (not I help)', 'offering', 0),
  ('B', 'Sure, I''ll give it to him when I see him this afternoon.', 'agreeing', 1),
  ('B', 'Thanks for lending me the money. I''ll pay you back on Friday.', 'promising', 2),
  ('B', 'I''ve tried to give her advice, but she won''t listen.', 'refusing', 3),
  ('B', 'Will you please turn the music down? It''s too loud. (= please do it)', 'request', 4),
  ('C', 'I''m going on holiday next Saturday. (not I''ll go)', 'already arranged', 0),
  ('C', '''I''ll meet you at half past ten, OK?'' ''Fine. See you then.'' (decided now)', 'decided now', 1),
  ('D', 'Shall I open the window? (= do you want me to open it?)', 'suggestion/offer', 0),
  ('D', '''Where shall we have lunch?'' ''Let''s go to Marino''s.''', 'suggestion', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 21.1-21.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '21.1', 'Complete the sentences with I''ll + a suitable verb.', 0
from units where slug = 'unit-21';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-21' where es.title = '21.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''It''s cold in this room.'' ''Is it? {0} on the heating then.''', null),
  (2, '''Are you free next Friday?'' ''Let me see. {0} my diary.''', null),
  (3, '''Shall I do the washing-up?'' ''No, it''s all right. {0} it later.''', null),
  (4, '''I don''t know how to use this phone.'' ''OK, {0} you.''', null),
  (5, '''Would you like tea or coffee?'' ''{0} coffee, please.''', null),
  (6, '''Are you coming with us?'' ''No, I think {0}.''', null),
  (7, '''Can you finish this report today?'' ''Well, {0}, but I can''t promise.''', null)
) as v(n, template, hint)
where es.title = '21.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '21.1'
join (values
  (1, 0, 'I''ll turn', array['I''ll switch', 'I''ll put']::text[]),
  (2, 0, 'I''ll check', array[]::text[]),
  (3, 0, 'I''ll do', array[]::text[]),
  (4, 0, 'I''ll show', array[]::text[]),
  (5, 0, 'I''ll have', array[]::text[]),
  (6, 0, 'I''ll stay here', array['I''ll wait here']::text[]),
  (7, 0, 'I''ll try', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '21.2', 'Read the situations and write sentences with I think I''ll ... or I don''t think I''ll ... .', 1
from units where slug = 'unit-21';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-21' where es.title = '21.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You are feeling tired and it''s getting late. You decide to go to bed. I''m tired, so {0}. Goodnight!', null),
  (2, 'The weather is nice and you need some exercise. You decide to go for a walk. It''s a lovely morning. {0}. Do you want to come too?', null),
  (3, 'You were going to have lunch. Now you decide you don''t want to eat anything. I don''t feel hungry any more. {0} lunch.', null),
  (4, 'You planned to go swimming today. Now you decide not to go. I''ve got a lot to do, so {0} today.', null)
) as v(n, template, hint)
where es.title = '21.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '21.2'
join (values
  (1, 0, 'I think I''ll go to bed', array[]::text[]),
  (2, 0, 'I think I''ll go for a walk', array[]::text[]),
  (3, 0, 'I don''t think I''ll have', array['I don''t think I''ll have any lunch']::text[]),
  (4, 0, 'I don''t think I''ll go swimming', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '21.3', 'Which is correct?', 2
from units where slug = 'unit-21';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-21' where es.title = '21.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can''t meet you tomorrow morning. {0} tennis.', 'I''m playing / I''ll play'),
  (2, '''{0} you outside the hotel at 10.30, OK?'' ''Yes, that''s fine.''', 'I meet / I''ll meet'),
  (3, '''Please don''t go yet.'' ''OK, {0} a little longer, but I have to go soon.''', 'I''m staying / I''ll stay'),
  (4, '{0} a party next Saturday. I hope you can come.', 'I''m having / I''ll have'),
  (5, '''Remember to lock the door when you go out.'' ''OK. {0}.''', 'I don''t forget / I won''t forget'),
  (6, '''Do you have any plans for the weekend?'' ''Yes, {0} to a wedding.''', 'we''re going / we''ll go'),
  (7, '''{0} anything tomorrow evening?'' ''No, I''m free. Why?''', 'Are you doing / Will you do'),
  (8, '''{0} something for me?'' ''It depends. What do you want me to do?''', 'Do you do / Will you do'),
  (9, '''{0} to work by car?'' ''Not usually. I prefer to walk.''', 'Do you go / Will you go'),
  (10, 'I asked Sue what happened, but she {0} me.', 'doesn''t tell / won''t tell'),
  (11, 'I don''t know if I can win the race tomorrow, but {0} my best.', 'I''m doing / I''ll do')
) as v(n, template, hint)
where es.title = '21.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '21.3'
join (values
  (1, 0, 'I''m playing'), (2, 0, 'I''ll meet'), (3, 0, 'I''ll stay'), (4, 0, 'I''m having'),
  (5, 0, 'I won''t forget'), (6, 0, 'we''re going'), (7, 0, 'Are you doing'), (8, 0, 'Will you do'),
  (9, 0, 'Do you go'), (10, 0, 'won''t tell'), (11, 0, 'I''ll do')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '21.4', 'What do you say in these situations? Write sentences with shall I ... ? or shall we ... ?', 3
from units where slug = 'unit-21';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-21' where es.title = '21.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You and a friend are going on holiday together, but you have to decide where. You ask your friend: {0}?', null),
  (2, 'You try on a jacket in a shop. You are not sure whether to buy it or not. You ask a friend for advice: {0}? What do you think?', null),
  (3, 'You and a friend are going out. You have to decide whether to get a taxi or to walk. You ask your friend: {0} or {1}?', null),
  (4, 'It''s Helen''s birthday soon. You want to give her a present, but what? You ask a friend: What {0}? Any ideas?', null),
  (5, 'You''re meeting a friend tomorrow, but you have to decide what time. You say: {0}? Is 10.30 OK for you?', null)
) as v(n, template, hint)
where es.title = '21.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '21.4'
join (values
  (1, 0, 'Where shall we go', array['Where shall we go on holiday']::text[]),
  (2, 0, 'Shall I buy it', array[]::text[]),
  (3, 0, 'Shall we get a taxi', array[]::text[]), (3, 1, 'shall we walk', array[]::text[]),
  (4, 0, 'shall I give her', array['shall I buy her', 'shall I get her']::text[]),
  (5, 0, 'What time shall we meet', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Future" / Unit 22 (will and shall 2), sourced from
-- pdf/Modulos/Future.pdf (extracted via `pdftotext -layout`) and cross-checked
-- against pdf/Key to Exercises.pdf.
--
-- Note: 22.4 ("Where do you think you will be...? Write sentences about
-- yourself") is open-ended, left out.
--
-- Safe to re-run: deletes unit-22 first (cascades) before re-inserting.

delete from units where slug = 'unit-22';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 22, 'unit-22', 'will and shall 2', null,
  'We use will/won''t to predict — to say what we know or believe about the future — rather than to say what has already been decided.', 3
from modules where slug = 'future';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'will for predictions, not decisions',
  'We don''t use will for what someone has already arranged or decided. We use will to say what we know or believe about the future — predicting, not reporting a decision.', 0
from units where slug = 'unit-22';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'will often used with probably, I''m sure, I think, I wonder',
  'We often use will (''ll) with probably, I''m sure, I think, I don''t think and I wonder. After I hope, we generally use the present, not will.', 1
from units where slug = 'unit-22';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'will can also describe now',
  'Generally we use will for the future, but sometimes we use it to talk about what we believe is true right now.', 2
from units where slug = 'unit-22';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'shall — only with I/we',
  'We normally only use shall with I and we (I shall = I will). The negative is shall not or shan''t. We don''t normally use shall with he/she/it/you/they.', 3
from units where slug = 'unit-22';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-22'
join (values
  ('A', 'Lisa is working next week. (not Lisa will work)', 'already decided — present continuous', 0),
  ('A', 'Joe believes that Kate will pass the driving test. He is predicting the future.', 'prediction', 1),
  ('A', 'That plate is hot. If you touch it, you''ll burn yourself.', 'prediction', 2),
  ('A', 'I think James is going to the party on Friday. (= I think he has already decided to go)', 'already decided', 3),
  ('A', 'I think James will go to the party on Friday. (= I think he will decide to go)', 'prediction', 4),
  ('B', 'I''ll probably be home late tonight.', 'probably', 0),
  ('B', 'Don''t worry about the exam. I''m sure you''ll pass.', 'I''m sure', 1),
  ('B', 'I wonder what will happen.', 'I wonder', 2),
  ('B', 'After I hope, we generally use the present: I hope Kate passes the driving test.', 'hope + present', 3),
  ('C', 'Don''t phone Amy now. She''ll be busy. (= she''ll be busy now)', 'will about now', 0),
  ('D', 'I shall be late this evening. (or I will be)', 'shall with I', 0),
  ('D', 'I shan''t be here tomorrow. (or I won''t be)', 'shan''t = shall not', 1),
  ('D', 'She will be very angry. (not She shall be)', 'not with she/he/it/you/they', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 22.1, 22.2, 22.3, 22.5 — 22.4 skipped, open-ended)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '22.1', 'Put in will (''ll) or won''t.', 0
from units where slug = 'unit-22';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-22' where es.title = '22.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There''s no point in asking Amanda for advice. She {0} know what to do.', null),
  (2, 'I''m glad I''m meeting Emma tomorrow. It {0} be good to see her again.', null),
  (3, 'I''m sorry about what happened yesterday. It {0} happen again.', null),
  (4, 'You don''t need to take an umbrella with you. I don''t think it {0} rain.', null),
  (5, 'I''ve got some incredible news! You {0} believe it.', null)
) as v(n, template, hint)
where es.title = '22.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '22.1'
join (values
  (1, 0, 'won''t', array[]::text[]),
  (2, 0, '''ll', array['will']::text[]),
  (3, 0, 'won''t', array[]::text[]),
  (4, 0, '''ll', array['will']::text[]),
  (5, 0, 'won''t', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '22.2', 'Complete the sentences using will (''ll). Choose from: it/be, she/come, you/get, you/like, you/enjoy, people/live, it/look, we/meet, you/pass, she/mind.', 1
from units where slug = 'unit-22';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-22' where es.title = '22.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Why don''t you try on this jacket? {0} nice on you.', null),
  (2, 'You must meet Max sometime. I think {0} him.', null),
  (3, 'It''s a very nice hotel. {0} your stay there.', null),
  (4, 'It''s raining hard. Don''t go out. {0} very wet.', null),
  (5, 'Do you think {0} longer in the future?', null),
  (6, 'Goodbye! I''m sure {0} again before long.', null),
  (7, 'I''ve invited Anna to the party, but I don''t think {0}.', null),
  (8, 'You can borrow Amy''s umbrella. I don''t think {0}.', null),
  (9, 'It takes me an hour to get to work at the moment. When the new road is finished, {0} much quicker.', null)
) as v(n, template, hint)
where es.title = '22.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '22.2'
join (values
  (1, 0, 'It will look', array['It''ll look']::text[]),
  (2, 0, 'you''ll like', array['you will like']::text[]),
  (3, 0, 'You''ll enjoy', array['You will enjoy']::text[]),
  (4, 0, 'You''ll get', array['You will get']::text[]),
  (5, 0, 'people will live', array[]::text[]),
  (6, 0, 'we''ll meet', array['we will meet']::text[]),
  (7, 0, 'she''ll come', array['she will come']::text[]),
  (8, 0, 'she''ll mind', array['she will mind']::text[]),
  (9, 0, 'it will be', array['it''ll be']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '22.3', 'Write questions using do you think ... will ... ? + the following: be back, cost, end, get married, happen, like, rain.', 2
from units where slug = 'unit-22';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-22' where es.title = '22.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The weather doesn''t look very good. {0}?', null),
  (2, 'The meeting is still going on. {0}?', null),
  (3, 'My car needs to be repaired. {0}?', null),
  (4, 'Sally and David are in love. {0}?', null),
  (5, '''I''m going out now.'' ''OK. {0}?''', null),
  (6, 'The future situation is uncertain. {0}?', null)
) as v(n, template, hint)
where es.title = '22.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '22.3'
join (values
  (1, 0, 'Do you think it will rain', array[]::text[]),
  (2, 0, 'When do you think it will end', array[]::text[]),
  (3, 0, 'How much do you think it will cost', array[]::text[]),
  (4, 0, 'Do you think they''ll get married', array['Do you think they will get married']::text[]),
  (5, 0, 'What time do you think you''ll be back', array['What time do you think you will be back']::text[]),
  (6, 0, 'What do you think will happen', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '22.5', 'Which is better in these sentences?', 3
from units where slug = 'unit-22';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-22' where es.title = '22.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was an amazing experience. {0}.', 'I never forget it. / I''ll never forget it.'),
  (2, 'Something very funny happened. {0} when I tell you about it.', 'You''re laughing / You''ll laugh'),
  (3, '{0} to a party tomorrow night. Would you like to come too?', 'I''ll go / I''m going'),
  (4, 'Who do you think {0} the game tomorrow?', 'will win / is winning'),
  (5, 'I can''t meet you this evening. A friend of mine {0} to see me.', 'will come / is coming'),
  (6, 'Don''t be afraid of the dog. {0} you.', 'won''t hurt / isn''t hurting'),
  (7, '{0} if I press this button?', 'What''s happening / What will happen'),
  (8, 'a: Have you decided where to go for your holidays? b: Yes, {0} to Italy.', 'we''ll go / we''re going')
) as v(n, template, hint)
where es.title = '22.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '22.5'
join (values
  (1, 0, 'I''ll never forget it.'), (2, 0, 'You''ll laugh'), (3, 0, 'I''m going'), (4, 0, 'will win'),
  (5, 0, 'is coming'), (6, 0, 'It won''t hurt'), (7, 0, 'What will happen'), (8, 0, 'we''re going')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Future" / Unit 23 (I will and I'm going to), sourced from
-- pdf/Modulos/Future.pdf (extracted via `pdftotext -layout`) and cross-checked
-- against pdf/Key to Exercises.pdf.
--
-- Note on 23.3: the book's matching format (1-8 matched to a-h) is combined
-- into single sentences here, same approach as unit-6's 6.2.
--
-- Safe to re-run: deletes unit-23 first (cascades) before re-inserting.

delete from units where slug = 'unit-23';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 23, 'unit-23', 'I will and I''m going to', null,
  'We use will to announce a new decision made right now. We use (be) going to when we''ve already decided, or when the present situation makes something clearly about to happen.', 4
from modules where slug = 'future';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'will (a new decision) vs. (be) going to (already decided)',
  'We use will to announce a decision made at the moment of speaking. We use (be) going to when we have already decided to do something before now.', 0
from units where slug = 'unit-23';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Predicting the future',
  'For future happenings and situations, both will and going to are usually possible. But we prefer going to when the present situation already makes it clear something is about to happen.', 1
from units where slug = 'unit-23';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-23'
join (values
  ('A', '''Let''s have a party. That''s a great idea.'' ''We''ll invite lots of people.'' (new decision)', 'new decision — will', 0),
  ('A', '''Sarah and I have decided to have a party.'' ''We''re going to invite lots of people.'' (decided before)', 'decided before — going to', 1),
  ('A', '''Gary has been trying to contact you.'' ''Has he? OK, I''ll call him.''', 'new decision — will', 2),
  ('A', '''Gary has been trying to contact you.'' ''Yes, I know. I''m going to call him.''', 'decided before — going to', 3),
  ('B', 'I think the weather will be nice later. or I think the weather is going to be nice later.', 'either form possible', 0),
  ('B', 'Look at those black clouds. It''s going to rain. (not it will rain — the evidence is here now)', 'going to — evidence now', 1),
  ('B', 'Jane will be late for the meeting. She''s always late. (I believe this because I know what Jane is like)', 'will — general belief', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 23.1-23.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '23.1', 'Complete the sentences using will (''ll) or (be) going to.', 0
from units where slug = 'unit-23';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-23' where es.title = '23.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: I forgot my wallet. I don''t have any money. b: Not to worry. {0} you some.', 'I / lend'),
  (2, 'a: Why are you filling that bucket with water? b: {0} the car.', 'I / wash'),
  (3, 'a: I don''t know how to use the washing machine. b: It''s easy. {0} you.', 'I / show'),
  (4, 'a: I''ve decided to paint this room. b: That''s nice. What colour {0} it?', 'you / paint'),
  (5, 'a: Where are you going? Are you going shopping? b: Yes, {0} some things for dinner tonight.', 'I / buy'),
  (6, 'a: What would you like to eat? b: {0} a pizza, please.', 'I / have'),
  (7, 'a: This food doesn''t taste very good, does it? b: No, it''s horrible. {0} it.', 'I / not / finish'),
  (8, 'a: Tom is starting an evening class next month. b: Is he? What {0}?', 'he / study'),
  (9, 'a: Did you call Lisa? b: Oh, no. I completely forgot. {0} her now.', 'I / call'),
  (10, 'a: Has Dan decided what to do when he leaves school? b: Yes. Everything is planned. First {0} a holiday for a few weeks. Then {1} a management training course.', 'he / have ... he / do')
) as v(n, template, hint)
where es.title = '23.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '23.1'
join (values
  (1, 0, 'I''ll lend', array[]::text[]),
  (2, 0, 'I''m going to wash', array[]::text[]),
  (3, 0, 'I''ll show', array[]::text[]),
  (4, 0, 'are you going to paint', array[]::text[]),
  (5, 0, 'I''m going to buy', array[]::text[]),
  (6, 0, 'I''ll have', array[]::text[]),
  (7, 0, 'I''m not going to finish', array[]::text[]),
  (8, 0, 'is he going to study', array['''s he going to study']::text[]),
  (9, 0, 'I''ll call', array[]::text[]),
  (10, 0, 'he''s going to have', array['he is going to have']::text[]), (10, 1, 'he''s going to do', array['he is going to do']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '23.2', 'Read the situations and complete the sentences using will (''ll) or (be) going to.', 1
from units where slug = 'unit-23';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-23' where es.title = '23.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''re speaking to a friend and arranging to meet. You suggest a time and place. You say: {0} you at 10.30 in the hotel lobby, OK?', 'I / see'),
  (2, 'You have decided to sell your car. You tell a friend of yours. You say: I don''t need my car any more. {0} it.', 'I / sell'),
  (3, 'Your friend is worried because she has lost her driving licence. You say: Don''t worry. I''m sure {0} it.', 'you / find'),
  (4, 'You have an old camera that is broken. You have decided to throw it away. You tell your friend. You say: This camera is broken. {0} it away.', 'I / throw'),
  (5, 'Your friend loves and collects old cameras. He doesn''t want you to throw it away. He says: Don''t throw it away! {0} it.', 'I / have'),
  (6, 'Joe has to go to the airport tomorrow. He doesn''t know how to get there. Amy offers to take him. Amy says: Don''t worry about getting to the airport, Joe. {0} you.', 'I / take'),
  (7, 'Later that day, Paul offers to take Joe to the airport. Joe tells him that it''s not necessary. Joe says: Thanks, Paul, but {0} me.', 'Amy / take')
) as v(n, template, hint)
where es.title = '23.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '23.2'
join (values
  (1, 0, 'I''ll see', array[]::text[]),
  (2, 0, 'I''m going to sell', array[]::text[]),
  (3, 0, 'you''ll find', array['you''re going to find']::text[]),
  (4, 0, 'I''m going to throw', array[]::text[]),
  (5, 0, 'I''ll have', array[]::text[]),
  (6, 0, 'I''ll take', array[]::text[]),
  (7, 0, 'Amy is going to take', array['Amy is taking']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '23.3', 'Which goes with which? Combine the sentences.', 2
from units where slug = 'unit-23';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-23' where es.title = '23.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'That ceiling looks dangerous. {0}.', null),
  (2, 'He''s looking very tired. {0}.', null),
  (3, 'This table is too big. {0}.', null),
  (4, 'The weather forecast is good. {0}.', null),
  (5, 'Jack is very determined. {0}.', null),
  (6, 'They are building a new skyscraper here. {0}.', null),
  (7, 'I haven''t seen Ben for ages. {0}.', null)
) as v(n, template, hint)
where es.title = '23.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '23.3'
join (values
  (1, 0, 'It looks as if it''s going to fall down'),
  (2, 0, 'I think he''s going to fall asleep'),
  (3, 0, 'I don''t think it will fit in the room'),
  (4, 0, 'It''s going to be a nice day'),
  (5, 0, 'He''ll get what he wants'),
  (6, 0, 'It''s going to be 200 metres high'),
  (7, 0, 'He probably won''t remember me')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Future" / Unit 24 (will be doing and will have done), sourced from
-- pdf/Modulos/Future.pdf (extracted via `pdftotext -layout`) and cross-checked
-- against pdf/Key to Exercises.pdf.
--
-- Note on 24.1: the book's "tick the true sentences" format (checkboxes,
-- possibly more than one true per group) doesn't fit this app's single-blank
-- model, so each group of 4 options is reframed as "which is/are true? type
-- the letter(s)". Group 1 in the source has no recoverable answer (the
-- printed tick mark isn't preserved by text extraction and there's no
-- textual fallback), so it's left out; groups 2-6 all have Key-confirmed
-- answers.
--
-- Safe to re-run: deletes unit-24 first (cascades) before re-inserting.

delete from units where slug = 'unit-24';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 24, 'unit-24', 'will be doing and will have done', null,
  'will be + -ing (future continuous) describes being in the middle of an action at a future time. will have + past participle (future perfect) describes something complete before a future time.', 5
from modules where slug = 'future';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Two viewpoints on the future: in progress vs. already finished',
  'Looking forward from now, some things will be in progress at a future moment (will be doing), and others will already be finished by then (will have done).', 0
from units where slug = 'unit-24';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'will be doing = in the middle of it',
  'I will be doing something (future continuous) = I will be in the middle of doing it at that time — parallel to the present continuous (now) and past continuous (at a past time).', 1
from units where slug = 'unit-24';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'will be -ing for complete future actions',
  'We also use will be -ing to talk about complete future actions, especially fixed or routine events — similar in meaning to will (do) or going to (do).', 2
from units where slug = 'unit-24';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'will have done = already complete by then',
  'I will have done something (future perfect) = it will be complete before a particular time in the future.', 3
from units where slug = 'unit-24';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-24'
join (values
  ('A', 'Half an hour from now, the cinema will be full. Everyone will be watching the film.', 'in progress', 0),
  ('A', 'Three hours from now, the cinema will be empty. The film will have finished. Everyone will have gone home.', 'already finished', 1),
  ('B', 'This time next week I''ll be on holiday. I''ll be lying on the beach or swimming in the sea.', 'in progress', 0),
  ('B', 'At 10 o''clock tomorrow, she will be in her office. She will be working.', 'in progress', 1),
  ('C', 'The government will be making a statement about the crisis later today.', 'complete future event', 0),
  ('C', 'The team''s star player is injured and won''t be playing in the game on Saturday.', 'complete future event', 1),
  ('D', 'Sally always leaves for work at 8.30. She won''t be at home at 9 o''clock — she''ll have gone to work.', 'already complete', 0),
  ('D', 'We''re late. The film will already have started by the time we get to the cinema.', 'already complete', 1),
  ('D', 'Ted and Amy have been married for 24 years. (present perfect) Next year they will have been married for 25 years. (future perfect)', 'present vs. future perfect', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_structure_rows (unit_id, row_type, subject_label, aux_form, example_text, order_index)
select id, 'positive', 'I / we / you / they / he / she / it', 'will be', 'doing / working / eating', 0 from units where slug = 'unit-24'
union all
select id, 'negative', null, null, 'Subject + won''t be + verb-ing', 0 from units where slug = 'unit-24'
union all
select id, 'question', null, null, 'Will + subject + be + verb-ing?', 0 from units where slug = 'unit-24';

-- ============================================================
-- Exercises (main, split into the book's own 24.1-24.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '24.1', 'Read about Andy''s daily routine. For each time, which sentence(s) are true? Type the letter(s).', 0
from units where slug = 'unit-24';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-24' where es.title = '24.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Andy leaves home at 8.00 and arrives at work at 8.45. At 8.15: (a) he''ll be leaving the house (b) he''ll have left the house (c) he''ll have arrived at work (d) he''ll be arriving at work. {0}', 'Andy leaves home at 8, works 8.45-12.30, lunch until 1.15, works until 4.30 sharp.'),
  (2, 'At 9.15: (a) he''ll be working (b) he''ll start work (c) he''ll have started work (d) he''ll be arriving at work. {0}', null),
  (3, 'He has lunch at 12.30 for about half an hour. At 12.45: (a) he''ll have lunch (b) he''ll be having lunch (c) he''ll have finished his lunch (d) he''ll have started his lunch. {0}', null),
  (4, 'He starts again at 1.15 and goes home at exactly 4.30. At 4 o''clock: (a) he''ll have finished work (b) he''ll finish work (c) he''ll be working (d) he won''t have finished work. {0}', null),
  (5, 'At 4.45: (a) he''ll leave work (b) he''ll be leaving work (c) he''ll have left work (d) he''ll have arrived home. {0}', null)
) as v(n, template, hint)
where es.title = '24.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '24.1'
join (values
  (1, 0, 'b'), (2, 0, 'a and c'), (3, 0, 'b and d'), (4, 0, 'c and d'), (5, 0, 'c')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '24.2', 'Complete the sentences. Choose from: be watching, will be landing, won''t be playing, will be starting, will you be voting, won''t be going, be going, will you be doing.', 1
from units where slug = 'unit-24';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-24' where es.title = '24.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ll {0} shopping later. Can I get you anything?', null),
  (2, 'Emily is not well, so she {0} volleyball tomorrow.', null),
  (3, 'Little Emma {0} school soon. She''s growing up fast.', null),
  (4, 'The match is on TV tonight. Will you {0} it?', null),
  (5, 'What {0} in your new job? The same as before?', null),
  (6, 'I {0} to the wedding. I''ll be away on holiday.', null),
  (7, 'Please fasten your seat belts. The plane {0} in ten minutes.', null)
) as v(n, template, hint)
where es.title = '24.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '24.2'
join (values
  (1, 0, 'be going'), (2, 0, 'won''t be playing'), (3, 0, 'will be starting'), (4, 0, 'be watching'),
  (5, 0, 'will you be doing'), (6, 0, 'won''t be going'), (7, 0, 'will be landing')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '24.3', 'Put the verb into the correct form, will be (do)ing or will have (done).', 2
from units where slug = 'unit-24';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-24' where es.title = '24.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Tomorrow afternoon we''re going to play tennis from 3 o''clock until 4.30. So at 4 o''clock, {0} tennis.', 'we / play'),
  (2, 'Sarah will meet you at the station. {0} for you when you arrive.', 'she / wait'),
  (3, 'The meeting starts at 9.30 and won''t last longer than an hour. You can be sure that {0} by 11 o''clock.', 'it / finish'),
  (4, 'Do you think {0} in the same place in ten years'' time?', 'you / still / live'),
  (5, 'Lisa is travelling in Europe and so far she has travelled about 1,000 miles. By the end of the trip, {0} more than 3,000 miles.', 'she / travel'),
  (6, 'If you need to contact me, {0} at the Lion Hotel until Friday.', 'I / stay'),
  (7, 'Ben is on holiday and is spending his money very quickly. If he continues like this, {0} all his money before the end of his holiday.', 'he / spend'),
  (8, 'I''m fed up with my job. I hope {0} it much longer.', 'I / not / do')
) as v(n, template, hint)
where es.title = '24.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '24.3'
join (values
  (1, 0, 'we''ll be playing', array['we will be playing']::text[]),
  (2, 0, 'She''ll be waiting', array['She will be waiting']::text[]),
  (3, 0, 'it will have finished', array['it will be finished']::text[]),
  (4, 0, 'you''ll still be living', array['you will still be living']::text[]),
  (5, 0, 'she''ll have travelled', array['she will have travelled']::text[]),
  (6, 0, 'I''ll be staying', array['I will be staying']::text[]),
  (7, 0, 'he''ll have spent', array['he will have spent']::text[]),
  (8, 0, 'I won''t be doing', array['I will not be doing']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Future" / Unit 25 (when I do and when I've done. if and when), the
-- last unit of this module, sourced from pdf/Modulos/Future.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-25 first (cascades) before re-inserting.

delete from units where slug = 'unit-25';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 25, 'unit-25', 'when I do and when I''ve done. if and when', null,
  'After when/while/before/after/as soon as/until, we use the present (not will) for the future. After if, we use the present for something that may or may not happen; when is for something sure to happen.', 6
from modules where slug = 'future';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Present, not will, after time conjunctions',
  'After when, while, before, after, as soon as and until, we use the present simple (not will) for future time — "when I arrive", not "when I will arrive".', 0
from units where slug = 'unit-25';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Present perfect to show one thing finishes before another',
  'You can also use the present perfect (have done) after when/after/until/as soon as, to show that one thing is complete before the other — but not if the two things happen together.', 1
from units where slug = 'unit-25';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'if (possible) vs. when (sure to happen)',
  'After if, we normally use the present for the future. We use if for things that may or may not happen, and when for things that are sure to happen.', 2
from units where slug = 'unit-25';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-25'
join (values
  ('A', 'I''ll call you again later when I arrive. (not when I will arrive)', 'present, not will', 0),
  ('A', 'We''ll go out when it stops raining. (not when it will stop)', 'present, not will', 1),
  ('A', 'Don''t forget to lock the door when you go out. (not will go)', 'present, not will', 2),
  ('A', 'Wait here until I come back. or ... till I come back.', 'present, not will', 3),
  ('B', 'Can I have the newspaper when you''ve finished with it?', 'perfect — sequence', 0),
  ('B', 'When I''ve phoned Kate, we can go out. (= first phone, then go out)', 'perfect — sequence', 1),
  ('B', 'When I phone Kate, I''ll ask her about the party. (not when I''ve phoned — happens together)', 'simple — simultaneous', 2),
  ('B', 'I''ll come as soon as I finish. or I''ll come as soon as I''ve finished.', 'either form possible', 3),
  ('C', 'I''ll be angry if it happens again. (not if it will happen)', 'if + present', 0),
  ('C', 'If it is raining this evening, I won''t go out. (not when it is raining)', 'if — not sure', 1),
  ('C', 'I might go out later. (it''s possible) If I go out, I''ll get some bread.', 'if — possible', 2),
  ('C', 'I''m going out later. (for sure) When I go out, I''ll get some bread.', 'when — sure', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 25.1-25.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '25.1', 'Which is correct?', 0
from units where slug = 'unit-25';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-25' where es.title = '25.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'As soon as we get any more information, {0} you know.', 'we let / we''ll let'),
  (2, 'I want to get to the cinema before the film {0}.', 'starts / will start'),
  (3, 'Don''t drive through a red light. Wait until {0} to green.', 'it changes / it will change'),
  (4, 'Sarah will be here soon. {0} some coffee when she comes.', 'I make / I''ll make'),
  (5, 'I''m 20 now. I wonder where I''ll be when {0}.', 'I''m 40 / I''ll be 40'),
  (6, '{0} for you until you''re ready, but don''t be long.', 'I wait / I''ll wait'),
  (7, 'Oliver is five years old. He wants to be a TV presenter when {0}.', 'he grows up / he''ll grow up'),
  (8, 'We could meet for coffee tomorrow morning if {0} free.', 'you''re / you will be'),
  (9, 'If the weather {0} nice tomorrow, we''re going to the beach.', 'is / will be'),
  (10, 'Vicky {0} very disappointed if she doesn''t get a place at university.', 'is / will be'),
  (11, 'You''ll feel better after {0} something to eat.', 'you''ve had / you''ll have')
) as v(n, template, hint)
where es.title = '25.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '25.1'
join (values
  (1, 0, 'we''ll let'), (2, 0, 'starts'), (3, 0, 'it changes'), (4, 0, 'I''ll make'), (5, 0, 'I''m 40'),
  (6, 0, 'I''ll wait'), (7, 0, 'he grows up'), (8, 0, 'you''re'), (9, 0, 'is'), (10, 0, 'will be'), (11, 0, 'you''ve had')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '25.2', 'Complete the sentences using the verbs in brackets. Use will/won''t or the present.', 1
from units where slug = 'unit-25';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-25' where es.title = '25.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I want to see Sophie before {0} away next week.', 'she / go'),
  (2, 'Call me when {0} what time you''re going to get here.', 'you / know'),
  (3, 'There''s no need to hurry. {0} for you until {1} ready.', 'I / wait ... you / be'),
  (4, 'I''m going out for about an hour. {0} here when {1} back?', 'you / still / be ... I / get'),
  (5, 'I think everything will be fine, but if {0} any problems, {1} you know, OK?', 'there / be ... I / let'),
  (6, 'Kate looks completely different now. {0} her when {1} her again.', 'you / not / recognise ... you / see'),
  (7, 'I''m going to be away for a few days. If {0} to contact me while {1} away, you can call me.', 'you / need ... I / be')
) as v(n, template, hint)
where es.title = '25.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '25.2'
join (values
  (1, 0, 'she goes', array[]::text[]),
  (2, 0, 'you know', array[]::text[]),
  (3, 0, 'I''ll wait', array['I will wait']::text[]), (3, 1, 'you''re', array['you are']::text[]),
  (4, 0, 'Will you still be', array[]::text[]), (4, 1, 'I get', array[]::text[]),
  (5, 0, 'there are', array[]::text[]), (5, 1, 'I''ll let', array['I will let']::text[]),
  (6, 0, 'You won''t recognise', array['You will not recognise']::text[]), (6, 1, 'you see', array[]::text[]),
  (7, 0, 'you need', array[]::text[]), (7, 1, 'I''m', array['I am']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '25.3', 'Read the situations and complete the sentences.', 2
from units where slug = 'unit-25';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-25' where es.title = '25.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''re visiting a friend. It''s going to get dark soon, and you want to leave before that. You say: I''d better go now before {0}.', null),
  (2, 'You want to sell your car. Mark is interested in buying it, but he hasn''t decided yet. You say: Let me know as soon as {0}.', null),
  (3, 'Your friends are going to Hong Kong soon. You want to know where they''re going to stay. You ask: Where are you going to stay when {0}?', null),
  (4, 'The traffic is bad in your town, but they are going to build a new road. You say: I think things will be better when they {0}.', null),
  (5, 'Someone you know has been very rude to you. You want her to apologise. You say: I won''t speak to her until {0}.', null)
) as v(n, template, hint)
where es.title = '25.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '25.3'
join (values
  (1, 0, 'it gets dark', array[]::text[]),
  (2, 0, 'you decide', array['you''ve decided', 'you have decided']::text[]),
  (3, 0, 'you''re in Hong Kong', array['you go to Hong Kong']::text[]),
  (4, 0, 'build the new road', array['''ve built the new road', 'have built the new road']::text[]),
  (5, 0, 'she apologises', array['she''s apologised', 'she has apologised']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '25.4', 'Put in when or if.', 3
from units where slug = 'unit-25';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-25' where es.title = '25.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Be careful. You''ll hurt yourself {0} you fall.', null),
  (2, 'I''m going shopping. {0} you want anything, I can get it for you.', null),
  (3, 'I''m going away for a few days. I''ll call you {0} I get back.', null),
  (4, '{0} I don''t see you tomorrow, when will I see you again?', null),
  (5, 'I''m watching a programme on TV right now. {0} it finishes, I''m going to bed.', null),
  (6, 'We can eat at home or, {0} you prefer, we can go to a restaurant.', null),
  (7, 'I hope Sarah can come to the party. It will be a shame {0} she can''t come.', null)
) as v(n, template, hint)
where es.title = '25.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '25.4'
join (values
  (1, 0, 'if'), (2, 0, 'If'), (3, 0, 'when'), (4, 0, 'If'), (5, 0, 'When'), (6, 0, 'if'), (7, 0, 'if')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
