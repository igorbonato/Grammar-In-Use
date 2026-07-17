-- Marco 4 (slice 6): seeds the "Passive" module — units 42-46 (Passive 1,
-- Passive 2, Passive 3, he is supposed to ..., have something done).
--
-- Sourced from pdf/Modulos/Passive.pdf (extracted via `pdftotext -layout`,
-- same workaround as previous modules — pdftoppm/poppler isn't available
-- locally) and cross-checked against pdf/Key to Exercises.pdf. This PDF
-- turned out to be a clean 1:1 match with the "Passive" chapter (units
-- 42-46 only — confirmed by grepping the extracted text for unit-number
-- headers across the whole file, per the lesson from the Modals.pdf
-- discovery); "UNIT 47" (Reported speech) starts immediately after in the
-- Key to Exercises, confirming the boundary.
--
-- Open-ended own-answer exercises: none found in this chapter — every
-- exercise in 42-46 has fixed expected answers in the Key to Exercises.
--
-- Where a book exercise item is itself the worked example (already
-- answered inline), it's dropped and the remaining items are renumbered
-- from 1 in this module's DB rows — same convention as prior migrations.
-- "Write a sentence" style exercises (42.4, 43.2, 43.3, 45.1-45.4, 46.3,
-- 46.5) use the "scenario -> single full-sentence blank" shape from
-- 0007/0006 rather than the book's own partial-stem scaffolding, for the
-- same pdftotext -layout short-word-near-blank reliability reason
-- documented there.
--
-- 46.1 ("Which is correct for each picture?") is a picture-based exercise
-- with no fill-in text in the book at all — the four scenes are described
-- in the exercise templates themselves and in a theory_images placeholder,
-- since there's no picture data to seed.
--
-- 46.4 ("Which goes with which?") is adapted the same way matching-format
-- exercises were in prior migrations (27.1, 32.1, 37.1, 38.2): the prompt
-- becomes the template and the correct match's full sentence becomes the
-- answer.
--
-- Additional exercises 22-24 are referenced at the end of units 43, 44 and
-- 45 ("Additional exercises 22-24 (pages 314-15)") but, same as the
-- deferred 19-21 in 0007, are left out of this slice — not attempted this
-- round, consistent with every prior module.
--
-- Consolidated into a single migration, same pattern as 0003-0007, so
-- Supabase's GitHub-linked CI/CD applies it automatically on push.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('passive', 'Passive', 5)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 42: Passive 1 (is done / was done)
-- ============================================================

delete from units where slug = 'unit-42';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 42, 'unit-42', 'Passive 1 (is done / was done)', null,
  'The passive is be (is/was etc.) + past participle. We use it when who or what causes the action is unknown or unimportant, or when we want to focus on what happens to the subject rather than on who does it. Use by to say who or what causes the action.', 0
from modules where slug = 'passive';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Active vs passive: what the subject does / what happens to the subject',
  'Compare active and passive: "Somebody built this house in 1981" (active — subject + object) and "This house was built in 1981" (passive — the object of the active sentence becomes the subject). With an active verb we say what the subject does; with a passive verb we say what happens to the subject.', 0
from units where slug = 'unit-42';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'by, and when the passive is used',
  'When we use the passive, who or what causes the action is often unknown or unimportant: "A lot of money was stolen in the robbery" (we don''t know who). If we want to say who does or what causes the action, we use by: "This house was built by my grandfather."', 1
from units where slug = 'unit-42';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'be + past participle, present and past simple',
  'The passive is be (is/was etc.) + past participle (done/cleaned/seen etc.); the past participle often ends in -ed, but many important verbs are irregular. Present simple passive: am/is/are + past participle ("This room is cleaned every day"). Past simple passive: was/were + past participle ("This room was cleaned yesterday").', 2
