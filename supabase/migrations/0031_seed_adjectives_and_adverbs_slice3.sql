-- Marco 4 (slice 30): seeds the third slice of the "Adjectives and
-- adverbs" module — units 102 (so and such) and 103 (enough and too).
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode for 102.3's word-order
-- items, since -layout scattered the exercise's trailing follow-up
-- clauses into an unordered block) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 102.3's follow-up clauses ("Can't you drive faster?", "There's plenty
-- of time." etc.) could not be reliably paired back to their items — two
-- items (2 and 6) are both about driving speed, so the ambiguous
-- follow-up could plausibly belong to either. Rather than guess, dropped
-- the follow-up clauses entirely and kept only the Key-confirmed
-- word-order answer for each item, same "when extraction reliability is
-- in doubt, drop it rather than guess" policy as 65.5 in 0012.
--
-- 102.4 ("Use your own ideas to complete these sentences") is skipped as
-- open-ended — the Key itself labels it "Example answers" for genuinely
-- personal completions, same policy as every prior module.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 102: so and such
-- ============================================================

delete from units where slug = 'unit-102';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 102, 'unit-102', 'so and such', null,
  'so goes with an adjective or adverb alone (so stupid, so quickly); such goes with a noun, or adjective + noun (such people, such a stupid story) — we say such a, never a such. Both make the meaning stronger and can be followed by that (often left out): I was so tired (that) I fell asleep. It was such nice weather (that) we spent the whole day outside. So and such can also mean "like this": I didn''t realise it was so old. There''s no such word.', 4
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'so + adjective/adverb, such + noun',
  'Compare so and such. We use so + adjective/adverb: so stupid, so quick, so nice, so quickly. I didn''t like the book. The story was so stupid. Everything happened so quickly. We use such + noun: such a story, such people. We also use such + adjective + noun: such a stupid story, such nice people. I didn''t like the book. It was such a stupid story. (not a so stupid story) I like Liz and Joe. They are such nice people. (not so nice people) We say such a ... (not a such): such a big dog.', 0
from units where slug = 'unit-102';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'so/such make the meaning stronger; so/such ... that',
  'So and such make the meaning stronger: I''ve had a busy day. I''m so tired. (= really tired) It''s difficult to understand him. He talks so quietly. We had a great trip. We had such a good time. (= a really good time) You always think good things are going to happen. You''re such an optimist. You can use so ... that: I was so tired that I fell asleep in the armchair. We usually leave out that: I was so tired I fell asleep. You can use such ... that: It was such nice weather that we spent the whole day on the beach. We usually leave out that: It was such nice weather we spent ...', 1
from units where slug = 'unit-102';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'so/such = ''like this''',
  'So and such also mean ''like this'': Somebody told me the house was built 100 years ago. I didn''t realise it was so old. (= as old as it is) I''m tired because I got up at six. I don''t usually get up so early. I expected the weather to be cooler. I''m surprised it is so warm. I didn''t realise it was such an old house. You know it''s not true. How can you say such a thing? (= a thing like this) Note the expression no such ...: You won''t find the word ''blid'' in the dictionary. There''s no such word. (= this word does not exist)', 2
from units where slug = 'unit-102';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'so long, such a long time',
  'Compare: so long — I haven''t seen her for so long I''ve forgotten what she looks like. such a long time — I haven''t seen her for such a long time. (not so long time) so far — I didn''t know it was so far. such a long way — I didn''t know it was such a long way. so much, so many — I''m sorry I''m late — there was so much traffic. such a lot (of) — I''m sorry I''m late — there was such a lot of traffic.', 3
