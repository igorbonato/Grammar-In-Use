-- Marco 4 (slice 56): seeds the fourteenth slice of the "Prepositions"
-- module — unit 134 (Verb + preposition 3: about and of).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 134.3 item 8 (renumbered 7) is the only four-blank item in this module
-- so far.
--
-- Safe to re-run: unit 134 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 134: Verb + preposition 3 about and of
-- ============================================================

delete from units where slug = 'unit-134';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 134, 'unit-134', 'Verb + preposition 3 about and of', null,
  'hear about = be told about something; hear of = know it exists; hear from = be in contact with somebody. think about = consider, concentrate on; think of = produce an idea, or give an opinion (often either works). dream about (while asleep); dream of/about = imagine; wouldn''t dream of = would never do it. complain (to somebody) about a problem, but complain of a pain/illness. remind somebody about something = so they don''t forget it; remind somebody of something = cause them to remember/resemble it.', 13
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'hear about / of / from',
  'hear about ... = be told about something: Did you hear about the fire at the hotel? hear of ... = know that somebody/something exists: ''Who is Tom Hart?'' ''I have no idea. I''ve never heard of him.'' (not heard from him) hear from ... = be in contact with somebody: ''Have you heard from Jane recently?'' ''Yes, she called me a few days ago.''', 0
from units where slug = 'unit-134';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'think about / of',
  'think about something = consider it, concentrate your mind on it: I''ve thought about what you said and I''ve decided to take your advice. ''Will you lend me the money?'' ''I''ll think about it.'' (not think of it) think of something = produce an idea: It was my idea. I thought of it first. (not thought about it) I felt embarrassed. I couldn''t think of anything to say. (not think about anything) We also use think of when we ask for or give an opinion: ''What did you think of the movie?'' ''I didn''t think much of it.'' (= I didn''t like it much) Sometimes the difference is very small and you can use of or about: When I''m alone, I often think of you. or ... think about you. You can say think of or think about doing something (for possible future actions): My sister is thinking of going to Canada. or ... thinking about going ...', 1
from units where slug = 'unit-134';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'dream about / of',
  'dream about ... (when you are asleep): I dreamt about you last night. dream of/about being something / doing something = imagine: Do you dream of being rich and famous? or ... dream about being rich ... I wouldn''t dream of doing something = I would never do it: ''Don''t tell anyone what I said.'' ''No, I wouldn''t dream of it.''', 2
from units where slug = 'unit-134';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'complain about / of',
  'complain (to somebody) about ... = say that you are not satisfied: We complained to the manager of the restaurant about the food. complain of a pain, an illness etc. = say that you have a pain etc.: We called the doctor because George was complaining of a pain in his stomach.', 3
from units where slug = 'unit-134';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'remind somebody about / of',
  'remind somebody about ... = tell somebody not to forget: It''s good you reminded me about the meeting. I''d completely forgotten about it. remind somebody of ... = cause somebody to remember: This house reminds me of the one I lived in when I was a child. Look at this photograph of Richard. Who does he remind you of?', 4
