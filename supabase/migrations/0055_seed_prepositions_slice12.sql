-- Marco 4 (slice 54): seeds the twelfth slice of the "Prepositions"
-- module — unit 132 (Verb + preposition 1: to and at).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 132.1 ("Which is correct?") is adapted to a short-answer format: the
-- blank's correct answer is literally "a" or "b", same convention as
-- 121.3/0044.
--
-- Safe to re-run: unit 132 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 132: Verb + preposition 1 to and at
-- ============================================================

delete from units where slug = 'unit-132';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 132, 'unit-132', 'Verb + preposition 1 to and at', null,
  'talk/speak/listen/apologise/explain/describe take to (explain/describe something TO somebody, never explain somebody). But phone/call/email/text/answer/ask/thank somebody take NO preposition at all. look/stare/glance/laugh/aim/point/shoot/fire take at. shout, throw etc. can take either at (aggressive, to hit) or to (so they can hear, to catch), with a real difference in meaning.', 11
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verb + to',
  'talk / speak to somebody (talk/speak with is also possible): Who were you talking to? listen to ...: When I''m driving, I like to listen to the radio. (not listen the radio) apologise to somebody (for ...): They apologised to me for their mistake. (not apologised me) explain something to somebody: Can you explain this word to me? (not explain me this word) explain / describe (to somebody) what/how/why ...: I explained to them why I was worried. (not I explained them) Let me describe to you what I saw. (not Let me describe you)', 0
from units where slug = 'unit-132';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'phone somebody, ask somebody etc. (without to)',
  'phone / call / email / text somebody: I called the airline to cancel my flight. (not called to the airline) But we say ''write (a letter) to somebody''. answer somebody/something: You didn''t answer my email. (not answer to my email) But we say reply to (an email / a letter etc.). ask somebody (a question): If there''s anything you want to know, you can ask me. (not ask to me) thank somebody (for ...): He thanked me for helping him. (not He thanked to me)', 1
from units where slug = 'unit-132';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'verb + at',
  'look / stare / glance at ..., have a look / take a look at ...: Why are you looking at me like that? laugh at ...: I look stupid with this haircut. Everybody will laugh at me. aim / point (something) at ..., shoot / fire (a gun) at ...: Don''t point that knife at me. It''s dangerous. We saw someone with a gun shooting at birds, but he didn''t hit any.', 2
from units where slug = 'unit-132';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'at or to, with a difference in meaning',
  'Some verbs can be followed by at or to, with a difference in meaning. For example: shout at somebody (when you are angry or aggressive): He got very angry and started shouting at me. shout to somebody (so that they can hear you): He shouted to me from the other side of the street. throw something at somebody/something (to hit them): Somebody threw an egg at the politician. throw something to somebody (for somebody to catch): Lisa shouted ''Catch!'' and threw the keys to me from the window.', 3
