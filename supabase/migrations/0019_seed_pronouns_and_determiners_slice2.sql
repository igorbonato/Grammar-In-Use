-- Marco 4 (slice 18): seeds the second slice of the "Pronouns and
-- determiners" module — units 84-85 (there ... and it ..., some and any).
--
-- Sourced from pdf/Modulos/Pronouns and determiners.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (re-extracted without -layout, same workaround as prior slices).
--
-- 84.1 has TWO pre-filled worked examples (items 1 and 2 both already
-- answered) — same recurring gotcha as several exercises in earlier
-- slices; confirmed via the Key, which starts numbering at item 3. 84.2,
-- 84.3, 84.4, 85.1, 85.2 and 85.3 each have the book's usual single
-- worked example. All renumbered from 1 in this migration's DB rows.
--
-- 84.2 item 6 ("I like this town — it's lively") is labelled "(example
-- answers)" in the Key, but unlike genuinely open-ended exercises (where
-- the answer is a personal fact), this one is a fixed rephrasing task with
-- a handful of closely-equivalent correct phrasings — seeded normally
-- with the Key's variants as accepted_alternatives, same judgment call as
-- 47.2/51.3 in earlier modules (an "example answers" label alone isn't
-- enough reason to skip).
--
-- 84.4 and 85.1/85.2's item 18 are the only multi-blank items this slice;
-- everything else is single-blank.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 84: there ... and it ...
-- ============================================================

delete from units where slug = 'unit-84';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 84, 'unit-84', 'there ... and it ...', null,
  'We use there ... to say that something exists, especially the first time we mention it (There''s a new restaurant in Hill Street). We use it to refer to a specific thing, place, fact or situation already mentioned, and also to talk about distance, time and weather (How far is it? It''s a long time since ... It was windy).', 2
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'there ... for something existing (first mention); it = a specific thing',
  'We use there ... when we talk about something for the first time, to say that it exists: There''s a new restaurant in Hill Street. I''m sorry I''m late. There was a lot of traffic (not It was a lot of traffic). Things are very expensive now. There has been a big rise in the cost of living. It = a specific thing, place, fact, situation etc.: We went to the new restaurant. It''s very good (It = the restaurant). I wasn''t expecting her to call me. It was a complete surprise (It = that she called). Compare: I like this town. There''s a lot to do here. It''s an interesting place. There also means "to/at/in that place": The house is unoccupied. There''s nobody living there (= in the house).', 0
from units where slug = 'unit-84';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'there will be, there must have been, there used to be etc.',
  'You can say: there will be, there must be, there might be etc.; there must have been, there should have been, there would have been etc.; there is sure to be, there is bound to be, there is going to be, there is supposed to be, there used to be. ''Is there a flight to Rome tonight?'' ''There might be. I''ll check online.'' If people drove more carefully, there wouldn''t be so many accidents. I could hear music coming from the house. There must have been somebody at home. There''s bound to be a cafe somewhere near here (= There''s sure to be ...). Compare there and it: They live on a busy road. There must be a lot of noise from the traffic. They live on a busy road. It must be very noisy (It = living on a busy road). There used to be a cinema here, but it closed a few years ago. That building is now a supermarket. It used to be a cinema (It = that building).', 1
from units where slug = 'unit-84';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'it for distance, time, weather, and "It''s ... to ..." sentences',
  'We say: It''s dangerous to walk in the road (not To walk in the road is dangerous). Normally we use It ... at the beginning of sentences like this: It didn''t take us long to get here. It''s a shame (that) you can''t come to the party. It''s not worth waiting any longer. Let''s go. We also use it to talk about distance, time and weather: How far is it from here to the airport? It''s a long time since we last saw you. Compare it and there: It was windy, but There was a cold wind.', 2
