-- Marco 4 (slice 32): seeds the fifth slice of the "Adjectives and
-- adverbs" module — units 105 (Comparative 1: cheaper, more expensive
-- etc.) and 106 (Comparative 2: much better / any better etc.).
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 105.4 item 3 (renumbered 2) is the only two-blank item in 105.4: "The
-- journey takes ___ train ___ car" → "longer by" / "than by".
--
-- 106.4 ("Complete the sentences using the ... the ...") mixes items with
-- a partial scaffold and items needing the whole answer — kept each
-- item's own natural shape (matching how much of the fixed sentence the
-- book actually gives before the blank) rather than forcing one uniform
-- style, since every item here happened to have a clean, unambiguous
-- split point.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 105: Comparative 1 (cheaper, more expensive etc.)
-- ============================================================

delete from units where slug = 'unit-105';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 105, 'unit-105', 'Comparative 1 (cheaper, more expensive etc.)', null,
  'The comparative form is -er (for short, one-syllable words, and two-syllable words ending in -y) or more ... (for longer words and adverbs ending in -ly): cheaper, easier, more expensive, more slowly. A few adjectives/adverbs are irregular: good/well → better, bad/badly → worse, far → further or farther. After a comparative you can use than: It''s cheaper to drive than go by train.', 7
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'comparative forms and than',
  'Look at these examples: How shall we travel? Shall we drive or go by train? Let''s drive. It''s cheaper. Don''t go by train. It''s more expensive. Cheaper and more expensive are comparative forms. After comparatives you can use than (see Unit 107): It''s cheaper to drive than go by train. Going by train is more expensive than driving.', 0
from units where slug = 'unit-105';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', '-er or more ...',
  'The comparative form is -er or more ... . We use -er for short words (one syllable): cheap → cheaper, fast → faster, large → larger, thin → thinner. We also use -er for two-syllable words that end in -y (-y → -ier): lucky → luckier, early → earlier, easy → easier, pretty → prettier. We use more ... for longer words (two syllables or more): more serious, more expensive, more often, more comfortable. We also use more ... for adverbs that end in -ly: more slowly, more seriously, more easily, more quietly. For spelling, see Appendix 6. Compare these examples: You''re older than me. / You''re more patient than me. The exam was quite easy — easier than I expected. / The exam was quite difficult — more difficult than I expected. Can you walk a bit faster? / Can you walk a bit more slowly? I''d like to have a bigger car. / I''d like to have a more reliable car. Last night I went to bed earlier than usual. / I don''t play tennis much these days. I used to play more often. We use both -er or more ... with some two-syllable adjectives, especially: clever, narrow, quiet, shallow, simple. It''s too noisy here. Can we go somewhere quieter? or ... somewhere more quiet?', 1
from units where slug = 'unit-105';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'irregular comparatives',
  'A few adjectives and adverbs have irregular comparative forms: good/well → better. The garden looks better since you tidied it up. I know him well — probably better than anybody else knows him. bad/badly → worse. ''How''s your headache? Better?'' ''No, it''s worse.'' He did very badly in the exam — worse than expected. far → further (or farther). It''s a long walk from here to the park — further than I thought. (or farther than) Note that further (but not farther) also means ''more'' or ''additional'': Let me know if you hear any further news. (= any more news)', 2
