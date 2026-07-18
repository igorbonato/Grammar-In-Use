-- Marco 4 (slice 67): seeds the ninth and FINAL slice of the
-- "Phrasal verbs" module — unit 145 (Phrasal verbs 9: away/back).
--
-- This is the LAST unit in the entire book (units 1-145 confirmed
-- via grep, no "146" header exists). Completing this unit finishes
-- Marco 4 (full-book content ingestion) end to end.
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Section C's raw pdftotext output is corrupted by an OCR/column
-- overlap (two columns of text interleaved character-by-character).
-- Reconstructed from the book's own well-known content: "throw
-- something back = throw it to the person who threw it to you" —
-- confirmed correct by cross-referencing exercise 145.1 item 5
-- ("Ellie threw the ball to Ben and he threw it back (to her)"),
-- which only makes sense with that gloss.
--
-- 145.1 is picture-based (6 small scenes) — a theory_images
-- placeholder plus each scene rebuilt from its caption.
--
-- Safe to re-run: unit 145 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 145: Phrasal verbs 9 away/back
-- ============================================================

delete from units where slug = 'unit-145';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 145, 'unit-145', 'Phrasal verbs 9 away/back', null,
  'away = away from home/a place/a person (go away, drive away, fly away, blow away, take away); back = back home / back to a place (be back, walk back, give something back, put something back; also go back, come back, get back, take something back). Other verbs + away: get away = escape; get away with something = do wrong without being caught; keep away (from) = don''t go near; give something away = give it to somebody else; put something away = put it where it is usually kept; throw something away = put it in the rubbish. Other verbs + back: throw something back = throw it to the person who threw it to you; call/phone/ring somebody back = return a phone call; get back to somebody = reply to them; look back (on something) = think about the past; pay back money / pay somebody back.', 8
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Compare away and back',
  'away = away from home: We''re going away on holiday today. away = away from a place, a person etc.: Sarah got into her car, started the engine and drove away. I tried to take a picture of the bird, but it flew away. I dropped the ticket, and it blew away in the wind. The police searched the house and took away a computer. In the same way you can say: walk away, run away, look away etc. back = back home: We''ll be back in three weeks. back = back to a place, a person etc.: I''m going out now. What time will you be back? After eating at a restaurant, we walked back to our hotel. I''ve still got Jane''s keys. I forgot to give them back to her. When you''ve finished with that book, can you put it back on the shelf? In the same way you can say: go back, come back, get back, take something back etc.', 0
from units where slug = 'unit-145';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Other verbs + away',
  'get away = escape, leave with difficulty. get away with something = do something wrong without being caught. keep away (from ...) = don''t go near. give something away = give it to somebody else because you don''t want it any more. put something away = put it in the place where it is usually kept. throw something away = put it in the rubbish.', 1
from units where slug = 'unit-145';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Other verbs + back',
  'throw something back = throw it to the person who threw it to you. call/phone/ring (somebody) back = return a phone call. get back to somebody = reply to them by phone etc. look back (on something) = think about what happened in the past. pay back money, pay somebody back.', 2