from units where slug = 'unit-84';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-84'
join (values
  ('A', 'There''s a new restaurant in Hill Street.', null, 0),
  ('A', 'I''m sorry I''m late. There was a lot of traffic. (not It was a lot of traffic)', null, 1),
  ('A', 'Things are very expensive now. There has been a big rise in the cost of living.', null, 2),
  ('A', 'We went to the new restaurant. It''s very good.', '= the restaurant', 3),
  ('A', 'I wasn''t expecting her to call me. It was a complete surprise.', '= that she called', 4),
  ('A', 'I like this town. There''s a lot to do here. It''s an interesting place.', null, 5),
  ('A', 'The house is unoccupied. There''s nobody living there.', '= in the house', 6),
  ('B', '''Is there a flight to Rome tonight?'' ''There might be. I''ll check online.''', null, 0),
  ('B', 'If people drove more carefully, there wouldn''t be so many accidents.', null, 1),
  ('B', 'I could hear music coming from the house. There must have been somebody at home.', null, 2),
  ('B', 'There''s bound to be a cafe somewhere near here.', '= There''s sure to be ...', 3),
  ('B', 'They live on a busy road. There must be a lot of noise from the traffic.', null, 4),
  ('B', 'They live on a busy road. It must be very noisy.', '= living on a busy road', 5),
  ('B', 'There used to be a cinema here, but it closed a few years ago.', null, 6),
  ('B', 'That building is now a supermarket. It used to be a cinema.', '= that building', 7),
  ('C', 'It''s dangerous to walk in the road. (not To walk in the road is dangerous)', null, 0),
  ('C', 'It didn''t take us long to get here.', null, 1),
  ('C', 'It''s a shame (that) you can''t come to the party.', null, 2),
  ('C', 'It''s not worth waiting any longer. Let''s go.', null, 3),
  ('C', 'How far is it from here to the airport?', null, 4),
  ('C', 'It''s a long time since we last saw you.', null, 5),
  ('C', 'It was windy. but There was a cold wind.', null, 6)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 84.1-84.4; 84.1 renumbered from the book's
-- item 3 — both items 1 and 2 are worked examples)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '84.1', 'Put in there is/was or it is/was. Some sentences are questions and some are negative.', 0
from units where slug = 'unit-84';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-84' where es.title = '84.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} something wrong with the washing machine. It''s not working properly.', null),
  (2, 'I wanted to visit the museum yesterday, but {0} enough time.', null),
  (3, 'What''s that new building over there? {0} a hotel?', null),
  (4, 'How can we get across the river? {0} a bridge?', null),
  (5, 'A few days ago {0} a big storm, which caused a lot of damage.', null),
  (6, 'I can''t find my phone. {0} in my bag — I just looked.', null),
  (7, '{0} anything interesting on TV, so I turned it off.', null),
  (8, '{0} often very cold here, but {1} much snow.', null),
  (9, 'I couldn''t see anything. {0} completely dark.', null),
  (10, '''{0} a bookshop near here?'' ''Yes, {1} one in Hudson Street.''', null),
  (11, '{0} difficult to get a job right now. {1} a lot of unemployment.', null),
  (12, 'When we got to the cinema, {0} a queue outside. {1} a very long queue, so we decided not to wait.', null)
) as v(n, template, hint)
where es.title = '84.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '84.1'
join (values
  (1, 0, 'There''s', array['There is']::text[]),
  (2, 0, 'there wasn''t', array[]::text[]),
  (3, 0, 'Is it', array[]::text[]),
  (4, 0, 'Is there', array[]::text[]),
  (5, 0, 'there was', array[]::text[]),
  (6, 0, 'It isn''t', array['It''s not']::text[]),
  (7, 0, 'There wasn''t', array[]::text[]),
  (8, 0, 'It''s', array['It is']::text[]), (8, 1, 'there isn''t', array[]::text[]),
  (9, 0, 'It was', array[]::text[]),
  (10, 0, 'Is there', array[]::text[]), (10, 1, 'there''s', array['there is']::text[]),
  (11, 0, 'It''s', array['It is']::text[]), (11, 1, 'There''s', array['There is']::text[]),
  (12, 0, 'there was', array[]::text[]), (12, 1, 'It was', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '84.2', 'Read the first sentence and then write a sentence beginning There ... .', 1
from units where slug = 'unit-84';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-84' where es.title = '84.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'This soup is very salty. {0}', null),
  (2, 'The box was empty. {0}', null),
  (3, 'About 50 people came to the meeting. {0}', null),
  (4, 'The film is very violent. {0}', null),
  (5, 'I like this town — it''s lively. {0}', null)
) as v(n, template, hint)
where es.title = '84.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '84.2'
join (values
  (1, 'There''s a lot of salt in the soup.', array['There is a lot of salt in the soup.', 'There''s too much salt in the soup.']::text[]),
  (2, 'There was nothing in the box.', array[]::text[]),
  (3, 'There were about 50 people at the meeting.', array[]::text[]),
  (4, 'There''s a lot of violence in the film.', array['There is a lot of violence in the film.']::text[]),
  (5, 'There is a lot to do in this town.', array['There''s plenty to do in this town.', 'There''s a lot happening in this town.', 'There are a lot of places to go in this town.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '84.3', 'Complete the sentences. Use there would be, there used to be etc. Choose from: won''t, may, would, wouldn''t, should, used to, is going to.', 2
from units where slug = 'unit-84';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-84' where es.title = '84.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''Do we have any eggs?'' ''I''m not sure. {0} some in the fridge.''', null),
  (2, 'I think everything will be OK. {0} any problems.', null),
  (3, 'Look at those clouds. {0} a storm. I''m sure of it.', null),
  (4, 'There isn''t a school in the village. {0} one, but it closed a few years ago.', null),
  (5, 'People drive too fast on this road. I think {0} a speed limit.', null),
  (6, 'If people weren''t so aggressive, {0} any wars.', null)
) as v(n, template, hint)
where es.title = '84.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '84.3'
join (values
  (1, 'There may be'), (2, 'There won''t be'), (3, 'There''s going to be'),
  (4, 'There used to be'), (5, 'there should be'), (6, 'there wouldn''t be')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '84.4', 'Are these sentences OK? Change it to there where necessary.', 3
from units where slug = 'unit-84';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-84' where es.title = '84.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s a long way from my house to the nearest shop.', 'OK — no change needed'),
  (2, 'After the lecture {0} to ask questions.', null),
  (3, 'Why was she so unfriendly? {0}', null),
  (4, 'I like where I live, but it would be nicer to live by the sea.', 'OK — no change needed'),
  (5, 'How long is it since you last went to the theatre?', 'OK — no change needed'),
  (6, '{0} here, but not many come now.', null),
  (7, 'My phone won''t work here. {0}', null),
  (8, 'It was Ken''s birthday yesterday. We had a party.', 'OK — no change needed'),
  (9, 'We won''t have any problem parking the car. {0} somewhere.', null),
  (10, 'I''m sorry about what happened. It was my fault.', 'OK — no change needed'),
  (11, 'I was told that {0} at the station, but it wasn''t anybody.', null)
) as v(n, template, hint)
where es.title = '84.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '84.4'
join (values
  (1, 'It''s a long way from my house to the nearest shop.'),
  (2, 'there will be an opportunity'),
  (3, 'There must have been a reason.'),
  (4, 'I like where I live, but it would be nicer to live by the sea.'),
  (5, 'How long is it since you last went to the theatre?'),
  (6, 'There used to be a lot of tourists'),
  (7, 'There''s no signal.'),
  (8, 'It was Ken''s birthday yesterday. We had a party.'),
  (9, 'There''s sure to be a car park'),
  (10, 'I''m sorry about what happened. It was my fault.'),
  (11, 'there would be somebody to meet me')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 85: some and any
-- ============================================================

delete from units where slug = 'unit-85';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 85, 'unit-85', 'some and any', null,
  'We generally use some (and somebody/someone/something) in positive sentences, and any (anybody/anyone/anything) in negative sentences and most questions. We use some in questions when offering or asking for things, and any to mean "it doesn''t matter which". Somebody/anyone etc. are singular words but we use they/them/their after them.', 3
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'some in positive sentences, any in negative sentences',
  'In general we use some (also somebody/someone/something) in positive sentences and any (also anybody etc.) in negative sentences: We bought some flowers. We didn''t buy any flowers. He''s busy. He has some work to do. He''s lazy. He never does any work. There''s somebody at the door. There isn''t anybody at the door. I want something to eat. I don''t want anything to eat. We use any in sentences that are negative in meaning: She went out without any money (she didn''t take any money with her). He refused to eat anything (he didn''t eat anything). It''s a very easy exam. Hardly anybody fails (= almost nobody fails).', 0
from units where slug = 'unit-85';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'some and any in questions',
  'We use both some and any in questions. We use some/somebody/something to talk about a person or thing that we know exists, or we think exists: Are you waiting for somebody? (I think you are waiting for somebody). We use some in questions when we ask for or offer things: Can I have some sugar, please? (there is probably some sugar that I can have). Would you like something to eat? (there is something to eat). But in most questions, we use any — we do not know if the thing or person exists: Do you have any luggage? (maybe you do, maybe not). Is there anybody in the house? (maybe there is, maybe not).', 1
from units where slug = 'unit-85';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'if + any',
  'You can use if + any: Let me know if you need anything. If anyone has any questions, I''ll be pleased to answer them. The following sentences have the idea of if: I''m sorry for any trouble I''ve caused (= if I have caused any trouble). The police want to speak to anyone who saw the accident (= if there is anyone).', 2
from units where slug = 'unit-85';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', '"it doesn''t matter which": any, anybody, anywhere',
  'We also use any with the meaning "it doesn''t matter which": You can take any bus. They all go to the centre (= it doesn''t matter which bus you take). Come and see me any time you want. We use anybody/anyone/anything/anywhere in the same way: We forgot to lock the door. Anybody could have come in. Compare some- and any-: ''I''m hungry. I want something to eat.'' ''What would you like?'' ''I don''t mind. Anything.'' (= it doesn''t matter what). ''Let''s go out somewhere.'' ''Where shall we go?'' ''Anywhere. I just want to go out.''', 3
from units where slug = 'unit-85';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'somebody/anybody are singular, but use they/them/their',
  'Somebody/someone/anybody/anyone are singular words: Someone is here to see you. But we use they/them/their after these words: Someone has forgotten their umbrella (= his or her umbrella). If anybody wants to leave early, they can (= he or she can).', 4
from units where slug = 'unit-85';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-85'
join (values
  ('A', 'We bought some flowers.', null, 0),
  ('A', 'We didn''t buy any flowers.', null, 1),
  ('A', 'He''s busy. He has some work to do.', null, 2),
  ('A', 'He''s lazy. He never does any work.', null, 3),
  ('A', 'There''s somebody at the door.', null, 4),
  ('A', 'There isn''t anybody at the door.', null, 5),
  ('A', 'She went out without any money.', 'she didn''t take any money with her', 6),
  ('A', 'He refused to eat anything.', 'he didn''t eat anything', 7),
  ('A', 'It''s a very easy exam. Hardly anybody fails.', '= almost nobody fails', 8),
  ('B', 'Are you waiting for somebody?', 'I think you are waiting for somebody', 0),
  ('B', 'Can I have some sugar, please?', 'there is probably some sugar that I can have', 1),
  ('B', 'Would you like something to eat?', null, 2),
  ('B', 'Do you have any luggage?', 'maybe you do, maybe not', 3),
  ('B', 'Is there anybody in the house?', 'maybe there is, maybe not', 4),
  ('C', 'Let me know if you need anything.', null, 0),
  ('C', 'If anyone has any questions, I''ll be pleased to answer them.', null, 1),
  ('C', 'I''m sorry for any trouble I''ve caused.', '= if I have caused any trouble', 2),
  ('C', 'The police want to speak to anyone who saw the accident.', '= if there is anyone', 3),
  ('D', 'You can take any bus. They all go to the centre.', '= it doesn''t matter which bus you take', 0),
  ('D', 'Come and see me any time you want.', null, 1),
  ('D', 'We forgot to lock the door. Anybody could have come in.', null, 2),
  ('D', '''I''m hungry. I want something to eat.'' ''What would you like?'' ''I don''t mind. Anything.''', '= it doesn''t matter what', 3),
  ('E', 'Someone is here to see you.', null, 0),
  ('E', 'Someone has forgotten their umbrella.', '= his or her umbrella', 1),
  ('E', 'If anybody wants to leave early, they can.', '= he or she can', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 85.1-85.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '85.1', 'Put in some or any.', 0
from units where slug = 'unit-85';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-85' where es.title = '85.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Tonight I''m going out with {0} friends of mine.', null),
  (2, 'Have you seen {0} good movies recently?', null),
  (3, 'I''d like {0} information about what there is to see in this town.', null),
  (4, 'I didn''t have {0} money. I had to borrow {1}.', null),
  (5, 'You can use your card to withdraw money at {0} cash machine.', null),
  (6, 'Those apples look nice. Shall we get {0}?', null),
  (7, 'With the special tourist train ticket, you can travel on {0} train you like.', null),
  (8, '''Can I have {0} more coffee, please?'' ''Sure. Help yourself.''', null),
  (9, 'If there are {0} words you don''t understand, look them up in a dictionary.', null),
  (10, 'We wanted to buy {0} grapes, but they didn''t have {1} in the shop.', null)
) as v(n, template, hint)
where es.title = '85.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '85.1'
join (values
  (1, 0, 'some'), (2, 0, 'any'), (3, 0, 'some'),
  (4, 0, 'any'), (4, 1, 'some'), (5, 0, 'any'), (6, 0, 'some'), (7, 0, 'any'),
  (8, 0, 'some'), (9, 0, 'any'), (10, 0, 'some'), (10, 1, 'any')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '85.2', 'Complete the sentences with some- or any- + -body/-thing/-where.', 1
from units where slug = 'unit-85';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-85' where es.title = '85.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There''s {0} at the door. Can you go and see who it is?', null),
  (2, 'Does {0} mind if I open the window?', null),
  (3, 'I can''t drive and I don''t know {0} about cars.', null),
  (4, 'You must be hungry. Why don''t I get you {0} to eat?', null),
  (5, 'Emma is very tolerant. She never complains about {0}.', null),
  (6, 'There was hardly {0} on the beach. It was almost deserted.', null),
  (7, 'Let''s go away. Let''s go {0} warm and sunny.', null),
  (8, 'I''m going out now. If {0} asks where I am, tell them you don''t know.', null),
  (9, 'Why are you looking under the bed? Have you lost {0}?', null),
  (10, 'This is a no-parking area. {0} who parks their car here will have to pay a fine.', null),
  (11, 'Quick, let''s go! There''s {0} coming and I don''t want {1} to see us.', null),
  (12, 'They stay at home all the time. They never seem to go {0}.', null),
  (13, 'Jonathan stood up and left the room without saying {0}.', null),
  (14, '''Can I ask you {0}?'' ''Sure. What do you want to ask?''', null),
  (15, 'Sarah was upset about {0} and refused to talk to {1}.', null),
  (16, 'I need {0} to translate. Is there {1} here who speaks English?', null),
  (17, 'Sue is very secretive. She never tells {0} {1}.', '2 words')
) as v(n, template, hint)
where es.title = '85.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '85.2'
join (values
  (1, 0, 'somebody', array['someone']::text[]),
  (2, 0, 'anybody', array['anyone']::text[]),
  (3, 0, 'anything', array[]::text[]),
  (4, 0, 'something', array[]::text[]),
  (5, 0, 'anything', array[]::text[]),
  (6, 0, 'anybody', array['anyone']::text[]),
  (7, 0, 'somewhere', array[]::text[]),
  (8, 0, 'anybody', array['anyone']::text[]),
  (9, 0, 'something', array[]::text[]),
  (10, 0, 'Anybody', array['Anyone']::text[]),
  (11, 0, 'somebody', array['someone']::text[]), (11, 1, 'anybody', array['anyone']::text[]),
  (12, 0, 'anywhere', array[]::text[]),
  (13, 0, 'anything', array[]::text[]),
  (14, 0, 'something', array[]::text[]),
  (15, 0, 'something', array[]::text[]), (15, 1, 'anybody', array['anyone']::text[]),
  (16, 0, 'somebody', array['someone']::text[]), (16, 1, 'anybody', array['anyone']::text[]),
  (17, 0, 'anybody', array['anyone']::text[]), (17, 1, 'anything', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '85.3', 'Complete the sentences. Use any (+ noun) or anybody/anything/anywhere.', 2
from units where slug = 'unit-85';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-85' where es.title = '85.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When shall we meet? Monday? I don''t mind. {0} next week will be OK for me.', null),
  (2, 'What do you want to eat? {0}. I don''t mind. Whatever you have.', null),
  (3, 'Who shall I invite to the party? It''s your party. You can invite {0} you want.', null),
  (4, 'What sort of job are you looking for? {0}. It doesn''t matter what it is.', null),
  (5, 'Where shall I sit? It''s up to you. You can sit {0} you like.', null),
  (6, 'Is this machine difficult to use? No, it''s easy. {0} can learn to use it very quickly.', null)
) as v(n, template, hint)
where es.title = '85.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '85.3'
join (values
  (1, 'Any day', array[]::text[]),
  (2, 'Anything', array[]::text[]),
  (3, 'anybody', array['anyone']::text[]),
  (4, 'Any job', array['Anything']::text[]),
  (5, 'anywhere', array[]::text[]),
  (6, 'Anybody', array['Anyone']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
