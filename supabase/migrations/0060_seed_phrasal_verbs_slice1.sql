-- Marco 4 (slice 59): seeds the first slice of the "Phrasal verbs" module
-- — unit 137 (Phrasal verbs 1: Introduction). This is the FINAL module in
-- the book.
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Grepped unit-number headers across the whole file before assuming its
-- range (same check applied to every oversized PDF since Modals.pdf):
-- this file spans units 137-145 (9 units, confirmed no "146" header). New
-- module `phrasal-verbs`, order_index 15, seeded one unit per migration
-- slice per the standing feedback memory, built via small Write +
-- incremental Edit calls, with a missing-{0}-placeholder grep run after
-- every slice.
--
-- 137.4 items 6 and 9 are labelled "(example answer)" in the Key (put
-- your coat on / put up the price(s)) — the grammar pattern (object +
-- particle, either order) is fully fixed, only the exact noun is
-- illustrative, so seeded with the Key's own example noun as the primary
-- answer plus the word-order alternative, rather than skipping as
-- open-ended (same "check if the answer actually varies in substance"
-- judgment call as 47.2/51.3 in earlier modules).
--
-- Safe to re-run: unit 137 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('phrasal-verbs', 'Phrasal verbs', 15)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 137: Phrasal verbs 1 Introduction
-- ============================================================

delete from units where slug = 'unit-137';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 137, 'unit-137', 'Phrasal verbs 1 Introduction', null,
  'We often use verbs with in/on/up/away/by/about/over/round, out/off/down/back/through/along/forward — these are phrasal verbs (look out, get on, take off). The second word often gives the verb a special meaning (break down = stop working, find out = discover). A phrasal verb can be followed by a preposition (look up at, keep up with) or have an object, which can usually go before or after the particle — but if the object is a pronoun (it/them/me), only one position works: turn it on (not turn on it).', 0
from modules where slug = 'phrasal-verbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verbs of movement + in/on/up etc.',
  'We often use verbs with: in, on, up, away, by, about, over, round or around; out, off, down, back, through, along, forward. So you can say look out / get on / take off / run away etc. These are phrasal verbs. We often use on/off/out etc. with verbs of movement. For example: get on — The bus was full. We couldn''t get on. drive off — A woman got into the car and drove off. come back — Sarah is leaving tomorrow and coming back on Saturday. turn round — When I touched him on the shoulder, he turned round.', 0
from units where slug = 'unit-137';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'the second word gives a special meaning',
  'Often the second word (on/off/out etc.) gives a special meaning to the verb. For example: break down — Sorry I''m late. The car broke down. (= the engine stopped working) find out — I never found out who sent me the flowers. (= I never discovered) take off — It was my first flight. I was nervous as the plane took off. (= went into the air) give up — I tried many times to contact her. In the end I gave up. (= stopped trying) get on — How was the exam? How did you get on? (= How did you do?) get by — My French isn''t good, but it''s enough to get by. (= enough to manage) For more phrasal verbs, see Units 138-145.', 1
from units where slug = 'unit-137';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'phrasal verb + preposition',
  'Sometimes a phrasal verb is followed by a preposition. For example: look up at — We looked up at the plane as it flew above us. run away from — Why did you run away from me? keep up with — You''re walking too fast. I can''t keep up with you. look forward to — Are you looking forward to your trip?', 2
from units where slug = 'unit-137';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'phrasal verb + object',
  'Sometimes a phrasal verb has an object. For example: I turned on the light. (the light is the object) Usually there are two possible positions for the object. You can say: I turned on the light. or I turned the light on. But if the object is a pronoun (it/them/me/him etc.), only one position is possible: I turned it on. (not I turned on it) In the same way, you can say: I''m going to take off my shoes. or take my shoes off. but These shoes are uncomfortable. I''m going to take them off. (not take off them) Don''t wake up the baby. or wake the baby up. but The baby is asleep. Don''t wake her up. (not wake up her) Don''t throw away this box. or throw this box away. but I want to keep this box, so don''t throw it away. (not throw away it)', 3
