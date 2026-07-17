-- Marco 4 (slice 5): seeds the "Conditionals and wish" module — units 38-41
-- (if I do ... and if I did ..., if I knew ... I wish I knew ..., if I had
-- known ... I wish I had known ..., wish).
--
-- Sourced from pdf/Modulos/Modals.pdf (extracted via `pdftotext -layout`,
-- same workaround as previous modules — pdftoppm/poppler isn't available
-- locally) and cross-checked against pdf/Key to Exercises.pdf.
--
-- As documented in 0006_seed_modals.sql, this single PDF actually spans
-- units 26-41 across three book chapters. Modals (26-34) and the
-- modal-adjacent group (35-37) were seeded as the "Modals" module; this
-- migration covers the remaining "Conditionals and wish" chapter
-- (38-41) as its own module, per Igor's earlier decision. The next unit
-- (42, Passive) confirms the chapter boundary — unit 42's exercises appear
-- right after 41's in the Key to Exercises.
--
-- Open-ended own-answer exercises are skipped: 39.4 ("Write your own
-- sentences beginning I wish ...", about the student's own life) has no
-- key answers and no single correct answer. Every other exercise item that
-- looks free-form (38.4, 39.2, 39.3, 40.2, 40.3, 41.3) actually has fixed
-- expected answers in the Key to Exercises, so those are seeded normally,
-- using the same "scenario -> single full-sentence blank" shape already
-- used for unit-35's write-a-sentence exercises (35.1 in 0006), rather than
-- the book's own partial-stem scaffolding — pdftotext -layout unreliably
-- drops short words immediately next to a blank (confirmed while
-- cross-checking this chapter), so reproducing the book's exact partial
-- stems verbatim isn't safe; asking for the whole answer sentence is.
--
-- Choice-format exercise 38.2 ("What do you say ...? a or b") is adapted
-- the same way matching-format exercises were in 0006 (27.1, 32.1, 37.1):
-- the scenario becomes the template and the correct option's full sentence
-- becomes the answer.
--
-- Where a book exercise item is itself the worked example (already
-- answered inline, matching the Key's own numbering gap), it's dropped and
-- the remaining items are renumbered from 1 in this module's DB rows —
-- same convention as unit-35/40's "item 1 is the example" exercises in
-- prior migrations.
--
-- Additional exercises 19-21 ("Past, present and future") are explicitly
-- cross-referenced from the ends of units 39 and 40 in the book itself
-- ("Additional exercises 19-21 (pages 313-14)") — a much less ambiguous
-- link than the usual TOC-range guesswork this project has otherwise
-- relied on (see the additional-exercises caveat in prior migrations).
-- Exercises 19 and 20 are genuine conditionals fill-ins; 21 is open-ended
-- ("use your own ideas"). Still deferred this round, not seeded: spot-
-- checking exercise 20 against the key surfaced the same short-word-near-
-- blank extraction loss noted above (item 20.2's blank silently swallowed
-- "me"), and additional exercises weren't in scope for this slice anyway
-- (same as every prior module) — flagging as a clean, unambiguous
-- follow-up candidate rather than risking subtly wrong seeded content.
--
-- Consolidated into a single migration, same pattern as 0003-0006, so
-- Supabase's GitHub-linked CI/CD applies it automatically on push.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('conditionals-and-wish', 'Conditionals and wish', 4)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 38: if I do ... and if I did ...
-- ============================================================

delete from units where slug = 'unit-38';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 38, 'unit-38', 'if I do ... and if I did ...', null,
  'if + present (if we take the bus) is for real or possible future situations. if + past (if we took the bus) is for unreal or unlikely situations, imagined for the present or future — the meaning is not past. would (not will) goes in the other part of the sentence, never in the if-part.', 0
from modules where slug = 'conditionals-and-wish';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Real vs unreal: if we take the bus / if we took the bus',
  'Compare: "If we take the bus, it will be cheaper" (Jess still thinks taking the bus is possible) and "If we took the bus, it would be cheaper" (Jess knows they are not going to take the bus — she is imagining it).', 0
from units where slug = 'unit-38';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'if + past for things that will not (or probably will not) happen',
  'We use if + past (if we went / if there was etc.) to talk about something that will not happen, or that we do not expect to happen. The meaning is not past: "What would you do if you won a lot of money?" (I do not really expect this).', 1
from units where slug = 'unit-38';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'would does not go in the if-part',
  'We do not normally use would in the if-part of the sentence: "I''d be very scared if somebody pointed a gun at me" (not if somebody would point). would (''d) goes in the other part of the sentence. could and might are also possible there.', 2
from units where slug = 'unit-38';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-38'
join (values
  ('A', 'If we take the bus, it will be cheaper.', 'real possibility — they might still take the bus', 0),
  ('A', 'If we took the bus, it would be cheaper, but the train is quicker.', 'unreal — they''ve already decided to take the train', 1),
  ('B', 'What would you do if you won a lot of money?', 'I don''t really expect this to happen', 0),
  ('B', 'If there was an election tomorrow, who would you vote for?', 'there will not be an election tomorrow', 1),
  ('B', 'I''d be surprised if they didn''t come to the party.', 'I expect them to come', 2),
  ('B', 'If you found a wallet in the street, what would you do with it?', null, 3),
  ('C', 'I''d be very scared if somebody pointed a gun at me.', 'not if somebody would point', 0),
  ('C', 'If we went by bus, it would be cheaper.', 'not if we would go', 1),
  ('C', 'What would you do if you were bitten by a snake?', null, 2),
  ('C', 'If I won a lot of money, I might buy a house.', '= it is possible that I would buy a house', 3),
  ('C', 'If it stopped raining, we could go out.', '= we would be able to go out', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: two comic-style dialogue panels — Lisa and Jess deciding whether to take the bus or train ("If we take the bus, it will be cheaper"), then Jess talking to Joe after they have already decided to take the train ("If we took the bus, it would be cheaper, but the train is quicker") — illustrating real vs unreal conditional]', 0
from units where slug = 'unit-38';

-- ------------------------------------------------------------
-- Exercises (main, book's own 38.1-38.4; item 1 of each is the book's
-- worked example and is dropped, remaining items renumbered from 1)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '38.1', 'Complete the sentences. Choose from: did, dropped, found, happened, lost, was, went.', 0
from units where slug = 'unit-38';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-38' where es.title = '38.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Be careful with that vase. If you {0} it, it would break into small pieces.', null),
  (2, 'This notebook is very important to me. I''d be very upset if I {0} it.', null),
  (3, 'I don''t expect to lose my job but if that {0}, I''d have to find another one.', null),
  (4, 'We''re thinking about our holiday for next year. If we {0} to Italy, would you come with us?', null),
  (5, 'I don''t think he''ll fail the exam. I''d be very surprised if he {0}.', null),
  (6, 'If there {0} a fire in the building, would you know how to put the fire out?', null)
) as v(n, template, hint)
where es.title = '38.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '38.1'
join (values
  (1, 0, 'dropped'), (2, 0, 'lost'), (3, 0, 'happened'),
  (4, 0, 'went'), (5, 0, 'did'), (6, 0, 'was')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '38.2', 'What do you say in these situations? Choose the correct sentence.', 1
from units where slug = 'unit-38';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-38' where es.title = '38.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''re not going to sell your car because it''s old and not worth much. {0}', null),
  (2, 'You often see Sarah. A friend of yours wants to contact her. {0}', null),
  (3, 'You don''t expect that there will be a fire in the building. {0}', null),
  (4, 'You''ve never lost your passport. You can only imagine it. {0}', null),
  (5, 'Somebody stops you and asks the way to a bank. {0}', null),
  (6, 'You''re in a lift. There is an emergency button. Nobody is going to press it. {0}', null)
) as v(n, template, hint)
where es.title = '38.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '38.2'
join (values
  (1, 0, 'If I sold my car, I wouldn''t get much money for it.'),
  (2, 0, 'If I see Sarah, I''ll tell her to call you.'),
  (3, 0, 'What would you do if there was a fire in the building?'),
  (4, 0, 'I don''t know what I''d do if I lost my passport.'),
  (5, 0, 'If you go right at the end of this street, you''ll see a bank on your left.'),
  (6, 0, 'What would happen if somebody pressed that button?')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '38.3', 'Complete the sentences.', 2
from units where slug = 'unit-38';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-38' where es.title = '38.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can''t afford to buy a car. If {0} a car, I''d have to borrow the money.', '(I / buy)'),
  (2, 'If you had a party, who {0}?', '(you / invite)'),
  (3, 'Don''t lend James your car. If {0} me, I wouldn''t lend him mine.', '(he / ask)'),
  (4, 'I don''t think Gary and Emma will get married. {0} amazed if they did.', '(I / be)'),
  (5, 'If {0} me $20,000, {1} a long holiday.', '(somebody / give) ... (I / have)'),
  (6, '{0} nervous if {1} a famous person?', '(you / be) ... (you / meet)'),
  (7, 'What {0} if {1} in a lift and {2} between floors?', '(you / do) ... (you / be) ... (it / stop)')
) as v(n, template, hint)
where es.title = '38.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '38.3'
join (values
  (1, 0, 'I bought', array[]::text[]),
  (2, 0, 'would you invite', array[]::text[]),
  (3, 0, 'he asked', array[]::text[]),
  (4, 0, 'I''d be', array['I would be']::text[]),
  (5, 0, 'somebody gave', array[]::text[]), (5, 1, 'I''d have', array['I would have']::text[]),
  (6, 0, 'Would you be', array[]::text[]), (6, 1, 'you met', array[]::text[]),
  (7, 0, 'would you do', array[]::text[]), (7, 1, 'you were', array[]::text[]), (7, 2, 'it stopped', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '38.4', 'Write sentences beginning If ... .', 3
from units where slug = 'unit-38';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-38' where es.title = '38.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We''re not going to stay at a hotel. {0}', '(it / cost too much)'),
  (2, 'There''s no point in telling you what happened. {0}', '(you / not / believe)'),
  (3, 'Sally has no plans to leave her job. {0}', '(it / hard to find another one)'),
  (4, 'Kevin is not going to apply for the job. {0}', '(he / not / get it)')
) as v(n, template, hint)
where es.title = '38.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '38.4'
join (values
  (1, 0, 'If we stayed at a hotel, it would cost too much.', array[]::text[]),
  (2, 0, 'If I told you what happened, you wouldn''t believe me.', array['If I told you what happened, you wouldn''t believe it.']::text[]),
  (3, 0, 'If she left her job, it would be hard to find another one.', array[]::text[]),
  (4, 0, 'If he applied for the job, he wouldn''t get it.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 39: if I knew ... I wish I knew ...
-- ============================================================

delete from units where slug = 'unit-39';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 39, 'unit-39', 'if I knew ... I wish I knew ...', null,
  'We use if + past (if I knew / if you were etc.) to imagine a present situation that is not real — the meaning is present, not past. We use the past the same way after wish, to say we regret something now (I wish I knew). After if and wish, were is possible instead of was. would does not go after if or wish.', 1
from modules where slug = 'conditionals-and-wish';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'if + past for imagined present/future situations',
  'When we imagine a situation that is not real — "I''d phone him if I knew his number" — we use if + past (if I knew / if you were / if we didn''t etc.), but the meaning is present, not past.', 0
from units where slug = 'unit-39';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'wish + past, to say we regret something now',
  'We use the past in the same way after wish (I wish I knew / I wish you were etc.), to say that we regret something, that something is not as we would like it to be now.', 1
from units where slug = 'unit-39';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'were instead of was after if and wish',
  'After if and wish, you can use were instead of was (if I were / I wish it were etc.). You can also use was: "If I were you, I wouldn''t buy that coat" or "If I was you, ...".', 2
from units where slug = 'unit-39';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'would does not go after if or wish',
  'We do not usually say "if ... would". We use would (''d) in the other part of the sentence: "If I were rich, I would travel a lot" (not If I would be rich). In the same way: "I wish I had something to read" (not I wish I would have).', 3
from units where slug = 'unit-39';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'could = would be able to / was able to',
  'could sometimes means "would be able to" and sometimes "was/were able to": "She could get a better job if she could speak another language" (could get = would be able to get; could speak = was able to speak). "I wish I could help you" (= I wish I was able).', 4
from units where slug = 'unit-39';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-39'
join (values
  ('A', 'I''d phone him if I knew his number.', 'Sarah doesn''t know Paul''s number', 0),
  ('A', 'There are many things I''d like to do if I had more time.', 'but I don''t have time', 1),
  ('A', 'If you were in my position, what would you do?', null, 2),
  ('A', 'It''s a pity he can''t drive. It would be useful if he could.', null, 3),
  ('B', 'I wish I knew Paul''s phone number.', '= I don''t know it and I regret this', 0),
  ('B', 'Do you ever wish you could fly?', 'you can''t fly', 1),
  ('B', 'It''s very crowded here. I wish there weren''t so many people.', null, 2),
  ('B', 'I wish I lived here.', 'compare: I''m glad I live here (I live here and that''s good)', 3),
  ('C', 'If I were you, I wouldn''t buy that coat.', 'or If I was you, ...', 0),
  ('C', 'I''d go for a walk if it weren''t so cold.', 'or ... if it wasn''t so cold', 1),
  ('C', 'I wish Anna were here.', 'or I wish Anna was here', 2),
  ('D', 'If I were rich, I would travel a lot.', 'not If I would be rich', 0),
  ('D', 'Who would you ask if you needed help?', 'not if you would need', 1),
  ('D', 'I wish I had something to read.', 'not I wish I would have', 2),
  ('D', 'I wish she were here now.', 'not I wish she would be', 3),
  ('E', 'She could get a better job if she could speak another language.', 'could get = would be able to get; could speak = was able to speak', 0),
  ('E', 'I wish I could help you.', '= I wish I was able', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Sarah wanting to phone Paul but not knowing his number, with a thought bubble reading "... if I knew his number ..."]', 0
from units where slug = 'unit-39';

-- ------------------------------------------------------------
-- Exercises (main, book's own 39.1-39.3; 39.4 skipped — open-ended, no
-- key answers, "write your own sentences about yourself")
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '39.1', 'Put the verb into the correct form.', 0
from units where slug = 'unit-39';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-39' where es.title = '39.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} you if I could, but I''m afraid I can''t.', '(I / help)'),
  (2, 'This soup isn''t very nice. {0} better if it wasn''t so salty.', '(it / taste)'),
  (3, 'We live in a city and don''t need a car, but we would need one if {0} in the country.', '(we / live)'),
  (4, 'If we had the choice, {0} in the country.', '(we / live)'),
  (5, 'I''d make a lot of changes if {0} the manager of the company.', '(I / be)'),
  (6, 'I wouldn''t call someone in the middle of the night if {0} important.', '(it / not / be)'),
  (7, 'If I were you, {0}. {1} now.', '(I / not / wait) ... (I / go)'),
  (8, 'You''re always tired because you go to bed so late. If {0} to bed so late every night, {1} tired all the time.', '(you / not / go) ... (you / not / be)'),
  (9, 'I think there are too many cars. If {0} so many cars, {1} so much pollution.', '(there / not / be) ... (there / not / be)'),
  (10, 'We all need jobs and money, but what {0} if {1} to work?', '(you / do) ... (you / not / have)')
) as v(n, template, hint)
where es.title = '39.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '39.1'
join (values
  (1, 0, 'I''d help', array['I would help']::text[]),
  (2, 0, 'It would taste', array[]::text[]),
  (3, 0, 'we lived', array[]::text[]),
  (4, 0, 'we''d live', array['we would live']::text[]),
  (5, 0, 'I was', array['I were']::text[]),
  (6, 0, 'it wasn''t', array['it weren''t']::text[]),
  (7, 0, 'I wouldn''t wait', array[]::text[]), (7, 1, 'I''d go', array['I would go']::text[]),
  (8, 0, 'you didn''t go', array[]::text[]), (8, 1, 'you wouldn''t be', array[]::text[]),
  (9, 0, 'there weren''t', array[]::text[]), (9, 1, 'there wouldn''t be', array[]::text[]),
  (10, 0, 'would you do', array[]::text[]), (10, 1, 'you didn''t have', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '39.2', 'Write a sentence with if ... for each situation.', 1
from units where slug = 'unit-39';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-39' where es.title = '39.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I like these shoes but they''re too expensive, so I''m not going to buy them. {0}', null),
  (2, 'We''d like to go on holiday, but we can''t afford it. {0}', null),
  (3, 'It would be nice to have lunch outside but it''s raining, so we can''t. {0}', null),
  (4, 'I don''t want his advice, and that''s why I''m not going to ask for it. {0}', null)
) as v(n, template, hint)
where es.title = '39.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '39.2'
join (values
  (1, 0, 'I''d buy them if they weren''t so expensive.', array['I would buy them if they weren''t so expensive.']::text[]),
  (2, 0, 'We''d go on holiday if we could afford it.', array['We would go on holiday if we could afford it.']::text[]),
  (3, 0, 'We could have lunch outside if it weren''t raining.', array['We could have lunch outside if it wasn''t raining.']::text[]),
  (4, 0, 'If I wanted his advice, I''d ask for it.', array['If I wanted his advice, I would ask for it.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '39.3', 'Write sentences beginning I wish ... .', 2
from units where slug = 'unit-39';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-39' where es.title = '39.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t have much free time (and I need more). {0}', null),
  (2, 'Helen isn''t here (and I need to see her). {0}', null),
  (3, 'It''s cold (and I hate cold weather). {0}', null),
  (4, 'I live in a big city (and I don''t like it). {0}', null),
  (5, 'I can''t find my phone (which is a problem). {0}', null),
  (6, 'I''m not feeling well (which isn''t good). {0}', null),
  (7, 'I have to get up early tomorrow (but I''d prefer to sleep late). {0}', null),
  (8, 'I don''t know much about science (and I should know more). {0}', null)
) as v(n, template, hint)
where es.title = '39.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '39.3'
join (values
  (1, 0, 'I wish I had more free time.', array[]::text[]),
  (2, 0, 'I wish Helen were here.', array['I wish Helen was here.']::text[]),
  (3, 0, 'I wish it weren''t so cold.', array['I wish it wasn''t so cold.']::text[]),
  (4, 0, 'I wish I didn''t live in a big city.', array[]::text[]),
  (5, 0, 'I wish I could find my phone.', array[]::text[]),
  (6, 0, 'I wish I was feeling better.', array['I wish I were feeling better.', 'I wish I was feeling well.', 'I wish I were feeling well.']::text[]),
  (7, 0, 'I wish I didn''t have to get up early tomorrow.', array[]::text[]),
  (8, 0, 'I wish I knew more about science.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 40: if I had known ... I wish I had known ...
-- ============================================================

delete from units where slug = 'unit-40';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 40, 'unit-40', 'if I had known ... I wish I had known ...', null,
  'We use if + had (''d) ... to imagine a past situation that was different (if I''d known / if you''d done etc.), and had done/known/been etc. the same way after wish, to regret something in the past. would does not go in the if-part; would have, could have and might have go in the other part.', 2
from modules where slug = 'conditionals-and-wish';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'if + had (done), for imagined past situations',
  'We use if + had (''d) ... to talk about the past (if I''d known / if you''d done etc.) — imagining that something had been different: "If I''d known you were in hospital, I would have gone to visit you" (= I didn''t know, so I didn''t go).', 0
from units where slug = 'unit-40';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'would does not go in the if-part',
  'We do not say "if something would have happened". We use would in the other part of the sentence: "If I had seen you, I would have said hello" (not If I would have seen you). The short form ''d can be would or had: "If I''d seen you, I''d have said hello."', 1
from units where slug = 'unit-40';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'wish + had (done), to regret the past',
  'We use had done/known/been etc. in the same way after wish. I wish something had happened = I am sorry that it didn''t happen; I wish something hadn''t happened = I am sorry that it happened.', 2
from units where slug = 'unit-40';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'would (do) vs would have (done)',
  'Compare would (do) and would have (done): "If I''d gone to the party last night, I would be tired now" (present) and "If I''d gone to the party last night, I would have met lots of people" (past). could have and might have are also possible instead of would have.', 3
from units where slug = 'unit-40';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-40'
join (values
  ('A', 'If I''d known you were in hospital, I would have gone to visit you.', '= I didn''t know, so I didn''t go to visit you', 0),
  ('A', 'If I''d seen you, I would have said hello.', 'I didn''t see you', 1),
  ('A', 'They would have gone out if they hadn''t been so tired.', 'but they were tired', 2),
  ('A', 'I would have taken some pictures if I''d had a camera with me.', 'but I didn''t have a camera', 3),
  ('B', 'If I had seen you, I would have said hello.', 'not If I would have seen you', 0),
  ('B', 'If I''d seen you, I''d have said hello.', 'I''d seen = I had seen; I''d have said = I would have said', 1),
  ('C', 'I wish I''d known that Gary was ill. I would have gone to see him.', 'but I didn''t know', 0),
  ('C', 'I feel sick. I wish I hadn''t eaten so much.', 'I ate too much', 1),
  ('C', 'Do you wish you''d studied science instead of languages?', 'you didn''t study science', 2),
  ('C', 'I wish I''d seen him.', 'compare: I''m glad I saw him (= I saw him)', 3),
  ('D', 'If I''d gone to the party last night, I would be tired now.', 'I am not tired now — present', 0),
  ('D', 'If I''d gone to the party last night, I would have met lots of people.', 'I didn''t meet lots of people — past', 1),
  ('D', 'If the weather hadn''t been so bad, we could have gone out.', '= we would have been able to go out', 2),
  ('D', 'If the weather hadn''t been so bad, we might have gone out.', '= maybe we would have gone out', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 40.1-40.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '40.1', 'Put the verb into the correct form.', 0
from units where slug = 'unit-40';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-40' where es.title = '40.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sarah got to the station just in time to catch her train to the airport. If {0} the train, {1} her flight too.', '(she / miss) ... (she / miss)'),
  (2, 'Thanks for reminding me about Lisa''s birthday. {0} if {1} me.', '(I / forget) ... (you / not / remind)'),
  (3, 'I didn''t have your email address, so I couldn''t contact you. If {0} your email address, {1} you an email.', '(I / have) ... (I / send)'),
  (4, 'Their trip was OK, but {0} it more if the weather {1} better.', '(they / enjoy) ... (be)'),
  (5, 'Sorry we''re late. Our taxi got stuck in the traffic. {0} quicker if {1}.', '(it / be) ... (we / walk)'),
  (6, 'Why didn''t you tell me about your problem? If {0} me, {1} to help you.', '(you / tell) ... (I / try)'),
  (7, 'I''m not tired. If {0} tired, I''d go home now.', '(I / be)'),
  (8, 'I wasn''t tired last night. If {0} tired, I would have gone home earlier.', '(I / be)')
) as v(n, template, hint)
where es.title = '40.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '40.1'
join (values
  (1, 0, 'she''d missed', array['she had missed']::text[]), (1, 1, 'she''d have missed', array['she would have missed']::text[]),
  (2, 0, 'I''d have forgotten', array['I would have forgotten']::text[]), (2, 1, 'you hadn''t reminded', array[]::text[]),
  (3, 0, 'I''d had', array['I had had']::text[]), (3, 1, 'I''d have sent', array['I would have sent']::text[]),
  (4, 0, 'they''d have enjoyed', array['they would have enjoyed']::text[]), (4, 1, 'had been', array[]::text[]),
  (5, 0, 'It would have been', array[]::text[]), (5, 1, 'we''d walked', array['we had walked']::text[]),
  (6, 0, 'you''d told', array['you had told']::text[]), (6, 1, 'I''d have tried', array['I would have tried']::text[]),
  (7, 0, 'I were', array['I was']::text[]),
  (8, 0, 'I''d been', array['I had been']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '40.2', 'For each situation, write a sentence beginning with If.', 1
from units where slug = 'unit-40';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-40' where es.title = '40.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The accident happened because the road was icy. {0}', null),
  (2, 'I didn''t know that you had to get up early, so I didn''t wake you up. {0}', null),
  (3, 'Unfortunately I lost my phone, so I couldn''t call you. {0}', null),
  (4, 'Karen wasn''t injured in the crash, because fortunately she was wearing a seat belt. {0}', null),
  (5, 'You didn''t have any breakfast — that''s why you''re hungry now. {0}', null),
  (6, 'I didn''t get a taxi because I didn''t have enough money. {0}', null),
  (7, 'Dan didn''t do well at school, so he couldn''t go to university. {0}', null)
) as v(n, template, hint)
where es.title = '40.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '40.2'
join (values
  (1, 0, 'If the road hadn''t been icy, the accident wouldn''t have happened.', array[]::text[]),
  (2, 0, 'If I''d known that you had to get up early, I''d have woken you up.', array['If I had known that you had to get up early, I would have woken you up.']::text[]),
  (3, 0, 'If I hadn''t lost my phone, I''d have called you.', array['If I''d had my phone, I''d have called you.', 'If I hadn''t lost my phone, I would have called you.']::text[]),
  (4, 0, 'If Karen hadn''t been wearing a seat belt, she''d have been injured in the crash.', array['If Karen hadn''t been wearing a seat belt, she would have been injured in the crash.', 'If Karen hadn''t been wearing a seat belt, she might have been injured in the crash.', 'If Karen hadn''t been wearing a seat belt, she could have been injured in the crash.']::text[]),
  (5, 0, 'If you''d had breakfast, you wouldn''t be hungry now.', array['If you had had breakfast, you wouldn''t be hungry now.']::text[]),
  (6, 0, 'If I''d had enough money, I''d have got a taxi.', array['If I had had enough money, I would have got a taxi.', 'If I''d had enough money, I''d have taken a taxi.']::text[]),
  (7, 0, 'If Dan had done better at school, he could have gone to university.', array['If Dan had done well at school, he would have gone to university.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '40.3', 'Imagine that you are in these situations. For each situation, write a sentence with I wish.', 2
from units where slug = 'unit-40';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-40' where es.title = '40.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When you were younger, you never learned to play a musical instrument. Now you regret this. {0}', null),
  (2, 'You''ve painted the gate red. Now you think it doesn''t look good. Red was the wrong colour. {0}', null),
  (3, 'You decided to travel by car, but the journey was long and tiring. Going by train would have been better. {0}', null),
  (4, 'Last year you went to New York with a friend. You didn''t have time to do all the things you wanted to do. {0}', null),
  (5, 'You moved to a new flat a few months ago. Now you don''t like your new flat. You think that moving was a bad idea. {0}', null)
) as v(n, template, hint)
where es.title = '40.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '40.3'
join (values
  (1, 0, 'I wish I''d learned to play a musical instrument.', array['I wish I had learned to play a musical instrument.', 'I wish I could play a musical instrument.', 'I wish I was able to play a musical instrument.']::text[]),
  (2, 0, 'I wish I hadn''t painted the gate red.', array['I wish I hadn''t painted it red.', 'I wish I had painted it a different colour.']::text[]),
  (3, 0, 'I wish we''d gone by train.', array['I wish we had gone by train.', 'I wish we hadn''t gone by car.']::text[]),
  (4, 0, 'I wish we''d had more time.', array['I wish we had had more time.']::text[]),
  (5, 0, 'I wish I hadn''t moved to my new flat.', array['I wish I''d stayed where I was.', 'I wish I''d stayed in my old flat.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 41: wish
-- ============================================================

delete from units where slug = 'unit-41';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 41, 'unit-41', 'wish', null,
  'wish somebody something (luck, all the best) — not "I wish something happens", use hope for that. wish + past/had done regrets something now or in the past (see units 39-40). wish ... would is for wanting something to happen or change, often to complain about a repeated situation.', 3
from modules where slug = 'conditionals-and-wish';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'wish somebody luck / all the best (not hope)',
  'We say "wish somebody luck / all the best / success" etc., but we do not say "I wish something happens" — we use hope for that: "I hope you feel better soon" (not I wish you feel).', 0
from units where slug = 'unit-41';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'wish + past, to regret something now or before',
  'We also use wish to say that something is not as we would like it to be. We use the past (knew/lived etc.), but the meaning is present: "I wish I knew what to do about the problem" (but I don''t know). To regret something that happened before, we use wish + had known / had said etc.', 1
from units where slug = 'unit-41';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'wish I could (do) / wish I could have (done)',
  'I wish I could (do something) = I regret that I cannot do it: "I wish you could stay longer" (but you can''t). I wish I could have (done something) = I regret that I could not do it: "I wish I could have gone" (but I couldn''t go).', 2
from units where slug = 'unit-41';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'wish ... would, to want something to happen or change',
  'We use I wish ... would when we would like something to happen or change, often to complain about a situation: "I wish it would stop raining." "I wish somebody would answer it." We use I wish ... wouldn''t to complain about things people do repeatedly: "I wish you wouldn''t keep interrupting me."', 3
from units where slug = 'unit-41';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'wish ... would vs wishing things were different',
  'We use I wish ... would to say that we want something to happen, not to say how we would like things to be: "I wish Sarah would come" (= I want her to come) but "I wish Sarah was here now" (not I wish Sarah would be).', 4
from units where slug = 'unit-41';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-41'
join (values
  ('A', 'I wish you all the best in the future.', null, 0),
  ('A', 'I saw Mark before the exam and he wished me luck.', null, 1),
  ('A', 'I hope you feel better soon.', 'not I wish you feel', 2),
  ('A', 'I hope you enjoy your stay at this hotel.', 'not I wish you enjoy', 3),
  ('B', 'I wish I knew what to do about the problem.', 'but I don''t know', 0),
  ('B', 'Do you wish you lived near the sea?', 'you don''t live near the sea', 1),
  ('B', 'I wish I''d known about the party. I''d have gone if I''d known.', 'but I didn''t know', 2),
  ('B', 'It was a stupid thing to say. I wish I hadn''t said it.', 'but I said it', 3),
  ('C', 'I wish you could stay longer.', 'but you can''t', 0),
  ('C', 'I wish I could remember his name.', 'but I can''t', 1),
  ('C', 'I wish I could have gone.', 'but I couldn''t go', 2),
  ('D', 'I wish it would stop raining.', 'Tanya would like the rain to stop', 0),
  ('D', 'The phone has been ringing for five minutes. I wish somebody would answer it.', null, 1),
  ('D', 'I wish you''d do something instead of just sitting and doing nothing.', null, 2),
  ('D', 'I wish you wouldn''t keep interrupting me.', '= please stop interrupting me', 3),
  ('E', 'I wish Sarah would come.', '= I want her to come', 0),
  ('E', 'I wish Sarah was (or were) here now.', 'not I wish Sarah would be', 1),
  ('E', 'I wish somebody would buy me a car.', null, 2),
  ('E', 'I wish I had a car.', 'not I wish I would have', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Tanya annoyed by the rain, saying "I wish it would stop raining"]', 0
from units where slug = 'unit-41';

-- ------------------------------------------------------------
-- Exercises (main, book's own 41.1-41.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '41.1', 'Put in wish(ed) or hope(d).', 0
from units where slug = 'unit-41';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-41' where es.title = '41.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Enjoy your holiday. I {0} you have a great time.', null),
  (2, 'Goodbye. I {0} you all the best for the future.', null),
  (3, 'We said goodbye to each other and {0} each other luck.', null),
  (4, 'We''re going to have a picnic tomorrow, so I {0} the weather is nice.', null),
  (5, 'Congratulations on your new job. I {0} you every success.', null),
  (6, 'Good luck in your new job. I {0} it works out well for you.', null)
) as v(n, template, hint)
where es.title = '41.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '41.1'
join (values
  (1, 0, 'hope'), (2, 0, 'wish'), (3, 0, 'wished'),
  (4, 0, 'hope'), (5, 0, 'wish'), (6, 0, 'hope')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '41.2', 'Complete the sentences.', 1
from units where slug = 'unit-41';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-41' where es.title = '41.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m very tired and I have so much to do. I wish I {0} so tired.', null),
  (2, 'You didn''t tell me you were ill. Why not? I wish you {0} me.', null),
  (3, 'I don''t have enough free time. I wish I {0} more free time.', null),
  (4, 'I can''t make up my mind what to do. I wish I {0} decide.', null),
  (5, 'I bought these shoes, but now I don''t like them. I wish I {0} them.', null),
  (6, 'We have to go out now and I don''t want to go. I wish we {0} to go out now.', null),
  (7, 'Unfortunately I couldn''t go to the wedding last month. I wish I could {0}.', null)
) as v(n, template, hint)
where es.title = '41.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '41.2'
join (values
  (1, 0, 'wasn''t', array['weren''t']::text[]),
  (2, 0, 'had told', array['''d told']::text[]),
  (3, 0, 'had', array['could have']::text[]),
  (4, 0, 'could', array[]::text[]),
  (5, 0, 'hadn''t bought', array[]::text[]),
  (6, 0, 'didn''t have', array[]::text[]),
  (7, 0, 'have gone', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '41.3', 'What do you say in these situations? Write sentences with I wish ... would or I wish ... wouldn''t.', 2
from units where slug = 'unit-41';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-41' where es.title = '41.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''re waiting for Jane. She''s late and you''re getting impatient. {0}', null),
  (2, 'You''re looking for a job — so far without success. Nobody will give you a job. {0}', null),
  (3, 'You can hear a dog barking. It''s been barking a long time and you''re trying to study. {0}', null),
  (4, 'Your friend is driving very fast. She always drives fast and you don''t like this. You say to her: {0}', null),
  (5, 'Joe leaves the door open all the time. This annoys you. You say to Joe: {0}', null),
  (6, 'A lot of people drop litter in the street. You don''t like this. {0}', null)
) as v(n, template, hint)
where es.title = '41.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '41.3'
join (values
  (1, 0, 'I wish she would come.', array['I wish she would hurry up.']::text[]),
  (2, 0, 'I wish somebody would give me a job.', array[]::text[]),
  (3, 0, 'I wish the dog would stop barking.', array['I wish that dog would stop barking.']::text[]),
  (4, 0, 'I wish you wouldn''t drive so fast.', array[]::text[]),
  (5, 0, 'I wish you wouldn''t leave the door open all the time.', array['I wish you wouldn''t leave the door open.']::text[]),
  (6, 0, 'I wish people wouldn''t drop litter in the street.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '41.4', 'Put the verb into the correct form.', 3
from units where slug = 'unit-41';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-41' where es.title = '41.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s a difficult question. I wish {0} the answer.', '(I / know)'),
  (2, 'I really didn''t enjoy the party. I wish {0}.', '(we / not / go)'),
  (3, 'I wish {0}. We''ve been waiting for 20 minutes.', '(the bus / come)'),
  (4, 'You''re lucky to be going away. I wish {0} with you.', '(I / can / come)'),
  (5, 'Our flat is rather small. I wish {0} a bit bigger.', '(it / be)'),
  (6, 'I should have listened to you. I wish {0} your advice.', '(I / take)'),
  (7, 'You keep interrupting me! I wish {0}.', '(you / listen)'),
  (8, 'You''re always complaining. I wish {0} all the time.', '(you / not / complain)'),
  (9, 'It''s freezing today. I wish {0} so cold. I hate cold weather.', '(it / not / be)'),
  (10, 'I wish {0}. It''s horrible!', '(the weather / change)'),
  (11, 'I wish {0} a piano. I''d love to have one.', '(I / have)'),
  (12, 'When we were in London last year, we didn''t have time to see all the things we wanted to see. I wish {0} there longer.', '(we / can / stay)')
) as v(n, template, hint)
where es.title = '41.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '41.4'
join (values
  (1, 0, 'I knew', array[]::text[]),
  (2, 0, 'we hadn''t gone', array[]::text[]),
  (3, 0, 'the bus would come', array[]::text[]),
  (4, 0, 'I could come', array[]::text[]),
  (5, 0, 'it was', array['it were']::text[]),
  (6, 0, 'I''d taken', array['I had taken']::text[]),
  (7, 0, 'you''d listen', array['you would listen']::text[]),
  (8, 0, 'you wouldn''t complain', array['you didn''t complain']::text[]),
  (9, 0, 'it wasn''t', array['it weren''t']::text[]),
  (10, 0, 'the weather would change', array[]::text[]),
  (11, 0, 'I had', array['I could have']::text[]),
  (12, 0, 'we could have stayed', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