from units where slug = 'unit-132';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-132'
join (values
  ('A', 'Who were you talking to?', null, 0),
  ('A', 'Can you explain this word to me?', 'not explain me this word', 1),
  ('B', 'I called the airline to cancel my flight.', 'not called to the airline', 0),
  ('B', 'You didn''t answer my email.', 'not answer to my email', 1),
  ('B', 'He thanked me for helping him.', 'not He thanked to me', 2),
  ('C', 'Why are you looking at me like that?', null, 0),
  ('C', 'Everybody will laugh at me.', null, 1),
  ('C', 'Don''t point that knife at me.', null, 2),
  ('D', 'He got very angry and started shouting at me.', null, 0),
  ('D', 'He shouted to me from the other side of the street.', null, 1),
  ('D', 'Somebody threw an egg at the politician.', null, 2),
  ('D', 'Lisa threw the keys to me from the window.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 132.1-132.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '132.1', 'Which is correct, a or b?', 0
from units where slug = 'unit-132';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-132' where es.title = '132.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a I got angry with Mark. Afterwards, I apologised to him. b I got angry with Mark. Afterwards, I apologised him. Which is correct? {0}', null),
  (2, 'a Amy won''t be able to help you. There''s no point in asking to her. b Amy won''t be able to help you. There''s no point in asking her. Which is correct? {0}', null),
  (3, 'a I need somebody to explain me what I have to do. b I need somebody to explain to me what I have to do. Which is correct? {0}', null),
  (4, 'a They didn''t understand the system, so I explained it to them. b They didn''t understand the system, so I explained it them. Which is correct? {0}', null),
  (5, 'a I like to sit on the beach and listen to the sound of the sea. b I like to sit on the beach and listen the sound of the sea. Which is correct? {0}', null),
  (6, 'a I asked them to describe me exactly what happened. b I asked them to describe to me exactly what happened. Which is correct? {0}', null),
  (7, 'a We''d better phone the restaurant to reserve a table. b We''d better phone to the restaurant to reserve a table. Which is correct? {0}', null),
  (8, 'a It was a difficult question. I couldn''t answer to it. b It was a difficult question. I couldn''t answer it. Which is correct? {0}', null),
  (9, 'a I explained everybody the reasons for my decision. b I explained to everybody the reasons for my decision. Which is correct? {0}', null),
  (10, 'a I thanked everybody for all the help they had given me. b I thanked to everybody for all the help they had given me. Which is correct? {0}', null),
  (11, 'a My friend texted to me to let me know she was going to be late. b My friend texted me to let me know she was going to be late. Which is correct? {0}', null)
) as v(n, template, hint)
where es.title = '132.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '132.1'
join (values
  (1, 'a'), (2, 'b'), (3, 'b'), (4, 'a'), (5, 'a'),
  (6, 'b'), (7, 'a'), (8, 'b'), (9, 'b'), (10, 'a'), (11, 'b')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '132.2', 'Complete the sentences. Use these verbs + the correct preposition: explain, listen, look, point, reply, speak, throw, throw.', 1
from units where slug = 'unit-132';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-132' where es.title = '132.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We live in the same building, but we''ve never {0} one another.', null),
  (2, 'Be careful with those scissors! Don''t {0} them {1} me!', null),
  (3, 'You shouldn''t {0} directly {1} the sun. You''ll damage your eyes.', null),
  (4, 'Please {0} me! I''ve got something important to tell you.', null),
  (5, 'Don''t {0} stones {1} the birds!', null),
  (6, 'If you don''t want that sandwich, {0} it {1} the birds. They''ll eat it.', null),
  (7, 'I tried to contact Tina, but she didn''t {0} my emails.', null)
) as v(n, template, hint)
where es.title = '132.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '132.2'
join (values
  (1, 0, 'spoken to'),
  (2, 0, 'point'), (2, 1, 'at'),
  (3, 0, 'look'), (3, 1, 'at'),
  (4, 0, 'listen to'),
  (5, 0, 'throw'), (5, 1, 'at'),
  (6, 0, 'throw'), (6, 1, 'to'),
  (7, 0, 'reply to')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '132.3', 'Put in to or at.', 2
from units where slug = 'unit-132';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-132' where es.title = '132.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I glanced {0} my watch to see what time it was.', null),
  (2, 'Please don''t shout {0} me! Try to calm down.', null),
  (3, 'I saw Lisa and shouted {0} her, but she didn''t hear me.', null),
  (4, 'Don''t listen {0} what he says. He doesn''t know what he''s talking about.', null),
  (5, 'What''s so funny? What are you laughing {0}?', null),
  (6, 'Is it all right if I have a look {0} your magazine?', null),
  (7, 'I''m lonely. I need somebody to talk {0}.', null),
  (8, 'She was so angry she threw a book {0} the wall.', null),
  (9, 'The woman sitting opposite me on the train kept staring {0} me.', null),
  (10, 'Do you have a moment? I need to speak {0} you.', null)
) as v(n, template, hint)
where es.title = '132.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '132.3'
join (values
  (1, 'at'), (2, 'at'), (3, 'to'), (4, 'to'), (5, 'at'),
  (6, 'at'), (7, 'to'), (8, 'at'), (9, 'at'), (10, 'to')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
