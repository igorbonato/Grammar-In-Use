-- Marco 4 (slice 17): seeds the first slice of the "Pronouns and
-- determiners" module — units 82-83 (myself/yourself/themselves etc.,
-- on my own / by myself).
--
-- Sourced from pdf/Modulos/Pronouns and determiners.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (re-extracted without -layout for the Key, same workaround established
-- in the Articles and nouns slices — the Key's 3-column layout garbles
-- under -layout).
--
-- Grepped unit-number headers across the whole file before assuming its
-- range (same lesson as every prior oversized PDF): this file spans units
-- 82-91 (10 units, confirmed no "92" header — Relative clauses.pdf starts
-- there instead). Following the -ing-and-to/Articles-and-nouns precedent,
-- kept as ONE module (`pronouns-and-determiners`), seeded across multiple
-- migration slices. The module row uses `on conflict (slug) do nothing`
-- so later slices can extend it safely.
--
-- 82.1, 82.2, 82.4, 82.5, 83.1-83.6 each have the book's usual single
-- worked example. 82.3 has TWO pre-filled worked examples (items 1 and 2
-- both already answered) — same recurring gotcha as several exercises in
-- the Articles and nouns slices (69.2/69.3, 71.1/71.2, 77.2); confirmed via
-- the Key, which starts numbering at item 3. All renumbered from 1 in this
-- migration's DB rows.
--
-- 82.4 item 9 and 83.1's items are the only multi-blank items this slice;
-- everything else is single-blank.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('pronouns-and-determiners', 'Pronouns and determiners', 10)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 82: myself/yourself/themselves etc.
-- ============================================================

delete from units where slug = 'unit-82';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 82, 'unit-82', 'myself/yourself/themselves etc.', null,
  'We use myself/yourself/himself/herself/itself/ourselves/yourselves/themselves (reflexive pronouns) when the subject and object of a verb are the same (Steve introduced himself). We do not normally use them after feel/relax/concentrate/meet or wash/shave/dress. -selves is different from each other/one another. Myself etc. can also emphasise a noun or pronoun (I repaired it myself).', 0
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'reflexive pronouns: myself, yourself, himself...',
  'We use myself/yourself/himself etc. (reflexive pronouns) when the subject and object are the same: Steve introduced himself to the other guests. The reflexive pronouns are: myself, yourself (one person), himself/herself/itself, ourselves, yourselves (more than one), themselves. I don''t want you to pay for me. I''ll pay for myself (not I''ll pay for me). Amy had a great holiday. She really enjoyed herself. Do you talk to yourself sometimes? (said to one person). If you want more to eat, help yourselves (said to more than one person). Compare: Lisa introduced me to the other guests. I introduced myself to the other guests.', 0
from units where slug = 'unit-82';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'no myself after feel/relax/concentrate/meet, or wash/shave/dress',
  'We do not use myself etc. after feel/relax/concentrate/meet: I feel nervous. I can''t relax. You need to concentrate (not concentrate yourself). What time shall we meet tomorrow? Normally we do not use myself etc. after wash/shave/dress: He got up, washed, shaved and dressed (not washed himself etc.). You can also say get dressed (He got dressed).', 1
from units where slug = 'unit-82';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', '-selves vs. each other / one another',
  'Compare -selves and each other: Kate and Joe stood in front of the mirror and looked at themselves (= Kate and Joe together looked at Kate and Joe). Kate looked at Joe, and Joe looked at Kate. They looked at each other. You can use one another instead of each other: How long have you and Ben known each other? or ... known one another? Sue and Alice don''t like each other, or ... don''t like one another. Do they live near each other? or ... near one another?', 2
from units where slug = 'unit-82';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'myself etc. to emphasise "I", "you" etc.',
  'We also use myself/yourself etc. to emphasise a noun or pronoun. For example: ''Who repaired your bike?'' ''I repaired it myself.'' I repaired it myself = I repaired it, not another person — here, myself emphasises ''I'' (makes it stronger). I''m not going to do your work for you. You can do it yourself (= you, not me). Let''s paint the house ourselves. It will be much cheaper. The film itself wasn''t very good, but I loved the music. I don''t think Lisa will get the job she applied for. Lisa doesn''t think so herself, or Lisa herself doesn''t think so.', 3