from units where slug = 'unit-134';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-134'
join (values
  ('A', 'Did you hear about the fire at the hotel?', null, 0),
  ('A', 'I''ve never heard of him.', 'not heard from him', 1),
  ('A', 'Have you heard from Jane recently?', null, 2),
  ('B', 'I''ll think about it.', 'not think of it', 0),
  ('B', 'I thought of it first.', 'not thought about it', 1),
  ('B', 'I didn''t think much of it.', '= I didn''t like it much', 2),
  ('B', 'My sister is thinking of going to Canada.', 'or thinking about going', 3),
  ('C', 'I dreamt about you last night.', null, 0),
  ('C', 'Do you dream of being rich and famous?', null, 1),
  ('C', '''I wouldn''t dream of it.''', null, 2),
  ('D', 'We complained to the manager of the restaurant about the food.', null, 0),
  ('D', 'George was complaining of a pain in his stomach.', null, 1),
  ('E', 'It''s good you reminded me about the meeting.', null, 0),
  ('E', 'This house reminds me of the one I lived in when I was a child.', null, 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 134.1-134.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '134.1', 'Complete the sentences using hear or heard + a preposition (about/of/from).', 0
from units where slug = 'unit-134';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-134' where es.title = '134.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''Did you {0} the accident last night?'' ''No, what happened?''', null),
  (2, 'Sarah used to call me quite often, but I haven''t {0} her for a long time now.', null),
  (3, '''Have you {0} William Hudson?'' ''No. Who is he?''', null),
  (4, 'Thanks for your email. It was good to {0} you.', null),
  (5, '''Do you want to {0} our trip?'' ''Not now. Tell me later.''', null),
  (6, 'I live in a very small town. You''ve probably never {0} it.', null)
) as v(n, template, hint)
where es.title = '134.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '134.1'
join (values
  (1, 'hear about'), (2, 'heard from'), (3, 'heard of'),
  (4, 'hear from'), (5, 'hear about'), (6, 'heard of')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '134.2', 'Complete the sentences using think about or think of. Sometimes both about and of are possible. Use the correct form of think (think/thinking/thought).', 1
from units where slug = 'unit-134';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-134' where es.title = '134.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I need time to make decisions. I like to {0} things carefully.', null),
  (2, 'You look serious. What are you {0}?', null),
  (3, 'That''s a good idea. Why didn''t I {0} that?', null),
  (4, 'I don''t really want to meet Tom tonight. I''ll have to {0} an excuse.', null),
  (5, 'I''m {0} buying a new car. What would you advise me to buy?', null),
  (6, 'When I was offered the job, I didn''t accept immediately. I went away and {0} it for a while. In the end I decided to take the job.', null),
  (7, '''I''ve just finished reading the book you lent me.'' ''What did you {0} it? Did you like it?''', null),
  (8, '''Will you be able to help me?'' ''I''m not sure. I''ll {0} it.''', null),
  (9, 'I don''t {0} much {1} this coffee. It''s like water.', null),
  (10, 'Katherine is homesick. She''s always {0} her family back home.', null),
  (11, '''Do you think I should apply to do the course?'' ''I can''t {0} any reason why not.''', null)
) as v(n, template, hint)
where es.title = '134.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '134.2'
join (values
  (1, 0, 'think about', array[]::text[]),
  (2, 0, 'thinking about', array[]::text[]),
  (3, 0, 'think of', array[]::text[]),
  (4, 0, 'think of', array[]::text[]),
  (5, 0, 'thinking of', array['thinking about']::text[]),
  (6, 0, 'thought about', array[]::text[]),
  (7, 0, 'think of', array[]::text[]),
  (8, 0, 'think about', array[]::text[]),
  (9, 0, 'think', array[]::text[]), (9, 1, 'of', array[]::text[]),
  (10, 0, 'thinking about', array['thinking of']::text[]),
  (11, 0, 'think of', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '134.3', 'Put in the correct preposition.', 2
from units where slug = 'unit-134';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-134' where es.title = '134.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I love living here. I wouldn''t dream {0} going anywhere else.', null),
  (2, '''I had a strange dream last night.'' ''Did you? What did you dream {0}?''', null),
  (3, 'I love this music. It reminds me {0} a warm day in spring.', null),
  (4, '''We''ve got no money. What are we going to do?'' ''Don''t worry. I''ll think {0} something.''', null),
  (5, 'Our neighbours complained {0} us {1} the noise we made.', null),
  (6, 'Paul was complaining {0} pains in his chest, so he went to the doctor.', null),
  (7, 'He loves his job. He thinks {0} it all the time, he dreams {1} it, he talks {2} it and I''m fed up with hearing {3} it.', null)
) as v(n, template, hint)
where es.title = '134.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '134.3'
join (values
  (1, 0, 'of'), (2, 0, 'about'), (3, 0, 'of'), (4, 0, 'of'),
  (5, 0, 'to'), (5, 1, 'about'),
  (6, 0, 'of'),
  (7, 0, 'about'), (7, 1, 'about'), (7, 2, 'about'), (7, 3, 'about')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '134.4', 'Complete the sentences using these verbs (in the correct form) + a preposition: complain, dream, hear, remind, remind, think.', 3
from units where slug = 'unit-134';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-134' where es.title = '134.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ben is never satisfied. He''s always {0} something.', null),
  (2, 'I can''t make a decision yet. I need time to {0} your proposal.', null),
  (3, 'He''s not a well-known singer. Not many people have {0} him.', null),
  (4, '''You wouldn''t go away without telling me, would you?'' ''Of course not. I wouldn''t {0} it.''', null),
  (5, 'I would have forgotten my appointment if you hadn''t {0} me {1} it.', null),
  (6, 'Do you see that man over there? Does he {0} you {1} anybody you know?', null)
) as v(n, template, hint)
where es.title = '134.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '134.4'
join (values
  (1, 0, 'complaining about'),
  (2, 0, 'think about'),
  (3, 0, 'heard of'),
  (4, 0, 'dream of'),
  (5, 0, 'reminded'), (5, 1, 'about'),
  (6, 0, 'remind'), (6, 1, 'of')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
