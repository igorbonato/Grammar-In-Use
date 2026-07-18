-- Marco 4 (slice 52): seeds the tenth slice of the "Prepositions" module
-- — unit 130 (Adjective + preposition 1).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 130.3 item 24 (renumbered 23) is the only two-blank item in this
-- exercise.
--
-- Safe to re-run: unit 130 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 130: Adjective + preposition 1
-- ============================================================

delete from units where slug = 'unit-130';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 130, 'unit-130', 'Adjective + preposition 1', null,
  'nice/kind/generous/stupid etc. + of somebody (to do something), but nice/kind/rude etc. + to somebody. angry/annoyed/upset about something, but with somebody for doing something. excited/worried/nervous about something, but pleased/satisfied/disappointed with something you get. surprised/shocked at or by something; impressed with/by; fed up/bored with; tired of. sorry about a situation, but sorry for/about something you did — and sorry for somebody in a bad situation.', 9
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'nice of you, nice to me',
  'nice / kind / good / generous / polite / honest / stupid / silly etc. + of somebody (to do something): Thank you. It was very nice of you to help me. It was stupid of me to go out without a coat in such cold weather. (be) nice / kind / good / generous / polite / rude / friendly / cruel etc. + to somebody: They have always been very nice to me. (not with me) Why were you so unfriendly to Lucy?', 0
from units where slug = 'unit-130';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'adjective + about / with',
  'angry / annoyed / furious / upset about something, but with somebody for doing something: There''s no point in getting angry about things that don''t matter. Are you annoyed with me for being late? Lisa is upset about not being invited to the party. excited / worried / nervous / happy etc. about something: Are you nervous about the exam? pleased / satisfied / happy / delighted / disappointed with something you get or experience: They were delighted with the present I gave them. Were you happy with your exam results?', 1
from units where slug = 'unit-130';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'adjective + at / by / with / of',
  'surprised / shocked / amazed / astonished / upset at / by something: Everybody was surprised at the news. or ... by the news. I hope you weren''t shocked by what I said. or ... at what I said. impressed with / by somebody/something: I''m very impressed with (or by) her English. It''s very good. fed up / bored with something: I don''t enjoy my job any more. I''m fed up with it. / I''m bored with it. tired of something: Come on, let''s go! I''m tired of waiting.', 2
from units where slug = 'unit-130';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'sorry about / for',
  'sorry about a situation or something that happened: I''m sorry about the mess. I''ll clear it up later. Sorry about last night. (= Sorry about something that happened last night) sorry for / about something you did or caused: I''m sorry for shouting at you yesterday. (or sorry about shouting) Sorry for the delay. (or Sorry about the delay) You can also say ''I''m sorry I (did something)'': I''m sorry I shouted at you yesterday. feel / be sorry for somebody in a bad situation: I feel sorry for Mark. He''s had a lot of bad luck. (not I feel sorry about Mark)', 3
