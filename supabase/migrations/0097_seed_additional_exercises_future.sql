-- Additional exercises 10-13: "The future" (Units 19-25, Appendix 3).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 11 ("Choose the best alternative", lettered A/B/C) follows
-- the project's established "which is correct" convention: the
-- blank's correct answer is the full correct phrase, not a letter.
-- Exercise 12's four numbered sub-dialogues are each kept as one
-- exercise_sentences row with several blanks (blank_index) rather
-- than split per turn, since each sub-dialogue's Key answers are
-- numbered as one continuous set; sub-dialogue 1's item (1) is the
-- book's own worked example (Key starts at (2)) — the other three
-- sub-dialogues have no dropped example (Key starts at (1)).
--
-- Linked to units 19-25 via exercise_set_units, matching this
-- group's own printed subtitle (Appendix 3 isn't a linkable unit row).
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 10', 'Additional exercise 11', 'Additional exercise 12', 'Additional exercise 13') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 10',
  'What do you say to Joe in these situations? Use the words given in brackets. Use the present continuous (I am doing), going to or will (I''ll).', 0
from units u where u.slug = 'unit-19';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-19','unit-20','unit-21','unit-22','unit-23','unit-24','unit-25')
where es.title = 'Additional exercise 10' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You have made an appointment with the dentist for Friday morning. JOE: Shall we meet on Friday morning? YOU: I can''t on Friday. {0}', '(I / go)'),
  (2, 'You and some friends are planning a holiday in Spain. You have decided to rent a car, but you haven''t arranged this yet. JOE: How do you plan to travel round Spain? By train? YOU: No, {0}', '(we / rent)'),
  (3, 'Joe reminds you that you have to call your sister. You completely forgot. JOE: Did you call your sister? YOU: No, I forgot. Thanks for reminding me. {0}', '(I / call / now)'),
  (4, 'You have already arranged to have lunch with Sue tomorrow. JOE: Are you free at lunchtime tomorrow? YOU: No, {0}', '(have lunch)'),
  (5, 'You are in a restaurant. You and Joe are looking at the menu. Maybe Joe has decided what to have. You ask him. YOU: What {0}? JOE: I don''t know. I can''t make up my mind.', '(you / have)'),
  (6, 'Joe is reading, but it''s getting dark. He''s having trouble reading. You turn on the light. JOE: It''s getting dark and it''s hard to read. YOU: Yes, {0}', '(I / turn on)'),
  (7, 'You and Joe are sitting in a room with the window open. It''s getting cold. You decide to close the window. You stand up and walk towards it. JOE: What are you doing? YOU: {0}', '(I / close)')
) as v(n, template, hint)
where es.title = 'Additional exercise 10';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 10' and es.kind = 'additional'
join (values
  (1, 'I''m going to the dentist.', array[]::text[]),
  (2, 'we''re going to rent a car.', array[]::text[]),
  (3, 'I''ll call her now.', array[]::text[]),
  (4, 'I''m having lunch with Sue.', array[]::text[]),
  (5, 'are you going to have', array['are you having']::text[]),
  (6, 'I''ll turn on the light.', array[]::text[]),
  (7, 'I''m going to close the window.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 11', 'Choose the best alternative.', 1
from units u where u.slug = 'unit-19';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-19','unit-20','unit-21','unit-22','unit-23','unit-24','unit-25')
where es.title = 'Additional exercise 11' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, '''I can''t open this bottle.'' ''Give it to me. {0} it.'' Which is correct — A I open, B I''ll open, or C I''m going to open?'),
  (2, '''Is Emily here yet?'' ''Not yet. I''ll let you know as soon as {0}.'' Which is correct — A she arrives, B she''s arriving, or C she''ll arrive?'),
  (3, '''Are you free tomorrow afternoon?'' ''No, {0}.'' Which is correct — A I work, B I''m working, or C I''ll work?'),
  (4, '''What time is the film tonight?'' ''{0} at 8.40.'' Which is correct — A It starts, B It''s going to start, or C It will start?'),
  (5, '''Are you going to the beach tomorrow?'' ''Yes, if the weather {0} good.'' Which is correct — A is going to be, B will be, or C is?'),
  (6, '''What time {0} tomorrow?'' ''How about 8.30?'' Which is correct — A do we meet, B are we meeting, or C shall we meet?'),
  (7, '''When {0}?'' ''Tomorrow.'' Which is correct — A does the festival finish, B is the festival finished, or C is the festival finishing?')
) as v(n, template)
where es.title = 'Additional exercise 11';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 11' and es.kind = 'additional'
join (values
  (1, 'I''ll open'),
  (2, 'she arrives'),
  (3, 'I''m working'),
  (4, 'It starts'),
  (5, 'is'),
  (6, 'shall we meet'),
  (7, 'does the festival finish')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 12', 'Put the verb into the most suitable form. Sometimes there is more than one possibility.', 2
from units u where u.slug = 'unit-19';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-19','unit-20','unit-21','unit-22','unit-23','unit-24','unit-25')
where es.title = 'Additional exercise 12' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'A has decided to learn a language. a: I''ve decided to try and learn a foreign language. b: Have you? Which language are you going to learn? a: Spanish. b: {0} a course? a: Yes, {1} next week. b: That''s great. I''m sure {2} it. a: I hope so. But I think {3} difficult.'),
  (2, 'A wants to know about B''s holiday plans. a: I hear {0} on holiday soon. b: That''s right. {1} to Finland. a: I hope {2} a nice time. b: Thanks. {3} in touch with you when {4} back and maybe we can meet sometime.'),
  (3, 'A invites B to a party. a: {0} a party next Saturday. Can you come? b: On Saturday? I''m not sure. Some friends of mine {1} to stay with me next week, but I think {2} by Saturday. But if {3} still here, {4} able to come to the party. a: OK. Well, tell me as soon as {5}. b: Right. {6} you during the week.'),
  (4, 'A and B are two secret agents arranging a meeting. They are talking on the phone. a: Well, what time {0}? b: Come to the cafe by the station at 4 o''clock. {1} for you when {2}. {3} by the window and {4} a bright green sweater. a: OK. {5} too? b: No, she can''t be there. a: Oh. {6} the documents? b: Yes. {7} everything when {8} you. And don''t be late. a: OK. {9} to be on time.')
) as v(n, template)
where es.title = 'Additional exercise 12';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 12' and es.kind = 'additional'
join (values
  (1, 0, 'Are you going to do', array['Are you doing']::text[]),
  (1, 1, 'it starts', array[]::text[]),
  (1, 2, 'you''ll enjoy', array['you''re going to enjoy']::text[]),
  (1, 3, 'it will be', array['it''s going to be']::text[]),
  (2, 0, 'you''re going', array[]::text[]),
  (2, 1, 'We''re going', array[]::text[]),
  (2, 2, 'you have', array[]::text[]),
  (2, 3, 'I''ll get', array[]::text[]),
  (2, 4, 'I get', array[]::text[]),
  (3, 0, 'I''m having', array['I''m going to have']::text[]),
  (3, 1, 'are coming', array[]::text[]),
  (3, 2, 'they''ll have left', array[]::text[]),
  (3, 3, 'they''re', array[]::text[]),
  (3, 4, 'I won''t be', array['I will not be']::text[]),
  (3, 5, 'you know', array[]::text[]),
  (3, 6, 'I''ll call', array[]::text[]),
  (4, 0, 'shall we meet', array[]::text[]),
  (4, 1, 'I''ll be waiting', array[]::text[]),
  (4, 2, 'you arrive', array[]::text[]),
  (4, 3, 'I''ll be sitting', array[]::text[]),
  (4, 4, 'I''ll be wearing', array[]::text[]),
  (4, 5, 'Is Agent 307 coming', array['Is Agent 307 going to come', 'Will Agent 307 be coming']::text[]),
  (4, 6, 'Shall I bring', array[]::text[]),
  (4, 7, 'I''ll explain', array['I''m going to explain']::text[]),
  (4, 8, 'I see', array[]::text[]),
  (4, 9, 'I''ll try', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 13',
  'Put the verb into the correct form. Choose from the following: present continuous (I am doing), present simple (I do), going to (I''m going to do), will (''ll) / won''t, will be doing, shall.', 3
from units u where u.slug = 'unit-19';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-19','unit-20','unit-21','unit-22','unit-23','unit-24','unit-25')
where es.title = 'Additional exercise 13' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'I feel a bit hungry. I think {0} something to eat.'),
  (2, 'Why are you putting on your coat? {0} somewhere?'),
  (3, 'What time {0} you tomorrow? About 10.30?'),
  (4, 'Look! That plane is flying towards the airport. {0}.'),
  (5, 'We must do something soon, before {0} too late.'),
  (6, 'I''m sorry you''ve decided to leave the company. {0} you when {1}.'),
  (7, '{0} you my phone number? If {1} you my number, {2} me?'),
  (8, 'Are you still watching that programme? What time {0}?'),
  (9, '{0} to a wedding next weekend. My cousin {1} married.'),
  (10, 'I''m not ready yet. {0} you when {1} ready. I promise {2} very long.'),
  (11, '{0} my hair cut tomorrow. I''ve just made an appointment.'),
  (12, 'She was very rude to me. I won''t speak to her again until {0}.'),
  (13, 'I wonder where {0} ten years from now.'),
  (14, 'What are you planning to do when {0} your course at college?')
) as v(n, template)
where es.title = 'Additional exercise 13';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 13' and es.kind = 'additional'
join (values
  (1, 0, 'I''ll have', array[]::text[]),
  (2, 0, 'Are you going', array[]::text[]),
  (3, 0, 'shall I phone', array[]::text[]),
  (4, 0, 'It''s going to land', array[]::text[]),
  (5, 0, 'it''s', array['it is']::text[]),
  (6, 0, 'I''ll miss', array['I''m going to miss']::text[]), (6, 1, 'you go', array['you''ve gone']::text[]),
  (7, 0, 'Shall I give', array[]::text[]), (7, 1, 'I give', array[]::text[]), (7, 2, 'will you call', array[]::text[]),
  (8, 0, 'does it finish', array[]::text[]),
  (9, 0, 'I''m going', array[]::text[]), (9, 1, 'is getting', array[]::text[]),
  (10, 0, 'I''ll tell', array[]::text[]), (10, 1, 'I''m', array[]::text[]), (10, 2, 'I won''t be', array[]::text[]),
  (11, 0, 'I''m going to have', array['I''m having']::text[]),
  (12, 0, 'she apologises', array[]::text[]),
  (13, 0, 'we''ll be living', array['we''ll live']::text[]),
  (14, 0, 'you finish', array['you''ve finished']::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