from units where slug = 'unit-42';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-42'
join (values
  ('A', 'Somebody built this house in 1981.', 'active', 0),
  ('A', 'This house was built in 1981.', 'passive', 1),
  ('A', 'My grandfather was a builder. He built this house in 1981.', null, 2),
  ('A', 'Two hundred people are employed by the company.', null, 3),
  ('B', 'A lot of money was stolen in the robbery.', 'somebody stole it, but we don''t know who', 0),
  ('B', 'Is this room cleaned every day?', 'does somebody clean it — it''s not important who', 1),
  ('B', 'This house was built by my grandfather.', null, 2),
  ('C', 'Many accidents are caused by careless driving.', null, 0),
  ('C', 'I''m not invited to parties very often.', null, 1),
  ('C', 'How is this word pronounced?', null, 2),
  ('C', 'We were woken up by a loud noise during the night.', null, 3),
  ('C', 'How much money was stolen in the robbery?', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: a house with a caption "This house was built in 1981", with subject/object labels illustrating how the object of the active sentence ("Somebody built this house in 1981") becomes the subject of the passive sentence]', 0
from units where slug = 'unit-42';

-- ------------------------------------------------------------
-- Exercises (main, book's own 42.1-42.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '42.1', 'Complete the sentences. Use these verbs in the correct form, present or past: cause, damage, find, hold, injure, invite, make, overtake, own, send, show, surround.', 0
from units where slug = 'unit-42';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-42' where es.title = '42.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Cheese {0} from milk.', null),
  (2, 'The roof of the building {0} in a storm a few days ago.', null),
  (3, 'A cinema is a place where films {0}.', null),
  (4, 'You {0} to the party. Why didn''t you go?', null),
  (5, 'This plant is very rare. It {0} in very few places.', null),
  (6, 'Although we were driving fast, we {0} by a lot of other cars.', null),
  (7, 'In the US, elections for president {0} every four years.', null),
  (8, 'There was an accident last night, but fortunately nobody {0}.', null),
  (9, 'You can''t see the house from the road. It {0} by trees.', null),
  (10, 'I never received the letter. It {0} to the wrong address.', null),
  (11, 'The company I work for {0} by a much larger company.', null)
) as v(n, template, hint)
where es.title = '42.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '42.1'
join (values
  (1, 0, 'is made', array[]::text[]),
  (2, 0, 'was damaged', array[]::text[]),
  (3, 0, 'are shown', array[]::text[]),
  (4, 0, 'were invited', array[]::text[]),
  (5, 0, 'is found', array['''s found']::text[]),
  (6, 0, 'were overtaken', array[]::text[]),
  (7, 0, 'are held', array[]::text[]),
  (8, 0, 'was injured', array[]::text[]),
  (9, 0, 'is surrounded', array[]::text[]),
  (10, 0, 'was sent', array[]::text[]),
  (11, 0, 'is owned', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '42.2', 'Write questions using the passive. Some are present and some are past.', 1
from units where slug = 'unit-42';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-42' where es.title = '42.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ask about television. {0}', '(when / invent?)'),
  (2, 'Ask about mountains. {0}', '(how / form?)'),
  (3, 'Ask about DNA. {0}', '(when / discover?)'),
  (4, 'Ask about silver. {0}', '(what / use for?)')
) as v(n, template, hint)
where es.title = '42.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '42.2'
join (values
  (1, 0, 'When was television invented?'),
  (2, 0, 'How are mountains formed?'),
  (3, 0, 'When was DNA discovered?'),
  (4, 0, 'What is silver used for?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '42.3', 'Put the verb into the correct form, present or past, active or passive.', 2
from units where slug = 'unit-42';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-42' where es.title = '42.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Water {0} most of the earth''s surface.', '(cover)'),
  (2, 'How much of the earth''s surface {0} by water?', '(cover)'),
  (3, 'While I was on holiday, my camera {0} from my hotel room.', '(steal)'),
  (4, 'While I was on holiday, my camera {0} from my hotel room.', '(disappear)'),
  (5, 'Robert''s parents {0} when he was very young.', '(die)'),
  (6, 'Robert and his sister {0} by their grandparents.', '(bring up)'),
  (7, 'The boat hit a rock and {0} quickly.', '(sink)'),
  (8, 'Fortunately everybody {0}.', '(rescue)'),
  (9, 'Bill {0} from his job. He wasn''t very good at it.', '(fire)'),
  (10, 'Sue {0} from her job because she didn''t enjoy it any more.', '(resign)'),
  (11, 'It can be noisy living here, but it {0} me.', '(not / bother)'),
  (12, 'It can be noisy living here, but I {0} by it.', '(not / bother)'),
  (13, 'Maria had an accident. She {0} off her bike.', '(knock)'),
  (14, 'Maria had an accident. She {0} off her bike.', '(fall)'),
  (15, 'I haven''t seen these flowers before. What {0}?', '(they / call)'),
  (16, 'I haven''t seen these flowers before. What {0} them?', '(you / call)')
) as v(n, template, hint)
where es.title = '42.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '42.3'
join (values
  (1, 0, 'covers', array[]::text[]),
  (2, 0, 'is covered', array[]::text[]),
  (3, 0, 'was stolen', array[]::text[]),
  (4, 0, 'disappeared', array[]::text[]),
  (5, 0, 'died', array[]::text[]),
  (6, 0, 'were brought up', array[]::text[]),
  (7, 0, 'sank', array[]::text[]),
  (8, 0, 'was rescued', array[]::text[]),
  (9, 0, 'was fired', array[]::text[]),
  (10, 0, 'resigned', array[]::text[]),
  (11, 0, 'doesn''t bother', array[]::text[]),
  (12, 0, 'am not bothered', array['''m not bothered']::text[]),
  (13, 0, 'was knocked', array[]::text[]),
  (14, 0, 'fell', array[]::text[]),
  (15, 0, 'are they called', array[]::text[]),
  (16, 0, 'do you call', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '42.4', 'Instead of using somebody, they, people etc., write a passive sentence.', 3
from units where slug = 'unit-42';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-42' where es.title = '42.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'They cancelled all flights because of fog. {0}', null),
  (2, 'Somebody accused me of stealing money. {0}', null),
  (3, 'How do you use this word? {0}', null),
  (4, 'The price includes all taxes. {0}', null),
  (5, 'People warned us not to go out alone. {0}', null),
  (6, 'We don''t use this office any more. {0}', null),
  (7, 'They invited five hundred people to the wedding. {0}', null)
) as v(n, template, hint)
where es.title = '42.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '42.4'
join (values
  (1, 0, 'All flights were cancelled because of fog.', array[]::text[]),
  (2, 0, 'I was accused of stealing money.', array[]::text[]),
  (3, 0, 'How is this word used?', array[]::text[]),
  (4, 0, 'All taxes are included in the price.', array[]::text[]),
  (5, 0, 'We were warned not to go out alone.', array[]::text[]),
  (6, 0, 'This office isn''t used any more.', array['This office is not used any more.']::text[]),
  (7, 0, 'Five hundred people were invited to the wedding.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 43: Passive 2 (be done / been done / being done)
-- ============================================================

delete from units where slug = 'unit-43';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 43, 'unit-43', 'Passive 2 (be done / been done / being done)', null,
  'The passive can be used in the infinitive (be done), the perfect infinitive (have been done), the present/past perfect (has/had been done), and the present/past continuous (is/was being done).', 1
from modules where slug = 'passive';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Infinitive passive: (to) be + done',
  'The active infinitive is (to) do/clean/see etc.; the passive is (to) be + done/cleaned/seen etc.: "Somebody will clean this room later" becomes "This room will be cleaned later."', 0
from units where slug = 'unit-43';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Perfect infinitive passive: (to) have been + done',
  'The active perfect infinitive is (to) have + done etc.; the passive is (to) have been + done etc.: "Somebody should have cleaned the room" becomes "The room should have been cleaned."', 1
from units where slug = 'unit-43';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Present/past perfect passive: has/have/had been + done',
  'Present perfect active is have/has + done; passive is have/has been + done ("The room looks nice. It has been cleaned."). Past perfect active is had + done; passive is had been + done ("The room looked nice. It had been cleaned.").', 2
from units where slug = 'unit-43';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'Present/past continuous passive: am/is/are/was/were being + done',
  'Present continuous active is am/is/are + (do)ing; passive is am/is/are + being (done) ("The room is being cleaned at the moment."). Past continuous active is was/were + (do)ing; passive is was/were + being (done) ("The room was being cleaned when I arrived.").', 3
from units where slug = 'unit-43';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-43'
join (values
  ('A', 'This room will be cleaned later.', null, 0),
  ('A', 'The situation is serious. Something must be done before it''s too late.', null, 1),
  ('A', 'A mystery is something that can''t be explained.', null, 2),
  ('A', 'The music was very loud and could be heard from a long way away.', null, 3),
  ('A', 'Please go away. I want to be left alone.', null, 4),
  ('B', 'The room should have been cleaned.', null, 0),
  ('B', 'I haven''t received the letter yet. It might have been sent to the wrong address.', null, 1),
  ('B', 'If you had locked the car, it wouldn''t have been stolen.', null, 2),
  ('B', 'There were some problems at first, but they seem to have been solved.', null, 3),
  ('C', 'The room looks nice. It has been cleaned.', null, 0),
  ('C', 'Have you ever been bitten by a dog?', null, 1),
  ('C', '''Are you going to the party?'' ''No, I haven''t been invited.''', null, 2),
  ('C', 'The vegetables didn''t taste good. They had been cooked too long.', null, 3),
  ('C', 'The car was three years old, but hadn''t been used very much.', null, 4),
  ('D', 'The room is being cleaned at the moment.', null, 0),
  ('D', 'There''s somebody walking behind us. I think we are being followed.', null, 1),
  ('D', 'A new bridge is being built across the river. It will be finished next year.', null, 2),
  ('D', 'The room was being cleaned when I arrived.', null, 3),
  ('D', 'There was somebody walking behind us. I think we were being followed.', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 43.1-43.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '43.1', 'Complete these sentences. Use the following verbs in the passive: arrest, carry, cause, delay, do, forget, keep, knock, know, make, repair, send. Sometimes you need have (might have, would have etc.).', 0
from units where slug = 'unit-43';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-43' where es.title = '43.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A decision will not {0} until the next meeting.', null),
  (2, 'These documents are important. They should always {0} in a safe place.', null),
  (3, 'This road is in bad condition. It should {0} a long time ago.', null),
  (4, 'The injured man couldn''t walk and had to {0}.', null),
  (5, 'If you hadn''t shouted at the policeman, you wouldn''t {0}.', null),
  (6, 'I''m not sure what time I''ll arrive tomorrow. I may {0}.', null),
  (7, 'It''s not certain how the fire started. It might {0} by an electrical fault.', null),
  (8, 'A new school is being built. The old one is going to {0} down.', null),
  (9, 'The election is next Sunday. The full results will {0} on Tuesday.', null),
  (10, 'Last week they weren''t speaking to one another. Now they''re happy again. The problem seems to {0}.', null)
) as v(n, template, hint)
where es.title = '43.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '43.1'
join (values
  (1, 0, 'be made'), (2, 0, 'be kept'), (3, 0, 'have been repaired'), (4, 0, 'be carried'),
  (5, 0, 'have been arrested'), (6, 0, 'be delayed'), (7, 0, 'have been caused'), (8, 0, 'be knocked'),
  (9, 0, 'be known'), (10, 0, 'have been forgotten')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '43.2', 'Make sentences from the words in brackets. Sometimes the verb is active, sometimes passive.', 1
from units where slug = 'unit-43';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-43' where es.title = '43.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My bike has disappeared. {0}', '(It / steal!)'),
  (2, 'My umbrella has disappeared. {0}', '(Somebody / take)'),
  (3, 'A neighbour of mine disappeared six months ago. {0}', '(He / not / see / since then)'),
  (4, 'I wonder how Jessica is these days. {0}', '(I / not / see / for ages)'),
  (5, 'A friend of mine was stung by a bee recently. {0}', '(you / ever / sting / bee?)'),
  (6, 'The bridge was damaged recently. {0}', '(It / repair / at the moment)'),
  (7, 'Tom''s car was stolen recently. {0}', '(It / not / find / yet)'),
  (8, 'I went into the room and saw that the table and chairs were not in the same place. {0}', '(The furniture / move)')
) as v(n, template, hint)
where es.title = '43.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '43.2'
join (values
  (1, 0, 'It''s been stolen!', array['It has been stolen!']::text[]),
  (2, 0, 'Somebody has taken it.', array['Somebody has taken my umbrella.']::text[]),
  (3, 0, 'He hasn''t been seen since then.', array[]::text[]),
  (4, 0, 'I haven''t seen her for ages.', array[]::text[]),
  (5, 0, 'Have you ever been stung by a bee?', array[]::text[]),
  (6, 0, 'It''s being repaired at the moment.', array['It is being repaired at the moment.']::text[]),
  (7, 0, 'It hasn''t been found yet.', array['It has not been found yet.']::text[]),
  (8, 0, 'The furniture had been moved.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '43.3', 'Instead of using somebody, they etc., write a passive sentence.', 2
from units where slug = 'unit-43';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-43' where es.title = '43.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'They are building a new road around the city. {0}', null),
  (2, 'They have built two new hotels near the airport. {0}', null),
  (3, 'When I last visited, they were building some new houses here. {0}', null),
  (4, 'The meeting is now on 15 April. They have changed the date. {0}', null),
  (5, 'I didn''t know that somebody was recording our conversation. {0}', null),
  (6, 'Is anyone doing anything about the problem? {0}', null),
  (7, 'The windows were very dirty. Nobody had cleaned them for ages. {0}', null)
) as v(n, template, hint)
where es.title = '43.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '43.3'
join (values
  (1, 0, 'A new road is being built around the city.', array[]::text[]),
  (2, 0, 'Two new hotels have been built near the airport.', array[]::text[]),
  (3, 0, 'When I last visited, some new houses were being built here.', array[]::text[]),
  (4, 0, 'The date of the meeting has been changed.', array[]::text[]),
  (5, 0, 'I didn''t know that our conversation was being recorded.', array[]::text[]),
  (6, 0, 'Is anything being done about the problem?', array[]::text[]),
  (7, 0, 'The windows hadn''t been cleaned for ages.', array['The windows had not been cleaned for ages.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 44: Passive 3
-- ============================================================

delete from units where slug = 'unit-44';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 44, 'unit-44', 'Passive 3', null,
  'Verbs with two objects (give, offer, pay, show, tell, ask) usually put the person first in the passive (I was given ...). being done/seen is the passive of doing/seeing. We say I was born (not I am born, except in general statements). get can replace be in informal spoken passives, but only for things that "happen".', 2
from modules where slug = 'passive';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'I was given ... / I was offered ... (verbs with two objects)',
  'Some verbs can have two objects (give, ask, offer, pay, show, tell): "My grandfather gave me this watch" can become "I was given this watch (by my grandfather)" or "This watch was given to me (by my grandfather)." In the passive we most often begin with the person: "I''ve been offered the job, but I don''t think I want it."', 0
from units where slug = 'unit-44';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'being done / being seen',
  'The passive of doing/seeing etc. is being done / being seen etc.: "I don''t like people telling me what to do" (active) becomes "I don''t like being told what to do" (passive). "Steve hates being kept waiting" (= he hates people keeping him waiting).', 1
from units where slug = 'unit-44';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'I was born ...',
  'We say "I was born ..." (not I am born): "I was born in Chicago." "Where were you born?" But for general statements we use the present: "How many babies are born every day?"', 2
from units where slug = 'unit-44';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'get instead of be',
  'You can use get for the passive, mainly in informal spoken English: "There was a fight, but nobody got hurt" (= nobody was hurt). We use get only when things happen — not for states: "Jessica is liked by everybody" (not gets liked). get married, get divorced, get dressed, get lost and get changed are common expressions that use get but aren''t passive in meaning.', 3
from units where slug = 'unit-44';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-44'
join (values
  ('A', 'My grandfather gave me this watch.', 'active, two objects', 0),
  ('A', 'I was given this watch (by my grandfather).', null, 1),
  ('A', 'This watch was given to me (by my grandfather).', null, 2),
  ('A', 'I''ve been offered the job, but I don''t think I want it.', '= somebody has offered me the job', 3),
  ('A', 'You will be given plenty of time to decide.', '= we will give you plenty of time', 4),
  ('A', 'I didn''t see the original document, but I was shown a copy.', '= somebody showed me a copy', 5),
  ('B', 'I don''t like being told what to do.', '= I don''t like people telling me what to do', 0),
  ('B', 'I remember being taken to the zoo when I was a child.', '= I remember somebody taking me to the zoo', 1),
  ('B', 'Steve hates being kept waiting.', '= he hates people keeping him waiting', 2),
  ('B', 'We climbed over the wall without being seen.', '= without anybody seeing us', 3),
  ('C', 'I was born in Chicago.', 'past', 0),
  ('C', 'Where were you born?', 'not Where are you born?', 1),
  ('C', 'How many babies are born every day?', 'present, general statement', 2),
  ('D', 'There was a fight, but nobody got hurt.', '= nobody was hurt', 0),
  ('D', 'I don''t get invited to many parties.', '= I''m not invited', 1),
  ('D', 'I''m surprised Liz didn''t get offered the job.', '= Liz wasn''t offered the job', 2),
  ('D', 'Jessica is liked by everybody.', 'not gets liked — this is not a "happening"', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 44.1-44.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '44.1', 'Complete the sentences using the correct form of the verb.', 0
from units where slug = 'unit-44';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-44' where es.title = '44.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Amy retired from her job recently. She {0} a present by her colleagues.', '(give)'),
  (2, 'I didn''t know there was a meeting yesterday. I {0} about it.', '(not / tell)'),
  (3, 'Sarah''s salary is very low. I don''t understand why she {0} so little.', '(pay)'),
  (4, 'You will need to use this machine. Have you {0} how it works?', '(show)'),
  (5, 'I had an interview for a job recently. It wasn''t easy. I {0} some questions that were very hard for me to answer.', '(ask)'),
  (6, 'They didn''t tell us much about the project. We {0} enough information.', '(not / give)'),
  (7, 'I was surprised to get the job I applied for. I didn''t expect {0} it.', '(offer)')
) as v(n, template, hint)
where es.title = '44.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '44.1'
join (values
  (1, 0, 'was given', array[]::text[]),
  (2, 0, 'wasn''t told', array['was not told']::text[]),
  (3, 0, 'is paid', array['''s paid']::text[]),
  (4, 0, 'been shown', array[]::text[]),
  (5, 0, 'was asked', array[]::text[]),
  (6, 0, 'weren''t given', array['were not given']::text[]),
  (7, 0, 'to be offered', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '44.2', 'Complete the sentences using being + the following verbs (in the correct form): bite, give, invite, keep, knock down, stick, treat.', 1
from units where slug = 'unit-44';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-44' where es.title = '44.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We went to the wedding without {0}.', null),
  (2, 'I like giving presents and I also like {0} them.', null),
  (3, 'It''s a busy road and I don''t like crossing it. I''m afraid of {0}.', null),
  (4, 'How do you avoid {0} by mosquitoes?', null),
  (5, 'I''m an adult. I don''t like {0} like a child.', null),
  (6, 'You can''t do anything about {0} in a traffic jam.', null)
) as v(n, template, hint)
where es.title = '44.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '44.2'
join (values
  (1, 0, 'being invited'), (2, 0, 'being given'), (3, 0, 'being knocked down'),
  (4, 0, 'being bitten'), (5, 0, 'being treated'), (6, 0, 'being stuck')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '44.3', 'Complete the sentences using get or got + the following verbs (in the correct form): ask, break, hurt, pay, steal, sting, stop, use.', 2
from units where slug = 'unit-44';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-44' where es.title = '44.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Alex {0} by a bee while he was sitting in the garden.', null),
  (2, 'These tennis courts don''t {0} very often. Not many people want to play here.', null),
  (3, 'I used to have a bike, but it {0} a few months ago.', null),
  (4, 'Rachel works hard, but she doesn''t {0} very much.', null),
  (5, 'Please pack these things very carefully. I don''t want anything to {0}.', null),
  (6, 'People often want to know what my job is. I {0} that question a lot.', null),
  (7, 'Last night I {0} by the police as I was driving home. One of the lights on my car wasn''t working.', null)
) as v(n, template, hint)
where es.title = '44.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '44.3'
join (values
  (1, 0, 'got stung'), (2, 0, 'get used'), (3, 0, 'got stolen'), (4, 0, 'get paid'),
  (5, 0, 'get broken'), (6, 0, 'get asked'), (7, 0, 'got stopped')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '44.4', 'Complete the sentences.', 3
from units where slug = 'unit-44';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-44' where es.title = '44.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Which year {0} you born in?', null),
  (2, 'I haven''t been {0} any information yet.', null),
  (3, 'I didn''t know the way, so I got {0}.', null),
  (4, 'He doesn''t like {0} interrupted when he''s speaking.', null),
  (5, 'How did the window {0} broken? What happened?', null),
  (6, 'She''s a voluntary worker. She {0} get paid.', null),
  (7, 'I {0} born in a small town in the north of the country.', null),
  (8, 'We had to do what we did. We {0} given any choice.', null)
) as v(n, template, hint)
where es.title = '44.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '44.4'
join (values
  (1, 0, 'were'), (2, 0, 'given'), (3, 0, 'lost'), (4, 0, 'being'),
  (5, 0, 'get'), (6, 0, 'doesn''t'), (7, 0, 'was'), (8, 0, 'weren''t')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 45: he is supposed to ...
-- ============================================================

delete from units where slug = 'unit-45';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 45, 'unit-45', 'he is supposed to ...', null,
  'It is said/believed/thought/reported etc. that ... can also be phrased as subject + is said/believed/thought to (be/have been) .... supposed to works the same way, and also has a separate meaning: what is intended, arranged, or expected — often different from what actually happens.', 3
from modules where slug = 'passive';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'It is said that ... / he is said to ...',
  '"It is said that he is 108 years old" and "He is said to be 108 years old" both mean "People say that he is 108 years old." Used with verbs like alleged, believed, considered, expected, known, reported, thought, understood — often in news reports: "It is reported that two people were injured" or "Two people are reported to have been injured."', 0
from units where slug = 'unit-45';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'supposed to ...',
  'supposed to ... can be used the same way as said to ...: "It''s supposed to be good" (= people say it''s good). It can also mean what is intended, arranged or expected — often different from the real situation: "You''re supposed to be on holiday" (= you arranged to be on holiday). "You''re not supposed to do something" = it is not allowed or advised.', 1
from units where slug = 'unit-45';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-45'
join (values
  ('A', 'It is said that he is 108 years old.', 'or He is said to be 108 years old', 0),
  ('A', 'It is believed that the boy is wearing a white sweater and blue jeans.', 'or The boy is believed to be wearing a white sweater and blue jeans', 1),
  ('A', 'The strike is expected to end soon.', null, 2),
  ('A', 'He is alleged to have stolen a car.', null, 3),
  ('A', 'There is said to be a secret tunnel between them.', null, 4),
  ('A', 'It is reported that two people were injured in the explosion.', 'or Two people are reported to have been injured in the explosion', 5),
  ('B', 'I want to see that film. It''s supposed to be good.', '= people say it''s good', 0),
  ('B', 'He''s supposed to have robbed a bank many years ago.', null, 1),
  ('B', 'Fireworks are supposed to have been invented in China. Is it true?', null, 2),
  ('B', 'The plan is supposed to be a secret, but everybody seems to know about it.', '= the plan is intended to be a secret', 3),
  ('B', 'What are you doing at work? You''re supposed to be on holiday.', '= you arranged to be on holiday', 4),
  ('B', 'You''re not supposed to park your car here. It''s private parking only.', '= it is not allowed', 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of George, a very old man, with a caption "It is said that he is 108 years old"]', 0
from units where slug = 'unit-45';

-- ------------------------------------------------------------
-- Exercises (main, book's own 45.1-45.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '45.1', 'Write these sentences in another way, beginning as shown.', 0
from units where slug = 'unit-45';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-45' where es.title = '45.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It is reported that many people are homeless after the floods. {0}', null),
  (2, 'It is thought that the thieves got in through a window in the roof. {0}', null),
  (3, 'It is alleged that the driver of the car was driving at 110 miles an hour. {0}', null),
  (4, 'It is reported that the building has been badly damaged by the fire. {0}', null),
  (5, 'It is said that the company is losing a lot of money. {0}', null),
  (6, 'It is believed that the company lost a lot of money last year. {0}', null),
  (7, 'It is expected that the company will make a loss this year. {0}', null)
) as v(n, template, hint)
where es.title = '45.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '45.1'
join (values
  (1, 0, 'Many people are reported to be homeless after the floods.', array[]::text[]),
  (2, 0, 'The thieves are thought to have got in through a window in the roof.', array[]::text[]),
  (3, 0, 'The driver of the car is alleged to have been driving at 110 miles an hour.', array['The driver of the car is alleged to have driven at 110 miles an hour.']::text[]),
  (4, 0, 'The building is reported to have been badly damaged by the fire.', array[]::text[]),
  (5, 0, 'The company is said to be losing a lot of money.', array[]::text[]),
  (6, 0, 'The company is believed to have lost a lot of money last year.', array[]::text[]),
  (7, 0, 'The company is expected to make a loss this year.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '45.2', 'Complete the sentences. Use the words in brackets and any other necessary words.', 1
from units where slug = 'unit-45';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-45' where es.title = '45.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: How much are these paintings worth? b: I''m not sure, but {0}', '(they / supposed)'),
  (2, 'a: This looks an interesting building. b: Yes, {0}', '(it / supposed)'),
  (3, 'a: Is it true that your neighbours were lucky in the lottery? b: Yes, {0}', '(they / supposed / win)'),
  (4, 'a: Is it possible to climb to the top of the tower? b: Yes, {0}', '(the view / supposed)'),
  (5, 'a: I heard that Laura has gone away. b: Yes, {0}', '(she / supposed / living)')
) as v(n, template, hint)
where es.title = '45.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '45.2'
join (values
  (1, 0, 'they''re supposed to be very valuable.', array['they are supposed to be very valuable.']::text[]),
  (2, 0, 'it''s supposed to have been a prison a long time ago.', array['it is supposed to have been a prison a long time ago.']::text[]),
  (3, 0, 'they''re supposed to have won a lot of money.', array['they are supposed to have won a lot of money.']::text[]),
  (4, 0, 'the view is supposed to be very nice.', array[]::text[]),
  (5, 0, 'she''s supposed to be living in London now.', array['she is supposed to be living in London now.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '45.3', 'Write sentences using supposed to be + the following: on a diet, a flower, my friend, a joke, open every day, a secret, working.', 2
from units where slug = 'unit-45';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-45' where es.title = '45.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You shouldn''t criticise me all the time. {0}', null),
  (2, 'I shouldn''t be eating this cake really. {0}', null),
  (3, 'I''m sorry for what I said. I was trying to be funny. {0}', null),
  (4, 'What''s this drawing? Is it a tree? {0}', null),
  (5, 'You shouldn''t be playing a game now. {0}', null),
  (6, 'That''s strange. The museum seems to be closed. {0}', null)
) as v(n, template, hint)
where es.title = '45.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '45.3'
join (values
  (1, 0, 'You''re supposed to be my friend.', array['You are supposed to be my friend.']::text[]),
  (2, 0, 'I''m supposed to be on a diet.', array['I am supposed to be on a diet.']::text[]),
  (3, 0, 'It was supposed to be a joke.', array[]::text[]),
  (4, 0, 'Or maybe it''s supposed to be a flower.', array['Or maybe it is supposed to be a flower.']::text[]),
  (5, 0, 'You''re supposed to be working.', array['You are supposed to be working.']::text[]),
  (6, 0, 'It''s supposed to be open every day.', array['It is supposed to be open every day.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '45.4', 'Write sentences with supposed to ... or not supposed to ... . Choose from the following verbs: depart, lift, park, phone, put, start.', 3
from units where slug = 'unit-45';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-45' where es.title = '45.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We {0} work at 8.15, but we rarely do anything before 8.30.', null),
  (2, 'I {0} Helen last night, but I completely forgot.', null),
  (3, 'This door is a fire exit. We {0} anything in front of it.', null),
  (4, 'My flight {0} at 10.15, but it didn''t leave until 11.30.', null),
  (5, 'Jonathan has a problem with his back. He {0} anything heavy.', null)
) as v(n, template, hint)
where es.title = '45.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '45.4'
join (values
  (1, 0, 'are supposed to start', array['''re supposed to start']::text[]),
  (2, 0, 'was supposed to phone', array[]::text[]),
  (3, 0, 'aren''t supposed to put', array['''re not supposed to put', 'are not supposed to put']::text[]),
  (4, 0, 'was supposed to depart', array[]::text[]),
  (5, 0, 'isn''t supposed to lift', array['''s not supposed to lift', 'is not supposed to lift']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 46: have something done
-- ============================================================

delete from units where slug = 'unit-46';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 46, 'unit-46', 'have something done', null,
  'have/get something done = arrange for somebody else to do something for you (Lisa had the roof repaired). have something done can also mean that something (often unwanted) happens to somebody or their belongings (Paul had his bags stolen).', 4
from modules where slug = 'passive';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'have something done = arrange for somebody else to do it',
  'If you have something done, you arrange for somebody to do it for you, rather than doing it yourself: "Lisa had the roof repaired" (= she arranged for somebody else to repair it, she didn''t repair it herself). Compare: "Lisa repaired the roof" (she did it herself).', 0
from units where slug = 'unit-46';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'word order: have + object + past participle',
  'The word order is have + object + past participle: "Lisa had the roof repaired." "Where did you have your hair cut?" We say How often do you have your car serviced? (not have serviced your car).', 1
from units where slug = 'unit-46';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'get something done',
  'You can say get something done instead of have something done, especially in informal English: "When are you going to get the roof repaired?" (= have the roof repaired).', 2
from units where slug = 'unit-46';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'have something done for things that happen to you',
  'We also use have something done with a different meaning, to say that something (often unwanted) happens to somebody or their belongings, without them arranging it: "Paul and Karen had their bags stolen while they were travelling" (= their bags were stolen, not that they arranged for it).', 3
from units where slug = 'unit-46';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-46'
join (values
  ('A', 'Lisa had the roof repaired.', '= she arranged for somebody else to repair it', 0),
  ('A', 'Lisa repaired the roof.', '= she repaired it herself', 1),
  ('A', 'Did you have those curtains made?', '= did somebody else make them for you', 2),
  ('B', 'Where did you have your hair cut?', null, 0),
  ('B', 'We are having that coat cleaned.', null, 1),
  ('B', 'How often do you have your car serviced?', 'not have serviced your car', 2),
  ('B', 'Our neighbour is having a garage built.', 'not having built a garage', 3),
  ('C', 'When are you going to get the roof repaired?', '= have the roof repaired', 0),
  ('C', 'I think you should get your hair cut really short.', null, 1),
  ('D', 'Paul and Karen had their bags stolen while they were travelling.', '= their bags were stolen, not that they arranged it', 0),
  ('D', 'Gary had his nose broken in a fight.', '= his nose was broken', 1),
  ('D', 'Have you ever had your bike stolen?', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Lisa watching a builder repair her roof, captioned "Lisa had the roof repaired yesterday" — she arranged for somebody else to do it, she didn''t repair it herself]', 0
from units where slug = 'unit-46';

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: four small scenes used in exercise 46.1 — (1) a hairdresser cutting Sarah''s hair, (2) Dan cutting his own hair at a mirror, (3) a painter painting Kate''s gate while she watches, (4) a photographer taking Sue''s picture — each pair the doing-it-yourself sentence against the having-it-done-by-somebody-else sentence]', 1
from units where slug = 'unit-46';

-- ------------------------------------------------------------
-- Exercises (main, book's own 46.1-46.5)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '46.1', 'Which is correct for each picture?', 0
from units where slug = 'unit-46';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-46' where es.title = '46.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Picture 1: a hairdresser is cutting Sarah''s hair. {0}', null),
  (2, 'Picture 2: Dan is standing at a mirror, cutting his own hair. {0}', null),
  (3, 'Picture 3: a painter is painting Kate''s gate while she watches. {0}', null),
  (4, 'Picture 4: a photographer is taking Sue''s picture. {0}', null)
) as v(n, template, hint)
where es.title = '46.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '46.1'
join (values
  (1, 0, 'Sarah is having her hair cut.'),
  (2, 0, 'Dan is cutting his hair.'),
  (3, 0, 'Kate is having the gate painted.'),
  (4, 0, 'Sue is having her picture taken.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '46.2', 'Put the words in the correct order.', 1
from units where slug = 'unit-46';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-46' where es.title = '46.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sarah {0}', '(serviced / car / once a year / has)'),
  (2, 'Have {0}', '(had / your / recently / tested / eyes / you)'),
  (3, 'I {0}', '(like / cut / my / having / don''t / hair)'),
  (4, 'It {0}', '(fifteen pounds / have / cleaned / my suit / cost / to)'),
  (5, 'You {0}', '(as soon as possible / need / translated / to get / this document)')
) as v(n, template, hint)
where es.title = '46.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '46.2'
join (values
  (1, 0, 'has her car serviced once a year.'),
  (2, 0, 'you had your eyes tested recently?'),
  (3, 0, 'don''t like having my hair cut.'),
  (4, 0, 'cost fifteen pounds to have my suit cleaned.'),
  (5, 0, 'need to get this document translated as soon as possible.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '46.3', 'Write sentences in the way shown.', 2
from units where slug = 'unit-46';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-46' where es.title = '46.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I didn''t cut my hair myself. {0}', null),
  (2, 'We didn''t clean the carpets ourselves. {0}', null),
  (3, 'Ben didn''t build that wall himself. {0}', null),
  (4, 'I didn''t deliver the flowers myself. {0}', null),
  (5, 'Sarah didn''t repair her shoes herself. {0}', null)
) as v(n, template, hint)
where es.title = '46.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '46.3'
join (values
  (1, 0, 'I had it cut.'), (2, 0, 'We had them cleaned.'), (3, 0, 'He had it built.'),
  (4, 0, 'I had them delivered.'), (5, 0, 'She had them repaired.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '46.4', 'Which goes with which? Combine the sentences.', 3
from units where slug = 'unit-46';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-46' where es.title = '46.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I really like this picture. {0}', null),
  (2, 'The washing machine is broken. {0}', null),
  (3, 'I want to wear earrings. {0}', null),
  (4, 'Can you recommend a dentist? {0}', null),
  (5, 'I''ve lost my key. {0}', null)
) as v(n, template, hint)
where es.title = '46.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '46.4'
join (values
  (1, 0, 'I''m going to get it framed.'),
  (2, 0, 'I need to get it fixed.'),
  (3, 0, 'I''m going to get my ears pierced.'),
  (4, 0, 'I need to get my teeth checked.'),
  (5, 0, 'I''ll have to get a new one made.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '46.5', 'Use the words in brackets to complete the sentences.', 4
from units where slug = 'unit-46';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-46' where es.title = '46.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Security at the airport was strict. {0}', '(We / our bags / search)'),
  (2, 'I''ve had some good news! {0}', '(I / my salary / increase)'),
  (3, 'Joe can''t get a visa. {0}', '(He / his application / refuse)')
) as v(n, template, hint)
where es.title = '46.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '46.5'
join (values
  (1, 0, 'We had our bags searched.', array[]::text[]),
  (2, 0, 'I''ve had my salary increased.', array['I had my salary increased.']::text[]),
  (3, 0, 'He''s had his application refused.', array['He had his application refused.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
