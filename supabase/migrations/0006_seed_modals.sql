-- Marco 4 (slice 4): seeds the "Modals" module — units 26-37 (can/could/(be)
-- able to, could (do) and could have (done), must and can't, may/might 1
-- and 2, have to and must, must/mustn't/needn't, should 1 and 2, I'd
-- better/it's time, would, and requests/offers/permission/invitations).
--
-- Sourced from pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`,
-- same workaround as previous modules — pdftoppm/poppler isn't available
-- locally) and cross-checked against pdf/Key to Exercises.pdf.
--
-- This single PDF actually spans units 26-41 across three book chapters:
-- Modals proper (26-34), a modal-adjacent group (35-37: I'd better/it's
-- time, would, requests/offers/permission), and Conditionals and wish
-- (38-41). Per Igor's decision, this migration covers only units 26-37 as
-- the "Modals" module; Conditionals and wish (38-41) is a separate
-- follow-up module. The 'modals' module row is created here.
--
-- Open-ended own-answer exercises (26.2, 36.1) are left out, same reasoning
-- as previous modules. Matching-format exercises (27.1, 32.1, 37.1) are
-- combined into single sentences, same approach as unit-6's 6.2.
--
-- Consolidated from supabase/seed/unit-26.sql .. unit-37.sql into a single
-- migration, same pattern as 0003-0005, so Supabase's GitHub-linked CI/CD
-- applies it automatically on push.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('modals', 'Modals', 3)
on conflict (slug) do nothing;

delete from units where slug = 'unit-26';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 26, 'unit-26', 'can, could and (be) able to', null,
  'can is used for possibility, permission and ability. could is the past of can, especially with see/hear/smell/taste/feel/remember/understand; for a specific past success, we normally use was/were able to or managed to instead.', 0
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'can: possibility, permission, ability',
  'We use can to say that something is possible or allowed, or that somebody has the ability to do something. The negative is can''t (= cannot).', 0
from units where slug = 'unit-26';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', '(be) able to instead of can',
  'can is more usual than (be) able to, but can only has two forms (can, could), so (be) able to is needed for other forms (future, perfect, after modals).', 1
from units where slug = 'unit-26';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'could as the past of can',
  'We use could especially with see, hear, smell, taste, feel, remember, understand, and also for general past ability or past permission.', 2
from units where slug = 'unit-26';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'could vs. was/were able to / managed to',
  'could is used for general ability in the past. To say somebody succeeded in a specific situation, we normally use was/were able to or managed to, not could. The negative couldn''t works in all situations.', 3
from units where slug = 'unit-26';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-26'
join (values
  ('A', 'We can see the lake from our hotel.', 'possibility', 0),
  ('A', 'Can you speak any foreign languages?', 'ability', 1),
  ('A', 'The word ''dream'' can be a noun or a verb.', 'possibility', 2),
  ('A', 'I''m afraid I can''t come to the party on Friday.', 'negative', 3),
  ('B', 'I haven''t been able to sleep recently.', 'no perfect form of can', 0),
  ('B', 'Tom might be able to come tomorrow.', 'after another modal', 1),
  ('B', 'Applicants for the job must be able to speak two foreign languages.', 'after another modal', 2),
  ('C', 'We had a lovely room in the hotel. We could see the lake.', 'could + see', 0),
  ('C', 'As soon as I walked into the room, I could smell gas.', 'could + smell', 1),
  ('C', 'My grandfather could speak five languages.', 'general past ability', 2),
  ('C', 'We were totally free. We could do what we wanted. (= we were allowed to)', 'past permission', 3),
  ('D', 'The fire spread quickly, but everybody was able to escape. (not could escape)', 'specific success', 0),
  ('D', 'I didn''t know where Max was, but I managed to find him in the end. (not could find)', 'specific success', 1),
  ('D', 'Jack was an excellent tennis player when he was younger. He could beat anybody. (general ability)', 'general ability', 2),
  ('D', 'Andy played well, but Jack managed to beat him. (= he succeeded this time)', 'specific success', 3),
  ('D', 'My grandfather couldn''t swim. I looked for Max everywhere, but I couldn''t find him.', 'couldn''t works everywhere', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 26.1, 26.3-26.5 — 26.2 skipped, open-ended)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '26.1', 'Complete the sentences using can or (be) able to. If can is not possible, use (be) able to.', 0
from units where slug = 'unit-26';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-26' where es.title = '26.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Nicole {0} drive, but she doesn''t have a car.', null),
  (2, 'I used to {0} stand on my head, but I can''t do it any more.', null),
  (3, 'I can''t understand Mark. I''ve never {0} understand him.', null),
  (4, 'I can''t see you on Friday, but I {0} meet you on Saturday morning.', null),
  (5, 'Ask Katherine about your problem. She might {0} help you.', null),
  (6, 'You have to be careful in this part of the city. It {0} be dangerous.', null),
  (7, 'Michael has lived in Italy a long time, so he should {0} speak Italian.', null)
) as v(n, template, hint)
where es.title = '26.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '26.1'
join (values
  (1, 0, 'can', array[]::text[]),
  (2, 0, 'be able to', array[]::text[]),
  (3, 0, 'been able to', array[]::text[]),
  (4, 0, 'can', array['will be able to']::text[]),
  (5, 0, 'be able to', array[]::text[]),
  (6, 0, 'can', array[]::text[]),
  (7, 0, 'be able to', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '26.3', 'Complete the sentences with can/can''t/could/couldn''t + the following: believe, come, hear, run, sleep, wait.', 1
from units where slug = 'unit-26';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-26' where es.title = '26.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When Dan was 16, he {0} 100 metres in 11 seconds.', null),
  (2, '''Are you in a hurry?'' ''No, I''ve got plenty of time. I {0}.''', null),
  (3, 'I don''t feel good this morning. I {0} last night.', null),
  (4, 'Can you speak a little louder? I {0} you very well.', null),
  (5, 'I was amazed when I heard the news. I {0} it.', null)
) as v(n, template, hint)
where es.title = '26.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '26.3'
join (values
  (1, 0, 'could run'), (2, 0, 'can wait'), (3, 0, 'couldn''t sleep'), (4, 0, 'can''t hear'), (5, 0, 'couldn''t believe')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '26.4', 'Complete the answers to the questions with was/were able to ... .', 2
from units where slug = 'unit-26';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-26' where es.title = '26.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Did you finish your work this afternoon? Yes, there was nobody to disturb me, so I {0}.', null),
  (2, 'Did you solve the problem? Yes, we did. It wasn''t easy, but we {0}.', null),
  (3, 'Did the thief get away? Yes. No-one realised what was happening and the thief {0}.', null)
) as v(n, template, hint)
where es.title = '26.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '26.4'
join (values
  (1, 0, 'was able to finish it'), (2, 0, 'were able to solve it'), (3, 0, 'was able to get away')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '26.5', 'Complete the sentences using could, couldn''t or managed to.', 3
from units where slug = 'unit-26';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-26' where es.title = '26.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Jessica had hurt her foot and {0} walk very well.', null),
  (2, 'There was a small fire in the kitchen, but fortunately I {0} put it out.', null),
  (3, 'The walls were thin and I {0} hear people talking in the next room.', null),
  (4, 'I ran my first marathon recently. It was very hard, but I {0} finish.', null),
  (5, 'My grandmother loved music. She {0} play the piano very well.', null),
  (6, 'We wanted to go to the concert, but we {0} get tickets.', null),
  (7, 'A girl fell into the river, but some people {0} pull her out. She''s all right now.', null)
) as v(n, template, hint)
where es.title = '26.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '26.5'
join (values
  (1, 0, 'couldn''t'), (2, 0, 'managed to'), (3, 0, 'could'), (4, 0, 'managed to'),
  (5, 0, 'could'), (6, 0, 'couldn''t'), (7, 0, 'managed to')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 27 (could (do) and could have (done)), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 27.1: matching format combined into single sentences, same
-- approach as unit-6's 6.2.
--
-- Safe to re-run: deletes unit-27 first (cascades) before re-inserting.

delete from units where slug = 'unit-27';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 27, 'unit-27', 'could (do) and could have (done)', null,
  'could is also used (not just as the past of can) for possible present/future actions, suggestions, and unrealistic actions. could have (done) talks about possibilities in the past that didn''t happen.', 1
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'could for suggestions now or in the future',
  'could is not always the past of can — we also use it for possible actions now or in the future, especially to make suggestions. can is also possible, but could is less sure.', 0
from units where slug = 'unit-27';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'could for unrealistic actions',
  'We use could (not can) for actions that are not realistic — an exaggeration or hypothetical, not something you''d actually do.', 1
from units where slug = 'unit-27';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'could for present/future possibility',
  'We also use could (not can) to say that something is possible now or in the future, as opposed to can for something true in general.', 2
from units where slug = 'unit-27';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'could have (done) — past possibility',
  'could have (done) talks about the past version of the same ideas: something was possible but didn''t happen.', 3
from units where slug = 'unit-27';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'couldn''t (do) / couldn''t have (done) = would not be/have been possible',
  'I couldn''t do something = it would not be possible (now, or generally). For the past, couldn''t have (done) = it would not have been possible.', 4
from units where slug = 'unit-27';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-27'
join (values
  ('A', '''What shall we do tonight?'' ''We could go to the cinema.''', 'suggestion', 0),
  ('A', 'When you go to Paris next month, you could stay with Sarah.', 'suggestion', 1),
  ('B', 'I''m so tired, I could sleep for a week. (not I can sleep for a week)', 'unrealistic', 0),
  ('B', 'This is a wonderful place. I could stay here for ever. (unrealistic)', 'unrealistic', 1),
  ('C', 'The story could be true, but I don''t think it is.', 'present possibility', 0),
  ('C', 'The weather is nice now, but it could change later.', 'present possibility, not general', 1),
  ('D', 'Why did you stay at a hotel? You could have stayed with me.', 'possible, didn''t happen', 0),
  ('D', 'David was lucky. He could have hurt himself when he fell, but he''s all right.', 'possible, didn''t happen', 1),
  ('E', 'I couldn''t live in a big city. I''d hate it. (= it wouldn''t be possible for me)', 'not possible', 0),
  ('E', 'We had a really good holiday. It couldn''t have been better.', 'past — not possible', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 27.1-27.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '27.1', 'Which goes with which? Combine the sentences.', 0
from units where slug = 'unit-27';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-27' where es.title = '27.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I need to phone Vicky sometime. {0}.', null),
  (2, 'What shall I get Ann for her birthday? {0}.', null),
  (3, 'Where shall we put this picture? {0}.', null),
  (4, 'What would you like to do at the weekend? {0}.', null),
  (5, 'I don''t know what to wear to the wedding. {0}.', null)
) as v(n, template, hint)
where es.title = '27.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '27.1'
join (values
  (1, 0, 'You could do it now'), (2, 0, 'You could give her a book'), (3, 0, 'We could hang it in the kitchen'),
  (4, 0, 'We could go away somewhere'), (5, 0, 'You could wear your brown suit')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '27.2', 'Put in can or could.', 1
from units where slug = 'unit-27';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-27' where es.title = '27.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m so angry with him. I {0} kill him!', null),
  (2, 'I {0} hear a strange noise. What is it?', null),
  (3, 'It''s so nice here. I {0} sit here all day but unfortunately I have to go.', null),
  (4, 'I {0} understand your point of view, but I don''t agree with you.', null),
  (5, 'Peter is a keen musician. He plays the flute and he {0} also play the piano.', null),
  (6, 'The company Amy works for isn''t doing well. She {0} lose her job.', null),
  (7, 'Some people are unlucky. Life {0} be very unfair.', null),
  (8, 'I''ve been really stupid. I {0} kick myself.', null),
  (9, 'Be careful climbing that tree. You {0} fall.', null)
) as v(n, template, hint)
where es.title = '27.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '27.2'
join (values
  (1, 0, 'could'), (2, 0, 'can'), (3, 0, 'could'), (4, 0, 'can'), (5, 0, 'can'),
  (6, 0, 'could'), (7, 0, 'can'), (8, 0, 'could'), (9, 0, 'could')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '27.3', 'Complete the sentences. Choose from: gone, could be, could come, could sleep, have moved, could have, could have come, could have been.', 2
from units where slug = 'unit-27';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-27' where es.title = '27.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I spent a very boring evening at home yesterday. Why did you stay at home? You {0} out with us.', null),
  (2, 'Shall I open this letter? Yes. It {0} important.', null),
  (3, 'How was your exam? Was it difficult? It wasn''t so bad. It {0} worse.', null),
  (4, 'I got very wet walking home in the rain. Why did you walk? You {0} taken a taxi.', null),
  (5, 'Where shall we meet tomorrow? Well, I {0} to your office if you like.', null),
  (6, 'Does Tom still live in the same place? I''m not sure. He could {0}.', null),
  (7, 'Did you go to university? No. I could have {0}, but I didn''t want to.', null)
) as v(n, template, hint)
where es.title = '27.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '27.3'
join (values
  (1, 0, 'could have come'), (2, 0, 'could be'), (3, 0, 'could have been'), (4, 0, 'could have'),
  (5, 0, 'could come'), (6, 0, 'have moved'), (7, 0, 'gone')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '27.4', 'Complete the sentences. Use couldn''t or couldn''t have + these verbs: afford, be, be, live, manage, stand, study, wear.', 3
from units where slug = 'unit-27';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-27' where es.title = '27.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I {0} that hat. People would laugh at me.', null),
  (2, 'You helped me a lot. I {0} without you.', null),
  (3, 'The staff at the hotel were really good. They {0} more helpful.', null),
  (4, 'There''s no way we could buy a car now. We {0} it.', null),
  (5, 'Jack prepared for the exam as well as he could. He {0} harder.', null),
  (6, 'I wouldn''t like to live near the motorway. I {0} the noise of the traffic.', null)
) as v(n, template, hint)
where es.title = '27.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '27.4'
join (values
  (1, 0, 'couldn''t wear', array[]::text[]),
  (2, 0, 'couldn''t have managed', array[]::text[]),
  (3, 0, 'couldn''t have been', array[]::text[]),
  (4, 0, 'couldn''t afford', array['couldn''t manage']::text[]),
  (5, 0, 'couldn''t have studied', array[]::text[]),
  (6, 0, 'couldn''t stand', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 28 (must and can't), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-28 first (cascades) before re-inserting.

delete from units where slug = 'unit-28';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 28, 'unit-28', 'must and can''t', null,
  'We use must to say we believe something is certain, and can''t to say we believe something is not possible. For the past, we use must have and can''t have (or couldn''t have).', 2
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'must (certain) and can''t (not possible)',
  'We use must to say that we believe something is certain, based on evidence or reasoning. We use can''t to say we believe something is not possible.', 0
from units where slug = 'unit-28';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'must have / can''t have for the past',
  'For the past we use must have (done) and can''t have (done) — or couldn''t have, which means the same as can''t have.', 1
from units where slug = 'unit-28';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-28'
join (values
  ('A', 'You''ve been travelling all day. You must be tired.', 'certain', 0),
  ('A', '''Joe is a hard worker.'' ''Joe? You must be joking. He doesn''t do anything.''', 'certain', 1),
  ('A', 'You''ve just had lunch. You can''t be hungry already.', 'not possible', 2),
  ('A', 'They haven''t lived here for very long. They can''t know many people.', 'not possible', 3),
  ('B', 'There''s nobody at home. They must have gone out.', 'past — certain', 0),
  ('B', 'I lost one of my gloves. I must have dropped it somewhere.', 'past — certain', 1),
  ('B', 'Sarah hasn''t contacted me. She can''t have got my message.', 'past — not possible', 2),
  ('B', 'Max walked into a wall. He can''t have been looking where he was going.', 'past — not possible', 3),
  ('B', 'You can use couldn''t have instead of can''t have: Sarah couldn''t have got my message.', 'couldn''t have = can''t have', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 28.1-28.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '28.1', 'Put in must or can''t.', 0
from units where slug = 'unit-28';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-28' where es.title = '28.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'That restaurant {0} be very good. It''s always full of people.', null),
  (2, 'That restaurant {0} be very good. It''s always empty.', null),
  (3, 'I''m sure Kate gave me her address. I {0} have it somewhere.', null),
  (4, 'I often see that man in this street. He {0} live near here.', null),
  (5, 'It rained every day during their holiday. It {0} have been very nice for them.', null),
  (6, 'Congratulations on passing your exam. You {0} be very pleased.', null),
  (7, 'This bill {0} be correct. It''s much too high.', null),
  (8, 'You got here very quickly. You {0} have driven very fast.', null),
  (9, 'Bill and Sue always stay at five-star hotels. They {0} be short of money.', null),
  (10, 'Karen hasn''t left the office yet. She {0} be working late tonight.', null)
) as v(n, template, hint)
where es.title = '28.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '28.1'
join (values
  (1, 0, 'must'), (2, 0, 'can''t'), (3, 0, 'must'), (4, 0, 'must'), (5, 0, 'can''t'),
  (6, 0, 'must'), (7, 0, 'can''t'), (8, 0, 'must'), (9, 0, 'can''t'), (10, 0, 'must')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '28.2', 'Complete each sentence with a verb (one or two words).', 1
from units where slug = 'unit-28';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-28' where es.title = '28.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''ve lived in this village a long time. You must {0} everybody who lives here.', null),
  (2, 'I don''t seem to have my wallet with me. I must {0} it at home.', null),
  (3, '''How old is Ed?'' ''He''s older than me. He must {0} at least 40.''', null),
  (4, 'I didn''t hear my phone. I must {0} asleep.', null),
  (5, '''You''re going on holiday soon. You must {0} forward to it.'' ''Yes, I am.''', null),
  (6, 'I''m sure you know this song. You must {0} it before.', null),
  (7, 'The road is closed, so we have to go another way. There must {0} an accident.', null),
  (8, '''Do you have a car?'' ''You must {0}! How could I afford to have a car?''', null),
  (9, 'David is the managing director of a large company, so he must {0} quite a high salary.', null)
) as v(n, template, hint)
where es.title = '28.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '28.2'
join (values
  (1, 0, 'know', array[]::text[]),
  (2, 0, 'have left', array[]::text[]),
  (3, 0, 'be', array[]::text[]),
  (4, 0, 'have been', array[]::text[]),
  (5, 0, 'be looking', array[]::text[]),
  (6, 0, 'have heard', array[]::text[]),
  (7, 0, 'have been', array[]::text[]),
  (8, 0, 'be joking', array[]::text[]),
  (9, 0, 'get', array['be getting', 'have']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '28.3', 'Use the words in brackets to write sentences with must have and can''t have.', 2
from units where slug = 'unit-28';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-28' where es.title = '28.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The jacket you bought is very good quality. {0}.', 'it / be / very expensive'),
  (2, 'I haven''t seen our neighbours for the last few days. {0}.', 'they / go away'),
  (3, 'I can''t find my umbrella. {0}.', 'I / leave / it in the restaurant last night'),
  (4, 'Amy was in a very difficult situation when she lost her job. {0}.', 'it / be / easy for her'),
  (5, 'There was a man standing outside the cafe. He was there a long time. {0}.', 'he / wait / for somebody'),
  (6, 'Rachel did the opposite of what I asked her to do. {0}.', 'she / understand / what I said'),
  (7, 'When I got back to my car, it was unlocked. {0}.', 'I / forget / to lock it'),
  (8, 'My neighbours were making a lot of noise in the night. It woke me up. {0}.', 'they / have / a party'),
  (9, 'The light was red, but the car didn''t stop. {0}.', 'the driver / see / the red light'),
  (10, 'Paul has had these shoes for years, but they still look new. {0}.', 'he / wear / them much')
) as v(n, template, hint)
where es.title = '28.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '28.3'
join (values
  (1, 0, 'It must have been very expensive', array[]::text[]),
  (2, 0, 'They must have gone away', array[]::text[]),
  (3, 0, 'I must have left it in the restaurant last night', array[]::text[]),
  (4, 0, 'It can''t have been easy for her', array[]::text[]),
  (5, 0, 'He must have been waiting for somebody', array[]::text[]),
  (6, 0, 'She can''t have understood what I said', array['She couldn''t have understood what I said']::text[]),
  (7, 0, 'I must have forgotten to lock it', array[]::text[]),
  (8, 0, 'They must have been having a party', array[]::text[]),
  (9, 0, 'The driver can''t have seen the red light', array['The driver couldn''t have seen the red light']::text[]),
  (10, 0, 'He can''t have worn them much', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 29 (may and might 1), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-29 first (cascades) before re-inserting.

delete from units where slug = 'unit-29';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 29, 'unit-29', 'may and might 1', null,
  'We use may or might to say that something is possible. For the past, we use may have (done) or might have (done).', 3
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'may/might for present possibility',
  'We use may or might to say that something is possible — either can be used, with no real difference in meaning. The negatives are may not and might not.', 0
from units where slug = 'unit-29';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'may have / might have for the past',
  'For the past we use may have (done) or might have (done) to say that something was possibly true.', 1
from units where slug = 'unit-29';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'could is similar, but couldn''t is different',
  'could is similar to may/might for possibility. But couldn''t (negative) means something different from may not/might not — couldn''t have means it''s not possible that something happened.', 2
from units where slug = 'unit-29';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-29'
join (values
  ('A', 'He may be in his office. (= perhaps he is in his office)', 'possible now', 0),
  ('A', 'He might be having lunch.', 'possible now', 1),
  ('A', 'Ask Kate. She might know.', 'possible now', 2),
  ('A', 'Note the difference between may be (2 words) and maybe (1 word): It may be true. / ''Is it true?'' ''Maybe.''', 'may be vs. maybe', 3),
  ('B', 'She may have been asleep. (= perhaps she was asleep)', 'past possibility', 0),
  ('B', 'You might have left it at work. (= perhaps you left it at work)', 'past possibility', 1),
  ('B', 'She might not have known about it. (= perhaps she didn''t know)', 'past possibility, negative', 2),
  ('C', 'It''s a strange story, but it could be true.', 'could = possible', 0),
  ('C', 'Sarah couldn''t have received my message. Otherwise she would have replied. (= it''s not possible that she got it)', 'couldn''t = not possible', 1),
  ('C', 'I suppose she might not have received it. (= it''s possible she didn''t — perhaps she did, perhaps not)', 'might not ≠ couldn''t', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 29.1-29.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '29.1', 'Complete the sentences. Choose from: may be Tom''s, may not be feeling well, may not be possible, might be in her room, might be Brazilian, might be driving, might have one, might know.', 0
from units where slug = 'unit-29';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-29' where es.title = '29.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Is there a bookshop near here? I''m not sure, but ask Anna. She {0}.', null),
  (2, 'Where are those people from? I don''t know. They {0}.', null),
  (3, 'I hope you can help me. I''ll try, but it {0}.', null),
  (4, 'Whose phone is this? It''s not mine. It {0}.', null),
  (5, 'Why doesn''t George answer his phone? He {0}.', null),
  (6, 'Do you know anyone who has a key to this cupboard? Rachel {0}, but I''m not sure.', null),
  (7, 'Gary is in a strange mood today. Yes, he is. He {0}.', null)
) as v(n, template, hint)
where es.title = '29.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '29.1'
join (values
  (1, 0, 'might know'), (2, 0, 'might be Brazilian'), (3, 0, 'may not be possible'), (4, 0, 'may be Tom''s'),
  (5, 0, 'might be driving'), (6, 0, 'might have one'), (7, 0, 'may not be feeling well')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '29.2', 'Complete each sentence using the verb in brackets.', 1
from units where slug = 'unit-29';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-29' where es.title = '29.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Who was the guy we saw with Anna yesterday? I''m not sure. It may {0} her brother.', 'be'),
  (2, 'Is Ellie here? I can''t see her. She may not {0} yet.', 'arrive'),
  (3, 'Gary said he would meet us in the cafe, but he isn''t here. He might {0} outside. I''ll go and look.', 'wait'),
  (4, 'How did John know that I''d lost my job? I don''t know. I suppose Sam may {0} him.', 'tell'),
  (5, 'Do you know where Jeff is? Is he still in the office? He was here earlier, but he might {0} home.', 'go'),
  (6, 'Where''s Emma? What''s she doing? I''m not sure. She might {0} TV.', 'watch'),
  (7, 'Does Max have any brothers or sisters? I''m not sure. I think he may {0} a younger sister.', 'have'),
  (8, 'I can''t find my umbrella. Have you seen it? You may {0} it in the restaurant last night.', 'leave'),
  (9, 'I rang Dan''s doorbell, but he didn''t answer. I''m sure he was there. He might not {0} the doorbell.', 'hear'),
  (10, 'Hannah is supposed to meet us here, and she''s already 20 minutes late. She may {0}. She''s always forgetting things.', 'forget')
) as v(n, template, hint)
where es.title = '29.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '29.2'
join (values
  (1, 0, 'have been'), (2, 0, 'have arrived'), (3, 0, 'be waiting'), (4, 0, 'have told'), (5, 0, 'have gone'),
  (6, 0, 'be watching'), (7, 0, 'have'), (8, 0, 'have left'), (9, 0, 'have heard'), (10, 0, 'have forgotten')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '29.3', 'Complete the sentences using might not have ... or couldn''t have ... .', 2
from units where slug = 'unit-29';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-29' where es.title = '29.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wonder why Tom didn''t come to the party. Perhaps he didn''t want to come. It''s possible. He {0} to come.', null),
  (2, 'I wonder how the fire started. Was it an accident? No, the police say it {0} an accident. It was deliberate.', null),
  (3, 'Mike says he needs to see you. He tried to find you yesterday. Well, he {0} very hard. I was in my office all day.', null),
  (4, 'The man you spoke to — are you sure he was American? No, I''m not sure. He {0}.', null)
) as v(n, template, hint)
where es.title = '29.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '29.3'
join (values
  (1, 0, 'might not have wanted'), (2, 0, 'couldn''t have been'), (3, 0, 'couldn''t have tried'), (4, 0, 'might not have been American')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 30 (may and might 2), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-30 first (cascades) before re-inserting.

delete from units where slug = 'unit-30';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 30, 'unit-30', 'may and might 2', null,
  'We use may and might to talk about possible future actions. We usually use might (not may) when the situation is unreal. might as well = there''s no better alternative, so let''s do it.', 4
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'may/might for possible future actions',
  'We use may and might to talk about possible actions or happenings in the future. The negative forms are may not and might not (mightn''t).', 0
from units where slug = 'unit-30';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Usually either may or might, but might for unreal situations',
  'Usually you can use either may or might with no difference in meaning. But we use might (not may) when the situation is not real — for example after an unreal if-clause.', 1
from units where slug = 'unit-30';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'may/might be -ing vs. will be -ing',
  'may/might be -ing is like will be -ing, but less certain — and we also use it for possible plans, as opposed to a definite plan (going to).', 2
from units where slug = 'unit-30';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'might as well',
  'We might as well do something = we should do it because there is no better alternative and no reason not to. You can also say may as well.', 3
from units where slug = 'unit-30';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-30'
join (values
  ('A', 'I haven''t decided where to go on holiday. I may go to Ireland.', 'possible future', 0),
  ('A', 'Take an umbrella with you. It might rain later.', 'possible future', 1),
  ('A', 'I''m going to buy a car. (for sure) I may buy a car. or I might buy a car. (possible)', 'for sure vs. possible', 2),
  ('B', 'If they paid me better, I might work harder. (not I may work)', 'unreal situation', 0),
  ('C', 'Don''t phone at 8.30. I''ll be watching the football on TV. / I might be watching the football on TV. (less sure)', 'less sure than will', 0),
  ('C', 'I''m going to Ireland soon. (for sure) I might be going (or I may be going) to Ireland soon. (possible)', 'possible plan', 1),
  ('D', 'We might as well do something = we should do it because there is no better alternative.', 'no better alternative', 0),
  ('D', 'Buses are so expensive these days, you might as well get a taxi.', 'no better alternative', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 30.1-30.5)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '30.1', 'Which alternative makes sense?', 0
from units where slug = 'unit-30';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-30' where es.title = '30.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Have you decided what sort of car you want to buy? Yes, {0} a sports car.', 'I might get / I''m going to get'),
  (2, 'When is Tom coming to see us? He hasn''t said yet. {0} on Sunday.', 'He might come / He''s coming'),
  (3, 'Where are you going to put that picture? I don''t know yet. {0} it in the bedroom.', 'I might hang / I''m going to hang'),
  (4, 'What''s Tanya going to do when she leaves school? Does she know yet? Yes, she''s decided. {0} to university.', 'She might go / She''s going'),
  (5, 'Do you have plans for the weekend? Nothing fixed. {0} away.', 'I might go / I''m going')
) as v(n, template, hint)
where es.title = '30.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '30.1'
join (values
  (1, 0, 'I''m going to get'), (2, 0, 'He might come'), (3, 0, 'I might hang'), (4, 0, 'She''s going'), (5, 0, 'I might go')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '30.2', 'Complete the sentences using might + a verb from the box: hear, need, rain, slip, spill, wake.', 1
from units where slug = 'unit-30';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-30' where es.title = '30.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Don''t make too much noise. You {0} the baby.', null),
  (2, 'Be careful with your coffee. You {0} it.', null),
  (3, 'Don''t forget your phone. You {0} it.', null),
  (4, 'It''s better if we don''t talk so loud. Somebody {0} us.', null),
  (5, 'Be careful. This footpath is icy. You {0}.', null)
) as v(n, template, hint)
where es.title = '30.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '30.2'
join (values
  (1, 0, 'might wake'), (2, 0, 'might spill'), (3, 0, 'might need'), (4, 0, 'might hear'), (5, 0, 'might slip')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '30.3', 'Complete the sentences. Use might be able to or might have to + one of these verbs: fix, help, leave, meet, pay, wait.', 2
from units where slug = 'unit-30';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-30' where es.title = '30.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can come to the meeting, but I {0} before the end.', null),
  (2, 'I''m not free this evening, but I {0} you tomorrow evening.', null),
  (3, 'I''m not sure whether this car park is free or not. We {0}.', null),
  (4, 'There''s a long queue. We {0} a long time.', null),
  (5, '''I''ve got a problem with my bike.'' ''Let me have a look. I {0} it.''', null)
) as v(n, template, hint)
where es.title = '30.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '30.3'
join (values
  (1, 0, 'might have to leave'), (2, 0, 'might be able to meet'), (3, 0, 'might have to pay'),
  (4, 0, 'might have to wait'), (5, 0, 'might be able to fix')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '30.4', 'Write sentences with might not.', 3
from units where slug = 'unit-30';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-30' where es.title = '30.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I haven''t seen him for a long time. I don''t know if I will recognise him or not. {0}.', null),
  (2, 'We want to go to the game, but I don''t know whether we''ll be able to get tickets. {0}.', null),
  (3, 'I said I''d do the shopping, but it''s possible I won''t have time. {0}.', null),
  (4, 'I''ve been invited to the wedding, but I''m not sure that I''ll be able to go. {0}.', null)
) as v(n, template, hint)
where es.title = '30.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '30.4'
join (values
  (1, 0, 'I might not recognise him'), (2, 0, 'We might not be able to get tickets for the game'),
  (3, 0, 'I might not have time to do the shopping'), (4, 0, 'I might not be able to go to the wedding')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '30.5', 'Read the situations and write sentences with might as well.', 4
from units where slug = 'unit-30';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-30' where es.title = '30.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Your computer doesn''t work any more. It will cost a lot to repair. You say: It''s not worth repairing. {0} a new one.', null),
  (2, 'You''ve painted the kitchen. You still have a lot of paint, so why not paint the bathroom too. You say: {0} too. There''s plenty of paint left.', null),
  (3, 'You and a friend are at home. You''re bored. There''s a film on TV starting in a few minutes. You say: {0} it. There''s nothing else to do.', null)
) as v(n, template, hint)
where es.title = '30.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '30.5'
join (values
  (1, 0, 'I might as well buy'), (2, 0, 'I might as well paint the bathroom'), (3, 0, 'We might as well watch')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 31 (have to and must), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-31 first (cascades) before re-inserting.

delete from units where slug = 'unit-31';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 31, 'unit-31', 'have to and must', null,
  'have to and must both express obligation. have to is used for facts and in questions/negatives (do/does/did); must is used for the speaker''s own opinion or recommendation, and in written rules. mustn''t and don''t have to are opposites, not synonyms.', 5
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'have to = it is necessary',
  'I have to do something = it is necessary, I am obliged to. We use do/does/did in questions and negative sentences.', 0
from units where slug = 'unit-31';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'must (opinion) vs. have to (fact)',
  'must and have to are similar, but we use must for the speaker''s own opinion (what I think is necessary, or a recommendation), and have to for an obligation that''s a fact, not an opinion. We use must in written rules, and had to (not must) for the past.', 1
from units where slug = 'unit-31';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'mustn''t vs. don''t have to',
  'These are completely different. You mustn''t do something = don''t do it. You don''t have to do something = it isn''t necessary, but you can if you want.', 2
from units where slug = 'unit-31';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'have got to',
  'You can use have got to instead of have to, with the same meaning.', 3
from units where slug = 'unit-31';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-31'
join (values
  ('A', 'You can''t turn right here. You have to turn left.', 'necessity', 0),
  ('A', 'What do I have to do to get a new driving licence? (not What have I to do?)', 'question with do', 1),
  ('A', 'Karen doesn''t have to work Saturdays. (not Karen hasn''t to)', 'negative with do', 2),
  ('B', 'I haven''t spoken to Sue for ages. I must phone her. / I have to phone her. (= I say this is necessary)', 'opinion', 0),
  ('B', 'I have to work from 8.30 to 5.30 every day. (a fact, not an opinion)', 'fact', 1),
  ('B', 'Applications for the job must be received by 18 May. (written rule)', 'written rule', 2),
  ('B', 'I went to the meeting yesterday, but I had to leave early. (not I must)', 'past — had to', 3),
  ('C', 'You must keep this a secret. You mustn''t tell anyone. (= don''t tell anyone)', 'mustn''t = don''t', 0),
  ('C', 'You don''t have to come with me. I can go alone.', 'don''t have to = not necessary', 1),
  ('D', 'I''ve got to work tomorrow. or I have to work tomorrow.', 'have got to = have to', 0)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 31.1-31.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '31.1', 'Complete the sentences using have/has/had to ... . Use the verbs in brackets.', 0
from units where slug = 'unit-31';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-31' where es.title = '31.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t have much time. {0} in ten minutes.', 'I / go'),
  (2, '''I''m afraid I can''t stay long.'' ''What time {0}?''', 'you / go'),
  (3, 'Joe starts work at 5 am every day, which means {0} at four.', 'he / get up'),
  (4, 'We nearly missed the bus this morning. {0} to catch it.', 'we / run'),
  (5, 'Is Lisa usually free on Saturdays or {0}?', 'she / work'),
  (6, 'There was nobody to help me. {0} everything by myself.', 'I / do'),
  (7, 'How old {0} to have a driving licence?', 'you / be'),
  (8, 'There was a lot of noise from the street. {0} the window.', 'we / close'),
  (9, 'Was the exhibition free, or {0} to go in?', 'you / pay')
) as v(n, template, hint)
where es.title = '31.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '31.1'
join (values
  (1, 0, 'I have to go', array['I''ll have to go']::text[]),
  (2, 0, 'do you have to go', array['will you have to go']::text[]),
  (3, 0, 'he has to get up', array[]::text[]),
  (4, 0, 'We had to run', array[]::text[]),
  (5, 0, 'does she have to work', array[]::text[]),
  (6, 0, 'I had to do', array[]::text[]),
  (7, 0, 'do you have to be', array[]::text[]),
  (8, 0, 'We had to close', array[]::text[]),
  (9, 0, 'did you have to pay', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '31.2', 'Complete the sentences using have/has/had to + the verbs in the list. Some sentences are negative: ask, decide, drive, get up, go, make, make, pay, show, stand.', 1
from units where slug = 'unit-31';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-31' where es.title = '31.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Excuse me a moment — I {0} a phone call. I won''t be long.', null),
  (2, 'You can let me know later what you want to do. You {0} now.', null),
  (3, 'I couldn''t find the street I wanted. I {0} somebody for directions.', null),
  (4, 'This car park is free. You {0}.', null),
  (5, 'A man was slightly injured in the accident, but he {0} to hospital.', null),
  (6, 'Jane has a senior position in the company. She {0} important decisions.', null),
  (7, 'The train was very full and there were no seats free. We {0} all the way.', null),
  (8, 'When Patrick starts his new job next month, he {0} 50 miles to work every day.', null)
) as v(n, template, hint)
where es.title = '31.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '31.2'
join (values
  (1, 0, 'have to make', array[]::text[]),
  (2, 0, 'don''t have to decide', array[]::text[]),
  (3, 0, 'had to ask', array[]::text[]),
  (4, 0, 'don''t have to pay', array[]::text[]),
  (5, 0, 'didn''t have to go', array[]::text[]),
  (6, 0, 'has to make', array[]::text[]),
  (7, 0, 'had to stand', array[]::text[]),
  (8, 0, 'will have to drive', array['''ll have to drive', 'is going to have to drive']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '31.3', 'In some of these sentences, must is wrong or unnatural. Correct them where necessary.', 2
from units where slug = 'unit-31';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-31' where es.title = '31.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} start work every day at 8.30.', null),
  (2, '{0} remember to call Sarah tomorrow.', null),
  (3, 'I couldn''t get a taxi last night. {0} walk home.', null),
  (4, '{0} come and see us again soon.', null),
  (5, 'Tom isn''t going out this evening. {0} study for his exam.', null),
  (6, 'We can''t go the usual way because the road is closed. {0} go another way.', null),
  (7, 'Julia wears glasses. {0} wear glasses since she was very young.', null)
) as v(n, template, hint)
where es.title = '31.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '31.3'
join (values
  (1, 0, 'I have to', array[]::text[]),
  (2, 0, 'I must', array['I have to']::text[]),
  (3, 0, 'I had to', array[]::text[]),
  (4, 0, 'You must', array['You have to']::text[]),
  (5, 0, 'He has to', array[]::text[]),
  (6, 0, 'We have to', array[]::text[]),
  (7, 0, 'She has had to', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '31.4', 'Complete the sentences with mustn''t, don''t have to or doesn''t have to.', 3
from units where slug = 'unit-31';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-31' where es.title = '31.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There''s a lift in the building, so we {0} climb the stairs.', null),
  (2, 'I promised Kate I''d call her tomorrow. I {0} forget.', null),
  (3, 'I''m not very busy. I have a few things to do, but I {0} do them now.', null),
  (4, 'Sophie likes weekends because she {0} get up early.', null),
  (5, 'You {0} be a good player to enjoy a game of tennis.', null),
  (6, 'You should keep trying to find a job. You {0} give up.', null),
  (7, 'I {0} eat too much. I''m supposed to be on a diet.', null),
  (8, 'We have plenty of time before our flight. We {0} check in yet.', null)
) as v(n, template, hint)
where es.title = '31.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '31.4'
join (values
  (1, 0, 'don''t have to'), (2, 0, 'mustn''t'), (3, 0, 'don''t have to'), (4, 0, 'doesn''t have to'),
  (5, 0, 'don''t have to'), (6, 0, 'mustn''t'), (7, 0, 'mustn''t'), (8, 0, 'don''t have to')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 32 (must, mustn't, needn't), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 32.1: matching format combined into single sentences, same
-- approach as unit-6's 6.2.
--
-- Safe to re-run: deletes unit-32 first (cascades) before re-inserting.

delete from units where slug = 'unit-32';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 32, 'unit-32', 'must, mustn''t, needn''t', null,
  'must = necessary; mustn''t = don''t do it; needn''t = not necessary (but you can if you want). needn''t have (done) means you did it, but now know it wasn''t necessary.', 6
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'must and mustn''t',
  'You must do something = it is necessary that you do it. You mustn''t do something = don''t do it.', 0
from units where slug = 'unit-32';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'needn''t and don''t need to',
  'You needn''t do something = it''s not necessary (but you can if you want). You can also use don''t/doesn''t need to. Note the pattern: "don''t need to do" but "needn''t do" (no to).', 1
from units where slug = 'unit-32';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'needn''t have (done)',
  'needn''t have (done) means somebody did something, but now we know it wasn''t necessary. Compare with needn''t (do): a present/future warning of unnecessity, vs. a fact realised after the event.', 2
from units where slug = 'unit-32';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'needn''t have (done) vs. didn''t need to (do)',
  'He needn''t have done something = he did it, but it turned out to be unnecessary. He didn''t need to do something = it wasn''t necessary — it doesn''t tell us whether he did it or not.', 3
from units where slug = 'unit-32';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-32'
join (values
  ('A', 'Don''t tell anybody what I said. You must keep it a secret.', 'necessary', 0),
  ('A', 'We must be very quiet. We mustn''t make any noise.', 'don''t do it', 1),
  ('B', 'We have plenty of time. We needn''t hurry. (= it is not necessary to hurry)', 'not necessary', 0),
  ('B', 'Joe can stay here. He needn''t come with us.', 'not necessary', 1),
  ('B', 'You needn''t tell Steve. I can tell him myself. (compare: not necessary)', 'needn''t ≠ mustn''t', 2),
  ('B', 'You mustn''t tell Steve. I don''t want him to know. (compare: don''t do it)', 'needn''t ≠ mustn''t', 3),
  ('C', 'Paul and Sarah reserved a table, but the restaurant was almost empty. They needn''t have reserved a table.', 'unnecessary, but done', 0),
  ('C', 'Everything will be OK. You needn''t worry. / Everything was OK. You needn''t have worried.', 'present vs. past', 1),
  ('D', 'He needn''t have got up so early. He could have stayed in bed longer.', 'did it, turned out unnecessary', 0),
  ('D', 'He didn''t need to get up early, so he didn''t.', 'wasn''t necessary, didn''t do it', 1),
  ('D', 'He didn''t need to get up early, but it was a beautiful morning, so he did.', 'wasn''t necessary, did it anyway', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 32.1-32.5)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '32.1', 'Which goes with which? Find the sentences with a similar meaning.', 0
from units where slug = 'unit-32';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-32' where es.title = '32.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You must remember your password. {0}.', null),
  (2, 'You must be brave. {0}.', null),
  (3, 'You must be on time. {0}.', null),
  (4, 'You must leave the furniture as it is. {0}.', null),
  (5, 'You must go away. {0}.', null),
  (6, 'You must forget what happened. {0}.', null)
) as v(n, template, hint)
where es.title = '32.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '32.1'
join (values
  (1, 0, 'You mustn''t forget it'), (2, 0, 'You mustn''t be afraid'), (3, 0, 'You mustn''t be late'),
  (4, 0, 'You mustn''t move anything'), (5, 0, 'You mustn''t stay here'), (6, 0, 'You mustn''t think about it')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '32.2', 'Which is correct?', 1
from units where slug = 'unit-32';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-32' where es.title = '32.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I have to talk to Gary. I {0} remember to call him.', 'must / mustn''t'),
  (2, 'I have to talk to Gary. I {0} forget to call him.', 'mustn''t / needn''t'),
  (3, 'There''s plenty of time for you to decide. You {0} decide now.', 'mustn''t / don''t need to'),
  (4, 'These are important documents. We {0} lose them.', 'mustn''t / needn''t'),
  (5, 'You {0} wait for me. You go on and I''ll join you later.', 'mustn''t / needn''t'),
  (6, 'This is a dangerous situation and we need to be careful. We {0} do anything stupid.', 'mustn''t / needn''t'),
  (7, 'I understand the situation perfectly. You {0} explain further.', 'mustn''t / don''t need to'),
  (8, 'What sort of house do you want to buy? Something big? It {0} be big — that''s not so important. But it {1} have a nice garden.', 'mustn''t / needn''t ... must / mustn''t')
) as v(n, template, hint)
where es.title = '32.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '32.2'
join (values
  (1, 0, 'must'), (2, 0, 'mustn''t'), (3, 0, 'don''t need to'), (4, 0, 'mustn''t'), (5, 0, 'needn''t'),
  (6, 0, 'mustn''t'), (7, 0, 'don''t need to'), (8, 0, 'needn''t'), (8, 1, 'must')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '32.3', 'Complete the sentences. Use needn''t + verb. Choose from: come, keep, leave, walk, worry.', 2
from units where slug = 'unit-32';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-32' where es.title = '32.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can manage the shopping alone. You {0} with me.', null),
  (2, 'We {0} all the way home. We can get a taxi.', null),
  (3, 'You can delete these emails. You {0} them.', null),
  (4, 'I''ll be all right. You {0} about me.', null)
) as v(n, template, hint)
where es.title = '32.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '32.3'
join (values
  (1, 0, 'needn''t come'), (2, 0, 'needn''t walk'), (3, 0, 'needn''t keep'), (4, 0, 'needn''t worry')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '32.4', 'Write two sentences for each situation. Use needn''t have in the first sentence and could have in the second.', 3
from units where slug = 'unit-32';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-32' where es.title = '32.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Why did you walk home? Why didn''t you take a taxi? {0}. {1}.', null),
  (2, 'Why did they stay at a hotel? Why didn''t they stay with us? {0}. {1}.', null),
  (3, 'Why did she phone me at 3 am? Why didn''t she wait until the morning? {0}. {1}.', null),
  (4, 'Why did you shout at me? Why weren''t you more patient? {0}. {1}.', null)
) as v(n, template, hint)
where es.title = '32.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '32.4'
join (values
  (1, 0, 'You needn''t have walked home'), (1, 1, 'You could have taken a taxi'),
  (2, 0, 'They needn''t have stayed at a hotel'), (2, 1, 'They could have stayed with us'),
  (3, 0, 'She needn''t have phoned me at 3 am'), (3, 1, 'She could have waited until the morning'),
  (4, 0, 'You needn''t have shouted at me'), (4, 1, 'You could have been more patient')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '32.5', 'Are these sentences OK? Change them where necessary.', 4
from units where slug = 'unit-32';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-32' where es.title = '32.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}. I can hear you perfectly.', 'original: You needn''t to shout.'),
  (2, '{0}, so I stayed at home.', 'original: I needn''t have gone out.'),
  (3, 'This train is direct. {0}.', 'original: You don''t need to change.'),
  (4, '{0}. It''s OK to leave it unlocked.', 'original: You mustn''t lock the door.'),
  (5, '{0}, so I kept quiet.', 'original: I needn''t have said anything.'),
  (6, '{0}. I should have kept quiet.', 'original: I needn''t have said anything.')
) as v(n, template, hint)
where es.title = '32.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '32.5'
join (values
  (1, 0, 'You needn''t shout', array['You don''t need to shout', 'You don''t have to shout']::text[]),
  (2, 0, 'I didn''t need to go out', array['I didn''t have to go out']::text[]),
  (3, 0, 'You don''t need to change', array[]::text[]),
  (4, 0, 'You needn''t lock the door', array['You don''t need to lock the door', 'You don''t have to lock the door']::text[]),
  (5, 0, 'I didn''t need to say anything', array['I didn''t have to say anything']::text[]),
  (6, 0, 'I needn''t have said anything', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 33 (should 1), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-33 first (cascades) before re-inserting.

delete from units where slug = 'unit-33';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 33, 'unit-33', 'should 1', null,
  'should = it is a good or right thing to do (advice/opinion), or what we expect to happen. should have (done) = it would have been good, but it didn''t happen.', 7
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'should for advice and opinion',
  'You should do something = it is a good or the right thing to do. We use should to give advice or an opinion, often with I think / I don''t think / Do you think ...? . should is weaker than must or have to.', 0
from units where slug = 'unit-33';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'should for what is expected',
  'We use should when something is not right, or not what we expect, and also to say that we expect something to happen.', 1
from units where slug = 'unit-33';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'should have (done)',
  'You should have done something = you didn''t do it, but it would have been good to. You shouldn''t have done something = you did it, but it wasn''t good to.', 2
from units where slug = 'unit-33';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'ought to',
  'You can use ought to instead of should in all these sentences — "ought to do" (with to).', 3
from units where slug = 'unit-33';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-33'
join (values
  ('A', 'You look tired. You should go to bed.', 'advice', 0),
  ('A', 'You shouldn''t believe everything you read in newspapers.', 'advice, negative', 1),
  ('A', 'You should apologise. (= it would be a good thing to do) You must apologise. (= you have no alternative)', 'should vs. must', 2),
  ('B', 'Where''s Tina? She should be here by now. (= she isn''t, and this is not normal)', 'not what''s expected', 0),
  ('B', 'Helen has been studying hard for the exam, so she should pass. (= I expect her to pass)', 'expectation', 1),
  ('C', 'You missed a great party last night. You should have come. Why didn''t you?', 'didn''t do it, would''ve been good', 0),
  ('C', 'I''m feeling sick. I shouldn''t have eaten so much. (= I ate too much)', 'did it, wasn''t good', 1),
  ('D', 'Do you think I ought to apply for this job? (= Do you think I should apply ...?)', 'ought to = should', 0),
  ('D', 'It was a great party last night. You ought to have come. (= You should have come)', 'ought to have = should have', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 33.1-33.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '33.1', 'For each situation, write a sentence with should or shouldn''t + one of the following: go away for a few days, stay up so late, look for another job, worry so much, put some pictures on the walls, take a picture.', 0
from units where slug = 'unit-33';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-33' where es.title = '33.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Your salary is very low. {0}.', null),
  (2, 'Jack always finds it hard to get up. {0}.', null),
  (3, 'What a beautiful view! {0}.', null),
  (4, 'Laura is always anxious. {0}.', null),
  (5, 'Dan''s room isn''t very nice. {0}.', null)
) as v(n, template, hint)
where es.title = '33.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '33.1'
join (values
  (1, 0, 'You should look for another job'), (2, 0, 'He shouldn''t stay up so late'), (3, 0, 'You should take a picture'),
  (4, 0, 'She shouldn''t worry so much'), (5, 0, 'He should put some pictures on the walls')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '33.2', 'Complete the sentences. Choose from: should solve, should be working OK, shouldn''t cost more, shouldn''t take long, should receive, should pass the exam, should be much warmer, should be here soon.', 1
from units where slug = 'unit-33';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-33' where es.title = '33.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Joe hasn''t arrived yet, but he {0}.', null),
  (2, 'The TV has been repaired. It {0} now.', null),
  (3, 'It {0} to get to the hotel. About 20 minutes.', null),
  (4, 'I sent the documents to you today, so you {0} them tomorrow.', null),
  (5, 'The weather is unusually cold. It {0} at this time of year.', null),
  (6, 'The best way to get to the airport is by taxi. It {0} than ten pounds.', null),
  (7, 'If you have a problem with the computer, try restarting it. That {0} the problem.', null)
) as v(n, template, hint)
where es.title = '33.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '33.2'
join (values
  (1, 0, 'should be here soon'), (2, 0, 'should be working OK'), (3, 0, 'shouldn''t take long'), (4, 0, 'should receive'),
  (5, 0, 'should be much warmer'), (6, 0, 'shouldn''t cost more'), (7, 0, 'should solve')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '33.3', 'Complete the sentences. Use should ... or should have ... + the verb in brackets.', 2
from units where slug = 'unit-33';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-33' where es.title = '33.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m in a difficult position. What do you think I {0} now?', 'do'),
  (2, 'I''m sorry that I didn''t take your advice. I {0} what you said.', 'do'),
  (3, 'We lost the game, but we were the better team. We {0}.', 'win'),
  (4, 'We don''t see you enough. You {0} and see us more often.', 'come'),
  (5, 'We went the wrong way and got lost. We {0} right, not left.', 'turn'),
  (6, 'My exam results weren''t good. I {0} better.', 'do')
) as v(n, template, hint)
where es.title = '33.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '33.3'
join (values
  (1, 0, 'should do'), (2, 0, 'should have done'), (3, 0, 'should have won'),
  (4, 0, 'should come'), (5, 0, 'should have turned'), (6, 0, 'should have done')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '33.4', 'Read the situations and write sentences with should / should have / shouldn''t / shouldn''t have.', 3
from units where slug = 'unit-33';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-33' where es.title = '33.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When we got to the restaurant, there were no free tables. We hadn''t reserved one. {0}.', null),
  (2, 'Laura told me her address, but I didn''t write it down. Now I can''t remember the house number. {0}.', null),
  (3, 'The shop is open every day from 8.30. It is 9 o''clock now, but the shop isn''t open yet. {0}.', null),
  (4, 'I was looking at my phone. I wasn''t looking where I was going. I walked into a wall. {0}.', null),
  (5, 'Kate is driving. The speed limit is 30 miles an hour, but Kate is doing 50. {0}.', null),
  (6, 'I wasn''t feeling well yesterday, but I went to work. That was a mistake. Now I feel worse. {0}.', null),
  (7, 'Tomorrow there is a football match between Team A and Team B. Team A are much better. {0}.', null),
  (8, 'I was driving. The car in front stopped suddenly and I drove into it. It wasn''t my fault. {0}.', null)
) as v(n, template, hint)
where es.title = '33.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '33.4'
join (values
  (1, 0, 'We should have reserved a table', array[]::text[]),
  (2, 0, 'I should have written down her address', array['I should have written her address down', 'I should have written it down']::text[]),
  (3, 0, 'The shop should be open now', array['The shop should have opened by now']::text[]),
  (4, 0, 'I shouldn''t have been looking at my phone', array['I should have looked where I was going', 'I should have been looking where I was going']::text[]),
  (5, 0, 'She shouldn''t be doing 50', array['She shouldn''t be driving so fast', 'She should be driving more slowly']::text[]),
  (6, 0, 'I shouldn''t have gone to work yesterday', array[]::text[]),
  (7, 0, 'Team A should win the match', array[]::text[]),
  (8, 0, 'The driver in front shouldn''t have stopped without warning', array['The driver in front shouldn''t have stopped so suddenly']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 34 (should 2), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-34 first (cascades) before re-inserting.

delete from units where slug = 'unit-34';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 34, 'unit-34', 'should 2', null,
  'should is used after verbs like insist/recommend/suggest and after it''s important/essential that..., though it can often be left out. It''s also used after adjectives like strange/surprising, and in if...should... for a smaller possibility.', 8
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'should after insist, recommend, suggest, and it''s important that...',
  'You can use should after insist, demand, recommend, suggest, propose, and after it''s important/vital/necessary/essential that ... .', 0
from units where slug = 'unit-34';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'should can be left out (subjunctive)',
  'You can leave out should in the sentences from section A — the form left behind (be/do/apologise) is called the subjunctive, the same as the infinitive without to. Normal present/past forms are also possible.', 1
from units where slug = 'unit-34';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'No to after suggest',
  'We do not use to with suggest — "What do you suggest we do?", not "What do you suggest us to do?".', 2
from units where slug = 'unit-34';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'should after strange, surprising, etc.',
  'You can use should after adjectives like strange, odd, funny, typical, natural, interesting, surprised, surprising.', 3
from units where slug = 'unit-34';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'if something should happen...',
  'You can say "if something should happen..." (or begin with Should: "Should something happen..."), meaning the same as "if something happens", but suggesting the possibility is smaller.', 4
from units where slug = 'unit-34';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'F', 'I should... to give advice',
  'You can use I should.../I shouldn''t... to give advice, meaning "I would... if I were you" or "I advise you to...".', 5
from units where slug = 'unit-34';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-34'
join (values
  ('A', 'I insisted that he should apologise.', 'should after insist', 0),
  ('A', 'Doctors recommend that everyone should eat plenty of fruit.', 'should after recommend', 1),
  ('A', 'It''s essential that everyone should be here on time.', 'should after it''s essential that', 2),
  ('B', 'It''s essential that everyone be here on time. (= ... that everyone should be here ...)', 'subjunctive', 0),
  ('B', 'It''s essential that everyone is here on time.', 'normal present tense', 1),
  ('C', 'What do you suggest we should do? or What do you suggest we do? (but not What do you suggest us to do?)', 'no to after suggest', 0),
  ('D', 'It''s strange that he should be late. He''s usually on time.', 'should after strange', 0),
  ('D', 'I was surprised that he should say such a thing.', 'should after surprised', 1),
  ('E', 'We have no jobs at present, but if the situation should change, we will contact you.', 'smaller possibility', 0),
  ('E', 'You can also begin with should: Should the situation change, we will contact you.', 'should at the start', 1),
  ('F', '''Shall I leave now?'' ''No, I should wait a bit.'' (= I advise you to wait)', 'advice', 0),
  ('F', 'I shouldn''t stay up too late. You have to be up early tomorrow.', 'advice', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 34.1-34.5)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '34.1', 'Complete the second sentence so that it means the same as the first.', 0
from units where slug = 'unit-34';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-34' where es.title = '34.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''You really must stay a little longer,'' she said to me. She insisted that {0} a little longer.', null),
  (2, '''Why don''t you visit the museum after lunch?'' I said to them. I suggested that {0} the museum after lunch.', null),
  (3, '''You must pay the rent by Friday,'' the landlord said to us. The landlord demanded that {0} the rent by Friday.', null),
  (4, '''Let''s go to the cinema,'' Chris said to me. Chris suggested that {0} to the cinema.', null)
) as v(n, template, hint)
where es.title = '34.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '34.1'
join (values
  (1, 0, 'I should stay', array['I stay', 'I stayed']::text[]),
  (2, 0, 'they should visit', array['they visit', 'they visited']::text[]),
  (3, 0, 'we should pay', array['we pay', 'we paid']::text[]),
  (4, 0, 'we should go', array['we go', 'we went']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '34.2', 'Two of these sentences are not correct. Change the two that are not correct.', 1
from units where slug = 'unit-34';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-34' where es.title = '34.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', 'original: I called Tina and suggested that we meet for coffee.'),
  (2, '{0}', 'original: What do you suggest me to do?'),
  (3, '{0}', 'original: What sort of car do you suggest I should buy?'),
  (4, '{0}', 'original: I suggest you to read this book.'),
  (5, '{0}', 'original: I suggested that Anna learn to drive.')
) as v(n, template, hint)
where es.title = '34.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '34.2'
join (values
  (1, 0, 'I called Tina and suggested that we meet for coffee.', array['I called Tina and suggested that we should meet for coffee.']::text[]),
  (2, 0, 'What do you suggest I do?', array['What do you suggest I should do?']::text[]),
  (3, 0, 'What sort of car do you suggest I should buy?', array['What sort of car do you suggest I buy?']::text[]),
  (4, 0, 'I suggest you read this book.', array['I suggest you should read this book.']::text[]),
  (5, 0, 'I suggested that Anna learn to drive.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '34.3', 'Complete the sentences using should + verb. Choose from: ask, be, be done, leave, say, vote, worry.', 2
from units where slug = 'unit-34';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-34' where es.title = '34.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s funny that you {0} that. I was thinking the same thing.', null),
  (2, 'It''s only natural that parents {0} about their children.', null),
  (3, 'Isn''t it typical of Joe that he {0} without saying goodbye to anybody?', null),
  (4, 'I was surprised that they {0} me for advice. What advice could I give them?', null),
  (5, 'This is a democratic election, and it''s important that you {0}.', null),
  (6, 'The bridge needs to be repaired. It''s essential that the work {0} as soon as possible.', null)
) as v(n, template, hint)
where es.title = '34.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '34.3'
join (values
  (1, 0, 'should say'), (2, 0, 'should worry'), (3, 0, 'should leave'),
  (4, 0, 'should ask'), (5, 0, 'should vote'), (6, 0, 'should be done')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '34.4', 'Complete the sentences using If ... should ... . Choose from: anyone/ask, the situation/change, it/rain, there/any problems. Then write the same sentences beginning with Should ... .', 3
from units where slug = 'unit-34';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-34' where es.title = '34.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ve hung out the washing to dry on the balcony. {0}, can you bring it inside?', null),
  (2, 'I think everything will be OK. {0}, I''m sure we''ll be able to solve them.', null),
  (3, 'I don''t want anyone to know where I''m going. {0}, say you don''t know.', null),
  (4, 'Now with Should ... : {0}, can you bring the washing inside?', null),
  (5, 'Now with Should ... : {0}, I''m sure we''ll be able to solve them.', null),
  (6, 'Now with Should ... : {0}, say you don''t know.', null)
) as v(n, template, hint)
where es.title = '34.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '34.4'
join (values
  (1, 0, 'If it should rain'), (2, 0, 'If there should be any problems'), (3, 0, 'If anyone should ask'),
  (4, 0, 'Should it rain'), (5, 0, 'Should there be any problems'), (6, 0, 'Should anyone ask')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '34.5', 'Complete the sentences using I should. Choose from: call, get, keep, wait.', 4
from units where slug = 'unit-34';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-34' where es.title = '34.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''Shall I throw these things away?'' ''No, {0} them. You may need them.''', null),
  (2, '''Shall I go and see Paul?'' ''Yes, but {0} him first.''', null),
  (3, '''Is it worth getting this computer repaired?'' ''{0} a new one.''', null)
) as v(n, template, hint)
where es.title = '34.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '34.5'
join (values
  (1, 0, 'I should keep'), (2, 0, 'I should call'), (3, 0, 'I should get')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 35 (I'd better ... it's time ...), sourced from
-- pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Safe to re-run: deletes unit-35 first (cascades) before re-inserting.

delete from units where slug = 'unit-35';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 35, 'unit-35', 'I''d better ... it''s time ...', null,
  'I''d better do something = it is advisable, or there''ll be a problem if I don''t. It''s time (for somebody) to do something, or it''s time somebody did something = they should have already started.', 9
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'had better (I''d better)',
  'I''d better do something = it is advisable to do it; if I don''t, there will be a problem or a danger. The negative is I''d better not. We say "I''d better do" (not to do), and had better is for the present/future, not the past.', 0
from units where slug = 'unit-35';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'had better vs. should',
  'had better is only for a specific situation, not for things in general (use should for that). Also, with had better there''s always a danger or problem if you don''t follow the advice — should just means it''s a good thing to do.', 1
from units where slug = 'unit-35';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'it''s time ...',
  'You can say It''s time (for somebody) to ..., or It''s time + past (it''s time we went), which means present, not past. It''s time somebody did something = they should have already done it — often used to criticise or complain.', 2
from units where slug = 'unit-35';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-35'
join (values
  ('A', 'I have to meet Amy in ten minutes. I''d better go now or I''ll be late.', 'advisable, or a problem', 0),
  ('A', 'We''d better stop for petrol soon. The tank is almost empty.', 'advisable', 1),
  ('A', '''That jacket looks good on you. Are you going to buy it?'' ''I''d better not. It''s very expensive.''', 'negative', 2),
  ('B', 'It''s late. You''d better go. or You should go. (a specific situation)', 'specific situation', 0),
  ('B', 'You''re always at home. You should go out more often. (in general — not had better go)', 'general advice', 1),
  ('B', 'The film starts at 8.30. You''d better go now or you''ll miss the beginning.', 'danger of missing it', 2),
  ('C', 'You can say It''s time (for somebody) to ...: It''s time to go home. / It''s time for us to go home.', 'time + to', 0),
  ('C', 'It''s late. It''s time we went home.', 'time + past = present meaning', 1),
  ('C', 'This situation can''t continue. It''s time you did something about it.', 'criticise/complain', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 35.1-35.4)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '35.1', 'Read the situations and write sentences with ''d better or ''d better not. Choose a verb from: check, disturb, go, put, reserve, take.', 0
from units where slug = 'unit-35';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-35' where es.title = '35.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You and Kate plan to go to a restaurant tonight. It will be busy. You say to Kate: {0}.', null),
  (2, 'Oliver has just cut himself. It''s bleeding and he''ll need a plaster on it. You say to him: {0}.', null),
  (3, 'Rebecca doesn''t look well this morning — not well enough to go to work. You say to her: {0}.', null),
  (4, 'You''re going to the cinema, but you''re not sure what time the film starts. You say: {0}.', null),
  (5, 'You need to talk to your boss, but she''s very busy right now. You say to a colleague: {0}.', null)
) as v(n, template, hint)
where es.title = '35.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '35.1'
join (values
  (1, 0, 'We''d better reserve a table', array[]::text[]),
  (2, 0, 'You''d better put a plaster on it', array[]::text[]),
  (3, 0, 'You''d better not go to work this morning', array[]::text[]),
  (4, 0, 'I''d better check what time the film starts', array['We''d better check what time the film starts']::text[]),
  (5, 0, 'I''d better not disturb her right now', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '35.2', 'Is had better OK in these sentences? Change to should where necessary.', 1
from units where slug = 'unit-35';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-35' where es.title = '35.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} set your alarm. You have to get up early tomorrow.', null),
  (2, 'I''m glad you came to see us. {0} come more often.', null),
  (3, 'She''ll be sad if we don''t invite her to the party, so {0} invite her.', null),
  (4, 'It''s nearly time to go out. {0} get ready.', null),
  (5, 'I think everybody {0} learn a foreign language.', null),
  (6, 'We''ve just missed the last bus. {0} get a taxi.', null)
) as v(n, template, hint)
where es.title = '35.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '35.2'
join (values
  (1, 0, 'You''d better'), (2, 0, 'You should'), (3, 0, 'we''d better'),
  (4, 0, 'I''d better'), (5, 0, 'should'), (6, 0, 'we''d better')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '35.3', 'Complete the sentences. Choose from the box: better, do, did, had, hadn''t, I''d, not, should, take, to, was, were.', 2
from units where slug = 'unit-35';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-35' where es.title = '35.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ben needs to know what happened. Somebody {0} better tell him.', null),
  (2, 'We''d better {0} park the car here. The road is too narrow.', null),
  (3, 'You {0} brush your teeth at least twice a day.', null),
  (4, 'What are we going to do? It''s time {0} decide.', null),
  (5, '{0} better not be late. It''s an important meeting.', null),
  (6, 'It''s time they {0} here. They promised they wouldn''t be late.', null),
  (7, 'The window is open. You''d {0} close it before you go out.', null),
  (8, 'We''d better leave as soon as possible, {0} we?', null),
  (9, 'The government should {0} something about the problem.', null),
  (10, 'It''s time the government {0} something about the problem.', null),
  (11, 'It''s time something {0} done about the problem.', null)
) as v(n, template, hint)
where es.title = '35.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '35.3'
join (values
  (1, 0, 'had'), (2, 0, 'not'), (3, 0, 'should'), (4, 0, 'to'), (5, 0, 'I''d'),
  (6, 0, 'were'), (7, 0, 'better'), (8, 0, 'hadn''t'), (9, 0, 'do'), (10, 0, 'did'), (11, 0, 'was')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '35.4', 'Read the situations and write sentences with It''s time (somebody did something).', 3
from units where slug = 'unit-35';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-35' where es.title = '35.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You haven''t had a holiday for a very long time. You need one now. {0}.', 'I / holiday'),
  (2, 'It''s 10 o''clock. It''s after the children''s bedtime. You think they should be in bed. {0}.', 'children / bed'),
  (3, 'You didn''t realise it was so late. You need to start cooking dinner. {0} dinner.', 'start / cook'),
  (4, 'Kate is always complaining about everything. You think she complains too much. {0} about everything.', 'stop / complaining'),
  (5, 'The company you work for has been badly managed for a long time. You think some changes should be made. {0} in the way the company is run.', 'changes / make')
) as v(n, template, hint)
where es.title = '35.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '35.4'
join (values
  (1, 0, 'It''s time I had a holiday', array[]::text[]),
  (2, 0, 'It''s time the children were in bed', array['It''s time the children went to bed']::text[]),
  (3, 0, 'It''s time I started cooking', array[]::text[]),
  (4, 0, 'It''s time she stopped complaining', array['It''s time Kate stopped complaining']::text[]),
  (5, 0, 'It''s time changes were made', array['It''s time some changes were made']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 36 (would), sourced from pdf/Modulos/Modals.pdf
-- (extracted via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf.
--
-- Note: 36.1 ("Write sentences about yourself") is open-ended, left out.
--
-- Safe to re-run: deletes unit-36 first (cascades) before re-inserting.

delete from units where slug = 'unit-36';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 36, 'unit-36', 'would', null,
  'would/wouldn''t is used to imagine a situation or action that isn''t real; would have (done) imagines something that didn''t happen in the past. would can also be the past of will, or describe regular past actions (like used to).', 10
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'would/wouldn''t for imagined situations',
  'We use would (''d)/wouldn''t when we imagine a situation or action that is not real. would have (done) imagines something that didn''t happen in the past.', 0
from units where slug = 'unit-36';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'would as the past of will; wouldn''t = refused',
  'would/wouldn''t is sometimes the past of will/won''t, reporting what someone said. Somebody wouldn''t do something = he/she/it refused to do it.', 1
from units where slug = 'unit-36';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'would for regular past actions',
  'We can also use would to talk about things that happened regularly in the past — similar to used to.', 2
from units where slug = 'unit-36';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-36'
join (values
  ('A', 'It would be nice to buy a new car, but we can''t afford it.', 'imagined situation', 0),
  ('A', 'They helped us a lot. I don''t know what we''d have done without their help.', 'imagined past', 1),
  ('A', 'I would call Lisa, but I don''t have her number. (now)', 'now', 2),
  ('A', 'I would have called Lisa, but I didn''t have her number. (past)', 'past', 3),
  ('B', 'TOM: ''I''ll call you on Sunday.'' → Tom said he''d call me on Sunday.', 'past of will', 0),
  ('B', 'I tried to warn him, but he wouldn''t listen to me. (= he refused to listen)', 'refused', 1),
  ('B', 'The car wouldn''t start. (= it ''refused'' to start)', 'refused', 2),
  ('C', 'When we were children, if the weather was fine, we would all get up early and go for a swim. (= we did this regularly)', 'regular past action', 0),
  ('C', 'Whenever Richard was angry, he would walk out of the room. (similar to used to)', 'regular past action', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 36.2-36.6 — 36.1 skipped, open-ended)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '36.2', 'Complete the sentences using would + the following verbs (in the correct form): be, be, do, do, enjoy, enjoy, have, stop.', 0
from units where slug = 'unit-36';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-36' where es.title = '36.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You should go and see the film. I think you {0} it.', null),
  (2, 'It''s a pity you couldn''t come to the party last night. You {0} it.', null),
  (3, 'Shall I apply for the job or not? What {0}?', null),
  (4, 'I was in a hurry when I saw you. Otherwise I {0} to talk.', null),
  (5, 'We took a taxi home last night, but got stuck in the traffic. It {0} quicker to walk.', null),
  (6, 'Why don''t you go and see Clare? She {0} very pleased to see you.', null),
  (7, 'In an ideal world, everybody {0} enough to eat.', null)
) as v(n, template, hint)
where es.title = '36.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '36.2'
join (values
  (1, 0, '''d enjoy', array['would enjoy']::text[]),
  (2, 0, '''d have enjoyed', array['would have enjoyed']::text[]),
  (3, 0, 'would you do', array[]::text[]),
  (4, 0, '''d have stopped', array['would have stopped']::text[]),
  (5, 0, 'would have been', array['''d have been']::text[]),
  (6, 0, '''d be', array['would be']::text[]),
  (7, 0, 'would have', array['''d have']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '36.3', 'Each sentence on the right follows a sentence on the left. Combine them.', 1
from units where slug = 'unit-36';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-36' where es.title = '36.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wouldn''t like to live on a busy road. {0}.', null),
  (2, 'I''m sorry your trip was cancelled. {0}.', null),
  (3, 'I''m looking forward to going out tonight. {0}.', null),
  (4, 'I''m glad we didn''t go out in the rain. {0}.', null),
  (5, 'I''m not looking forward to the trip. {0}.', null)
) as v(n, template, hint)
where es.title = '36.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '36.3'
join (values
  (1, 0, 'It wouldn''t be very nice'), (2, 0, 'It would have been fun'), (3, 0, 'It will be fun'),
  (4, 0, 'It wouldn''t have been very nice'), (5, 0, 'It won''t be much fun')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '36.4', 'Write sentences using promised + would/wouldn''t.', 2
from units where slug = 'unit-36';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-36' where es.title = '36.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wonder why Steve hasn''t called me. He promised {0}.', null),
  (2, 'Why did you tell Amy what I said? You {0}.', null),
  (3, 'I''m surprised they didn''t wait for us. They {0}.', null)
) as v(n, template, hint)
where es.title = '36.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '36.4'
join (values
  (1, 0, 'he''d call', array['he would call']::text[]),
  (2, 0, 'promised you wouldn''t tell her', array['promised you wouldn''t tell anyone', 'promised you wouldn''t tell anybody']::text[]),
  (3, 0, 'promised they''d wait', array['promised they would wait']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '36.5', 'Complete the sentences. Use wouldn''t + a suitable verb.', 3
from units where slug = 'unit-36';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-36' where es.title = '36.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I asked Amanda what had happened, but she {0} me.', null),
  (2, 'Paul was angry about what I''d said and he {0} to me for two weeks.', null),
  (3, 'Martina insisted on carrying all her luggage. She {0} me help her.', null)
) as v(n, template, hint)
where es.title = '36.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '36.5'
join (values
  (1, 0, 'wouldn''t tell'), (2, 0, 'wouldn''t speak'), (3, 0, 'wouldn''t let')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '36.6', 'Complete the sentences using would (regular past actions). Choose from: forget, shake, share, smile, stay, walk.', 4
from units where slug = 'unit-36';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-36' where es.title = '36.6' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We used to live next to a railway line. Every time a train went past, the house {0}.', null),
  (2, 'Katherine was always very generous. She didn''t have much, but she {0} what she had with everyone else.', null),
  (3, 'You could never rely on Joe. It didn''t matter how many times you reminded him to do something, he {0}.', null),
  (4, 'When we were children, we used to go to the beach a lot. We {0} there all day playing in the sand and swimming in the sea.', null),
  (5, 'Lucy was always friendly. Whenever I saw her, she {0} and say hello.', null)
) as v(n, template, hint)
where es.title = '36.6';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '36.6'
join (values
  (1, 0, 'would shake'), (2, 0, 'would share'), (3, 0, 'would always forget'),
  (4, 0, 'would stay'), (5, 0, 'would always smile')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
-- Seeds "Modals" / Unit 37 (can/could/would you ... ? etc. — Requests,
-- offers, permission and invitations), the last unit of this batch, sourced
-- from pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`) and
-- cross-checked against pdf/Key to Exercises.pdf.
--
-- Note on 37.1: matching format combined into single sentences, same
-- approach as unit-6's 6.2. 37.3 items accept several of the book's listed
-- equivalent phrasings as accepted_alternatives.
--
-- Safe to re-run: deletes unit-37 first (cascades) before re-inserting.