from units where slug = 'unit-82';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-82'
join (values
  ('A', 'Steve introduced himself to the other guests.', null, 0),
  ('A', 'I don''t want you to pay for me. I''ll pay for myself.', null, 1),
  ('A', 'Amy had a great holiday. She really enjoyed herself.', null, 2),
  ('A', 'Do you talk to yourself sometimes?', 'said to one person', 3),
  ('A', 'If you want more to eat, help yourselves.', 'said to more than one person', 4),
  ('A', 'Lisa introduced me to the other guests.', 'different subject and object', 5),
  ('A', 'I introduced myself to the other guests.', 'same subject and object', 6),
  ('B', 'I feel nervous. I can''t relax.', null, 0),
  ('B', 'You need to concentrate. (not concentrate yourself)', null, 1),
  ('B', 'What time shall we meet tomorrow?', null, 2),
  ('B', 'He got up, washed, shaved and dressed. (not washed himself etc.)', null, 3),
  ('C', 'Kate and Joe stood in front of the mirror and looked at themselves.', '= Kate and Joe together looked at Kate and Joe', 0),
  ('C', 'Kate looked at Joe, and Joe looked at Kate. They looked at each other.', null, 1),
  ('C', 'How long have you and Ben known each other? or ... known one another?', null, 2),
  ('C', 'Sue and Alice don''t like each other. or ... don''t like one another.', null, 3),
  ('D', '''Who repaired your bike?'' ''I repaired it myself.''', null, 0),
  ('D', 'I''m not going to do your work for you. You can do it yourself.', null, 1),
  ('D', 'Let''s paint the house ourselves. It will be much cheaper.', null, 2),
  ('D', 'The film itself wasn''t very good, but I loved the music.', null, 3),
  ('D', 'Lisa herself doesn''t think so.', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 82.1-82.5)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '82.1', 'Complete the sentences using myself/yourself etc. + these verbs (in the correct form): blame, burn, enjoy, express, hurt, put.', 0
from units where slug = 'unit-82';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-82' where es.title = '82.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ben fell down some steps, but fortunately he didn''t {0}.', null),
  (2, 'It isn''t Sue''s fault. She really shouldn''t {0} in my position.', null),
  (3, 'Please try and understand how I feel. You have to {0} in my position.', null),
  (4, 'The children had a great time at the beach. They really {0}.', null),
  (5, 'Be careful! That pan is hot. Don''t {0}.', null),
  (6, 'Sometimes I can''t say exactly what I mean. I wish I could {0}.', null)
) as v(n, template, hint)
where es.title = '82.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '82.1'
join (values
  (1, 'hurt himself'), (2, 'blame herself'), (3, 'put yourself'),
  (4, 'enjoyed themselves'), (5, 'burn yourself'), (6, 'express myself')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '82.2', 'Put in myself/yourself/ourselves etc. or me/you/us etc.', 1
from units where slug = 'unit-82';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-82' where es.title = '82.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s not my fault. You can''t blame {0}.', null),
  (2, 'What I did was really bad. I''m ashamed of {0}.', null),
  (3, 'We have a problem. I hope you can help {0}.', null),
  (4, '''Can I take another biscuit?'' ''Of course. Help {0}!''', null),
  (5, 'I want you to meet Sarah. I''ll introduce {0} to her.', null),
  (6, 'Don''t worry about us. We can take care of {0}.', null),
  (7, 'Don''t worry about the children. I''ll take care of {0}.', null),
  (8, 'I gave them a key to our house so that they could let {0} in.', null)
) as v(n, template, hint)
where es.title = '82.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '82.2'
join (values
  (1, 'me'), (2, 'myself'), (3, 'us'), (4, 'yourself'),
  (5, 'you'), (6, 'ourselves'), (7, 'them'), (8, 'themselves')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '82.3', 'Complete these sentences. Use myself/yourself etc. where necessary. Choose from: concentrate, defend, dry, feel, meet, relax.', 2
from units where slug = 'unit-82';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-82' where es.title = '82.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wasn''t very well yesterday, but I {0} much better today.', null),
  (2, 'I climbed out of the swimming pool and {0} with a towel.', null),
  (3, 'I tried to study, but I couldn''t {0}.', null),
  (4, 'If somebody attacks you, you have the right to {0}.', null),
  (5, 'I''m going out with Chris this evening. We''re {0} at 7.30.', null),
  (6, 'You''re always rushing. Why don''t you sit down and {0}?', null)
) as v(n, template, hint)
where es.title = '82.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '82.3'
join (values
  (1, 'feel'), (2, 'dried myself'), (3, 'concentrate'),
  (4, 'defend yourself'), (5, 'meeting'), (6, 'relax')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '82.4', 'Complete the sentences with ourselves/themselves or each other.', 3
from units where slug = 'unit-82';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-82' where es.title = '82.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'If people work too hard, they can make {0} ill.', null),
  (2, 'I need you and you need me. We need {0}.', null),
  (3, 'In Britain friends often give {0} presents at Christmas.', null),
  (4, 'Some people are selfish. They only think of {0}.', null),
  (5, 'Tracy and I don''t see {0} very often these days.', null),
  (6, 'We couldn''t get back into the house. We had locked {0} out.', null),
  (7, 'They''ve had an argument. Now they''re not speaking to {0}.', null),
  (8, 'We''d never met before, so we introduced {0} to {1}.', null)
) as v(n, template, hint)
where es.title = '82.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '82.4'
join (values
  (1, 0, 'themselves'), (2, 0, 'each other'), (3, 0, 'each other'), (4, 0, 'themselves'),
  (5, 0, 'each other'), (6, 0, 'ourselves'), (7, 0, 'each other'),
  (8, 0, 'ourselves'), (8, 1, 'each other')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '82.5', 'Complete the sentences using myself/yourself etc. Use the verb in brackets.', 4
from units where slug = 'unit-82';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-82' where es.title = '82.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I didn''t buy this cake from a shop. I {0}. (make)', null),
  (2, '''Who told you Laura was going away?'' ''{0}.'' (tell)', null),
  (3, 'I don''t know what they''re going to do. I don''t think they {0}. (know)', null),
  (4, '''Who cuts Paul''s hair for him?'' ''Nobody. He {0}.'' (cut)', null),
  (5, '''Can you phone Sam for me?'' ''Why can''t you {0}?'' (do)', null)
) as v(n, template, hint)
where es.title = '82.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '82.5'
join (values
  (1, 'I made it myself', array[]::text[]),
  (2, 'Laura told me herself', array['Laura herself told me']::text[]),
  (3, 'know themselves', array[]::text[]),
  (4, 'cuts it himself', array[]::text[]),
  (5, 'do it yourself', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 83: on my own / by myself
-- ============================================================

delete from units where slug = 'unit-83';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 83, 'unit-83', 'on my own / by myself', null,
  'A friend of mine/yours/his/hers/ours/theirs = one of my/your... friends. We say my own/your own/his own... (never "an own") for something that belongs only to me, not shared or borrowed — and also to say we do something ourselves rather than somebody else doing it for us (he cuts his own hair). On my own and by myself both mean "alone".', 1
from modules where slug = 'pronouns-and-determiners';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'a friend of mine / a friend of yours',
  'We say (a friend) of mine/yours/his/hers/ours/theirs. A friend of mine = one of my friends: I''m going to a wedding on Saturday. A friend of mine is getting married (not a friend of me). We went on holiday with some friends of ours (not some friends of us). Harry had an argument with a neighbour of his. It was a good idea of yours to go to the cinema. In the same way we say (a friend) of my sister''s / (a friend) of Tom''s etc.: That woman over there is a friend of my sister''s (= one of my sister''s friends). It was a good idea of Tom''s to go to the cinema.', 0
from units where slug = 'unit-83';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'my own ... / your own ... (not an own ...)',
  'We say my own / your own / her own ... etc.: my own house, your own car, her own room (not an own house, an own car etc.). my own ... = something that is only mine/yours, not shared or borrowed: I don''t want to share a room with anybody. I want my own room. Vicky and Gary would like to have their own house. It''s a shame that the apartment hasn''t got its own parking space. It''s my own fault that I have no money. Why don''t you use your own? (= your own car). You can also say a room of my own, a house of your own, problems of his own etc.: I''d like to have a room of my own. He has too many problems of his own.', 1
from units where slug = 'unit-83';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'his own hair: doing it yourself instead of somebody else',
  'We also use own to say that we do something ourselves instead of somebody else doing it for us: Paul usually cuts his own hair (= he cuts it himself). I''d like to have a garden so that I could grow my own vegetables (= grow them myself instead of buying them from shops).', 2
from units where slug = 'unit-83';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'on my own / by myself (= alone)',
  'On my own and by myself both mean alone. So you can say: on my/your/his/her/its own or by myself/yourself/himself/herself/itself (singular); on our/their own or by ourselves/yourselves/themselves (plural). I like living on my own, or I like living by myself. Some people prefer to live on their own, or ... live by themselves. Jack was sitting on his own in a corner of the cafe, or Jack was sitting by himself ... Did you go on holiday on your own? or Did you go on holiday by yourself?', 3
from units where slug = 'unit-83';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-83'
join (values
  ('A', 'I''m going to a wedding on Saturday. A friend of mine is getting married.', 'not a friend of me', 0),
  ('A', 'We went on holiday with some friends of ours.', 'not some friends of us', 1),
  ('A', 'Harry had an argument with a neighbour of his.', null, 2),
  ('A', 'It was a good idea of yours to go to the cinema.', null, 3),
  ('A', 'That woman over there is a friend of my sister''s.', '= one of my sister''s friends', 4),
  ('B', 'I don''t want to share a room with anybody. I want my own room.', null, 0),
  ('B', 'Vicky and Gary would like to have their own house.', null, 1),
  ('B', 'It''s a shame that the apartment hasn''t got its own parking space.', null, 2),
  ('B', 'Why don''t you use your own?', '= your own car', 3),
  ('B', 'I''d like to have a room of my own.', null, 4),
  ('B', 'He has too many problems of his own.', null, 5),
  ('C', 'Paul usually cuts his own hair.', '= he cuts it himself', 0),
  ('C', 'I''d like to have a garden so that I could grow my own vegetables.', 'instead of buying them from shops', 1),
  ('D', 'I like living on my own. or I like living by myself.', null, 0),
  ('D', 'Jack was sitting on his own in a corner of the cafe. or Jack was sitting by himself ...', null, 1),
  ('D', 'Did you go on holiday on your own? or Did you go on holiday by yourself?', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 83.1-83.6)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '83.1', 'Change the underlined words and use the structure ... of mine/yours etc.', 0
from units where slug = 'unit-83';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-83' where es.title = '83.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We met {0}.', 'one of your relatives'),
  (2, 'Jason borrowed {0}.', 'one of my books'),
  (3, 'I met Lisa and {0}.', 'some of her friends'),
  (4, 'We had dinner with {0}.', 'one of our neighbours'),
  (5, 'I went on holiday with {0}.', 'two of my friends'),
  (6, 'I met {0} at the party.', 'one of Amy''s friends'),
  (7, 'It''s always been {0} to travel round the world.', 'one of my ambitions')
) as v(n, template, hint)
where es.title = '83.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '83.1'
join (values
  (1, 'a relative of yours'), (2, 'a book of mine'), (3, 'some friends of hers'),
  (4, 'a neighbour of ours'), (5, 'two friends of mine'), (6, 'a friend of Amy''s'),
  (7, 'an ambition of mine')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '83.2', 'Complete the sentences using my own / our own etc. + the following: bathroom, business, opinions, private beach, words.', 1
from units where slug = 'unit-83';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-83' where es.title = '83.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Gary doesn''t think like me. He has {0}.', null),
  (2, 'Julia doesn''t want to work for other people. She wants to start {0}.', null),
  (3, 'In the test we had to read a story, and then write it in {0}.', null),
  (4, 'We stayed at a luxury hotel by the sea. The hotel had {0}.', null)
) as v(n, template, hint)
where es.title = '83.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '83.2'
join (values
  (1, 'his own opinions'), (2, 'her own business'), (3, 'our own words'), (4, 'its own private beach')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '83.3', 'Complete the sentences using my own / your own etc.', 2
from units where slug = 'unit-83';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-83' where es.title = '83.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'How can you blame me? It''s not my fault. It''s {0}.', null),
  (2, 'She''s always using my ideas. Why can''t she use {0}?', null),
  (3, 'Please don''t worry about my problems. I''m sure you have {0}.', null),
  (4, 'I can''t make his decisions for him. He has to make {0}.', null)
) as v(n, template, hint)
where es.title = '83.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '83.3'
join (values
  (1, 'your own fault'), (2, 'her own ideas'), (3, 'your own problems'), (4, 'his own decisions')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '83.4', 'Complete the sentences using my own / your own etc. Use the verbs in brackets.', 3
from units where slug = 'unit-83';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-83' where es.title = '83.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Helen doesn''t often buy clothes. She likes to {0}. (make)', null),
  (2, 'I''m not going to clean your shoes. You can {0}. (clean)', null),
  (3, 'We don''t often buy bread. We usually {0}. (bake)', null),
  (4, 'Jack and Joe are singers. They sing songs written by other people, but they also {0}. (write)', null)
) as v(n, template, hint)
where es.title = '83.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '83.4'
join (values
  (1, 'make her own clothes'), (2, 'clean your own shoes'),
  (3, 'bake our own bread'), (4, 'write their own songs')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '83.5', 'Complete the sentences using my own / your own etc. or myself/yourself etc.', 4
from units where slug = 'unit-83';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-83' where es.title = '83.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The box was too heavy for me to lift by {0}.', null),
  (2, 'We had no help decorating the apartment. We did it completely on {0}.', null),
  (3, 'Very young children should not go swimming by {0}.', null),
  (4, '''Who was Tom with when you saw him?'' ''Nobody. He was by {0}.''', null),
  (5, 'I don''t like strawberries with cream. I like them on {0}.', null),
  (6, 'Do you like working with other people or do you prefer working by {0}?', null),
  (7, 'I went out with Sally because she didn''t want to go out on {0}.', null)
) as v(n, template, hint)
where es.title = '83.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '83.5'
join (values
  (1, 'myself'), (2, 'our own'), (3, 'themselves'), (4, 'himself'),
  (5, 'their own'), (6, 'yourself'), (7, 'her own')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '83.6', 'Are these sentences OK? Correct them where necessary.', 5
from units where slug = 'unit-83';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-83' where es.title = '83.6' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sam and Chris are colleagues of {0}.', null),
  (2, 'I was scared. I didn''t want to go out {0}.', null),
  (3, 'In my last job I had {0}.', null),
  (4, 'He must be lonely. He''s always {0}.', null),
  (5, 'My parents have gone away with some friends of {0}.', null),
  (6, 'Are there any countries that produce all {0} food?', null)
) as v(n, template, hint)
where es.title = '83.6';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '83.6'
join (values
  (1, 'mine', array[]::text[]),
  (2, 'on my own', array['by myself']::text[]),
  (3, 'my own office', array[]::text[]),
  (4, 'by himself', array[]::text[]),
  (5, 'theirs', array[]::text[]),
  (6, 'their own', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