from units where slug = 'unit-102';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-102'
join (values
  ('A', 'The story was so stupid.', null, 0),
  ('A', 'Everything happened so quickly.', null, 1),
  ('A', 'It was such a stupid story.', 'not a so stupid story', 2),
  ('A', 'They are such nice people.', 'not so nice people', 3),
  ('A', 'such a big dog', 'not a such big dog', 4),
  ('B', 'I''ve had a busy day. I''m so tired.', '= really tired', 0),
  ('B', 'It''s difficult to understand him. He talks so quietly.', null, 1),
  ('B', 'We had a great trip. We had such a good time.', '= a really good time', 2),
  ('B', 'You''re such an optimist.', null, 3),
  ('B', 'I was so tired that I fell asleep in the armchair.', null, 4),
  ('B', 'I was so tired I fell asleep.', null, 5),
  ('B', 'It was such nice weather that we spent the whole day on the beach.', null, 6),
  ('C', 'I didn''t realise it was so old.', '= as old as it is', 0),
  ('C', 'I don''t usually get up so early.', null, 1),
  ('C', 'I''m surprised it is so warm.', null, 2),
  ('C', 'I didn''t realise it was such an old house.', null, 3),
  ('C', 'How can you say such a thing?', '= a thing like this', 4),
  ('C', 'There''s no such word.', '= this word does not exist', 5),
  ('D', 'I haven''t seen her for so long I''ve forgotten what she looks like.', null, 0),
  ('D', 'I haven''t seen her for such a long time.', 'not so long time', 1),
  ('D', 'I didn''t know it was so far.', null, 2),
  ('D', 'I didn''t know it was such a long way.', null, 3),
  ('D', 'I''m sorry I''m late — there was so much traffic.', null, 4),
  ('D', 'I''m sorry I''m late — there was such a lot of traffic.', null, 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 102.1-102.3; 102.4 skipped as open-ended.
-- Each renumbered from 1, dropping the book's own worked example(s) at
-- the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '102.1', 'Put in so, such or such a.', 0
from units where slug = 'unit-102';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-102' where es.title = '102.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Everything is {0} expensive these days, isn''t it?', null),
  (2, 'He always looks good. He wears {0} nice clothes.', null),
  (3, 'I couldn''t believe the news. It was {0} shock.', null),
  (4, 'What a nice garden! These are {0} lovely flowers.', null),
  (5, 'The party was great. It was {0} shame you couldn''t come.', null),
  (6, 'I was glad to see that he looked {0} well after his recent illness.', null),
  (7, 'I have to go. I didn''t realise it was {0} late.', null),
  (8, 'Why does it always take you {0} long time to get ready?', null),
  (9, 'Everything went wrong. We had {0} bad luck.', null)
) as v(n, template, hint)
where es.title = '102.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '102.1'
join (values
  (1, 'so'), (2, 'such'), (3, 'such a'), (4, 'such'), (5, 'such a'),
  (6, 'so'), (7, 'so'), (8, 'such a'), (9, 'such')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '102.2', 'Make one sentence from two. Choose from the box, and then complete the sentences using so or such: the music was loud, it was horrible weather, I''ve got a lot to do, I had a big breakfast, it was a beautiful day, her English is good, the bag was heavy, I was surprised, the hotel was a long way.', 1
from units where slug = 'unit-102';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-102' where es.title = '102.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0}, she couldn''t lift it.', null),
  (2, '{0}, I don''t know where to begin.', null),
  (3, '{0}, I didn''t know what to say.', null),
  (4, '{0}, it could be heard from miles away.', null),
  (5, '{0}, we spent the whole day indoors.', null),
  (6, '{0}, you would think it was her native language.', null),
  (7, '{0}, it took us ages to get there.', null),
  (8, '{0}, I didn''t eat anything for the rest of the day.', null)
) as v(n, template, hint)
where es.title = '102.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '102.2'
join (values
  (1, 'The bag was so heavy'), (2, 'I''ve got such a lot to do'), (3, 'I was so surprised'),
  (4, 'The music was so loud'), (5, 'It was such horrible weather'), (6, 'Her English is so good'),
  (7, 'The hotel was such a long way'), (8, 'I had such a big breakfast')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '102.3', 'Put the words in the right order.', 2
from units where slug = 'unit-102';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-102' where es.title = '102.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Why {0}?', '(a / such / hurry / you / in / are)'),
  (2, 'It took us an hour to get here. I''m {0}.', '(long / it / surprised / so / took)'),
  (3, 'He said he worked for a company called Elcron, but {0}.', '(such / there''s / company / no)'),
  (4, 'I regret what I did. I don''t know why {0}.', '(such / thing / I / did / a / stupid)'),
  (5, 'Why {0}?', '(driving / so / you / slowly / are)'),
  (6, 'Two months? How did you {0}?', '(English / time / learn / short / a / such / in)'),
  (7, 'Why {0}?', '(expensive / you / an / phone / did / such / buy)')
) as v(n, template, hint)
where es.title = '102.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '102.3'
join (values
  (1, 'are you in such a hurry'),
  (2, 'surprised it took so long'),
  (3, 'there''s no such company'),
  (4, 'I did such a stupid thing'),
  (5, 'are you driving so slowly'),
  (6, 'learn English in such a short time'),
  (7, 'did you buy such an expensive phone')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 103: enough and too
-- ============================================================

delete from units where slug = 'unit-103';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 103, 'unit-103', 'enough and too', null,
  'enough goes after adjectives/adverbs (not fit enough) but normally before nouns (enough money), and can be used alone. too means "more than is necessary" (too hard) while not ... enough means "less than is necessary" (not hard enough). Both combine with for somebody/something and to do something: too small for you, not old enough to have a licence. After too + adjective + to, no extra object pronoun is needed: too hot to eat (not to eat it).', 5
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'enough',
  'Enough goes after adjectives and adverbs: I can''t run very far. I''m not fit enough. (not enough fit) Let''s go. We''ve waited long enough. Enough normally goes before nouns: We have enough money. We don''t need any more. There weren''t enough chairs. Some of us had to sit on the floor. We also use enough alone (without a noun or adjective): We don''t need more money. We have enough.', 0
from units where slug = 'unit-103';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'too and enough',
  'Compare too ... and not ... enough: You never stop working. You work too hard. (= more than is necessary) You''re lazy. You don''t work hard enough. (= less than is necessary) Compare too much/many and enough: There''s too much furniture in this room. There''s not enough space. There were too many people and not enough chairs.', 1
from units where slug = 'unit-103';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'enough/too + for ... and to ...',
  'We say enough/too ... for somebody/something: Does Joe have enough experience for the job? This bag isn''t big enough for all my clothes. That shirt is too small for you. You need a larger size. We say enough/too ... to do something. For example: Does Joe have enough experience to do the job? Let''s get a taxi. It''s too far to walk home from here. She''s not old enough to have a driving licence. The next example has both for ... and to ...: The bridge is just wide enough for two cars to pass one another.', 2
from units where slug = 'unit-103';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'too hot to eat etc.',
  'We say: The food was very hot. We couldn''t eat it. and The food was so hot that we couldn''t eat it. but The food was too hot to eat. (not to eat it) In the same way we say: These boxes are too heavy to carry. (not to carry them) The wallet was too big to put in my pocket. (not to put it) This chair isn''t strong enough to stand on. (not to stand on it)', 3
from units where slug = 'unit-103';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-103'
join (values
  ('A', 'I can''t run very far. I''m not fit enough.', 'not enough fit', 0),
  ('A', 'Let''s go. We''ve waited long enough.', null, 1),
  ('A', 'We have enough money. We don''t need any more.', null, 2),
  ('A', 'There weren''t enough chairs. Some of us had to sit on the floor.', null, 3),
  ('A', 'We don''t need more money. We have enough.', null, 4),
  ('B', 'You never stop working. You work too hard.', '= more than is necessary', 0),
  ('B', 'You''re lazy. You don''t work hard enough.', '= less than is necessary', 1),
  ('B', 'There''s too much furniture in this room. There''s not enough space.', null, 2),
  ('B', 'There were too many people and not enough chairs.', null, 3),
  ('C', 'Does Joe have enough experience for the job?', null, 0),
  ('C', 'This bag isn''t big enough for all my clothes.', null, 1),
  ('C', 'That shirt is too small for you. You need a larger size.', null, 2),
  ('C', 'Does Joe have enough experience to do the job?', null, 3),
  ('C', 'Let''s get a taxi. It''s too far to walk home from here.', null, 4),
  ('C', 'She''s not old enough to have a driving licence.', null, 5),
  ('C', 'The bridge is just wide enough for two cars to pass one another.', null, 6),
  ('D', 'The food was very hot. We couldn''t eat it. The food was so hot that we couldn''t eat it.', null, 0),
  ('D', 'The food was too hot to eat.', 'not to eat it', 1),
  ('D', 'These boxes are too heavy to carry.', 'not to carry them', 2),
  ('D', 'The wallet was too big to put in my pocket.', 'not to put it', 3),
  ('D', 'This chair isn''t strong enough to stand on.', 'not to stand on it', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 103.1-103.3; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '103.1', 'Complete the sentences using enough + the following words: buses, chairs, cups, hard, room, tall, time, vegetables, warm, wide.', 0
from units where slug = 'unit-103';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-103' where es.title = '103.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Public transport isn''t good here. There aren''t {0}.', null),
  (2, 'I can''t park the car here. The space isn''t {0}.', null),
  (3, 'I always have to rush. There''s never {0}.', null),
  (4, 'You need to change your diet. You don''t eat {0}.', null),
  (5, 'I''m not good at basketball. I''m not {0}.', null),
  (6, 'The car is quite small. Do you think there''s {0} for five of us?', null),
  (7, 'Are you {0}? Or shall I switch on the heating?', null),
  (8, 'We can''t all have coffee at the same time. We don''t have {0}.', null)
) as v(n, template, hint)
where es.title = '103.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '103.1'
join (values
  (1, 'enough buses'), (2, 'wide enough'), (3, 'enough time'), (4, 'enough vegetables'),
  (5, 'tall enough'), (6, 'enough room'), (7, 'warm enough'), (8, 'enough cups')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '103.2', 'Complete the answers to the questions. Use too or enough + the word(s) in brackets.', 1
from units where slug = 'unit-103';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-103' where es.title = '103.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I need to talk to you about something. Well, I''m afraid I''m {0} to you now.', '(busy)'),
  (2, 'Let''s go to the cinema. No, it''s {0} to the cinema.', '(late)'),
  (3, 'Why don''t we sit outside? It''s not {0} outside.', '(warm)'),
  (4, 'Would you like to be a politician? No, I''m {0} a politician.', '(shy)'),
  (5, 'Would you like to be a teacher? No, I don''t have {0} a teacher.', '(patience)'),
  (6, 'Did you hear what he was saying? No, we were {0} what he was saying.', '(far away)'),
  (7, 'Can he read a newspaper in English? No, he doesn''t know {0} a newspaper.', '(English)')
) as v(n, template, hint)
where es.title = '103.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '103.2'
join (values
  (1, 'too busy to talk'), (2, 'too late to go'), (3, 'warm enough to sit'), (4, 'too shy to be'),
  (5, 'enough patience to be'), (6, 'too far away to hear'), (7, 'enough English to read')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '103.3', 'Make one sentence from two. Complete the new sentence using too or enough + to ... .', 2
from units where slug = 'unit-103';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-103' where es.title = '103.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can''t drink this coffee. It''s too hot. This coffee is {0}', null),
  (2, 'Nobody could move the piano. It was too heavy. The piano {0}', null),
  (3, 'Don''t eat these apples. They''re not ripe enough. These apples {0}', null),
  (4, 'I can''t explain the situation. It is too complicated. The situation {0}', null),
  (5, 'We couldn''t climb over the wall. It was too high. The wall {0}', null),
  (6, 'Three people can''t sit on this sofa. It isn''t big enough. This sofa {0}', null),
  (7, 'You can''t see some things without a microscope. They are too small. Some {0}', null)
) as v(n, template, hint)
where es.title = '103.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '103.3'
join (values
  (1, 'too hot to drink.', array[]::text[]),
  (2, 'was too heavy to move.', array[]::text[]),
  (3, 'aren''t ripe enough to eat.', array['are not ripe enough to eat.']::text[]),
  (4, 'is too complicated to explain.', array[]::text[]),
  (5, 'was too high to climb over.', array[]::text[]),
  (6, 'isn''t big enough for three people to sit on.', array['isn''t big enough for three people.', 'is not big enough for three people to sit on.']::text[]),
  (7, 'things are too small to see without a microscope.', array['things are too small to be seen without a microscope.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