from units where slug = 'unit-105';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-105'
join (values
  ('A', 'It''s cheaper to drive than go by train.', null, 0),
  ('A', 'Going by train is more expensive than driving.', null, 1),
  ('B', 'You''re older than me. You''re more patient than me.', null, 0),
  ('B', 'The exam was quite easy — easier than I expected.', null, 1),
  ('B', 'The exam was quite difficult — more difficult than I expected.', null, 2),
  ('B', 'Can you walk a bit faster? Can you walk a bit more slowly?', null, 3),
  ('B', 'I''d like to have a bigger car. I''d like to have a more reliable car.', null, 4),
  ('B', 'Last night I went to bed earlier than usual.', null, 5),
  ('B', 'I don''t play tennis much these days. I used to play more often.', null, 6),
  ('B', 'Can we go somewhere quieter? or ... somewhere more quiet?', null, 7),
  ('C', 'The garden looks better since you tidied it up.', null, 0),
  ('C', 'I know him well — probably better than anybody else knows him.', null, 1),
  ('C', '''How''s your headache? Better?'' ''No, it''s worse.''', null, 2),
  ('C', 'He did very badly in the exam — worse than expected.', null, 3),
  ('C', 'It''s a long walk from here to the park — further than I thought.', 'or farther than', 4),
  ('C', 'Let me know if you hear any further news.', '= any more news', 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 105.1-105.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '105.1', 'Complete the sentences using a comparative form (older / more important etc.).', 0
from units where slug = 'unit-105';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-105' where es.title = '105.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'This coffee is very weak. I like it {0}.', null),
  (2, 'The town was surprisingly big. I expected it to be {0}.', null),
  (3, 'The hotel was surprisingly cheap. I expected it to be {0}.', null),
  (4, 'The weather is too cold here. I''d like to live somewhere {0}.', null),
  (5, 'Sometimes my job is a bit boring. I''d like to do something {0}.', null),
  (6, 'It''s a shame you live so far away. I wish you lived {0}.', null),
  (7, 'It was quite easy to find a place to live. I thought it would be {0}.', null),
  (8, 'Your work isn''t very good. I''m sure you can do {0}.', null),
  (9, 'Don''t worry. The situation isn''t so bad. It could be {0}.', null),
  (10, 'You hardly ever call me. Why don''t you call me {0}?', null),
  (11, 'You''re too near the camera. Can you move a bit {0} away?', null)
) as v(n, template, hint)
where es.title = '105.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '105.1'
join (values
  (1, 'stronger', array[]::text[]),
  (2, 'smaller', array[]::text[]),
  (3, 'more expensive', array[]::text[]),
  (4, 'warmer', array['hotter']::text[]),
  (5, 'more interesting', array['more exciting']::text[]),
  (6, 'nearer', array['closer']::text[]),
  (7, 'harder', array['more difficult', 'more complicated']::text[]),
  (8, 'better', array[]::text[]),
  (9, 'worse', array[]::text[]),
  (10, 'more often', array[]::text[]),
  (11, 'further', array['farther']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '105.2', 'Complete the sentences. Use the comparative forms of the words in the box. Use than where necessary: big, early, high, important, interested, peaceful, reliable, serious, slowly, thin.', 1
from units where slug = 'unit-105';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-105' where es.title = '105.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Unfortunately the problem was {0} we thought at first.', null),
  (2, 'You look {0}. Have you lost weight?', null),
  (3, 'We don''t have enough space here. We need a {0} apartment.', null),
  (4, 'James doesn''t study very hard. He''s {0} in having a good time.', null),
  (5, 'Health and happiness are {0} money.', null),
  (6, 'I like living in the country. It''s {0} living in a town.', null),
  (7, 'I''m sorry I don''t understand. Can you speak {0}, please?', null),
  (8, 'In some parts of the country, prices are {0} in others.', null)
) as v(n, template, hint)
where es.title = '105.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '105.2'
join (values
  (1, 'more serious than'), (2, 'thinner'), (3, 'bigger'), (4, 'more interested'),
  (5, 'more important than'), (6, 'more peaceful than'), (7, 'more slowly'), (8, 'higher than')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '105.3', 'Complete the sentences. Choose from: than, more, worse, quietly, longer, better, careful, frequent.', 2
from units where slug = 'unit-105';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-105' where es.title = '105.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sorry about my mistake. I''ll try and be more {0} in future.', null),
  (2, 'Your English has improved. It''s {0} than it was.', null),
  (3, 'You can travel by bus or by train. The buses are more {0} than the trains.', null),
  (4, 'You can''t always have things immediately. You have to be {0} patient.', null),
  (5, 'I''m a pessimist. I always think things are going to get {0}.', null),
  (6, 'We were busier {0} usual in the office today. It''s not usually so busy.', null),
  (7, 'You''re talking very loudly. Can you speak more {0}?', null)
) as v(n, template, hint)
where es.title = '105.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '105.3'
join (values
  (1, 'careful'), (2, 'better'), (3, 'frequent'), (4, 'more'), (5, 'worse'), (6, 'than'), (7, 'quietly')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '105.4', 'Read the situations and complete the sentences. Use a comparative form (-er or more ...).', 3
from units where slug = 'unit-105';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-105' where es.title = '105.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Dan and I went for a run. I ran ten kilometres. Dan stopped after eight kilometres. I ran {0} Dan.', null),
  (2, 'The journey takes four hours by car and five hours by train. The journey takes {0} train {1} car.', null),
  (3, 'I expected my friends to arrive at about 4 o''clock. In fact they arrived at 2.30. My friends {0} I expected.', null),
  (4, 'There is always a lot of traffic here, but today the traffic is really bad. The traffic today {0} usual.', null)
) as v(n, template, hint)
where es.title = '105.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '105.4'
join (values
  (1, 0, 'further than', array['farther than']::text[]),
  (2, 0, 'longer by', array[]::text[]), (2, 1, 'than by', array[]::text[]),
  (3, 0, 'arrived earlier than', array[]::text[]),
  (4, 0, 'is worse than', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 106: Comparative 2 (much better / any better etc.)
-- ============================================================

delete from units where slug = 'unit-106';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 106, 'unit-106', 'Comparative 2 (much better / any better etc.)', null,
  'Before comparatives you can use much/a lot/far (= a lot), a bit/a little/slightly (= a little): much better, a bit more slowly. You can also use any/no + comparative (I''m not waiting any longer; it''s no bigger than ours). Repeating a comparative (better and better) shows continuous change, and the ... the ... links two comparatives (the sooner the better; the more I thought about it, the less I liked it). elder is only used for family members (my elder sister) and never after a verb (not "my sister is elder").', 8
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'much / a lot etc. + comparative',
  'Before comparatives you can use: much, a lot, far (= a lot); a bit, a little, slightly (= a little). I felt ill earlier, but I feel much better now. (or a lot better) Don''t go by train. It''s a lot more expensive. (or much more expensive) Could you speak a bit more slowly? (or a little more slowly) This bag is slightly heavier than the other one. The problem is far more serious than we thought at first.', 0
from units where slug = 'unit-106';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'any / no + comparative',
  'You can use any and no + comparative (any longer / no bigger etc.): I''ve waited long enough. I''m not waiting any longer. (= not even a little longer) We expected their apartment to be very big, but it''s no bigger than ours. or ... it isn''t any bigger than ours. (= not even a little bigger) How do you feel now? Do you feel any better? This hotel is better than the other one, and it''s no more expensive.', 1
from units where slug = 'unit-106';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'better and better, more and more etc.',
  'We repeat comparatives (better and better etc.) to say that something changes continuously: Your English is improving. It''s getting better and better. The city has grown fast in recent years. It''s got bigger and bigger. As I listened to his story, I became more and more convinced that he was lying. More and more tourists are visiting this part of the country.', 2
from units where slug = 'unit-106';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'the ... the ...',
  'You can say the sooner the better, the more the better etc.: ''What time shall we leave?'' ''The sooner the better.'' (= as soon as possible) ''What sort of bag do you want? A big one?'' ''Yes, the bigger the better.'' (= as big as possible) When you''re travelling, the less luggage you have the better. We also use the ... the ... to say that one thing depends on another thing: The sooner we leave, the earlier we''ll arrive. (= if we leave sooner, we''ll arrive earlier) The younger you are, the easier it is to learn. The more expensive the hotel, the better the service. The more I thought about the plan, the less I liked it.', 3
from units where slug = 'unit-106';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'older and elder',
  'The comparative of old is older: David looks older than he really is. (not looks elder) We use elder only when we talk about people in a family (my elder sister, their elder son etc.). You can also use older: My elder sister is a TV producer. (or My older sister ...) But we do not say that ''somebody is elder'': My sister is older than me. (not elder than me)', 4
from units where slug = 'unit-106';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-106'
join (values
  ('A', 'I felt ill earlier, but I feel much better now.', 'or a lot better', 0),
  ('A', 'Don''t go by train. It''s a lot more expensive.', 'or much more expensive', 1),
  ('A', 'Could you speak a bit more slowly?', 'or a little more slowly', 2),
  ('A', 'This bag is slightly heavier than the other one.', null, 3),
  ('A', 'The problem is far more serious than we thought at first.', null, 4),
  ('B', 'I''ve waited long enough. I''m not waiting any longer.', '= not even a little longer', 0),
  ('B', 'We expected their apartment to be very big, but it''s no bigger than ours.', '= not even a little bigger', 1),
  ('B', 'Do you feel any better?', null, 2),
  ('B', 'This hotel is better than the other one, and it''s no more expensive.', null, 3),
  ('C', 'It''s getting better and better.', null, 0),
  ('C', 'It''s got bigger and bigger.', null, 1),
  ('C', 'I became more and more convinced that he was lying.', null, 2),
  ('C', 'More and more tourists are visiting this part of the country.', null, 3),
  ('D', '''The sooner the better.''', '= as soon as possible', 0),
  ('D', '''Yes, the bigger the better.''', '= as big as possible', 1),
  ('D', 'The less luggage you have the better.', null, 2),
  ('D', 'The sooner we leave, the earlier we''ll arrive.', '= if we leave sooner, we''ll arrive earlier', 3),
  ('D', 'The younger you are, the easier it is to learn.', null, 4),
  ('D', 'The more expensive the hotel, the better the service.', null, 5),
  ('D', 'The more I thought about the plan, the less I liked it.', null, 6),
  ('E', 'David looks older than he really is.', 'not looks elder', 0),
  ('E', 'My elder sister is a TV producer.', 'or My older sister', 1),
  ('E', 'My sister is older than me.', 'not elder than me', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 106.1-106.5; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '106.1', 'Use the words in brackets to complete the sentences. Use much / a bit etc. + a comparative form. Use than where necessary.', 0
from units where slug = 'unit-106';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-106' where es.title = '106.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'This bag is too small. I need something {0}.', '(much / big)'),
  (2, 'I liked the museum. It was {0} I expected.', '(a lot / interesting)'),
  (3, 'It was very hot yesterday. Today it''s {0}.', '(a little / cool)'),
  (4, 'I''m afraid the problem is {0} it seems.', '(far / complicated)'),
  (5, 'You''re driving too fast. Can you drive {0}?', '(a bit / slowly)'),
  (6, 'I thought he was younger than me, but in fact he''s {0}.', '(slightly / old)')
) as v(n, template, hint)
where es.title = '106.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '106.1'
join (values
  (1, 'much bigger'), (2, 'a lot more interesting than'), (3, 'a little cooler'),
  (4, 'far more complicated than'), (5, 'a bit more slowly'), (6, 'slightly older')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '106.2', 'Complete the sentences using any/no + comparative. Use than where necessary.', 1
from units where slug = 'unit-106';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-106' where es.title = '106.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m sorry I''m a bit late, but I couldn''t get here {0}.', null),
  (2, 'This shop isn''t expensive. The prices are {0} anywhere else.', null),
  (3, 'I need to stop for a rest. I can''t walk {0}.', null),
  (4, 'The traffic isn''t especially bad today. It''s {0} usual.', null)
) as v(n, template, hint)
where es.title = '106.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '106.2'
join (values
  (1, 'any sooner', array['any earlier']::text[]),
  (2, 'no higher than', array['no more expensive than', 'no worse than']::text[]),
  (3, 'any further', array['any farther']::text[]),
  (4, 'no worse than', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '106.3', 'Complete the sentences using ... and ... (see Section C).', 2
from units where slug = 'unit-106';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-106' where es.title = '106.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'That hole in your sweater is getting {0}.', '(big)'),
  (2, 'I waited for my interview and became {0}.', '(nervous)'),
  (3, 'As the day went on, the weather got {0}.', '(bad)'),
  (4, 'Health care is becoming {0}.', '(expensive)'),
  (5, 'Since Anna went to Canada, her English has got {0}.', '(good)'),
  (6, 'These days I travel a lot. I''m spending {0} away from home.', '(time)')
) as v(n, template, hint)
where es.title = '106.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '106.3'
join (values
  (1, 'bigger and bigger'), (2, 'more and more nervous'), (3, 'worse and worse'),
  (4, 'more and more expensive'), (5, 'better and better'), (6, 'more and more time')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '106.4', 'Complete the sentences using the ... the ... .', 3
from units where slug = 'unit-106';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-106' where es.title = '106.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s hard to concentrate when you''re tired. The more tired you are, {0}', null),
  (2, 'We should decide what to do as soon as possible. {0}', null),
  (3, 'I know more, but I understand less. {0}', null),
  (4, 'If you use more electricity, your bill will be higher. The more electricity you use, {0}', null),
  (5, 'Kate had to wait a long time and became more and more impatient. {0}', null)
) as v(n, template, hint)
where es.title = '106.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '106.4'
join (values
  (1, 'the harder it is to concentrate.', array[]::text[]),
  (2, 'The sooner we decide, the better.', array['The sooner we decide what to do, the better.']::text[]),
  (3, 'The more I know, the less I understand.', array[]::text[]),
  (4, 'the higher your bill will be.', array[]::text[]),
  (5, 'The more she had to wait, the more impatient she became.', array['The longer she had to wait, the more impatient she became.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '106.5', 'Use the words on the right to complete the sentences: any, better, elder, less, less, longer, more, no, older, slightly, the.', 4
from units where slug = 'unit-106';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-106' where es.title = '106.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The problem is getting {0} and more serious.', null),
  (2, 'The more time I have, the {0} it takes me to do things.', null),
  (3, 'I''m walking as fast as I can. I can''t walk {0} faster.', null),
  (4, 'The higher your income, {0} more tax you have to pay.', null),
  (5, 'I''m surprised Anna is only 25. I thought she was {0}.', null),
  (6, 'Jane''s {0} sister is a nurse.', null),
  (7, 'I was a little late. The journey took {0} longer than I expected.', null),
  (8, 'Applications for the job must be received {0} later than 15 April.', null),
  (9, 'Don''t tell him anything. The {0} he knows, the {1}.', null)
) as v(n, template, hint)
where es.title = '106.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '106.5'
join (values
  (1, 0, 'more', array[]::text[]),
  (2, 0, 'longer', array[]::text[]),
  (3, 0, 'any', array[]::text[]),
  (4, 0, 'the', array[]::text[]),
  (5, 0, 'older', array[]::text[]),
  (6, 0, 'elder', array['older']::text[]),
  (7, 0, 'slightly', array[]::text[]),
  (8, 0, 'no', array[]::text[]),
  (9, 0, 'less', array[]::text[]), (9, 1, 'better', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
