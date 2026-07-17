-- Marco 4 (slice 11): seeds the second slice of the "-ing and to ..."
-- module — units 59-68 (prefer/would rather, preposition + -ing, be/get
-- used to, verb + preposition + -ing, there's no point in -ing, to.../
-- for.../so that, adjective + to, afraid to/of -ing, see somebody do/doing,
-- -ing clauses). This completes the module (units 53-68 total, slice 1 was
-- 0011).
--
-- Sourced from pdf/Modulos/-ing and to ….pdf (same file as slice 1,
-- extracted via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf.
--
-- Reminder: migrations are applied by pasting the full file into the
-- Supabase Studio SQL Editor by hand — there is no GitHub auto-deploy for
-- this project.
--
-- Open-ended own-answer exercises skipped: 59.1 ("Which do you prefer?
-- Write sentences...") is labelled "Example answers" in the Key, and
-- unlike 68.3/59.4 (also labelled that way but with fixed answers), 59.1's
-- answers genuinely vary in substance — which of two things you prefer is
-- a personal choice with no single correct pairing.
--
-- 59.4 ("Use your own ideas...") LOOKS open-ended by its instruction, but
-- the Key gives one fixed short answer per item (grammar-driven, not
-- opinion-driven) — seeded normally, same lesson as 0009/0011: check the
-- Key's actual answers, not just the exercise's instruction wording.
--
-- One item dropped for a genuine extraction gap: 65.5 item 5 ("The
-- holidays begin this weekend. There's sure to be ___") — the Key's answer
-- column is truncated mid-line by the 3-column layout and the completion
-- text after "sure to be" never appears anywhere in the extracted text, so
-- rather than guess the missing noun phrase, this single item is left out
-- (items 2-4 of 65.5 are unaffected and seeded normally).
--
-- Several exercises have blanks where the Key restates surrounding context
-- words for clarity even though those words are already fixed in the
-- template (e.g. 68.3's "5 Having lost his job" when the template already
-- ends in "his job recently, James is now unemployed."). Where the
-- surrounding text in the extraction was clearly intact and unambiguous,
-- the blank was trimmed to just the missing words rather than padded with
-- the Key's redundant repetition. Where extraction reliability was in
-- doubt, the safer "whole answer as one blank" shape was used instead
-- (same judgment call as 0009/0011).
--
-- Additional exercises 26-28 (pages 317-19) are referenced again in this
-- range (units 59-63) but, consistent with every module so far, deferred.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting. The module row already exists
-- from 0011 (on conflict do nothing).

insert into modules (slug, title, order_index)
values ('ing-and-to', '-ing and to ...', 8)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 59: prefer and would rather
-- ============================================================

delete from units where slug = 'unit-59';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 59, 'unit-59', 'prefer and would rather', null,
  'prefer to ... or prefer -ing for general preferences. would prefer to ... (not usually would prefer doing) for a specific situation. would rather do (not to do), with the negative I''d rather not ... . I''d rather you did something uses the past for a present meaning.', 6
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'prefer to ... and prefer -ing',
  'When you say what you prefer in general, you can use prefer to ... or prefer -ing: "I prefer to live in the country" or "I prefer living in the country." You can say prefer something to something else, prefer doing something to doing something else / rather than (doing) something else, or prefer to do something rather than (do) something else.', 0
from units where slug = 'unit-59';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'would prefer (I''d prefer ...)',
  'We use would prefer to say what somebody wants in a specific situation (not in general): "Would you prefer tea or coffee?" We say "would prefer to do something" (not usually would prefer doing): "I''d prefer to drive."', 1
from units where slug = 'unit-59';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'would rather (I''d rather ...)',
  'I''d rather do something = I''d prefer to do it. We say I''d rather do (not to do): "I''d rather drive" (not to drive). The negative is I''d rather not ...: "I''d rather not go out this evening." We say "I''d rather do one thing than do another": "I''d rather stay at home tonight than go to the cinema."', 2
from units where slug = 'unit-59';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'I''d rather somebody did something',
  'We say "I''d rather you did something" (not I''d rather you do): "I''d rather you drove." We use the past (drove, did etc.) here, but the meaning is present, not past. I''d rather you didn''t (do something) = I''d prefer you not to do it: "I''d rather you didn''t tell anyone what I said."', 3
from units where slug = 'unit-59';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-59'
join (values
  ('A', 'I prefer to live in the country.', 'or I prefer living in the country', 0),
  ('A', 'I prefer this coat to the other one.', null, 1),
  ('A', 'I prefer driving to travelling by train.', 'or I prefer driving rather than travelling by train', 2),
  ('A', 'Sarah prefers to live in the country rather than in a city.', null, 3),
  ('B', '"Would you prefer tea or coffee?" "Coffee, please."', null, 0),
  ('B', '"Shall we go by train?" "I''d prefer to drive."', null, 1),
  ('B', 'I''d prefer to stay at home tonight rather than go to the cinema.', null, 2),
  ('C', '"Shall we go by train?" "I''d rather drive."', 'not to drive', 0),
  ('C', 'Which would you rather do, go to the cinema or go shopping?', null, 1),
  ('C', 'I''m tired. I''d rather not go out this evening, if you don''t mind.', null, 2),
  ('C', 'I''d rather stay at home tonight than go to the cinema.', null, 3),
  ('D', '"Who''s going to drive, you or me?" "I''d rather you drove."', '= I would prefer this', 0),
  ('D', 'Are you going to tell Anna what happened, or would you rather I told her?', null, 1),
  ('D', 'I''d rather you didn''t tell anyone what I said.', null, 2),
  ('D', '"Shall I tell Anna what happened?" "I''d rather you didn''t."', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 59.2-59.4; 59.1 skipped — open-ended,
-- personal preference between two given options)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '59.2', 'Complete the sentences. Sometimes you need one word, sometimes more.', 0
from units where slug = 'unit-59';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-59' where es.title = '59.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Would you like to watch TV? I''d {0} to listen to some music.', null),
  (2, 'Do you want to go to a restaurant? I''d rather {0} at home.', null),
  (3, 'Let''s go now. {0} wait a few minutes.', null),
  (4, 'What about a game of tennis? I''d prefer {0} for a swim.', null),
  (5, 'I think we should decide now. I''d {0} think about it for a while.', null),
  (6, 'Would you like to sit down? {0} to stand.', null),
  (7, 'Do you want me to come with you? I''d rather {0} alone.', null),
  (8, 'Rewrite using than: Would you like to watch TV? {0}', null),
  (9, 'Rewrite using rather than: Do you want to go to a restaurant? {0}', null),
  (10, 'Rewrite using than: What about a game of tennis? {0}', null),
  (11, 'Rewrite using rather than: I think we should decide now. {0}', null)
) as v(n, template, hint)
where es.title = '59.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '59.2'
join (values
  (1, 0, 'prefer', array[]::text[]),
  (2, 0, 'eat', array['stay']::text[]),
  (3, 0, 'I''d rather', array['I''d prefer to']::text[]),
  (4, 0, 'to go', array[]::text[]),
  (5, 0, 'rather', array['prefer to']::text[]),
  (6, 0, 'I''d prefer', array[]::text[]),
  (7, 0, 'go', array[]::text[]),
  (8, 0, 'I''d rather listen to some music than watch TV.', array[]::text[]),
  (9, 0, 'I''d prefer to eat at home rather than go to a restaurant.', array['I''d prefer to stay at home rather than go to a restaurant.']::text[]),
  (10, 0, 'I''d rather go for a swim than play tennis.', array[]::text[]),
  (11, 0, 'I''d prefer to think about it for a while rather than decide now.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '59.3', 'Complete the sentences using would you rather I ... .', 1
from units where slug = 'unit-59';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-59' where es.title = '59.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Are you going to pay the bill or {0}?', null),
  (2, 'Are you going to do the shopping or {0}?', null),
  (3, 'Are you going to phone Tina or {0}?', null)
) as v(n, template, hint)
where es.title = '59.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '59.3'
join (values
  (1, 0, 'would you rather I paid it'),
  (2, 0, 'would you rather I did it'),
  (3, 0, 'would you rather I phoned her')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '59.4', 'Complete the sentences (one or two words each time).', 2
from units where slug = 'unit-59';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-59' where es.title = '59.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You can stay here if you want to, but I''d rather you {0} with us.', null),
  (2, 'I don''t like this programme. I''d rather not {0} it.', null),
  (3, 'I''d rather work outdoors {0} work in an office.', null),
  (4, 'This is a private matter. I''d rather you {0} tell anybody else.', null),
  (5, 'The weather here isn''t bad, but I''d rather it {0} a little warmer.', null),
  (6, 'I don''t want to go to the match. I''d prefer {0} it on TV.', null),
  (7, '"Do you mind if I open the window?" "I''d rather you {0}. I''m feeling cold."', null),
  (8, 'I hate doing the shopping. I''d rather somebody else {0} it.', null),
  (9, 'I''d prefer to go to the beach {0} go shopping.', null)
) as v(n, template, hint)
where es.title = '59.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '59.4'
join (values
  (1, 0, 'came'), (2, 0, 'watch'), (3, 0, 'than'), (4, 0, 'didn''t'),
  (5, 0, 'was'), (6, 0, 'to watch'), (7, 0, 'didn''t'), (8, 0, 'did'), (9, 0, 'rather than')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 60: Preposition (in/for/about etc.) + -ing
-- ============================================================

delete from units where slug = 'unit-60';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 60, 'unit-60', 'Preposition (in/for/about etc.) + -ing', null,
  'If a preposition is followed by a verb, the verb ends in -ing. This includes before/after/by/without + -ing, and to when it is a preposition (look forward to, prefer X to Y) rather than an infinitive marker.', 7
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'preposition + -ing',
  'If a preposition (in/for/about/at/with/of etc.) is followed by a verb, the verb ends in -ing: "Are you interested in working for us?" "I''m not good at learning languages." You can also say "instead of somebody doing something", "fed up with people doing something" etc.: "I''m fed up with people telling me what to do."', 0
from units where slug = 'unit-60';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'before/after/by/without + -ing',
  'before -ing, after -ing: "Before going out, I phoned Sarah" (not Before to go out). by -ing says how something happens: "You can improve your English by reading more." without -ing: "We ran ten kilometres without stopping."', 1
from units where slug = 'unit-60';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'to + -ing (look forward to doing something etc.)',
  'to is often an infinitive marker (to do/to see), but to can also be a preposition (like in/for/about): "I prefer tea to coffee." "Are you looking forward to the weekend?" When to is a preposition and followed by a verb, we use to -ing: "I prefer driving to travelling by train" (not to travel). "Are you looking forward to going on holiday?" (not looking forward to go).', 2
from units where slug = 'unit-60';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-60'
join (values
  ('A', 'Are you interested in working for us?', null, 0),
  ('A', 'I''m not good at learning languages.', null, 1),
  ('A', 'Kate must be fed up with studying.', null, 2),
  ('A', 'What are the advantages of having a car?', null, 3),
  ('A', 'Thanks very much for inviting me to your party.', null, 4),
  ('A', 'How about meeting for lunch tomorrow?', null, 5),
  ('A', 'Why don''t you go out instead of sitting at home all the time?', null, 6),
  ('A', 'Amy went to work in spite of feeling ill.', null, 7),
  ('A', 'I''m fed up with people telling me what to do.', null, 8),
  ('B', 'Before going out, I phoned Sarah.', 'not Before to go out', 0),
  ('B', 'What did you do after leaving school?', null, 1),
  ('B', 'You can improve your English by reading more.', null, 2),
  ('B', 'The burglars got into the house by breaking a window and climbing in.', null, 3),
  ('B', 'We ran ten kilometres without stopping.', null, 4),
  ('B', 'I have enough problems of my own without having to worry about yours.', null, 5),
  ('C', 'We went from Paris to Geneva.', 'to as a preposition', 0),
  ('C', 'I prefer tea to coffee.', null, 1),
  ('C', 'Are you looking forward to the weekend?', null, 2),
  ('C', 'I prefer driving to travelling by train.', 'not to travel', 3),
  ('C', 'Are you looking forward to going on holiday?', 'not looking forward to go', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 60.1-60.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '60.1', 'Complete the second sentence so that it means the same as the first.', 0
from units where slug = 'unit-60';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-60' where es.title = '60.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t intend to apply for the job. I have no intention of {0}.', null),
  (2, 'Helen has a good memory for names. Helen is good at {0}.', null),
  (3, 'You probably won''t win the lottery. You have little chance. You have little chance of {0}.', null),
  (4, 'Did you get into trouble because you were late? Did you get into trouble for {0}?', null),
  (5, 'We didn''t eat at home. We went to a restaurant instead. We went to a restaurant instead of {0}.', null),
  (6, 'We got into the exhibition. We didn''t have to queue. We got into the exhibition without {0}.', null),
  (7, 'Amy is 90 years old, but she''s fit and healthy. Amy is fit and healthy despite {0}.', null)
) as v(n, template, hint)
where es.title = '60.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '60.1'
join (values
  (1, 0, 'applying for the job', array[]::text[]),
  (2, 0, 'remembering names', array[]::text[]),
  (3, 0, 'winning the lottery', array[]::text[]),
  (4, 0, 'being late', array[]::text[]),
  (5, 0, 'eating at home', array[]::text[]),
  (6, 0, 'having to queue', array['queuing']::text[]),
  (7, 0, 'being 90 years old', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '60.2', 'Complete the sentences using by -ing. Choose from these verbs: borrow, break, drive, press, put, stand.', 1
from units where slug = 'unit-60';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-60' where es.title = '60.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I was able to reach the top shelf {0} on a chair.', null),
  (2, 'You turn on the computer {0} the button at the back.', null),
  (3, 'Kevin got himself into financial trouble {0} too much money.', null),
  (4, 'You can put people''s lives in danger {0} too fast.', null),
  (5, 'We made the room look nicer {0} some pictures on the walls.', null)
) as v(n, template, hint)
where es.title = '60.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '60.2'
join (values
  (1, 0, 'by standing'), (2, 0, 'by pressing'), (3, 0, 'by borrowing'),
  (4, 0, 'by driving'), (5, 0, 'by putting')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '60.3', 'Complete the sentences with a suitable word. Use only one word each time.', 2
from units where slug = 'unit-60';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-60' where es.title = '60.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Dan left the hotel without {0} his bill.', null),
  (2, 'It''s a nice morning. How about {0} for a walk?', null),
  (3, 'You need to think carefully before {0} an important decision.', null),
  (4, 'It was a long trip. We were tired after {0} on a train for 36 hours.', null),
  (5, 'I''m not looking forward to {0} away. I''d prefer to stay here.', null),
  (6, 'I was annoyed because the decision was made without anybody {0} me.', null),
  (7, 'After {0} the same job for ten years, Ellie felt she needed a change.', null),
  (8, 'We got lost because we went straight on instead of {0} left.', null),
  (9, 'I like these pictures you took. You''re good at {0} pictures.', null),
  (10, 'Can you touch your toes without {0} your knees?', null),
  (11, 'We''ve decided to sell our car. Are you interested in {0} it?', null)
) as v(n, template, hint)
where es.title = '60.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '60.3'
join (values
  (1, 0, 'paying'), (2, 0, 'going'), (3, 0, 'making'), (4, 0, 'being'),
  (5, 0, 'going'), (6, 0, 'asking'), (7, 0, 'doing'), (8, 0, 'turning'),
  (9, 0, 'taking'), (10, 0, 'bending'), (11, 0, 'buying')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '60.4', 'For each situation, write a sentence with I''m (not) looking forward to.', 3
from units where slug = 'unit-60';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-60' where es.title = '60.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A good friend of yours is coming to visit you soon. It will be good to see her again. How do you feel? {0}', null),
  (2, 'You''re going to the dentist tomorrow. You don''t enjoy visits to the dentist. How do you feel? {0}', null),
  (3, 'Rachel doesn''t like school, but she''s leaving next summer. How does she feel? {0}', null),
  (4, 'Joe and Helen are moving to a new apartment soon. It''s much nicer than where they live now. How do they feel? {0}', null)
) as v(n, template, hint)
where es.title = '60.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '60.4'
join (values
  (1, 0, 'I''m looking forward to seeing her again.'),
  (2, 0, 'I''m not looking forward to going to the dentist tomorrow.'),
  (3, 0, 'She''s looking forward to leaving school next summer.'),
  (4, 0, 'They''re looking forward to moving to their new apartment.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 61: be/get used to ... (I'm used to ...)
-- ============================================================

delete from units where slug = 'unit-61';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 61, 'unit-61', 'be/get used to ... (I''m used to ...)', null,
  'be/get used to something/doing something = it is (becoming) not new or strange for me. Here to is a preposition, so it takes -ing or a noun, not the infinitive. Don''t confuse this with used to do (past habit, Unit 18).', 8
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'be/get used to (example situation)',
  'Lisa is American, but she lives in Britain. When she first drove a car in Britain, driving on the left was a problem for her: "She wasn''t used to it. She wasn''t used to driving on the left" (because Americans drive on the right). After some time, driving on the left became easier: "She got used to driving on the left." Now it''s no problem for Lisa: "She is used to driving on the left."', 0
from units where slug = 'unit-61';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'I''m used to something = it is not new or strange for me',
  'You can say be/get used to something, or be/get used to doing something: "He''s used to living alone." "I bought some new shoes. They felt a little strange at first because I wasn''t used to them." "I expect we''ll get used to the noise."', 1
from units where slug = 'unit-61';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'used to doing (not used to do)',
  'We say "be/get used to doing something" (not I''m used to do): "Lisa is used to driving on the left" (not is used to drive). When we say "I am used to ...", to is a preposition, so it''s followed by -ing or a noun, not the infinitive: "We''re not used to living here" (not live here). Compare to + infinitive: "We don''t want to live here."', 2
from units where slug = 'unit-61';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'I am used to doing vs I used to do',
  'I am used to (doing) something = it isn''t strange or new for me now. I used to do something = I did it regularly in the past but no longer do it — this is only for the past (see Unit 18): "I used to drive to work every day, but these days I usually go by bike."', 3
from units where slug = 'unit-61';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-61'
join (values
  ('A', 'She wasn''t used to driving on the left.', 'because Americans drive on the right', 0),
  ('A', 'She got used to driving on the left.', 'after some time', 1),
  ('A', 'She is used to driving on the left.', 'now, no problem', 2),
  ('B', 'He is used to living alone.', null, 0),
  ('B', 'I bought some new shoes. They felt a little strange at first because I wasn''t used to them.', null, 1),
  ('B', 'Our new apartment is on a busy street. I expect we''ll get used to the noise.', null, 2),
  ('B', 'Katherine''s husband is often away from home. She''s used to him being away.', null, 3),
  ('C', 'Lisa is used to driving on the left.', 'not is used to drive', 0),
  ('C', 'I''m used to living alone.', 'not I''m used to live', 1),
  ('C', 'We''re not used to living here.', 'not live here', 2),
  ('C', 'We don''t want to live here.', 'compare to + infinitive', 3),
  ('D', 'I''m used to the weather here.', 'it isn''t strange or new for me', 0),
  ('D', 'I''m used to driving on the left because I''ve lived in Britain a long time.', null, 1),
  ('D', 'I used to drive to work every day, but these days I usually go by bike.', 'past habit, not present', 2),
  ('D', 'We used to live just outside the town, but now we live near the centre.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Lisa, an American driving in Britain, looking nervous about driving on the left — used across the unit''s wasn''t/got/is used to progression]', 0
from units where slug = 'unit-61';

-- ------------------------------------------------------------
-- Exercises (main, book's own 61.1-61.5)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '61.1', 'Complete the sentences using used to + a suitable verb.', 0
from units where slug = 'unit-61';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-61' where es.title = '61.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t feel good. I stayed up until 3 am. I''m not {0} to bed so late.', null),
  (2, 'Tomorrow I start a new job. I''ll have to get {0} with new people.', null),
  (3, 'My feet hurt. I can''t go any further. I''m not {0} so far.', null),
  (4, 'I like this part of town. I''ve been here a long time, so I''m {0} here.', null)
) as v(n, template, hint)
where es.title = '61.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '61.1'
join (values
  (1, 0, 'used to going'), (2, 0, 'used to working'), (3, 0, 'used to walking'), (4, 0, 'used to living')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '61.2', 'Read about Sarah and Jack. Complete the sentences using used to.', 1
from units where slug = 'unit-61';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-61' where es.title = '61.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sarah is a nurse. A year ago she started working nights. At first it was hard for her. Sarah wasn''t used to working nights. {0} Now, after a year, it''s normal for her. {1}', null),
  (2, 'Jack has to drive two hours to work every morning. Many years ago, when he first had to do this, it was hard for him and he didn''t like it. When Jack started working in this job, {0} driving two hours to work every morning, but after some time {1}. Now it''s no problem for him. {2}', null)
) as v(n, template, hint)
where es.title = '61.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '61.2'
join (values
  (1, 0, 'It took her a few months to get used to it.', array[]::text[]),
  (1, 1, 'She''s used to working nights.', array['She is used to working nights.']::text[]),
  (2, 0, 'he wasn''t used to', array[]::text[]),
  (2, 1, 'he got used to it', array[]::text[]),
  (2, 2, 'He''s used to driving two hours every morning.', array['He is used to driving two hours every morning.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '61.3', 'What do you say in these situations? Use I''m (not) used to ... .', 2
from units where slug = 'unit-61';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-61' where es.title = '61.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You sleep on the floor. It''s OK for you. You have always slept on the floor. friend: Wouldn''t you prefer to sleep in a bed? you: No, {0}', null),
  (2, 'You have to work long hours in your job. This is not a problem. You have always done this. friend: You have to work long hours in your job, don''t you? you: Yes, but I don''t mind that. {0}', null),
  (3, 'You''ve just moved from a village to a big city. It''s busy and you don''t like the crowds of people. friend: How do you like living here now? you: It''s different from living in a village. {0}', null)
) as v(n, template, hint)
where es.title = '61.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '61.3'
join (values
  (1, 0, 'I''m used to sleeping on the floor.'),
  (2, 0, 'I''m used to working long hours.'),
  (3, 0, 'I''m not used to the crowds of people.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '61.4', 'Read the situations and complete the sentences using get/got used to.', 3
from units where slug = 'unit-61';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-61' where es.title = '61.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The children got a new teacher. She was different from the teacher before her, but this wasn''t a problem for the children. {0}', null),
  (2, 'Kate moved from a big house to a much smaller one. She found it strange at first. {0}', null),
  (3, 'Anna has lived in Britain for ten years. She didn''t like the weather when she first came, and she still doesn''t like it. {0}', null),
  (4, 'Lee got a new job, but his new salary was much less. So he had less money. {0}', null)
) as v(n, template, hint)
where es.title = '61.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '61.4'
join (values
  (1, 0, 'They soon got used to her.', array['They soon got used to the new teacher.']::text[]),
  (2, 0, 'She had to get used to living in a much smaller house.', array[]::text[]),
  (3, 0, 'She can''t get used to the weather.', array[]::text[]),
  (4, 0, 'He had to get used to having less money.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '61.5', 'Complete the sentences using only one word each time.', 4
from units where slug = 'unit-61';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-61' where es.title = '61.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Daniel used to {0} a lot of coffee. Now he prefers tea.', null),
  (2, 'I feel very full after that meal. I''m not used to {0} so much.', null),
  (3, 'I wouldn''t like to share a room. I''m used to {0} my own room.', null),
  (4, 'I used to {0} a car, but I sold it a few months ago.', null),
  (5, 'When we were children, we used to {0} swimming very often.', null),
  (6, 'There used to {0} a school here, but it was knocked down a few years ago.', null),
  (7, 'I''m the boss here! I''m not used to {0} told what to do.', null)
) as v(n, template, hint)
where es.title = '61.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '61.5'
join (values
  (1, 0, 'drink'), (2, 0, 'eating'), (3, 0, 'having'), (4, 0, 'have'),
  (5, 0, 'go'), (6, 0, 'be'), (7, 0, 'being')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 62: Verb + preposition + -ing (succeed in -ing / insist on -ing etc.)
-- ============================================================

delete from units where slug = 'unit-62';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 62, 'unit-62', 'Verb + preposition + -ing (succeed in -ing / insist on -ing etc.)', null,
  'Verbs that take a preposition + object (approve of, decide against, dream of, feel like, insist on, look forward to, succeed in, think of/about) use -ing if the object is another verb. Some verbs have the structure verb + object + preposition + -ing (accuse ... of, congratulate ... on, prevent ... from, stop ... from, suspect ... of, thank ... for).', 9
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verb + preposition + -ing',
  'We use some verbs + preposition + object: "We talked about the problem." "I apologised for what I said." If the object is another verb, we use -ing: "We talked about going to South America." "You should apologise for not telling the truth." Other verbs used this way: approve of, decide against, dream of, feel like, insist on, look forward to, succeed in, think of/about. You can also say "approve of somebody doing something", "look forward to somebody doing something" etc.: "We are all looking forward to Andy coming home next week."', 0
from units where slug = 'unit-62';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'verb + object + preposition + -ing',
  'Some verbs have the structure verb + object + preposition + -ing: accuse ... of, congratulate ... on, prevent ... from, stop ... from, suspect ... of, thank ... for: "He accused me of telling lies." "We congratulated Lisa on winning the first prize." You can say "stop somebody doing" or "stop somebody from doing." Note this with not -ing: "He accused me of not telling the truth." Some of these verbs are often passive: "We were accused of telling lies." Note that we say "apologise to somebody for ..." (not I apologised them).', 1
from units where slug = 'unit-62';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-62'
join (values
  ('A', 'We talked about going to South America.', null, 0),
  ('A', 'You should apologise for not telling the truth.', null, 1),
  ('A', 'He doesn''t approve of swearing.', null, 2),
  ('A', 'We have decided against moving to London.', null, 3),
  ('A', 'I wouldn''t dream of asking them for money.', null, 4),
  ('A', 'I don''t feel like going out tonight.', null, 5),
  ('A', 'They insisted on paying for the meal.', null, 6),
  ('A', 'Are you looking forward to going away?', null, 7),
  ('A', 'Has Paul succeeded in finding a job yet?', null, 8),
  ('A', 'I''m thinking of buying a house.', null, 9),
  ('A', 'We are all looking forward to Andy coming home next week.', null, 10),
  ('B', 'He accused me of telling lies.', null, 0),
  ('B', 'We congratulated Lisa on winning the first prize.', null, 1),
  ('B', 'What prevented you from coming to see us?', null, 2),
  ('B', 'You can''t stop me doing what I want.', 'or You can''t stop me from doing ...', 3),
  ('B', 'The general was suspected of being a spy.', null, 4),
  ('B', 'I thanked everyone for helping me.', null, 5),
  ('B', 'He accused me of not telling the truth.', 'not -ing', 6),
  ('B', 'We were accused of telling lies.', 'passive, or ... accused of lying', 7),
  ('B', 'I apologised to them for keeping them waiting.', 'not I apologised them', 8)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 62.1-62.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '62.1', 'Complete the sentences. Use only one word each time.', 0
from units where slug = 'unit-62';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-62' where es.title = '62.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I feel lazy. I don''t feel like {0} any work.', null),
  (2, 'I wanted to go out alone, but Joe insisted on {0} with me.', null),
  (3, 'I''m fed up with my job. I''m thinking of {0} something else.', null),
  (4, 'We can''t afford a car right now, so we''ve decided against {0} one.', null),
  (5, 'It took us a long time, but we finally succeeded in {0} the problem.', null),
  (6, 'I''ve always dreamed of {0} a small house by the sea.', null),
  (7, 'It''s great that Amy and Sam are coming to visit us. I''m looking forward to {0} them again.', null)
) as v(n, template, hint)
where es.title = '62.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '62.1'
join (values
  (1, 0, 'doing'), (2, 0, 'coming'), (3, 0, 'doing'), (4, 0, 'buying'),
  (5, 0, 'solving'), (6, 0, 'buying'), (7, 0, 'seeing')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '62.2', 'Complete the sentences. Use a preposition + one of these verbs (in the correct form): be, eat, get, go out, invite, steal, take off, tell, try, use, walk.', 1
from units where slug = 'unit-62';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-62' where es.title = '62.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The police stopped the car because they suspected the driver {0} it.', null),
  (2, 'Our flight was delayed. Bad weather prevented the plane {0}.', null),
  (3, 'My phone is very old. I''m thinking {0} something.', null),
  (4, 'I didn''t want to hear the story but Dan insisted {0} me anyway.', null),
  (5, 'I''m getting hungry. I''m really looking forward {0}.', null),
  (6, 'I think you should apologise to Sarah {0} so rude.', null),
  (7, 'There''s a fence around the lawn to stop people {0} on the grass.', null),
  (8, 'I''m sorry I can''t come to your party, but thank you very much {0} me anyway.', null),
  (9, 'The man who has been arrested is suspected {0} a false passport.', null),
  (10, 'I did my best. Nobody can accuse me {0} not {1}.', null)
) as v(n, template, hint)
where es.title = '62.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '62.2'
join (values
  (1, 0, 'of stealing'), (2, 0, 'from taking off'), (3, 0, 'of getting'), (4, 0, 'on telling'),
  (5, 0, 'to eating'), (6, 0, 'for being'), (7, 0, 'from walking'), (8, 0, 'for inviting'),
  (9, 0, 'of using'), (10, 0, 'of'), (10, 1, 'trying')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '62.3', 'Complete the sentences on the right.', 2
from units where slug = 'unit-62';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-62' where es.title = '62.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ann: "I''ll take you to the station. I insist." {0}', null),
  (2, 'You: "I hear you got married. Congratulations!" Dan congratulated me {0}', null),
  (3, 'Sue: "It was nice of you to come to see me. Thank you." Jen thanked {0}', null),
  (4, 'You: "Sorry I''m late." Kate apologised {0}', null),
  (5, 'You: "You don''t care about other people." Jane accused {0}', null)
) as v(n, template, hint)
where es.title = '62.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '62.3'
join (values
  (1, 0, 'Tom insisted on taking Ann to the station.', array[]::text[]),
  (2, 0, 'on getting married.', array[]::text[]),
  (3, 0, 'Sue for coming to see her.', array[]::text[]),
  (4, 0, 'to me for being late.', array['for being late.']::text[]),
  (5, 0, 'me of not caring about other people.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 63: there's no point in -ing, it's worth -ing etc.
-- ============================================================

delete from units where slug = 'unit-63';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 63, 'unit-63', 'there''s no point in -ing, it''s worth -ing etc.', null,
  'there''s no point in / it''s no use / it''s no good + -ing. it''s (not) worth + -ing. have trouble/difficulty/a problem + -ing. spend/waste time + -ing, (be) busy + -ing. go + -ing for sports and activities.', 10
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'there''s no point in -ing / it''s no use -ing / it''s no good -ing',
  'There''s no point in having a car if you never use it. It''s no use worrying about what happened. It''s no good trying to persuade me. You won''t succeed. We say "no point in ..." but "the point of ...": "What''s the point of having a car if you never use it?"', 0
from units where slug = 'unit-63';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'it''s (not) worth -ing',
  'It''s a nice town. It''s worth spending a few days there. Our flight was very early in the morning, so it wasn''t worth going to bed. You can say something is worth it or not worth it, or that something is worth doing, a movie is worth seeing etc.: "It''s a great movie. It''s worth seeing."', 1
from units where slug = 'unit-63';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'have trouble/difficulty/a problem -ing',
  'I had no trouble finding a place to stay (not trouble to find). Did you have a problem getting a visa? People sometimes have difficulty reading my writing.', 2
from units where slug = 'unit-63';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'spend/waste time -ing, (be) busy -ing',
  'He spent hours trying to repair the clock. I waste a lot of time doing nothing. We also say "(be) busy doing something": "She was too busy doing other things."', 3
from units where slug = 'unit-63';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'go -ing (for sports and activities)',
  'We use go -ing for sports and other activities: go sailing, go swimming, go fishing, go riding, go hiking, go surfing, go scuba diving, go skiing, go jogging, go camping, go shopping: "How often do you go swimming?" "We went skiing last year." "Tom isn''t here. He''s gone shopping."', 4
from units where slug = 'unit-63';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-63'
join (values
  ('A', 'There''s no point in having a car if you never use it.', null, 0),
  ('A', 'There was no point in waiting any longer, so we left.', null, 1),
  ('A', 'It''s no use worrying about what happened.', null, 2),
  ('A', 'It''s no good trying to persuade me. You won''t succeed.', null, 3),
  ('A', 'What''s the point of having a car if you never use it?', 'the point of, not no point of', 4),
  ('B', 'It''s a nice town. It''s worth spending a few days there.', null, 0),
  ('B', 'Our flight was very early in the morning, so it wasn''t worth going to bed.', null, 1),
  ('B', 'You should spend a couple of days here. It''s worth it.', null, 2),
  ('B', 'It''s a great movie. It''s worth seeing.', null, 3),
  ('B', 'There was nothing worth stealing.', null, 4),
  ('B', 'It''s an interesting idea. It''s worth thinking about.', null, 5),
  ('C', 'I had no trouble finding a place to stay.', 'not trouble to find', 0),
  ('C', 'Did you have a problem getting a visa?', null, 1),
  ('C', 'People sometimes have difficulty reading my writing.', null, 2),
  ('D', 'He spent hours trying to repair the clock.', null, 0),
  ('D', 'I waste a lot of time doing nothing.', null, 1),
  ('D', 'She said she couldn''t meet me. She was too busy doing other things.', null, 2),
  ('E', 'How often do you go swimming?', null, 0),
  ('E', 'We went skiing last year.', null, 1),
  ('E', 'Tom isn''t here. He''s gone shopping.', null, 2),
  ('E', 'I''ve never been sailing.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 63.1-63.5)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '63.1', 'Which goes with which?', 0
from units where slug = 'unit-63';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-63' where es.title = '63.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s an interesting idea. {0}', null),
  (2, 'It''s no use standing here talking. {0}', null),
  (3, 'It''s not important. {0}', null),
  (4, 'There''s no point in looking for him. {0}', null),
  (5, 'It''s no good apologising to me. {0}', null),
  (6, 'It''s not worth arguing with him. {0}', null),
  (7, 'The hotel is a short walk from here. {0}', null)
) as v(n, template, hint)
where es.title = '63.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '63.1'
join (values
  (1, 0, 'It''s worth considering.'),
  (2, 0, 'We have to do something.'),
  (3, 0, 'It''s not worth worrying about.'),
  (4, 0, 'We''ll never find him.'),
  (5, 0, 'I don''t believe you''re sorry.'),
  (6, 0, 'He won''t change his opinion.'),
  (7, 0, 'It''s not worth getting a taxi.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '63.2', 'Write sentences beginning There''s no point ... .', 1
from units where slug = 'unit-63';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-63' where es.title = '63.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Why work if you don''t need money? {0}', null),
  (2, 'Don''t try to study if you feel tired. {0}', null),
  (3, 'Why hurry if you have plenty of time? {0}', null)
) as v(n, template, hint)
where es.title = '63.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '63.2'
join (values
  (1, 0, 'There''s no point in working if you don''t need money.', array[]::text[]),
  (2, 0, 'There''s no point in trying to study if you feel tired.', array['There''s no point in studying if you feel tired.']::text[]),
  (3, 0, 'There''s no point in hurrying if you have plenty of time.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '63.3', 'Complete the sentences.', 2
from units where slug = 'unit-63';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-63' where es.title = '63.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I find it hard to remember people''s names. I have a problem {0}.', null),
  (2, 'Lucy found a job easily. It wasn''t a problem. She had no trouble {0}.', null),
  (3, 'It will be easy to get a ticket for the game. You won''t have any problems {0}.', null),
  (4, 'It was easy for us to understand one another. We had no difficulty {0}.', null)
) as v(n, template, hint)
where es.title = '63.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '63.3'
join (values
  (1, 0, 'remembering people''s names', array[]::text[]),
  (2, 0, 'finding a job', array['getting a job']::text[]),
  (3, 0, 'getting a ticket for the game', array[]::text[]),
  (4, 0, 'understanding one another', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '63.4', 'Complete the sentences. Use only one word each time.', 3
from units where slug = 'unit-63';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-63' where es.title = '63.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'How much time do you spend {0} to and from work every day?', null),
  (2, 'Karen is going on holiday tomorrow, so she''s busy {0} her things ready.', null),
  (3, 'I waste too much time {0} TV.', null),
  (4, 'There was a beautiful view from the hill. It was worth {0} to the top.', null),
  (5, 'We need to stay calm. There''s no point in {0} angry.', null),
  (6, 'Amy is learning to play the guitar. She spends a lot of time {0}.', null),
  (7, 'Gary is enjoying his new job. He''s busy {0} on a new project.', null),
  (8, 'I decided it wasn''t worth {0} for the job. I had no chance of getting it.', null),
  (9, 'It''s no good {0} to escape. You won''t be able to get out of here.', null)
) as v(n, template, hint)
where es.title = '63.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '63.4'
join (values
  (1, 0, 'going'), (2, 0, 'getting'), (3, 0, 'watching'), (4, 0, 'going'),
  (5, 0, 'getting'), (6, 0, 'practising'), (7, 0, 'working'), (8, 0, 'applying'), (9, 0, 'trying')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '63.5', 'Complete these sentences. Choose from the following and put the verb in the correct form: go riding, go sailing, go shopping, go skiing, go swimming.', 4
from units where slug = 'unit-63';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-63' where es.title = '63.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was a very hot day, so we {0} in the lake.', null),
  (2, 'There''s plenty of snow in the mountains, so we''ll be able to {0}.', null),
  (3, 'Helen has two horses. She {0} regularly.', null),
  (4, 'Dan isn''t here. He {0}. There were a few things he needed to buy.', null)
) as v(n, template, hint)
where es.title = '63.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '63.5'
join (values
  (1, 0, 'went swimming', array[]::text[]),
  (2, 0, 'go skiing', array[]::text[]),
  (3, 0, 'goes riding', array[]::text[]),
  (4, 0, 'has gone shopping', array['''s gone shopping', 'went shopping']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 64: to ... , for ... and so that ...
-- ============================================================

delete from units where slug = 'unit-64';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 64, 'unit-64', 'to ... , for ... and so that ...', null,
  'to ... often expresses purpose: why somebody does/has/needs something. for + noun expresses the same idea for a thing (we stopped for petrol). so that (not to ...) is used especially with can/could and will/would.', 11
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'to ... for purpose',
  'to ... tells us the purpose of something — why somebody does something, has something, needs something, or why something exists: "I called the restaurant to reserve a table." "The president has a team of bodyguards to protect him."', 0
from units where slug = 'unit-64';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'a place to park, something to eat',
  'We say "a place to park", "something to eat", "work to do": "It''s hard to find a place to park in the city centre" (= a place where you can park). Sometimes there''s a preposition after the verb: "Is there a chair to sit on?" We also say money/time/chance/opportunity/energy/courage etc. to do something.', 1
from units where slug = 'unit-64';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'for + noun vs to + verb',
  'Compare for + noun and to + verb: "We stopped for petrol" / "We stopped to get petrol." You can say "for somebody to do something": "There weren''t any chairs for us to sit on." We use for (do)ing to say what something is used for: "This brush is for washing the dishes." But we do not use for -ing to say why somebody does something: "I went into the kitchen to wash the dishes" (not for washing). You can use What ... for? to ask about purpose: "What is this switch for?"', 2
from units where slug = 'unit-64';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'so that',
  'We use so that (not to ...) especially with can/could and will/would: "She''s learning English so that she can study in Canada." "I hurried so that I wouldn''t be late." You can leave out that: "I hurried so I wouldn''t be late."', 3
from units where slug = 'unit-64';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-64'
join (values
  ('A', 'I called the restaurant to reserve a table.', null, 0),
  ('A', 'What do you need to make bread?', null, 1),
  ('A', 'We shouted to warn everybody of the danger.', null, 2),
  ('A', 'The president has a team of bodyguards to protect him.', null, 3),
  ('B', 'It''s hard to find a place to park in the city centre.', '= a place where you can park', 0),
  ('B', 'Would you like something to eat?', '= something that you can eat', 1),
  ('B', 'Is there a chair to sit on?', '= a chair that I can sit on', 2),
  ('B', 'I need something to open this bottle with.', null, 3),
  ('B', 'They gave us money to buy food.', null, 4),
  ('B', 'I need a few days to think about your proposal.', null, 5),
  ('C', 'We stopped for petrol.', null, 0),
  ('C', 'We stopped to get petrol.', null, 1),
  ('C', 'I had to run for the bus.', null, 2),
  ('C', 'There weren''t any chairs for us to sit on, so we sat on the floor.', null, 3),
  ('C', 'This brush is for washing the dishes.', 'what it''s used for', 4),
  ('C', 'I went into the kitchen to wash the dishes.', 'not for washing', 5),
  ('C', 'What is this switch for?', '= what is it used for?', 6),
  ('C', 'What did you do that for?', '= why did you do that?', 7),
  ('D', 'She''s learning English so that she can study in Canada.', null, 0),
  ('D', 'We moved to London so that we could see our friends more often.', null, 1),
  ('D', 'I hurried so that I wouldn''t be late.', null, 2),
  ('D', 'I hurried so I wouldn''t be late.', 'that left out', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 64.1-64.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '64.1', 'Choose from Box A and Box B to make sentences with to ... .', 0
from units where slug = 'unit-64';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-64' where es.title = '64.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I opened the box. {0}', null),
  (2, 'I moved to a new apartment. {0}', null),
  (3, 'I couldn''t find a knife. {0}', null),
  (4, 'I called the police. {0}', null),
  (5, 'I called the hotel. {0}', null),
  (6, 'I employed an assistant. {0}', null)
) as v(n, template, hint)
where es.title = '64.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '64.1'
join (values
  (1, 0, 'I opened the box to see what was in it.', array[]::text[]),
  (2, 0, 'I moved to a new apartment to be nearer my friends.', array[]::text[]),
  (3, 0, 'I couldn''t find a knife to chop the onions.', array['I couldn''t find a knife to chop the onions with.']::text[]),
  (4, 0, 'I called the police to report the accident.', array[]::text[]),
  (5, 0, 'I called the hotel to find out if they had any rooms free.', array[]::text[]),
  (6, 0, 'I employed an assistant to help me with my work.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '64.2', 'Complete these sentences using to + a suitable verb.', 1
from units where slug = 'unit-64';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-64' where es.title = '64.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t have enough time {0} all the things I have to do.', null),
  (2, 'I came home by taxi. I didn''t have the energy {0}.', null),
  (3, 'Would you like something {0}? Coffee? Tea?', null),
  (4, 'Can you give me a bag {0} these things in?', null),
  (5, 'There will be a meeting next week {0} the problem.', null),
  (6, 'Do you need a visa {0} to the United States?', null),
  (7, 'I saw Helen at the party, but I didn''t have a chance {0} to her.', null),
  (8, 'I need some new clothes. I don''t have anything nice {0}.', null),
  (9, 'They''ve passed their exams. They''re going to have a party {0}.', null),
  (10, 'I can''t do all this work alone. I need somebody {0} me.', null),
  (11, 'Why are you so scared? There''s nothing {0} afraid of.', null)
) as v(n, template, hint)
where es.title = '64.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '64.2'
join (values
  (1, 0, 'to do', array[]::text[]),
  (2, 0, 'to walk', array[]::text[]),
  (3, 0, 'to drink', array[]::text[]),
  (4, 0, 'to put', array['to carry']::text[]),
  (5, 0, 'to discuss', array['to consider', 'to talk about']::text[]),
  (6, 0, 'to go', array['to travel']::text[]),
  (7, 0, 'to talk', array['to speak']::text[]),
  (8, 0, 'to wear', array['to put on']::text[]),
  (9, 0, 'to celebrate', array[]::text[]),
  (10, 0, 'to help', array['to assist']::text[]),
  (11, 0, 'to be', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '64.3', 'Put in to or for.', 2
from units where slug = 'unit-64';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-64' where es.title = '64.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We''ll need time {0} make a decision.', null),
  (2, 'I went to the dentist {0} a check-up.', null),
  (3, 'He''s very old. He needs somebody {0} take care of him.', null),
  (4, 'Can you lend me money {0} a taxi?', null),
  (5, 'Do you wear glasses {0} reading?', null),
  (6, 'I put on my glasses {0} read the letter.', null),
  (7, 'I wish we had a garden {0} children {1} play in.', null)
) as v(n, template, hint)
where es.title = '64.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '64.3'
join (values
  (1, 0, 'to'), (2, 0, 'for'), (3, 0, 'to'), (4, 0, 'for'),
  (5, 0, 'for'), (6, 0, 'to'), (7, 0, 'for'), (7, 1, 'to')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '64.4', 'Make one sentence from two, using so that.', 3
from units where slug = 'unit-64';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-64' where es.title = '64.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wore warm clothes. I didn''t want to get cold. {0}', null),
  (2, 'I gave Mark my phone number. I wanted him to be able to contact me. {0}', null),
  (3, 'We spoke very quietly. We didn''t want anybody else to hear us. {0}', null),
  (4, 'Please arrive early. We want to be able to start the meeting on time. {0}', null),
  (5, 'We made a list of things to do. We didn''t want to forget anything. {0}', null),
  (6, 'I slowed down. I wanted the car behind me to be able to overtake. {0}', null)
) as v(n, template, hint)
where es.title = '64.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '64.4'
join (values
  (1, 0, 'I wore warm clothes so that I wouldn''t get cold.', array['I wore warm clothes so that I wouldn''t be cold.']::text[]),
  (2, 0, 'I gave Mark my phone number so that he could contact me.', array['I gave Mark my phone number so that he would be able to contact me.']::text[]),
  (3, 0, 'We spoke very quietly so that nobody else would hear us.', array['We spoke very quietly so that nobody else could hear us.', 'We spoke very quietly so that nobody else would be able to hear us.']::text[]),
  (4, 0, 'Please arrive early so that we can start the meeting on time.', array['Please arrive early so that we''ll be able to start the meeting on time.']::text[]),
  (5, 0, 'We made a list of things to do so that we wouldn''t forget anything.', array[]::text[]),
  (6, 0, 'I slowed down so that the car behind me could overtake.', array['I slowed down so that the car behind me would be able to overtake.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 65: Adjective + to ...
-- ============================================================

delete from units where slug = 'unit-65';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 65, 'unit-65', 'Adjective + to ...', null,
  'Adjectives like hard, easy, safe, dangerous take to ... directly on the subject that would otherwise be the object ("He is hard to understand", not to understand him). nice/kind/silly etc. of somebody to ... judges an action. sorry/glad/surprised etc. to ... reacts to something. the first/last/only/next + to ... . sure/likely/bound to ... predicts.', 12
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'hard to understand, interesting to talk to etc.',
  '"It is hard to understand him" and "He is hard to understand" mean the same thing. Note that we say "He is hard to understand" (not He is hard to understand him). Other adjectives used this way: easy, nice, safe, cheap, exciting, interesting, difficult, good, dangerous, expensive, impossible. We also use this structure with adjective + noun: "This is a difficult question to answer" (not to answer it).', 0
from units where slug = 'unit-65';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'nice of (you) to ...',
  'We say "It''s nice of somebody to ...": "It was nice of you to take me to the airport." Other adjectives used this way: kind, generous, careless, silly, stupid, inconsiderate, unfair, typical: "It''s silly of Ruth to give up her job when she needs the money."', 1
from units where slug = 'unit-65';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'sorry to ... / surprised to ... etc.',
  'You can use adjective + to ... to say how somebody reacts to something: "I''m sorry to hear that your mother isn''t well." Other adjectives: glad, pleased, relieved, surprised, amazed, sad, disappointed: "Was Julia surprised to see you?"', 2
from units where slug = 'unit-65';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'the next / the last / the only / the first + to ...',
  'You can use to ... after the next / the last / the only / the first / the second etc.: "Everybody was late except me. I was the only one to arrive on time." "If I have any more news, you will be the first to know" (= the first person to know).', 3
from units where slug = 'unit-65';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'sure/likely/bound to ...',
  'You can say that something is sure/likely/bound to happen: "She''s bound to pass the exam" (= she is sure to pass). "It''s not likely to happen" (= it''s not probable).', 4
from units where slug = 'unit-65';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-65'
join (values
  ('A', 'It is hard to understand him.', null, 0),
  ('A', 'He is hard to understand.', 'not He is hard to understand him', 1),
  ('A', 'Do you think it is safe to drink this water?', null, 2),
  ('A', 'Do you think this water is safe to drink?', 'not to drink it', 3),
  ('A', 'Nicola is interesting to talk to.', 'not to talk to her', 4),
  ('A', 'This is a difficult question to answer.', 'not to answer it', 5),
  ('B', 'It was nice of you to take me to the airport. Thank you very much.', null, 0),
  ('B', 'It''s silly of Ruth to give up her job when she needs the money.', null, 1),
  ('B', 'I think it was unfair of him to criticise me.', null, 2),
  ('C', 'I''m sorry to hear that your mother isn''t well.', null, 0),
  ('C', 'Was Julia surprised to see you?', null, 1),
  ('C', 'It was a long and tiring journey. We were glad to get home.', null, 2),
  ('D', 'The next train to arrive at platform 4 will be the 10.50 to Liverpool.', null, 0),
  ('D', 'Everybody was late except me. I was the only one to arrive on time.', null, 1),
  ('D', 'If I have any more news, you will be the first to know.', '= the first person to know', 2),
  ('E', 'Carla is a very good student. She''s bound to pass the exam.', '= she is sure to pass', 0),
  ('E', 'It''s possible I''ll win the lottery one day, but it''s not likely to happen.', '= it''s not probable', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 65.1-65.5; one item of 65.5 dropped —
-- see migration header note about the truncated Key answer)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '65.1', 'Write these sentences in another way, beginning as shown.', 0
from units where slug = 'unit-65';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-65' where es.title = '65.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was difficult to open the window. {0}', null),
  (2, 'It''s impossible to translate some words. {0}', null),
  (3, 'It''s expensive to maintain a car. {0}', null),
  (4, 'It''s not safe to eat this meat. {0}', null),
  (5, 'It''s easy to get to my house from here. {0}', null)
) as v(n, template, hint)
where es.title = '65.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '65.1'
join (values
  (1, 0, 'The window was difficult to open.'),
  (2, 0, 'Some words are impossible to translate.'),
  (3, 0, 'A car is expensive to maintain.'),
  (4, 0, 'This meat isn''t safe to eat.'),
  (5, 0, 'My house is easy to get to from here.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '65.2', 'Make sentences from the words in brackets.', 1
from units where slug = 'unit-65';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-65' where es.title = '65.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s a very common mistake. {0}', '(easy mistake / make)'),
  (2, 'I like living in this town. {0}', '(great place / live)'),
  (3, 'I wonder why she said that. {0}', '(strange thing / say)')
) as v(n, template, hint)
where es.title = '65.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '65.2'
join (values
  (1, 0, 'It''s an easy mistake to make.'),
  (2, 0, 'It''s a great place to live.'),
  (3, 0, 'It was a strange thing to say.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '65.3', 'Complete the sentences. Choose from the box.', 2
from units where slug = 'unit-65';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-65' where es.title = '65.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ve been travelling a long time. Now I''m {0} to be back home.', null),
  (2, 'I heard about Tom''s accident. I was relieved {0} that he''s OK.', null),
  (3, 'It was nice {0} to remember my birthday.', null),
  (4, 'Let me know if you need any assistance. I''d be very pleased {0} you.', null),
  (5, 'I thought James was about 25. I was {0} to discover he was 40.', null),
  (6, 'It was inconsiderate of our neighbours {0} so much noise.', null),
  (7, 'My interview went well. I was disappointed {0} to be offered the job.', null),
  (8, 'It''s {0} of me to worry so much about things that are not important.', null)
) as v(n, template, hint)
where es.title = '65.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '65.3'
join (values
  (1, 0, 'glad'), (2, 0, 'to hear'), (3, 0, 'of you'), (4, 0, 'to help'),
  (5, 0, 'amazed'), (6, 0, 'to make'), (7, 0, 'not'), (8, 0, 'silly')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '65.4', 'Complete the sentences using: the first, the second, the last, the only.', 3
from units where slug = 'unit-65';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-65' where es.title = '65.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Everybody else arrived before Paul. {0}', null),
  (2, 'Emily passed the exam. All the other students failed. {0}', null),
  (3, 'I complained to the manager. Another customer had already complained. {0}', null),
  (4, 'Neil Armstrong walked on the moon in 1969. Nobody had done this before him. {0}', null)
) as v(n, template, hint)
where es.title = '65.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '65.4'
join (values
  (1, 0, 'Paul was the last person to arrive.', array['Paul was the last to arrive.']::text[]),
  (2, 0, 'Emily was the only student to pass the exam.', array['Emily was the only one to pass the exam.']::text[]),
  (3, 0, 'I was the second customer to complain.', array['I was the second person to complain.']::text[]),
  (4, 0, 'Neil Armstrong was the first person to walk on the moon.', array['Neil Armstrong was the first man to walk on the moon.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '65.5', 'Complete the sentences using the words in brackets and a suitable verb.', 4
from units where slug = 'unit-65';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-65' where es.title = '65.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m not surprised you''re tired after your trip. {0}', '(you / bound / tired)'),
  (2, 'Andy has a very bad memory. {0}', '(he / sure / forget)'),
  (3, 'I don''t think you''ll need an umbrella. {0}', '(it / not / likely / rain)')
) as v(n, template, hint)
where es.title = '65.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '65.5'
join (values
  (1, 0, 'You''re bound to be tired after such a long journey.', array['You are bound to be tired after such a long journey.']::text[]),
  (2, 0, 'He''s sure to forget anything you tell him.', array['He is sure to forget anything you tell him.']::text[]),
  (3, 0, 'It''s not likely to rain.', array['It isn''t likely to rain.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 66: to ... (afraid to do) and preposition + -ing (afraid of -ing)
-- ============================================================

delete from units where slug = 'unit-66';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 66, 'unit-66', 'to ... (afraid to do) and preposition + -ing (afraid of -ing)', null,
  'afraid to (do) = you avoid doing it because it could be dangerous/bad; afraid of (do)ing = you fear something bad will happen. interested in (do)ing = you would like to do it; interested to (do) = it was interesting for you. sorry for (do)ing apologises; sorry to (do) regrets something that happens.', 13
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'afraid to (do) and afraid of (do)ing',
  'I am afraid to do something = I don''t want to do it because it is dangerous or the result could be bad: "People are afraid to walk here at night." I am afraid of something happening = I am afraid that something bad will happen: "We were afraid of falling" (not afraid to fall). You are afraid to do something because you are afraid of something happening as a result: "I was afraid to go near the dog because I was afraid of being bitten."', 0
from units where slug = 'unit-66';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'interested in (do)ing and interested to (do)',
  'I''m interested in doing something = I''m thinking of doing it, I would like to do it: "Let me know if you''re interested in joining the club" (not to join). I was interested to hear/see/know something = it was interesting for me: "I was interested to hear that Tanya left her job." This structure is the same as surprised to ... / glad to ... (Unit 65C).', 1
from units where slug = 'unit-66';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'sorry for ... and sorry to ...',
  'We use sorry for (doing) to apologise for something: "I''m sorry for shouting at you yesterday" (not sorry to shout). We use sorry to ... to say that we regret something that happens: "I''m sorry to hear that Nicky lost her job" (not sorry for). We also say "I''m sorry to ..." to apologise at the time we do something: "I''m sorry to bother you, but I need to ask you a question."', 2
from units where slug = 'unit-66';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'verb patterns to compare',
  'Compare: I want to (do), I''d like to (do) — but I''m thinking of (do)ing. I hope to (do) — but I dream of (do)ing. I failed to (do) — but I succeeded in (do)ing. I allowed them to (do) — but I prevented them from (do)ing. I plan to (do) — but I''m looking forward to (do)ing. I promised to (do) — but I insisted on (do)ing.', 3
from units where slug = 'unit-66';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-66'
join (values
  ('A', 'This part of town is dangerous. People are afraid to walk here at night.', null, 0),
  ('A', 'James was afraid to tell his parents what had happened.', null, 1),
  ('A', 'The path was icy, so we walked very carefully. We were afraid of falling.', 'not afraid to fall', 2),
  ('A', 'I don''t like dogs. I''m always afraid of being bitten.', null, 3),
  ('A', 'I was afraid to go near the dog because I was afraid of being bitten.', null, 4),
  ('B', 'Let me know if you''re interested in joining the club.', 'not to join', 0),
  ('B', 'I tried to sell my car, but nobody was interested in buying it.', 'not to buy', 1),
  ('B', 'I was interested to hear that Tanya left her job.', null, 2),
  ('B', 'I''ll ask Mike for his opinion. I would be interested to know what he thinks.', null, 3),
  ('C', 'I''m sorry for shouting at you yesterday.', 'not sorry to shout', 0),
  ('C', 'I''m sorry to hear that Nicky lost her job.', 'not sorry for', 1),
  ('C', 'I''ve enjoyed my stay here. I''ll be sorry to leave.', null, 2),
  ('C', 'I''m sorry to bother you, but I need to ask you a question.', 'apologising as you do something', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 66.1-66.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '66.1', 'Write sentences using afraid to ... or afraid of -ing.', 0
from units where slug = 'unit-66';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-66' where es.title = '66.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t usually carry my passport with me. {0}', '(I / afraid / lose / it)'),
  (2, 'I thought she would be angry if I told her what had happened. {0}', '(I / afraid / tell / her)'),
  (3, 'We ran to the station. {0}', '(we / afraid / miss / our train)'),
  (4, 'In the middle of the film there was a very horrifying scene. {0}', '(we / afraid / look)'),
  (5, 'The vase was very valuable, so I held it carefully. {0}', '(I / afraid / drop / it)'),
  (6, 'If there''s anything you want to know, you can ask me. {0}', '(don''t / afraid / ask)'),
  (7, 'I was worried because we didn''t have much petrol. {0}', '(I / afraid / run out of petrol)')
) as v(n, template, hint)
where es.title = '66.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '66.1'
join (values
  (1, 0, 'I''m afraid of losing it.'),
  (2, 0, 'I was afraid to tell her.'),
  (3, 0, 'We were afraid of missing our train.'),
  (4, 0, 'We were afraid to look.'),
  (5, 0, 'I was afraid of dropping it.'),
  (6, 0, 'Don''t be afraid to ask.'),
  (7, 0, 'I was afraid of running out of petrol.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '66.2', 'Complete the sentences using interested in ... or interested to ... . Choose from these verbs: buy, hear, know, look, start, study.', 1
from units where slug = 'unit-66';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-66' where es.title = '66.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Nicola is {0} her own business.', null),
  (2, 'I saw Joe recently. You''ll be {0} that he''s getting married soon.', null),
  (3, 'I didn''t enjoy school. I wasn''t {0}.', null),
  (4, 'I went to a public meeting to discuss the plans for a new road. I was {0} how people felt about the project.', null),
  (5, 'Paul doesn''t enjoy sightseeing. He''s not {0} at old buildings.', null)
) as v(n, template, hint)
where es.title = '66.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '66.2'
join (values
  (1, 0, 'interested in starting', array[]::text[]),
  (2, 0, 'interested to know', array['interested to hear']::text[]),
  (3, 0, 'interested in studying', array[]::text[]),
  (4, 0, 'interested to hear', array['interested to know', 'interested in hearing', 'interested in knowing']::text[]),
  (5, 0, 'interested in looking', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '66.3', 'Complete the sentences using sorry for ... or sorry to ... . Use the verb in brackets.', 2
from units where slug = 'unit-66';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-66' where es.title = '66.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We were {0} that you can''t come to the wedding.', '(hear)'),
  (2, 'I''m {0} bad things about you. I didn''t mean what I said.', '(say)'),
  (3, 'It''s a shame Alan is leaving the company. I''ll be {0} him go.', '(see)'),
  (4, 'I''m {0} so much noise last night.', '(make)')
) as v(n, template, hint)
where es.title = '66.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '66.3'
join (values
  (1, 0, 'sorry to hear', array[]::text[]),
  (2, 0, 'sorry for saying', array['sorry I said']::text[]),
  (3, 0, 'sorry to see', array[]::text[]),
  (4, 0, 'sorry for making', array['sorry I made']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '66.4', 'Complete the sentences in each group using the verb in brackets.', 3
from units where slug = 'unit-66';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-66' where es.title = '66.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '(1b) We wanted to leave the building. We weren''t allowed {0} the building.', '(leave)'),
  (2, '(1c) We wanted to leave the building. We were prevented {0} the building.', '(leave)'),
  (3, '(2a) Sam and Chris hoped {0} the problem.', '(solve)'),
  (4, '(2b) Sam failed {0} the problem.', '(solve)'),
  (5, '(2c) Chris succeeded {0} the problem.', '(solve)'),
  (6, '(3a) I''m thinking {0} away next week.', '(go)'),
  (7, '(3b) I''m planning {0} away next week.', '(go)'),
  (8, '(3c) I''d like {0} away next week.', '(go)'),
  (9, '(3d) I''m looking forward {0} away next week.', '(go)'),
  (10, '(4a) Helen wanted {0} me lunch.', '(buy)'),
  (11, '(4b) Helen insisted {0} me lunch.', '(buy)'),
  (12, '(4c) Helen promised {0} me lunch.', '(buy)'),
  (13, '(4d) Helen wouldn''t dream {0} me lunch.', '(buy)')
) as v(n, template, hint)
where es.title = '66.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '66.4'
join (values
  (1, 0, 'to leave', array[]::text[]),
  (2, 0, 'from leaving', array[]::text[]),
  (3, 0, 'to solve', array[]::text[]),
  (4, 0, 'to solve', array[]::text[]),
  (5, 0, 'in solving', array[]::text[]),
  (6, 0, 'of going', array['about going']::text[]),
  (7, 0, 'to go', array['on going']::text[]),
  (8, 0, 'to go', array[]::text[]),
  (9, 0, 'to going', array[]::text[]),
  (10, 0, 'to buy', array[]::text[]),
  (11, 0, 'on buying', array[]::text[]),
  (12, 0, 'to buy', array[]::text[]),
  (13, 0, 'of buying', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 67: see somebody do and see somebody doing
-- ============================================================

delete from units where slug = 'unit-67';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 67, 'unit-67', 'see somebody do and see somebody doing', null,
  'see/hear/watch/feel + somebody + do something = the whole action happened and you witnessed it start to finish. see/hear/watch/feel/smell/find + somebody + doing something = you witnessed them in the middle of doing it, not necessarily from start to finish.', 14
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'see somebody do (the complete action)',
  'We say "I saw him do something" (= he did it and I saw this, from start to finish): "I saw Tom get into his car and drive off." The same pattern is used with hear, listen to somebody do something, watch something happen, feel: "I didn''t hear you come in." "Lisa suddenly felt somebody touch her on the shoulder."', 0
from units where slug = 'unit-67';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'see somebody doing (in progress)',
  'We say "I saw her doing something" (= she was doing it and I saw this, in progress): "I saw Kate waiting for a bus." The same pattern is used with hear, listen to, watch, feel, smell, find + somebody doing something / something happening: "I could hear it raining." "We found him sitting under a tree eating an apple."', 1
from units where slug = 'unit-67';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'do vs doing: the difference in meaning',
  'I saw him do something = he did something and I saw the complete action from start to finish: "He jumped over the wall and ran away. I saw him jump over the wall and run away." I saw him doing something = he was doing something and I saw him in the middle of it (not from start to finish): "I saw Tom walking along the street." Sometimes the difference isn''t important and you can use either form: "I''ve never seen her dance" or "I''ve never seen her dancing."', 2
from units where slug = 'unit-67';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-67'
join (values
  ('A', 'I saw Tom get into his car and drive off.', null, 0),
  ('A', 'I didn''t hear you come in.', 'you came in — I didn''t hear this', 1),
  ('A', 'Lisa suddenly felt somebody touch her on the shoulder.', null, 2),
  ('B', 'I saw Kate waiting for a bus.', null, 0),
  ('B', 'I could hear it raining.', null, 1),
  ('B', 'Listen to the birds singing!', null, 2),
  ('B', 'Can you smell something burning?', null, 3),
  ('B', 'We looked for Paul and finally we found him sitting under a tree eating an apple.', null, 4),
  ('C', 'He jumped over the wall and ran away. I saw him jump over the wall and run away.', 'complete action', 0),
  ('C', 'They went out. I heard them go out.', null, 1),
  ('C', 'I saw Tom as I drove past in my car. He was walking along the street. I saw Tom walking along the street.', 'in progress, not complete', 2),
  ('C', 'I''ve never seen her dance. or I''ve never seen her dancing.', 'sometimes either is fine', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Tom getting into his car and driving off, captioned "I saw Tom get into his car and drive off" — the unit''s opening example of see somebody do]', 0
from units where slug = 'unit-67';

-- ------------------------------------------------------------
-- Exercises (main, book's own 67.1-67.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '67.1', 'Complete the sentences with the verb in the correct form.', 0
from units where slug = 'unit-67';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-67' where es.title = '67.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Tom doesn''t have the keys. I saw him {0} them to Lisa.', '(give)'),
  (2, 'A car {0} outside our house, and then it drove off again.', '(stop)'),
  (3, 'We heard a car {0} outside our house, and then it drove off again.', '(stop)'),
  (4, 'Ben gave me the envelope and watched me {0} it.', '(open)'),
  (5, 'Ben gave me the envelope and I {0} it.', '(open)'),
  (6, 'Sarah is Canadian. I heard her {0} she''s from Toronto.', '(say)'),
  (7, 'Sarah is Canadian. She {0} she''s from Toronto.', '(say)'),
  (8, 'A man {0} over in the street, so we went to help him.', '(fall)'),
  (9, 'We saw a man {0} over in the street, so we went to help him.', '(fall)')
) as v(n, template, hint)
where es.title = '67.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '67.1'
join (values
  (1, 0, 'give', array[]::text[]),
  (2, 0, 'stopped', array[]::text[]),
  (3, 0, 'stop', array[]::text[]),
  (4, 0, 'open', array[]::text[]),
  (5, 0, 'opened', array[]::text[]),
  (6, 0, 'say', array[]::text[]),
  (7, 0, 'said', array['says']::text[]),
  (8, 0, 'fell', array[]::text[]),
  (9, 0, 'fall', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '67.2', 'You and a friend saw, heard or smelt something. Complete the sentences.', 1
from units where slug = 'unit-67';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-67' where es.title = '67.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Picture: Clare is eating/sitting in a restaurant. {0}', null),
  (2, 'Picture: David and Helen are playing tennis. {0}', null),
  (3, 'Something is burning. {0}', null),
  (4, 'Sound: Bill is playing his guitar. {0}', null),
  (5, 'Picture: Linda is jogging/running. {0}', null)
) as v(n, template, hint)
where es.title = '67.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '67.2'
join (values
  (1, 0, 'We saw Clare eating in a restaurant.', array['We saw Clare sitting in a restaurant.']::text[]),
  (2, 0, 'We saw David and Helen playing tennis.', array[]::text[]),
  (3, 0, 'We could smell something burning.', array[]::text[]),
  (4, 0, 'We could hear Bill playing his guitar.', array['We could hear Bill playing the guitar.']::text[]),
  (5, 0, 'We saw Linda jogging.', array['We saw Linda running.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '67.3', 'Complete the sentences. Use these verbs (in the correct form): crawl, cry, explode, get, happen, lie, put, ride, say, slam, stand, tell.', 2
from units where slug = 'unit-67';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-67' where es.title = '67.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I thought I heard somebody {0} ''Hi'', so I turned round.', null),
  (2, 'There was an accident outside my house, but I didn''t see it {0}.', null),
  (3, 'Listen. Can you hear a baby {0}?', null),
  (4, 'I know you took the key. I saw you {0} it in your pocket.', null),
  (5, 'We listened to the old man {0} his story from beginning to end.', null),
  (6, 'Everybody heard the bomb {0}. It was a tremendous noise.', null),
  (7, 'Oh! I can feel something {0} up my leg. It must be an insect.', null),
  (8, 'I looked out of the window and saw Dan {0} his bike along the road.', null),
  (9, 'I heard somebody {0} a door in the middle of the night. It woke me up.', null),
  (10, 'When I got home, I found a cat {0} on the kitchen table.', null)
) as v(n, template, hint)
where es.title = '67.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '67.3'
join (values
  (1, 0, 'say'), (2, 0, 'happen'), (3, 0, 'crying'), (4, 0, 'put'), (5, 0, 'tell'),
  (6, 0, 'explode'), (7, 0, 'crawling'), (8, 0, 'riding'), (9, 0, 'slam'), (10, 0, 'lying')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 68: -ing clauses (He hurt his knee playing football.)
-- ============================================================

delete from units where slug = 'unit-68';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 68, 'unit-68', '-ing clauses (He hurt his knee playing football.)', null,
  'An -ing clause can describe two things happening at once, or one action happening during another. having (done) is used when one action is complete before another. -ing (or having done) can also open a sentence to explain why — used more in written English, followed by a comma.', 15
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', '-ing clauses for actions at the same time',
  'You can use -ing when two things happen at the same time: "Kate is in the kitchen making coffee." "A man ran out of the house shouting." We also use -ing when one action happens during another: "Joe hurt his knee playing football" (= while he was playing). You can also say "while doing something" and "when doing something": "Joe hurt his knee while playing football."', 0
from units where slug = 'unit-68';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'having (done), for one action before another',
  'When one action happens before something else, we use having (done) for the first action: "Having found a hotel, we looked for somewhere to eat." You can also say after -ing: "After finishing her work, she went home." These structures are used more in written English than spoken English; write a comma after the -ing/having clause.', 1
from units where slug = 'unit-68';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', '-ing to explain why (reason)',
  'You can also use -ing to explain something, or say why somebody does something — the sentence usually begins with -ing: "Feeling tired, I went to bed early" (= because I felt tired). We use having (done) for something complete before something else: "Having seen the film twice, I didn''t want to see it again" (= because I had seen it twice). These structures are used more in written English; write a comma after the opening -ing/having clause.', 2
from units where slug = 'unit-68';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-68'
join (values
  ('A', 'Kate is in the kitchen making coffee.', null, 0),
  ('A', 'A man ran out of the house shouting.', null, 1),
  ('A', 'Don''t just stand there doing nothing!', null, 2),
  ('A', 'Be careful crossing the road.', null, 3),
  ('A', 'Joe hurt his knee playing football.', '= while he was playing', 4),
  ('A', 'Did you cut yourself shaving?', '= while you were shaving', 5),
  ('B', 'Having found a hotel, we looked for somewhere to eat.', null, 0),
  ('B', 'Having finished her work, she went home.', null, 1),
  ('B', 'After finishing her work, she went home.', null, 2),
  ('C', 'Feeling tired, I went to bed early.', '= because I felt tired', 0),
  ('C', 'Being unemployed, he doesn''t have much money.', '= because he is unemployed', 1),
  ('C', 'Not having a car, she finds it difficult to get around.', '= because she doesn''t have a car', 2),
  ('C', 'Having seen the film twice, I didn''t want to see it again.', '= because I had seen it twice', 3),
  ('C', 'Not knowing what to do, I called my friend to ask her advice.', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Kate in the kitchen making coffee, captioned "Kate is in the kitchen making coffee" — the unit''s opening example of an -ing clause]', 0
from units where slug = 'unit-68';

-- ------------------------------------------------------------
-- Exercises (main, book's own 68.1-68.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '68.1', 'Choose from Box A and Box B to make sentences. Use -ing.', 0
from units where slug = 'unit-68';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-68' where es.title = '68.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Amy was sitting in an armchair. She was reading a book. {0}', null),
  (2, 'Nicola opened the door carefully. She was trying not to make a noise. {0}', null),
  (3, 'Sarah went out. She said she would be back in an hour. {0}', null),
  (4, 'Lisa worked in Rome for two years. She was teaching English. {0}', null),
  (5, 'Anna walked around the town. She looked at the sights and took pictures. {0}', null)
) as v(n, template, hint)
where es.title = '68.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '68.1'
join (values
  (1, 0, 'Amy was sitting in an armchair reading a book.'),
  (2, 0, 'Nicola opened the door carefully trying not to make a noise.'),
  (3, 0, 'Sarah went out saying she would be back in an hour.'),
  (4, 0, 'Lisa worked in Rome for two years teaching English.'),
  (5, 0, 'Anna walked around the town looking at the sights and taking pictures.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '68.2', 'Put the words in the right order.', 1
from units where slug = 'unit-68';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-68' where es.title = '68.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}', '(in the rain / wet / got / very / walking) I ...'),
  (2, '{0}', '(to work / had / driving / an accident) Laura ...'),
  (3, '{0}', '(off / slipped / a bus / getting / and fell) My friend ...'),
  (4, '{0}', '(trying / her back / a heavy box / to lift / hurt) Emily ...'),
  (5, '{0}', '(to put out / by smoke / the fire / overcome / trying) Two people were ...')
) as v(n, template, hint)
where es.title = '68.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '68.2'
join (values
  (1, 0, 'I got very wet walking in the rain.'),
  (2, 0, 'Laura had an accident driving to work.'),
  (3, 0, 'My friend slipped and fell getting off a bus.'),
  (4, 0, 'Emily hurt her back trying to lift a heavy box.'),
  (5, 0, 'Two people were overcome by smoke trying to put out the fire.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '68.3', 'Complete the sentences. Use Having + a suitable verb.', 2
from units where slug = 'unit-68';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-68' where es.title = '68.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} our tickets, we went into the theatre and took our seats.', null),
  (2, '{0} the problem, I think we''ll be able to find a solution.', null),
  (3, '{0} he was hungry, Joe now says he doesn''t want to eat anything.', null),
  (4, '{0} his job recently, James is now unemployed.', null),
  (5, '{0} most of his life in London, Sam has now gone to live in a small village in the country.', null)
) as v(n, template, hint)
where es.title = '68.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '68.3'
join (values
  (1, 0, 'Having bought', array['Having got']::text[]),
  (2, 0, 'Having discussed', array['Having talked about', 'Having thought about']::text[]),
  (3, 0, 'Having said', array[]::text[]),
  (4, 0, 'Having lost', array['Having given up', 'Having been fired from']::text[]),
  (5, 0, 'Having spent', array['Having lived']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '68.4', 'Make one sentence from two. Begin with -ing or Not -ing. Sometimes you need to begin with Having ... .', 3
from units where slug = 'unit-68';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-68' where es.title = '68.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I thought they might be hungry. So I offered them something to eat. {0}', null),
  (2, 'Robert is a vegetarian. So he doesn''t eat any kind of meat. {0}', null),
  (3, 'I didn''t have a phone. So I had no way of contacting anyone. {0}', null),
  (4, 'Sarah has travelled a lot. So she knows a lot about other countries. {0}', null),
  (5, 'I wasn''t able to speak the local language. So I had trouble communicating. {0}', null),
  (6, 'We had spent nearly all our money. So we couldn''t afford to stay at a hotel. {0}', null)
) as v(n, template, hint)
where es.title = '68.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '68.4'
join (values
  (1, 0, 'Thinking they might be hungry, I offered them something to eat.'),
  (2, 0, 'Being a vegetarian, Robert doesn''t eat any kind of meat.'),
  (3, 0, 'Not having a phone, I had no way of contacting anyone.'),
  (4, 0, 'Having travelled a lot, Sarah knows a lot about other countries.'),
  (5, 0, 'Not being able to speak the local language, I had trouble communicating.'),
  (6, 0, 'Having spent nearly all our money, we couldn''t afford to stay at a hotel.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