from units where slug = 'unit-130';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-130'
join (values
  ('A', 'It was very nice of you to help me.', null, 0),
  ('A', 'They have always been very nice to me.', 'not with me', 1),
  ('B', 'Are you annoyed with me for being late?', null, 0),
  ('B', 'Are you nervous about the exam?', null, 1),
  ('B', 'They were delighted with the present I gave them.', null, 2),
  ('C', 'Everybody was surprised at the news.', 'or by the news', 0),
  ('C', 'I''m very impressed with (or by) her English.', null, 1),
  ('C', 'I don''t enjoy my job any more. I''m fed up with it.', null, 2),
  ('C', 'Come on, let''s go! I''m tired of waiting.', null, 3),
  ('D', 'I''m sorry about the mess. I''ll clear it up later.', null, 0),
  ('D', 'I''m sorry for shouting at you yesterday.', 'or sorry about shouting', 1),
  ('D', 'I feel sorry for Mark. He''s had a lot of bad luck.', 'not I feel sorry about Mark', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 130.1-130.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '130.1', 'Complete the sentences using nice of ..., kind of ... etc.', 0
from units where slug = 'unit-130';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-130' where es.title = '130.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I needed money and Lisa gave me some. (generous) That {0}', null),
  (2, 'They didn''t invite us to their party. (not very nice) That {0}', null),
  (3, 'Can I help you with your luggage? (very kind) That''s {0}', null),
  (4, 'Kevin never says ''thank you''. (not very polite) That {0}', null),
  (5, 'They''ve had an argument and now they refuse to speak to each other. (a bit childish) That''s {0}', null)
) as v(n, template, hint)
where es.title = '130.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '130.1'
join (values
  (1, 'was generous of her.'),
  (2, 'wasn''t very nice of them.'),
  (3, 'very kind of you.'),
  (4, 'isn''t very polite of him.'),
  (5, 'a bit childish of them.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '130.2', 'Complete the sentences using an adjective + preposition. Choose from: amazed, angry, bored, careless, excited, impressed, kind.', 1
from units where slug = 'unit-130';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-130' where es.title = '130.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Thank you for all you''ve done. You''ve been very {0} me.', null),
  (2, 'What have I done wrong? Why are you {0} me?', null),
  (3, 'You must be very {0} your trip next week. It sounds really great.', null),
  (4, 'I wasn''t {0} the service in the restaurant. We had to wait ages.', null),
  (5, 'Ben isn''t very happy at college. He says he''s {0} the course he''s doing.', null),
  (6, 'I''d never seen so many people before. I was {0} the crowds.', null),
  (7, 'It was {0} you to leave the car unlocked while you were shopping.', null)
) as v(n, template, hint)
where es.title = '130.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '130.2'
join (values
  (1, 'kind to', array[]::text[]),
  (2, 'angry with', array[]::text[]),
  (3, 'excited about', array[]::text[]),
  (4, 'impressed by', array['impressed with']::text[]),
  (5, 'bored with', array['bored by']::text[]),
  (6, 'amazed at', array['amazed by']::text[]),
  (7, 'careless of', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '130.3', 'Put in the correct preposition.', 2
from units where slug = 'unit-130';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-130' where es.title = '130.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was nice {0} you to come and see me when I was ill.', null),
  (2, 'Why are you always so rude {0} people? Why can''t you be more polite?', null),
  (3, 'We always have the same food every day. I''m fed up {0} it.', null),
  (4, 'We had a good holiday, but we were disappointed {0} the hotel.', null),
  (5, 'I can''t understand people who are cruel {0} animals.', null),
  (6, 'I was surprised {0} the way he behaved. It was completely out of character.', null),
  (7, 'I''ve been trying to learn Japanese, but I''m not very satisfied {0} my progress.', null),
  (8, 'Tanya doesn''t look very well. I''m worried {0} her.', null),
  (9, 'I''m sorry {0} yesterday. I completely forgot we''d arranged to meet.', null),
  (10, 'There''s no point in feeling sorry {0} yourself. It won''t help you.', null),
  (11, 'Are you still upset {0} what I said to you yesterday?', null),
  (12, 'Some people say Kate is unfriendly, but she''s always been very nice {0} me.', null),
  (13, 'I''m tired {0} doing the same thing every day. I need a change.', null),
  (14, 'We interviewed ten people for the job, and we weren''t impressed {0} any of them.', null),
  (15, 'Vicky is annoyed {0} me because I didn''t agree with her.', null),
  (16, 'I''m sorry {0} the smell in this room. I''ve just finished painting it.', null),
  (17, 'I was shocked {0} what I saw. I''d never seen anything like it before.', null),
  (18, 'Jack is sorry {0} what he did. He won''t do it again.', null),
  (19, 'The hotel was incredibly expensive. I was amazed {0} the price of a room.', null),
  (20, 'Paul made the wrong decision. It was honest {0} him to admit it.', null),
  (21, 'You''ve been very generous {0} me. You''ve helped me a lot.', null),
  (22, 'Our neighbours were very angry {0} the noise we made.', null),
  (23, 'Our neighbours were furious {0} us {1} making so much noise.', null)
) as v(n, template, hint)
where es.title = '130.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '130.3'
join (values
  (1, 0, 'of', array[]::text[]),
  (2, 0, 'to', array[]::text[]),
  (3, 0, 'with', array[]::text[]),
  (4, 0, 'with', array['by', 'in']::text[]),
  (5, 0, 'to', array[]::text[]),
  (6, 0, 'at', array['by']::text[]),
  (7, 0, 'with', array[]::text[]),
  (8, 0, 'about', array[]::text[]),
  (9, 0, 'about', array[]::text[]),
  (10, 0, 'for', array[]::text[]),
  (11, 0, 'about', array['by', 'at']::text[]),
  (12, 0, 'to', array[]::text[]),
  (13, 0, 'of', array[]::text[]),
  (14, 0, 'by', array['with']::text[]),
  (15, 0, 'with', array[]::text[]),
  (16, 0, 'about', array[]::text[]),
  (17, 0, 'at', array['by']::text[]),
  (18, 0, 'for', array['about']::text[]),
  (19, 0, 'at', array['by']::text[]),
  (20, 0, 'of', array[]::text[]),
  (21, 0, 'to', array[]::text[]),
  (22, 0, 'about', array[]::text[]),
  (23, 0, 'with', array[]::text[]), (23, 1, 'for', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
