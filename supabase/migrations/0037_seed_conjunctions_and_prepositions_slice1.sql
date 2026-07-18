-- Marco 4 (slice 36): seeds the first slice of the "Conjunctions and
-- prepositions" module — units 113 (although though even though; in
-- spite of despite) and 114 (in case).
--
-- Sourced from pdf/Modulos/Conjunctions and prepositions.pdf (extracted
-- via `pdftotext -layout`, re-extracted in plain mode for 113.1 where
-- -layout scattered several items' lead-in text away from their blanks)
-- and cross-checked against pdf/Key to Exercises.pdf (plain mode).
--
-- Grepped unit-number headers across the whole file before assuming its
-- range (same check applied to every oversized PDF since Modals.pdf):
-- this file spans units 113-120 (8 units, confirmed no "121" header). New
-- module `conjunctions-and-prepositions`, order_index 13, seeded across
-- multiple migration slices — sized by judgment (pairs of related units)
-- per Igor's standing instruction after the Relative clauses module.
--
-- 113.1 items 2, 5 and 6 (renumbered 1, 4, 5) have the blank at the very
-- start of the sentence ("Although ___, ...") rather than after a lead-in
-- clause — the plain extraction showed these items' lead-in slots as
-- completely empty (just the item number), which -layout had rendered
-- ambiguously; resolved by cross-checking every item against the Key's
-- word-bank assignment (Key gives one distinct phrase per item 2-8) until
-- each one made grammatical sense both with the fixed trailing clause and
-- as a not-yet-used word-bank phrase.
--
-- 113.2/114.1-114.3 skip Section 113.2's own "Use your own ideas" tail
-- (items 6-7, a/b each) as open-ended — the Key labels them "Example
-- answers", same policy as every prior module.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('conjunctions-and-prepositions', 'Conjunctions and prepositions', 13)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 113: although though even though; in spite of despite
-- ============================================================

delete from units where slug = 'unit-113';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 113, 'unit-113', 'in spite of despite (although though even though)', null,
  'Although and in spite of / despite have similar meanings but different grammar: although is followed by subject + verb (although it rained a lot), while in spite of / despite are followed by a noun, pronoun, or -ing (in spite of the rain, despite raining). We say in spite of but despite (no of, not despite of). though means the same as although and can go at the end of a spoken sentence (I like the garden though); even though (never even alone) is a stronger version of although.', 0
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'although and in spite of / despite',
  'Study this example situation: Last year Paul and Sarah had a holiday by the sea. It rained a lot, but they had a good time. You can say: Although it rained a lot, they had a good time. (= It rained a lot, but they ...) or In spite of the rain, they had a good time. or Despite the rain, they had a good time.', 0
from units where slug = 'unit-113';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'although + subject + verb',
  'After although we use a subject + verb: Although it rained a lot, they had a good time. I didn''t apply for the job although I had the necessary qualifications. Compare the meaning of although and because: We went out although it was raining heavily. We didn''t go out because it was raining heavily.', 1
from units where slug = 'unit-113';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'in spite of / despite + noun, pronoun or -ing',
  'After in spite of or despite, we use a noun, a pronoun (this/that/what etc.) or -ing: In spite of the rain, we had a good time. She wasn''t well, but in spite of this she continued working. In spite of what I said yesterday, I still love you. I didn''t apply for the job in spite of having the necessary qualifications. Despite is the same as in spite of. We say in spite of, but despite (without of): She wasn''t well, but despite this she continued working. (not despite of this) You can say ''in spite of the fact (that) ...'' and ''despite the fact (that) ...'': I didn''t apply for the job in spite of the fact (that) I had the necessary qualifications. or ... despite the fact (that) I had ... Compare in spite of and because of: We went out in spite of the rain. (or ... despite the rain.) We didn''t go out because of the rain.', 2
from units where slug = 'unit-113';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'although vs. in spite of / despite',
  'Compare although and in spite of / despite: Although the traffic was bad, we arrived on time. or In spite of the traffic, we arrived on time. (not in spite of the traffic was bad) I couldn''t sleep although I was very tired. (not despite I was tired) or I couldn''t sleep despite being very tired.', 3
from units where slug = 'unit-113';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'though and even though',
  'though = although: I didn''t apply for the job though I had the necessary qualifications. In spoken English we often use though at the end of a sentence: The house isn''t so nice. I like the garden though. (= but I like the garden) I see them every day. I''ve never spoken to them though. (= but I''ve never spoken to them) Even though (but not ''even'' alone) is similar to although: Even though I was really tired, I couldn''t sleep. (not even I was really tired)', 4
from units where slug = 'unit-113';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-113'
join (values
  ('A', 'Although it rained a lot, they had a good time.', null, 0),
  ('A', 'In spite of the rain, they had a good time.', null, 1),
  ('B', 'I didn''t apply for the job although I had the necessary qualifications.', null, 0),
  ('B', 'We went out although it was raining heavily.', null, 1),
  ('B', 'We didn''t go out because it was raining heavily.', null, 2),
  ('C', 'She wasn''t well, but in spite of this she continued working.', null, 0),
  ('C', 'In spite of what I said yesterday, I still love you.', null, 1),
  ('C', 'I didn''t apply for the job in spite of having the necessary qualifications.', null, 2),
  ('C', 'She wasn''t well, but despite this she continued working.', 'not despite of this', 3),
  ('C', 'We went out in spite of the rain. (or ... despite the rain.)', null, 4),
  ('C', 'We didn''t go out because of the rain.', null, 5),
  ('D', 'Although the traffic was bad, we arrived on time.', 'not in spite of the traffic was bad', 0),
  ('D', 'I couldn''t sleep although I was very tired.', 'not despite I was tired', 1),
  ('E', 'The house isn''t so nice. I like the garden though.', '= but I like the garden', 0),
  ('E', 'I see them every day. I''ve never spoken to them though.', '= but I''ve never spoken to them', 1),
  ('E', 'Even though I was really tired, I couldn''t sleep.', 'not even I was really tired', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 113.1-113.4; 113.2 items 6-7 skipped as
-- open-ended. Each renumbered from 1, dropping the book's own worked
-- example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '113.1', 'Complete the sentences. Use although + a sentence from the box: I didn''t speak the language well, she has a very important job, I had never seen her before, we don''t like them very much, it was quite cold, the heating was on, I''d met her twice before, we''ve known each other a long time.', 0
from units where slug = 'unit-113';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-113' where es.title = '113.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Although {0}, I recognised her from a photo.', null),
  (2, 'Sarah wasn''t wearing a coat although {0}.', null),
  (3, 'We decided to invite them to the party although {0}.', null),
  (4, 'Although {0}, I managed to make myself understood.', null),
  (5, 'Although {0}, the room wasn''t warm.', null),
  (6, 'I didn''t recognise her although {0}.', null),
  (7, 'We''re not close friends although {0}.', null)
) as v(n, template, hint)
where es.title = '113.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '113.1'
join (values
  (1, 'I had never seen her before'),
  (2, 'it was quite cold'),
  (3, 'we don''t like them very much'),
  (4, 'I didn''t speak the language well'),
  (5, 'the heating was on'),
  (6, 'I''d met her twice before'),
  (7, 'we''ve known each other a long time')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '113.2', 'Complete the sentences with although / in spite of / because / because of.', 1
from units where slug = 'unit-113';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-113' where es.title = '113.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} all our careful plans, a lot of things went wrong.', null),
  (2, '{0} we''d planned everything carefully, a lot of things went wrong.', null),
  (3, 'I went home early {0} I was feeling unwell.', null),
  (4, 'I went to work the next day {0} I was still feeling unwell.', null),
  (5, 'Chris only accepted the job {0} the salary, which was very high.', null),
  (6, 'Sam accepted the job {0} the salary, which was rather low.', null),
  (7, '{0} there was a lot of noise, I slept quite well.', null),
  (8, 'I couldn''t get to sleep {0} the noise.', null)
) as v(n, template, hint)
where es.title = '113.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '113.2'
join (values
  (1, 'In spite of', array['Despite']::text[]),
  (2, 'Although', array[]::text[]),
  (3, 'because', array[]::text[]),
  (4, 'although', array[]::text[]),
  (5, 'because of', array[]::text[]),
  (6, 'in spite of', array['despite']::text[]),
  (7, 'Although', array[]::text[]),
  (8, 'because of', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '113.3', 'Make one sentence from two. Use the word(s) in brackets in your sentences.', 2
from units where slug = 'unit-113';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-113' where es.title = '113.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We played quite well. We lost the game. (in spite of) {0}', null),
  (2, 'I''d hurt my foot. I managed to walk home. (although) {0}', null),
  (3, 'I enjoyed the film. The story was silly. (in spite of) {0}', null),
  (4, 'We live in the same building. We hardly ever see each other. (despite) {0}', null),
  (5, 'They came to the party. They hadn''t been invited. (even though) {0}', null)
) as v(n, template, hint)
where es.title = '113.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '113.3'
join (values
  (1, 'In spite of playing quite well, we lost the game.', array['In spite of the fact that we played quite well, we lost the game.']::text[]),
  (2, 'Although I''d hurt my foot, I managed to walk home.', array['I managed to walk home although I''d hurt my foot.']::text[]),
  (3, 'I enjoyed the film in spite of the silly story.', array['I enjoyed the film in spite of the story being silly.', 'In spite of the silly story, I enjoyed the film.']::text[]),
  (4, 'Despite living in the same building, we hardly ever see each other.', array['We hardly ever see each other despite living in the same building.']::text[]),
  (5, 'They came to the party even though they hadn''t been invited.', array['Even though they hadn''t been invited, they came to the party.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '113.4', 'Use the words in brackets to make a sentence with though at the end.', 3
from units where slug = 'unit-113';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-113' where es.title = '113.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I enjoyed reading the book. {0}', '(very long)'),
  (2, 'We didn''t like the food. {0}', '(ate)'),
  (3, 'Laura is very nice. I {0}', '(don''t like / husband)')
) as v(n, template, hint)
where es.title = '113.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '113.4'
join (values
  (1, 'It''s very long though.'), (2, 'We ate it though.'), (3, 'don''t like her husband though.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 114: in case
-- ============================================================

delete from units where slug = 'unit-114';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 114, 'unit-114', 'in case', null,
  'in case something happens = because it is possible it will happen — you do something now in case something happens later, unlike if, which only acts once the condition is met. We do not use will after in case. in case + past explains why somebody did something (I gave him my number in case he needed to contact me). in case of = if there is ..., especially on notices (In case of fire, ...).', 1
from modules where slug = 'conjunctions-and-prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'in case something happens',
  'Study this example situation: Your car should have a spare wheel in case you have a puncture. (= because it is possible you will have a puncture) in case something happens = because it is possible it will happen. Some more examples of in case: I''d better write down my password in case I forget it. (= because it is possible I will forget it) Shall I draw a map for you in case you have a problem finding our house? I''ll remind them about the meeting in case they''ve forgotten. We use just in case for a smaller possibility: I don''t think it will rain, but I''ll take an umbrella just in case. We do not use will after in case (see also Unit 25): I''ll write down my password in case I forget it. (not in case I will forget)', 0
from units where slug = 'unit-114';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'in case vs. if',
  'In case and if are not the same. We use in case to say why somebody does (or doesn''t do) something. You do something now in case something happens later. Compare: We''ll buy some more food in case Tom comes. (= Maybe Tom will come. We''ll buy some more food now, whether he comes or not. Then we''ll already have the food if he comes.) We''ll buy some more food if Tom comes. (= Maybe Tom will come. If he comes, we''ll buy some more food. If he doesn''t come, we won''t buy any more food.) I''ll give you my phone number in case you need to contact me. You can call me on this number if you need to contact me. You should insure your bike in case it is stolen. You should inform the police if your bike is stolen.', 1
from units where slug = 'unit-114';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'in case + past',
  'You can use in case + past to say why somebody did something: I gave him my phone number in case he needed to contact me. (= because it was possible that he would need to contact me) I drew a map for Sarah in case she had a problem finding our house. We rang the doorbell again in case they hadn''t heard it the first time.', 2
from units where slug = 'unit-114';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'in case of',
  'in case of = if there is ... (especially on notices, instructions etc.): In case of fire, please leave the building as quickly as possible. (= if there is a fire) In case of emergency, call this number. (= if there is an emergency)', 3
from units where slug = 'unit-114';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-114'
join (values
  ('A', 'Your car should have a spare wheel in case you have a puncture.', '= because it is possible you will have a puncture', 0),
  ('A', 'I''d better write down my password in case I forget it.', null, 1),
  ('A', 'Shall I draw a map for you in case you have a problem finding our house?', null, 2),
  ('A', 'I''ll remind them about the meeting in case they''ve forgotten.', null, 3),
  ('A', 'I don''t think it will rain, but I''ll take an umbrella just in case.', null, 4),
  ('A', 'I''ll write down my password in case I forget it.', 'not in case I will forget', 5),
  ('B', 'We''ll buy some more food in case Tom comes.', null, 0),
  ('B', 'We''ll buy some more food if Tom comes.', null, 1),
  ('B', 'I''ll give you my phone number in case you need to contact me.', null, 2),
  ('B', 'You can call me on this number if you need to contact me.', null, 3),
  ('B', 'You should insure your bike in case it is stolen.', null, 4),
  ('B', 'You should inform the police if your bike is stolen.', null, 5),
  ('C', 'I gave him my phone number in case he needed to contact me.', '= because it was possible that he would need to contact me', 0),
  ('C', 'I drew a map for Sarah in case she had a problem finding our house.', null, 1),
  ('C', 'We rang the doorbell again in case they hadn''t heard it the first time.', null, 2),
  ('D', 'In case of fire, please leave the building as quickly as possible.', '= if there is a fire', 0),
  ('D', 'In case of emergency, call this number.', '= if there is an emergency', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 114.1-114.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '114.1', 'Sophie is going for a long walk in the country and you''re worried about her. Complete the sentences using in case: perhaps she''ll be thirsty, she might need to call somebody, maybe she''ll get lonely, it''s possible she''ll get lost, perhaps she''ll get hungry, maybe it will rain.', 0
from units where slug = 'unit-114';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-114' where es.title = '114.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You should take some chocolate {0}.', null),
  (2, 'You''ll need an anorak {0}.', null),
  (3, 'Take plenty of water {0}.', null),
  (4, 'Don''t forget your phone {0}.', null),
  (5, 'Shall I come with you {0}?', null)
) as v(n, template, hint)
where es.title = '114.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '114.1'
join (values
  (1, 'in case you get hungry', array['in case you are hungry']::text[]),
  (2, 'in case it rains', array[]::text[]),
  (3, 'in case you get thirsty', array['in case you are thirsty']::text[]),
  (4, 'in case you need to call somebody', array[]::text[]),
  (5, 'in case you get lonely', array['in case you are lonely']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '114.2', 'What do you say in these situations? Use in case.', 1
from units where slug = 'unit-114';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-114' where es.title = '114.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'A friend of yours is going away for a long time. Maybe you won''t see her again before she goes, so you decide to say goodbye now. You say: I''ll say goodbye now {0}.', null),
  (2, 'You are buying food in a supermarket with a friend. You think you have everything you need, but maybe you''ve forgotten something. Your friend has the list. You ask her to check it. You say: Can you {0}?', null),
  (3, 'You''re shopping with a friend. She''s just bought some jeans, but she didn''t try them on. Maybe they won''t fit her, so you advise her to keep the receipt. You say: Keep {0}.', null)
) as v(n, template, hint)
where es.title = '114.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '114.2'
join (values
  (1, 'in case I don''t see you again', array['in case I don''t see you again before you go']::text[]),
  (2, 'check the list in case we''ve forgotten something', array['check the list in case we forgot something']::text[]),
  (3, 'the receipt in case they don''t fit you', array['the receipt in case they don''t fit you and you have to take them back to the shop']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '114.3', 'Complete the sentences using in case.', 2
from units where slug = 'unit-114';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-114' where es.title = '114.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I thought that I might forget the name of the book. So I wrote it down. I wrote down the name of the book {0}.', null),
  (2, 'I thought my parents might be worried about me. So I phoned them. I phoned my parents {0}.', null),
  (3, 'I sent an email to Lisa, but she didn''t reply. So I sent another email because maybe she didn''t get the first one. I sent her another email {0}.', null),
  (4, 'I met some people when I was on holiday in France. They said they might come to London one day. I live in London, so I gave them my phone number. I gave them my phone number {0}.', null)
) as v(n, template, hint)
where es.title = '114.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '114.3'
join (values
  (1, 'in case I forgot it.', array[]::text[]),
  (2, 'in case they were worried about me.', array['in case they were worried']::text[]),
  (3, 'in case she didn''t get the first one.', array['in case she hadn''t got the first one.']::text[]),
  (4, 'in case they came to London one day.', array['in case they come to London one day.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '114.4', 'Put in in case or if.', 3
from units where slug = 'unit-114';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-114' where es.title = '114.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I hope you''ll come to Australia sometime. {0} you come, you must visit us.', null),
  (2, 'I made a copy of the document {0} something happens to the original.', null),
  (3, 'This book belongs to Kate. Can you give it to her {0} you see her?', null),
  (4, 'Write your name and phone number on your bag {0} you lose it.', null),
  (5, 'Go to the lost property office {0} you lose your bag.', null),
  (6, 'The burglar alarm will ring {0} somebody tries to break into the house.', null),
  (7, 'You should lock your bike to something {0} somebody tries to steal it.', null),
  (8, 'I was advised to get insurance {0} I needed medical treatment while I was abroad.', null)
) as v(n, template, hint)
where es.title = '114.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '114.4'
join (values
  (1, 'If'), (2, 'in case'), (3, 'if'), (4, 'in case'),
  (5, 'if'), (6, 'if'), (7, 'in case'), (8, 'in case')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
