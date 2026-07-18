-- Marco 4 (slice 35): seeds the eighth and final slice of the "Adjectives
-- and adverbs" module — units 111 (still, any more, yet, already) and 112
-- (even).
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode). This completes the "Adjectives and adverbs" module: the
-- PDF's unit headers stop at 112 (confirmed via a full-file grep sweep at
-- the start of this slice sequence) — units 98-112, 15 units across eight
-- slices (0029-0036).
--
-- 111.1 is picture-based (three portraits of "Paul" over time), and one
-- item (8, "beard") has no corresponding fact in the exercise's own
-- printed table at all — the Key's answer ("He doesn't have a beard any
-- more") is the only source for this fact, so it was reconstructed
-- entirely from the Key rather than from any visible caption, unlike
-- 91.1/94.1 in earlier slices where every item's text was self-contained.
--
-- 111.1's second half ("Now write three sentences about Paul using no
-- longer") is genuinely open-choice in the book — it asks for any three
-- of four already-established "changed" facts (poems/politics/fishing/
-- beard), not a fixed set. Rather than leave the choice ambiguous (which
-- this app's exact-match grading can't handle), seeded all four facts as
-- separate deterministic items instead of the book's literal "three" —
-- every fact has one Key-confirmed correct answer, so there's no actual
-- ambiguity in what to seed, just in how many of the four the book asked
-- for.
--
-- 112.2 has two pre-filled worked examples (item 1 for the plain "even"
-- pattern, item 5 for negative + even) — same recurring gotcha as
-- 108.3/0034 and every "two sub-patterns, two examples" exercise since
-- unit 52.1/0010.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 111: still any more yet already
-- ============================================================

delete from units where slug = 'unit-111';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 111, 'unit-111', 'still any more yet already', null,
  'still says a situation is continuing, unchanged (Joe is still in bed); not ... any more or not ... any longer (or no longer, mid-sentence) says a situation has changed (Lucy doesn''t work here any more / no longer works here). yet is mainly for negatives and questions, showing the speaker expects something to happen (isn''t here yet, have you decided yet?). already says something happened sooner than expected (she has already left).', 13
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'still',
  'We use still to say that a situation or action is continuing. It hasn''t changed or stopped: It''s ten o''clock and Joe is still in bed. When I went to bed, Chris was still working. Do you still want to go away or have you changed your mind? Still also means ''in spite of this''. For example: He has everything he needs, but he''s still unhappy. Still usually goes in the middle of the sentence with the verb. See Unit 110.', 0
from units where slug = 'unit-111';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'not ... any more / any longer / no longer',
  'We use not ... any more or not ... any longer to say that a situation has changed. Any more and any longer go at the end of a sentence: Lucy doesn''t work here any more. She left last month. or Lucy doesn''t work here any longer. We used to be good friends, but we aren''t any more. or ... we aren''t any longer. You can write any more (2 words) or anymore (1 word). You can also use no longer. No longer goes in the middle of the sentence: Lucy no longer works here. We do not normally use no more in this way: We are no longer friends. (not we are no more friends) Compare still and not ... any more: Sally still works here, but Lucy doesn''t work here any more.', 1
from units where slug = 'unit-111';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'yet',
  'We use yet mainly in negative sentences (He isn''t here yet) and questions (Is he here yet?). Yet (= until now) shows that the speaker expects something to happen. Yet usually goes at the end of a sentence: It''s 10 o''clock and Joe isn''t here yet. Have you decided what to do yet? ''Where are you going on holiday?'' ''We don''t know yet.'' We often use yet with the present perfect (''Have you decided ... yet?''). See Unit 7C. Compare yet and still: Mike lost his job six months ago and is still unemployed. Mike lost his job six months ago and hasn''t found another job yet. Is it still raining? Has it stopped raining yet? Still is also possible in negative sentences (before the negative): She said she would be here an hour ago and she still hasn''t come. This is similar to ''she hasn''t come yet''. But still ... not shows a stronger feeling of surprise or impatience. Compare: I sent him an invitation last week. He hasn''t replied yet. (but I expect he will reply soon) I sent him an invitation weeks ago and he still hasn''t replied. (he should have replied before now)', 2