delete from units where slug = 'unit-37';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 37, 'unit-37', 'can/could/would you ... ? etc.', 'Requests, offers, permission and invitations',
  'can/could you...? to ask people to do things. Can/Could/May I have...? to ask for things. Can/Could/May I...? or Do you mind if I...? to ask to do things. Would you like...? to offer or invite.', 11
from modules where slug = 'modals';

-- ============================================================
-- Theory
-- ============================================================

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Asking people to do things (requests)',
  'We use can or could to ask people to do things — Can you wait a moment, please? / Could you wait a moment, please? You can also say Do you think you could...? .', 0
from units where slug = 'unit-37';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Asking for things',
  'To ask for something, we use Can (I) have...? / Could (I) have...? or Can (I) get...? . May I have...? is also possible.', 1
from units where slug = 'unit-37';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Asking to do things',
  'We use can I or could I to ask to do something. May is also possible, and more formal. You can also say Do you mind if I...? or Is it all right/OK if I...? .', 2
from units where slug = 'unit-37';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'Offering and inviting',
  'Can I...? offers to do something. Would you like...? (not Do you like) offers or invites. I''d like... (= I would like) is a polite way to say what you want.', 3
from units where slug = 'unit-37';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-37'
join (values
  ('A', 'Can you wait a moment, please? or Could you wait a moment, please?', 'request', 0),
  ('A', 'Do you think you could take me to the airport? (not Do you think you can)', 'polite request', 1),
  ('B', '(in a shop) Can I have these postcards, please? or Can I get these postcards, please?', 'asking for things', 0),
  ('B', 'May I have these postcards, please?', 'more formal', 1),
  ('C', '(on the phone) Hello, can I speak to Steve, please?', 'asking to do things', 0),
  ('C', 'Do you mind if I use your phone charger?', 'alternative phrasing', 1),
  ('C', '''Is it all right if I sit here?'' ''Yes, of course.''', 'alternative phrasing', 2),
  ('D', '''Can I help you?'' ''No, it''s OK. I can manage, thanks.''', 'offering', 0),
  ('D', '''Would you like some coffee?'' ''No, thanks.''', 'offering/inviting', 1),
  ('D', '(at a tourist information office) I''d like some information about hotels, please.', 'polite want', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ============================================================
-- Exercises (main, split into the book's own 37.1-37.3)
-- ============================================================

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '37.1', 'Which goes with which? Combine the sentences.', 0
from units where slug = 'unit-37';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-37' where es.title = '37.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Would you like to go to the cinema? {0}.', null),
  (2, 'Can I use your toilet? {0}.', null),
  (3, 'Do you mind if I leave work early? {0}.', null),
  (4, 'Can you do me a favour? {0}.', null),
  (5, 'Would you like something to eat? {0}.', null),
  (6, 'Can I give you a hand? {0}.', null),
  (7, 'I''d like some fresh air. {0}.', null)
) as v(n, template, hint)
where es.title = '37.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '37.1'
join (values
  (1, 0, 'Maybe. What''s on?'), (2, 0, 'Sure. It''s the door on the left.'), (3, 0, 'No, that''s fine.'),
  (4, 0, 'It depends what you want me to do.'), (5, 0, 'No, thanks. I''m not hungry.'),
  (6, 0, 'No, it''s all right. I can manage, thanks.'), (7, 0, 'Me too. Let''s go out for a walk.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '37.2', 'Complete the sentences. Choose from: I''d like, Would you like to try, Do you mind, Can I take, Can I give, Would you like to come, Would you like, I''d like to.', 1
from units where slug = 'unit-37';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-37' where es.title = '37.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''re making a cold drink for your friend. Perhaps he wants ice. You ask: {0} ice in your drink?', null),
  (2, 'You''re ordering something to eat in a cafe. You say: {0} a chicken salad, please.', null),
  (3, 'You have an extra ticket for a concert. Maybe your friend will come. You ask: {0} to a concert tomorrow night?', null),
  (4, 'You answer the phone. The caller wants to speak to Lisa. You say: Lisa''s not here. {0} a message?', null),
  (5, 'You need to see a dentist. You phone for an appointment. You say: Hello. {0} make an appointment, please.', null),
  (6, 'You work in a shoe shop. A customer asks you about some shoes. You ask: {0} them on?', null),
  (7, 'You go into a cafe and see some people you know. You ask: {0} if I join you?', null)
) as v(n, template, hint)
where es.title = '37.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '37.2'
join (values
  (1, 0, 'Would you like'), (2, 0, 'I''d like'), (3, 0, 'Would you like to come'), (4, 0, 'Can I take'),
  (5, 0, 'I''d like to'), (6, 0, 'Would you like to try'), (7, 0, 'Do you mind')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '37.3', 'What would you say in these situations?', 2
from units where slug = 'unit-37';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-37' where es.title = '37.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''ve finished your meal in a restaurant and now you want the bill. You ask the waiter: {0}', null),
  (2, 'You''ve filled in some forms in English. You want your friend to check them for you. You ask your friend: {0}', null),
  (3, 'The woman in the next room is playing music. It''s very loud. You want her to turn it down. You say to her: {0}', null),
  (4, 'You''re on a train. The window is open and you''re cold. You''d like to close it. You ask the man next to you: {0}', null),
  (5, 'You''re on a bus. You have a seat, but an elderly man is standing. You offer him your seat. You say to him: {0}', null),
  (6, 'You''re a tourist. You want to go to the station, but you don''t know how to get there. You ask at your hotel: {0}', null),
  (7, 'You are in a clothes shop. You see some trousers you like and you want to try them on. You say to the shop assistant: {0}', null),
  (8, 'You meet a very famous person. You want to get his/her autograph. You ask: {0}', null)
) as v(n, template, hint)
where es.title = '37.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '37.3'
join (values
  (1, 0, 'Can I have the bill, please?', array['Could I have the bill, please?', 'Can we have the bill, please?', 'Can I get the bill, please?']::text[]),
  (2, 0, 'Can you check these forms, please?', array['Could you check these forms for me?', 'Do you think you could check these forms?']::text[]),
  (3, 0, 'Can you turn the music down, please?', array['Could you turn the music down, please?', 'Could you turn it down?', 'Do you think you could turn the music down?']::text[]),
  (4, 0, 'Is it OK if I close the window?', array['Is it all right if I close the window?', 'Can I close the window?', 'Do you mind if I close the window?']::text[]),
  (5, 0, 'Would you like to sit down?', array['Would you like a seat?', 'Can I offer you a seat?']::text[]),
  (6, 0, 'Can you tell me how to get to the station?', array['Could you tell me how to get to the station?', 'Could you tell me the way to the station?', 'Could you tell me where the station is?']::text[]),
  (7, 0, 'Can I try on these trousers?', array['Could I try on these trousers?', 'Can I try these trousers on?', 'I''d like to try on these trousers.', 'Is it OK if I try them on?']::text[]),
  (8, 0, 'Can I get your autograph?', array['Could I get your autograph?', 'Can I have your autograph?', 'Do you think I could get your autograph?']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
