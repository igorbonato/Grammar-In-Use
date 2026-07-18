-- Marco 4 (slice 40): seeds the fifth slice of the "Conjunctions and
-- prepositions" module — unit 118 (like / as if).
--
-- Sourced from pdf/Modulos/Conjunctions and prepositions.pdf (extracted
-- via `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Written in multiple smaller Write/Edit calls rather than one large
-- Write, same fallback used for units 116/117 after the content-filtering
-- errors earlier in this module.
--
-- Safe to re-run: unit 118 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 118: like / as if
-- ============================================================

delete from units where slug = 'unit-118';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 118, 'unit-118', 'like / as if', null,
  'We use like or as if (or as though) to say how somebody/something looks, sounds or feels: it looks like it''s going to fall down, it sounds as if they''re having a party. After as if, we sometimes use a past tense even when talking about the present, because the idea is not real: he talks as if he knew everything (he doesn''t). In this unreal use, were can replace was: as if he were an old man. like is not normally used this way.', 5
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'like or as if to say how something looks/sounds/feels',
  'We use like or as if to say how somebody/something looks, sounds or feels: That house looks like it''s going to fall down. or That house looks as if it''s going to fall down. Amy sounded like she had a cold, didn''t she? or Amy sounded as if she had a cold, didn''t she? I''ve just had a holiday, but I feel very tired. I don''t feel like I''ve had a holiday. or I don''t feel as if I''ve had a holiday. You can also use as though in these examples: I don''t feel as though I''ve had a holiday. Compare: You look tired. (look + adjective) You look like you haven''t slept. You look as if you haven''t slept. (look like / as if + subject + verb)', 0
from units where slug = 'unit-118';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'it looks like ... / it sounds like ...',
  'We say: it looks like ... or it looks as if ...; it sounds like ... or it sounds as if ... . Sarah is very late. It looks like she isn''t coming. or It looks as if she isn''t coming. It looked like it was going to rain, so we took an umbrella. or It looked as if it was going to rain ... The noise is very loud next door. It sounds like they''re having a party. or It sounds as if they''re ... You can also use as though: It sounds as though they''re having a party.', 1
from units where slug = 'unit-118';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'like / as if / as though + other verbs',
  'You can use like / as if / as though with other verbs to say how somebody does something: He ran like he was running for his life. After the interruption, the speaker went on talking as if nothing had happened. When I told them my plan, they looked at me as though I was mad.', 2
from units where slug = 'unit-118';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'as if + past for an unreal present',
  'After as if, we sometimes use the past when we are talking about the present. For example: I don''t like him. He talks as if he knew everything. The meaning is not past. We use the past (as if he knew) because the idea is not real: he does not know everything. We use the past in the same way with if and wish (see Unit 39). We do not normally use like in this way. Some more examples: She''s always asking me to do things for her — as if I didn''t have enough to do already. (I have enough to do already) Joe''s only 40. Why do you talk about him as if he was an old man? (he isn''t an old man) When you use the past in this way, you can use were instead of was: Why do you talk about him as if he were an old man? They treat me as if I were their own son. or ... as if I was their own son. (I''m not their son)', 3
from units where slug = 'unit-118';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-118'
join (values
  ('A', 'That house looks like it''s going to fall down. or ... as if it''s going to fall down.', null, 0),
  ('A', 'Amy sounded like she had a cold, didn''t she? or ... as if she had a cold ...', null, 1),
  ('A', 'You look like you haven''t slept. You look as if you haven''t slept.', null, 2),
  ('B', 'It looks like she isn''t coming. or It looks as if she isn''t coming.', null, 0),
  ('B', 'It looked like it was going to rain, so we took an umbrella.', null, 1),
  ('B', 'It sounds like they''re having a party. or It sounds as if they''re ...', null, 2),
  ('C', 'He ran like he was running for his life.', null, 0),
  ('C', 'The speaker went on talking as if nothing had happened.', null, 1),
  ('C', 'They looked at me as though I was mad.', null, 2),
  ('D', 'He talks as if he knew everything.', 'he does not know everything', 0),
  ('D', 'She''s always asking me to do things for her — as if I didn''t have enough to do already.', 'I have enough to do already', 1),
  ('D', 'Why do you talk about him as if he was an old man?', 'he isn''t an old man', 2),
  ('D', 'Why do you talk about him as if he were an old man?', null, 3),
  ('D', 'They treat me as if I were their own son.', 'I''m not their son', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 118.1-118.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '118.1', 'What do you say in these situations? Use the words in brackets to make your sentence.', 0
from units where slug = 'unit-118';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-118' where es.title = '118.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Claire comes into the room. She looks absolutely terrified. You say to her: What''s the matter? You {0}', '(look / as if / see / a ghost)'),
  (2, 'You have just run one kilometre, but you are exhausted. You say: I {0}', '(feel / like / run / a marathon)'),
  (3, 'Joe is on holiday. He''s talking to you on the phone and sounds happy. You say to him: You {0}', '(sound / as if / have / a good time)')
) as v(n, template, hint)
where es.title = '118.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '118.1'
join (values
  (1, 'look as if you''ve seen a ghost.', array['look as if you saw a ghost.']::text[]),
  (2, 'feel like I''ve run a marathon.', array['feel like I ran a marathon.']::text[]),
  (3, 'sound as if you''re having a good time.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '118.2', 'Make sentences beginning It looks like ... or It sounds like ... .', 1
from units where slug = 'unit-118';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-118' where es.title = '118.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The sky is full of black clouds. You say: It {0}', null),
  (2, 'You hear two people shouting at each other next door. You say: {0}', null),
  (3, 'You see an ambulance, some policemen and two damaged cars at the side of the road. You say: {0}', null),
  (4, 'You and a friend are in a supermarket. You''re looking for bananas, but without success. You say: {0}', null),
  (5, 'Dave isn''t feeling well. He tells you all about it. You say: {0}', null)
) as v(n, template, hint)
where es.title = '118.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '118.2'
join (values
  (1, 'looks like it''s going to rain.'),
  (2, 'It sounds like they''re having an argument.'),
  (3, 'It looks like there''s been an accident.'),
  (4, 'It looks like they don''t have any.'),
  (5, 'It sounds like you should see a doctor.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '118.3', 'Complete the sentences with as if. Choose from the box, putting the verbs in the correct form: she enjoy it, I be crazy, he not eat for a week, he need a good rest, she hurt her leg, he mean what he say, I not exist, she not want come.', 2
from units where slug = 'unit-118';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-118' where es.title = '118.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t think Paul was joking. He looked {0}.', null),
  (2, 'What''s the matter with Lisa? She''s walking {0}.', null),
  (3, 'Paul was extremely hungry and ate his dinner very quickly. He ate {0}.', null),
  (4, 'I looked at Sarah during the movie. She had a bored expression on her face. She didn''t look {0}.', null),
  (5, 'I told my friends about my plan. They were amazed. They looked at me {0}.', null),
  (6, 'I phoned Kate and invited her to the party, but she wasn''t very enthusiastic. She sounded {0}.', null),
  (7, 'I went into the office, but nobody spoke to me or looked at me. Everybody ignored me {0}.', null)
) as v(n, template, hint)
where es.title = '118.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '118.3'
join (values
  (1, 'as if he meant what he said', array[]::text[]),
  (2, 'as if she''s hurt her leg', array['as if she hurt her leg']::text[]),
  (3, 'as if he hadn''t eaten for a week', array[]::text[]),
  (4, 'as if she was enjoying it', array['as if she were enjoying it']::text[]),
  (5, 'as if I was crazy', array['as if I were crazy']::text[]),
  (6, 'as if she didn''t want to come', array[]::text[]),
  (7, 'as if I didn''t exist', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '118.4', 'These sentences are like the ones in Section D. Complete each sentence using as if.', 3
from units where slug = 'unit-118';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-118' where es.title = '118.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m 20 years old, so please don''t talk to me {0} a child.', null),
  (2, 'Steve has never met Nicola, but he talks about her {0} his best friend.', null),
  (3, 'We first met a long time ago, but I remember it {0} yesterday.', null)
) as v(n, template, hint)
where es.title = '118.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '118.4'
join (values
  (1, 'as if I was', array['as if I were']::text[]),
  (2, 'as if she was', array['as if she were']::text[]),
  (3, 'as if it was', array['as if it were']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