from units where slug = 'unit-145';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-145'
join (values
  ('B', 'We tried to catch the thief, but she got away.', null, 0),
  ('B', 'I parked in a no-parking zone, but I got away with it. I didn''t have to pay a fine.', null, 1),
  ('B', 'Keep away from the edge of the pool. You might fall in.', null, 2),
  ('B', '''Did you sell your bike?'' ''No, I gave it away to a friend.''', null, 3),
  ('B', 'When the children finished playing with their toys, they put them away.', null, 4),
  ('B', 'I kept the letter, but I threw away the envelope.', null, 5),
  ('C', 'Ellie threw the ball to Ben and he threw it back.', null, 0),
  ('C', 'I can''t talk to you now. I''ll call you back in ten minutes.', null, 1),
  ('C', 'I sent him an email, but he never got back to me.', null, 2),
  ('C', 'My first job was in a travel agency. I didn''t like it much at the time but, looking back on it, I learnt a lot and it was a useful experience.', null, 3),
  ('C', 'If you borrow money, you have to pay it back.', null, 4),
  ('C', 'Thanks for lending me the money. I''ll pay you back next week.', null, 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 145.1-145.4; each renumbered from 1,
-- dropping the book's own worked example)
-- ------------------------------------------------------------

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: six small pictures used in exercise 145.1 — a woman waving to a man, who waves back; a £20 note blowing away in the wind; a woman putting a letter back in its envelope after reading it; a man trying to talk to a woman who walks away from him; Ellie and Ben throwing a ball back and forth; a man throwing away a pair of worn-out shoes]', 0
from units where slug = 'unit-145';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '145.1', 'Look at the pictures and complete the sentences.', 0
from units where slug = 'unit-145';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-145' where es.title = '145.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was windy. I dropped a £20 note and it {0}.', null),
  (2, 'She opened the letter, read it and {0} in the envelope.', null),
  (3, 'He tried to talk to her, but she just {0}.', null),
  (4, 'Ellie threw the ball to Ben and he {0}.', null),
  (5, 'His shoes were worn out, so he {0}.', null)
) as v(n, template, hint)
where es.title = '145.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '145.1'
join (values
  (1, 'blew away', array[]::text[]),
  (2, 'put it back', array[]::text[]),
  (3, 'walked away', array[]::text[]),
  (4, 'threw it back', array['threw it back to her']::text[]),
  (5, 'threw them away', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '145.2', 'Complete the sentences. Use a verb + away or back.', 1
from units where slug = 'unit-145';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-145' where es.title = '145.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I haven''t seen our neighbours for a while. I think they must {0}.', null),
  (2, '''I''m going out now.'' ''OK. What time will you {0}?''', null),
  (3, 'I saw a man trying to break into a car. When he saw me, he {0}.', null),
  (4, 'If you cheat in the exam, you might {0} with it, or you might get caught.', null),
  (5, 'Be careful! That''s an electric fence. Make sure you {0} from it.', null),
  (6, 'He wasn''t very friendly. I smiled at him, but he didn''t {0}.', null)
) as v(n, template, hint)
where es.title = '145.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '145.2'
join (values
  (1, 'be away', array['have gone away']::text[]),
  (2, 'be back', array[]::text[]),
  (3, 'ran away', array[]::text[]),
  (4, 'get away', array[]::text[]),
  (5, 'keep away', array['keep back']::text[]),
  (6, 'smile back', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '145.3', 'Complete the sentences. Use only one word each time.', 2
from units where slug = 'unit-145';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-145' where es.title = '145.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'This box could be useful, so I won''t {0} it away.', null),
  (2, 'Jane doesn''t do anything at work. I don''t know how she {0} away with it.', null),
  (3, 'I''m going out now. I''ll {0} back in about an hour.', null),
  (4, 'You should think more about the future. Don''t {0} back all the time.', null),
  (5, 'Gary is very generous. He won some money in the lottery and {0} it all away.', null),
  (6, 'I''ll {0} back to you as soon as I have the information you need.', null),
  (7, 'I washed the dishes, dried them and {0} them away.', null)
) as v(n, template, hint)
where es.title = '145.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '145.3'
join (values
  (1, 'throw'), (2, 'gets'), (3, 'be'), (4, 'look'),
  (5, 'gave'), (6, 'get'), (7, 'put')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '145.4', 'Complete the sentences. Use the verb in brackets + away or back.', 3
from units where slug = 'unit-145';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-145' where es.title = '145.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A: Do you want this magazine? B: No, I''ve finished with it. You can {0}.', '(throw)'),
  (2, 'A: How are your new jeans? Do they fit you OK? B: No, they''re too tight. I''m going to {0} to the shop.', '(take)'),
  (3, 'A: Here''s the money you asked me to lend you. B: Thanks. I''ll {0} as soon as I can.', '(pay)'),
  (4, 'A: What happened to all the books you used to have? B: I didn''t want them any more, so I {0}.', '(give)'),
  (5, 'A: Did you phone Sarah? B: Yes, I left a message for her, but she hasn''t {0}.', '(call)')
) as v(n, template, hint)
where es.title = '145.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '145.4'
join (values
  (1, 'throw it away', array[]::text[]),
  (2, 'take them back', array[]::text[]),
  (3, 'pay you back', array['pay it back']::text[]),
  (4, 'gave them away', array[]::text[]),
  (5, 'called back', array['called me back']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