from units where slug = 'unit-111';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'already',
  'We use already to say that something happened sooner than expected. ''What time is Sue leaving?'' ''She has already left.'' (= sooner than you expected) Shall I tell Joe what happened or does he already know? I''ve just had lunch and I''m already hungry. Already usually goes in the middle of a sentence (see Unit 110) or at the end: She''s already left. or She''s left already.', 3
from units where slug = 'unit-111';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-111'
join (values
  ('A', 'It''s ten o''clock and Joe is still in bed.', null, 0),
  ('A', 'When I went to bed, Chris was still working.', null, 1),
  ('A', 'Do you still want to go away or have you changed your mind?', null, 2),
  ('A', 'He has everything he needs, but he''s still unhappy.', '= in spite of this', 3),
  ('B', 'Lucy doesn''t work here any more. She left last month.', null, 0),
  ('B', 'We used to be good friends, but we aren''t any more.', null, 1),
  ('B', 'Lucy no longer works here.', null, 2),
  ('B', 'We are no longer friends.', 'not we are no more friends', 3),
  ('B', 'Sally still works here, but Lucy doesn''t work here any more.', null, 4),
  ('C', 'It''s 10 o''clock and Joe isn''t here yet.', null, 0),
  ('C', 'Have you decided what to do yet?', null, 1),
  ('C', '''Where are you going on holiday?'' ''We don''t know yet.''', null, 2),
  ('C', 'Mike lost his job six months ago and is still unemployed.', null, 3),
  ('C', 'Mike lost his job six months ago and hasn''t found another job yet.', null, 4),
  ('C', 'Is it still raining? Has it stopped raining yet?', null, 5),
  ('C', 'She said she would be here an hour ago and she still hasn''t come.', null, 6),
  ('C', 'I sent him an invitation last week. He hasn''t replied yet.', 'but I expect he will reply soon', 7),
  ('C', 'I sent him an invitation weeks ago and he still hasn''t replied.', 'he should have replied before now', 8),
  ('D', '''She has already left.''', '= sooner than you expected', 0),
  ('D', 'Shall I tell Joe what happened or does he already know?', null, 1),
  ('D', 'I''ve just had lunch and I''m already hungry.', null, 2),
  ('D', 'She''s already left. or She''s left already.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 111.1-111.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '111.1', 'Compare what Paul said a few years ago with what he says now. Write sentences with still and any more.', 0
from units where slug = 'unit-111';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-111' where es.title = '111.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Paul used to say: ''I write poems.'' Now he says: ''I gave up writing poems.'' {0}', '(poems)'),
  (2, 'Paul used to say: ''I want to be a teacher.'' Now he still says: ''I want to be a teacher.'' {0}', '(teacher)'),
  (3, 'Paul used to say: ''I''m interested in politics.'' Now he says: ''I''m not interested in politics.'' {0}', '(politics)'),
  (4, 'Paul used to say: ''I''m single.'' Now he still says: ''I''m single.'' {0}', '(single)'),
  (5, 'Paul used to say: ''I go fishing a lot.'' Now he says: ''I haven''t been fishing for years.'' {0}', '(fishing)'),
  (6, 'Paul used to have a beard. Now he doesn''t have a beard. {0}', '(beard)'),
  (7, 'Now write a sentence about Paul using no longer: he doesn''t write poems any more. {0}', null),
  (8, 'Now write a sentence about Paul using no longer: he isn''t interested in politics any more. {0}', null),
  (9, 'Now write a sentence about Paul using no longer: he doesn''t go fishing any more. {0}', null),
  (10, 'Now write a sentence about Paul using no longer: he doesn''t have a beard any more. {0}', null)
) as v(n, template, hint)
where es.title = '111.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '111.1'
join (values
  (1, 'He doesn''t write poems any more.', array[]::text[]),
  (2, 'He still wants to be a teacher.', array[]::text[]),
  (3, 'He isn''t interested in politics any more.', array['He''s not interested in politics any more.']::text[]),
  (4, 'He''s still single.', array['He is still single.']::text[]),
  (5, 'He doesn''t go fishing any more.', array[]::text[]),
  (6, 'He doesn''t have a beard any more.', array['He hasn''t got a beard any more.']::text[]),
  (7, 'He no longer writes poems.', array[]::text[]),
  (8, 'He is no longer interested in politics.', array['He''s no longer interested in politics.']::text[]),
  (9, 'He no longer goes fishing.', array[]::text[]),
  (10, 'He no longer has a beard.', array['He''s no longer got a beard.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '111.2', 'For each sentence (with still) write a sentence with a similar meaning using not ... yet. Choose from these verbs: decide, find, finish, go, stop, take off, wake up.', 1
from units where slug = 'unit-111';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-111' where es.title = '111.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Gary is still here. He {0}', null),
  (2, 'They''re still repairing the road. They {0}', null),
  (3, 'The children are still asleep. They {0}', null),
  (4, 'Kate is still looking for a job. She {0}', null),
  (5, 'I''m still wondering what to do. I {0}', null),
  (6, 'The plane is still waiting on the runway. It {0}', null)
) as v(n, template, hint)
where es.title = '111.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '111.2'
join (values
  (1, 'hasn''t gone yet.', array[]::text[]),
  (2, 'haven''t finished yet.', array['haven''t finished repairing the road yet.']::text[]),
  (3, 'haven''t woken up yet.', array[]::text[]),
  (4, 'hasn''t found one yet.', array['hasn''t found a job yet.']::text[]),
  (5, 'haven''t decided yet.', array['haven''t decided what to do yet.']::text[]),
  (6, 'hasn''t taken off yet.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '111.3', 'Put in still, yet, already or any more.', 2
from units where slug = 'unit-111';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-111' where es.title = '111.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Do you {0} live in the same place or have you moved?', null),
  (2, 'I''m hungry. Is dinner ready {0}?', null),
  (3, 'I was hungry earlier, but I don''t feel hungry {0}.', null),
  (4, 'Can we wait a few minutes? I don''t want to go out {0}.', null),
  (5, 'Amy used to work at the airport, but she doesn''t work there {0}.', null),
  (6, 'I used to live in Amsterdam. I {0} have a lot of friends there.', null),
  (7, 'There''s no need to introduce me to Joe. We''ve {0} met.', null),
  (8, 'John is 80 years old, but he''s {0} very fit and healthy.', null),
  (9, 'Would you like something to eat, or have you {0} eaten?', null),
  (10, '''Where''s Helen?'' ''She''s not here {0}. She''ll be here soon.''', null),
  (11, 'Mark said he''d be here at 8.30. It''s 9 o''clock now and he {0} isn''t here.', null),
  (12, 'Do you want to join the club or are you {0} a member?', null),
  (13, 'It happened a long time ago, but I {0} remember it very clearly.', null),
  (14, 'I''ve put on weight. These trousers don''t fit me {0}.', null)
) as v(n, template, hint)
where es.title = '111.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '111.3'
join (values
  (1, 'still'), (2, 'yet'), (3, 'any more'), (4, 'yet'), (5, 'any more'),
  (6, 'still'), (7, 'already'), (8, 'still'), (9, 'already'), (10, 'yet'),
  (11, 'still'), (12, 'already'), (13, 'still'), (14, 'any more')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 112: even
-- ============================================================

delete from units where slug = 'unit-112';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 112, 'unit-112', 'even', null,
  'We use even to say that something is unusual or surprising: she has a TV in every room, even the bathroom. even usually goes in the middle of the sentence with the verb, and can combine with a negative (not even, can''t even). even + comparative intensifies (even hotter, even less). even though/when/if + subject + verb introduce a surprising contrast (even though she can''t drive, she has a car) — but even alone (without though/if) cannot be followed directly by subject + verb.', 14
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'even = unusual or surprising',
  'Study this example situation: Tina loves watching TV. She has a television in every room of the house, even the bathroom. We use even to say that something is unusual or surprising. It is not usual to have a television in the bathroom. Some more examples: These pictures are really awful. Even I take better pictures than these. (and I''m certainly not a good photographer) He always wears a coat, even in hot weather. The print was very small. I couldn''t read it, even with glasses. Nobody would help her, not even her best friend. or Not even her best friend would help her.', 0
from units where slug = 'unit-112';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'even in the middle of a sentence',
  'You can use even with the verb in the middle of a sentence (see Unit 110): Laura has travelled all over the world. She''s even been to the Antarctic. They are very rich. They even have their own private jet. You can use even with a negative (not even, can''t even, don''t even etc.): I can''t cook. I can''t even boil an egg. (and boiling an egg is very easy) They weren''t very friendly to us. They didn''t even say hello. Jessica is very fit. She''s been running quite fast and she''s not even out of breath.', 1
from units where slug = 'unit-112';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'even + comparative',
  'You can use even + comparative (cheaper / more expensive etc.): I got up very early, but Jack got up even earlier. I knew I didn''t have much money, but I have even less than I thought. We were very surprised to get an email from her. We were even more surprised when she came to see us a few days later.', 2
from units where slug = 'unit-112';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'even though / even when / even if',
  'We use even though / even when / even if + subject + verb: Even though Tina can''t drive, she has a car. He never shouts, even when he''s angry. This river is dangerous. It''s dangerous to swim in it, even if you''re a strong swimmer. We do not use even + subject + verb. We say: Even though she can''t drive, she has a car. (not even she can''t drive) I can''t reach the shelf even if I stand on a chair. (not even I stand) Compare even if and even (without if): It''s dangerous to swim here even if you''re a strong swimmer. (not even you are) The river is dangerous, even for strong swimmers. Compare even if and if: We''re going to the beach tomorrow. It doesn''t matter what the weather is like. We''re going even if the weather is bad. We want to go to the beach tomorrow, but we won''t go if the weather is bad.', 3
from units where slug = 'unit-112';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-112'
join (values
  ('A', 'She has a television in every room of the house, even the bathroom.', null, 0),
  ('A', 'Even I take better pictures than these.', 'and I''m certainly not a good photographer', 1),
  ('A', 'He always wears a coat, even in hot weather.', null, 2),
  ('A', 'The print was very small. I couldn''t read it, even with glasses.', null, 3),
  ('A', 'Nobody would help her, not even her best friend.', null, 4),
  ('B', 'She''s even been to the Antarctic.', null, 0),
  ('B', 'They even have their own private jet.', null, 1),
  ('B', 'I can''t even boil an egg.', 'and boiling an egg is very easy', 2),
  ('B', 'They didn''t even say hello.', null, 3),
  ('B', 'She''s not even out of breath.', null, 4),
  ('C', 'I got up very early, but Jack got up even earlier.', null, 0),
  ('C', 'I have even less than I thought.', null, 1),
  ('C', 'We were even more surprised when she came to see us a few days later.', null, 2),
  ('D', 'Even though Tina can''t drive, she has a car.', null, 0),
  ('D', 'He never shouts, even when he''s angry.', null, 1),
  ('D', 'It''s dangerous to swim in it, even if you''re a strong swimmer.', null, 2),
  ('D', 'Even though she can''t drive, she has a car.', 'not even she can''t drive', 3),
  ('D', 'I can''t reach the shelf even if I stand on a chair.', 'not even I stand', 4),
  ('D', 'It''s dangerous to swim here even if you''re a strong swimmer.', 'not even you are', 5),
  ('D', 'The river is dangerous, even for strong swimmers.', null, 6),
  ('D', 'We''re going even if the weather is bad.', null, 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 112.1-112.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '112.1', 'Amy, Kate and Lisa are three friends who went on holiday together. Use the information given about them to complete the sentences using even or not even: Amy is usually happy, is usually on time, likes to get up early, is very interested in art; Kate isn''t very keen on art, is usually miserable, usually hates hotels, doesn''t use her camera much; Lisa is almost always late, is a keen photographer, loves staying in hotels, isn''t very good at getting up.', 0
from units where slug = 'unit-112';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-112' where es.title = '112.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'They arranged to meet. They all arrived on time, {0}.', null),
  (2, 'They went to an art gallery. Nobody enjoyed it, {0}.', null),
  (3, 'Yesterday they had to get up early. They all managed to do this, {0}.', null),
  (4, 'They were together yesterday. They were all in a good mood, {0}.', null),
  (5, 'None of them took any pictures, {0}.', null)
) as v(n, template, hint)
where es.title = '112.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '112.1'
join (values
  (1, 'even Lisa'), (2, 'not even Amy'), (3, 'even Lisa'), (4, 'even Kate'), (5, 'not even Lisa')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '112.2', 'Make sentences with even. Use the words in brackets.', 1
from units where slug = 'unit-112';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-112' where es.title = '112.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We painted the whole room. (the floor) We {0}', null),
  (2, 'Rachel has met lots of famous people. (the prime minister) She {0}', null),
  (3, 'You could hear the noise from a long way away. (from the next street) You {0}', null),
  (4, 'I can''t remember anything about her. (her name) I {0}', null),
  (5, 'There isn''t anything to do in this town. (a cinema) {0}', null),
  (6, 'He didn''t tell anybody where he was going. (his wife) {0}', null),
  (7, 'I don''t know anyone in our street. (my neighbours) {0}', null)
) as v(n, template, hint)
where es.title = '112.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '112.2'
join (values
  (1, 'even painted the floor.', array[]::text[]),
  (2, '''s even met the prime minister.', array['has even met the prime minister.']::text[]),
  (3, 'could even hear it from the next street.', array['could even hear the noise from the next street.', 'could hear it even from the next street.']::text[]),
  (4, 'can''t even remember her name.', array[]::text[]),
  (5, 'There isn''t even a cinema.', array[]::text[]),
  (6, 'He didn''t even tell his wife.', array['He didn''t even tell his wife where he was going.']::text[]),
  (7, 'I don''t even know my neighbours.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '112.3', 'Complete the sentences using even + comparative.', 2
from units where slug = 'unit-112';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-112' where es.title = '112.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The church is 700 years old, but the house next to it is {0}.', null),
  (2, 'That''s a very good idea, but I''ve got an {0} one.', null),
  (3, 'The first question was very difficult to answer. The second one was {0}.', null),
  (4, 'I did very badly in the exam, but most of my friends did {0}.', null),
  (5, 'Neither of us was hungry. I ate very little and my friend ate {0}.', null)
) as v(n, template, hint)
where es.title = '112.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '112.3'
join (values
  (1, 'even older'), (2, 'even better'), (3, 'even more difficult'), (4, 'even worse'), (5, 'even less')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '112.4', 'Complete the sentences. Choose from: if, even, even if, even though.', 3
from units where slug = 'unit-112';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-112' where es.title = '112.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The bus leaves in five minutes, but we can still catch it {0} we run.', null),
  (2, 'The bus leaves in two minutes. We won''t catch it now {0} we run.', null),
  (3, 'Mark''s Spanish isn''t very good, {0} after three years in Spain.', null),
  (4, 'Mark''s Spanish isn''t very good, {0} he lived in Spain for three years.', null),
  (5, '{0} with the heating on, it was cold in the house.', null),
  (6, 'I couldn''t sleep {0} I was very tired.', null),
  (7, 'I won''t forgive them for what they did, {0} they apologise.', null),
  (8, '{0} I hadn''t eaten anything for 24 hours, I wasn''t hungry.', null)
) as v(n, template, hint)
where es.title = '112.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '112.4'
join (values
  (1, 'if'), (2, 'even if'), (3, 'even'), (4, 'even though'),
  (5, 'Even'), (6, 'even though'), (7, 'even if'), (8, 'Even though')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