from units where slug = 'unit-137';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-137'
join (values
  ('A', 'The bus was full. We couldn''t get on.', null, 0),
  ('A', 'A woman got into the car and drove off.', null, 1),
  ('A', 'When I touched him on the shoulder, he turned round.', null, 2),
  ('B', 'Sorry I''m late. The car broke down.', '= the engine stopped working', 0),
  ('B', 'I never found out who sent me the flowers.', '= I never discovered', 1),
  ('B', 'I was nervous as the plane took off.', '= went into the air', 2),
  ('B', 'I tried many times to contact her. In the end I gave up.', '= stopped trying', 3),
  ('C', 'We looked up at the plane as it flew above us.', null, 0),
  ('C', 'Why did you run away from me?', null, 1),
  ('C', 'You''re walking too fast. I can''t keep up with you.', null, 2),
  ('C', 'Are you looking forward to your trip?', null, 3),
  ('D', 'I turned on the light. or I turned the light on.', null, 0),
  ('D', 'I turned it on.', 'not I turned on it', 1),
  ('D', 'I want to keep this box, so don''t throw it away.', 'not throw away it', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 137.1-137.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '137.1', 'Complete each sentence using a verb (in the correct form) + a word: be, get, fly, sit, go, speak, break, get, look, take, come, get; away, back, on, round, back, down, off, up, back, down, out, up.', 0
from units where slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-137' where es.title = '137.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ve been standing a long time. I''m going to {0} for a bit.', null),
  (2, 'It''s a very busy airport. There are planes landing and {0} all the time.', null),
  (3, 'A cat tried to catch the bird, but it {0} just in time.', null),
  (4, 'We were trapped in the building. We couldn''t {0}.', null),
  (5, 'I can''t hear you very well. Can you {0} a little?', null),
  (6, 'Ben''s salary is very low, but it''s enough to {0}.', null),
  (7, 'Everything is so expensive now. Prices have {0} a lot.', null),
  (8, 'I heard a noise behind me, so I {0} to see what it was.', null),
  (9, 'I''m going out now to do some shopping. I''ll {0} in about an hour.', null),
  (10, 'Our car {0} on the motorway and we had to call for help.', null),
  (11, 'How is your new job? How are you {0}?', null)
) as v(n, template, hint)
where es.title = '137.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '137.1'
join (values
  (1, 'sit down', array[]::text[]),
  (2, 'taking off', array[]::text[]),
  (3, 'flew away', array['flew off']::text[]),
  (4, 'get out', array[]::text[]),
  (5, 'speak up', array[]::text[]),
  (6, 'get by', array[]::text[]),
  (7, 'gone up', array[]::text[]),
  (8, 'looked round', array[]::text[]),
  (9, 'be back', array[]::text[]),
  (10, 'broke down', array[]::text[]),
  (11, 'getting on', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '137.2', 'Complete each sentence using a word from A and a word from B: away, in, up, back, out, up, up, forward; at, to, at, to, with, with, about, through.', 1
from units where slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-137' where es.title = '137.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My holidays are nearly over. Next week I''ll be {0} work.', null),
  (2, 'We went {0} the top floor of the building to admire the view.', null),
  (3, 'The meeting tomorrow is going to be difficult. I''m not looking {0} it.', null),
  (4, 'There was a bank robbery last week. The robbers got {0} £50,000.', null),
  (5, 'I love to look {0} the stars in the night sky.', null),
  (6, 'I was sitting in the kitchen when a bird flew {0} the open window.', null),
  (7, 'How do you know about the plan? How did you find {0} it?', null)
) as v(n, template, hint)
where es.title = '137.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '137.2'
join (values
  (1, 'back at'), (2, 'up to'), (3, 'forward to'), (4, 'away with'),
  (5, 'up at'), (6, 'in through'), (7, 'out about')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '137.3', 'Complete the sentences. Use these phrasal verbs + it/them/me: get out, give back, switch on, take off, wake up.', 2
from units where slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-137' where es.title = '137.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m going to bed now. Can you {0} at 6.30?', null),
  (2, 'I''ve got something in my eye and I can''t {0}.', null),
  (3, 'I don''t like it when people borrow things and don''t {0} before going into the house.', null),
  (4, 'I want to use the hair dryer. How do I {0}?', null),
  (5, 'My shoes are dirty. I''d better {0}.', null)
) as v(n, template, hint)
where es.title = '137.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '137.3'
join (values
  (1, 'wake me up'), (2, 'get it out'), (3, 'give them back'),
  (4, 'switch it on'), (5, 'take them off')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '137.4', 'Complete the sentences. Use the word in brackets.', 3
from units where slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-137' where es.title = '137.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'These books are Lisa''s. I have to give {0} to her.', '(back)'),
  (2, 'We can turn {0}. Nobody is watching it.', '(off)'),
  (3, 'Shh! My mother is asleep. I don''t want to wake {0}.', '(up)'),
  (4, 'It''s cold today. You should put {0} if you go out.', '(on)'),
  (5, 'It was only a small fire. I was able to put {0} easily.', '(out)'),
  (6, 'It''s a bit dark in this room. Shall I turn {0}?', '(on)'),
  (7, '''The hotel is more expensive than when we stayed here last year.'' ''Yes, they''ve put {0}.''', '(up)'),
  (8, '''How did the vase get broken?'' ''I''m afraid I knocked {0} while I was cleaning.''', '(over)')
) as v(n, template, hint)
where es.title = '137.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '137.4'
join (values
  (1, 'them back', array[]::text[]),
  (2, 'the TV off', array['off the TV', 'it off']::text[]),
  (3, 'her up', array[]::text[]),
  (4, 'your coat on', array['on your coat']::text[]),
  (5, 'it out', array[]::text[]),
  (6, 'the light on', array['on the light', 'the lights on', 'on the lights']::text[]),
  (7, 'the prices up', array['up the prices', 'the price up', 'up the price']::text[]),
  (8, 'it over', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
