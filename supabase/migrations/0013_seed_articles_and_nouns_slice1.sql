-- Marco 4 (slice 12): seeds the first slice of the "Articles and nouns"
-- module — units 69-70 (Countable and uncountable 1, Countable and
-- uncountable 2).
--
-- Sourced from pdf/Modulos/Articles and nouns.pdf (extracted via
-- `pdftotext -layout`, same workaround as previous modules — pdftoppm/
-- poppler isn't available locally) and cross-checked against pdf/Key to
-- Exercises.pdf.
--
-- Grepped unit-number headers across the whole file before assuming its
-- range (same lesson as Modals.pdf and -ing and to ….pdf): this PDF spans
-- units 69-81 (13 units), a genuinely large single book chapter. Following
-- the -ing-and-to precedent, it stays as ONE module (`articles-and-nouns`)
-- seeded across multiple migration slices. The module row uses
-- `on conflict (slug) do nothing` so later slices can extend it safely.
--
-- 69.1 ("Correct the sentences where necessary") uses the same "OK
-- convention" as unit-3's 3.1: the blank isolates just the noun phrase that
-- may need a/an, and where the book's answer is "OK" the blank's correct
-- answer is simply the noun unchanged.
--
-- 69.2 and 69.3 both have TWO pre-filled worked examples at the start (not
-- just one) — confirmed via the Key, which starts numbering at item 3 for
-- 69.2 and item 2 for 69.3. Same gotcha as unit 52.1 in 0010: always check
-- where the Key's numbering actually starts. Renumbered from 1 in this
-- migration's DB rows.
--
-- 70.1 and 70.2 ("Which is correct?") embed both alternatives inside one
-- sentence (e.g. "there's a lot of noise / there are a lot of noises")
-- rather than offering two full alternative sentences — adapted by
-- replacing just the alternative span with the blank, correct option as the
-- answer (same spirit as 38.2/46.1's "template + correct option" pattern,
-- but scoped to the phrase rather than the whole sentence). Both exercises'
-- own item 1 is the worked example (answered inline in the book) and is
-- dropped, remaining items renumbered from 1. 70.2 item 10 has two
-- independently graded blanks (subject-verb agreement + it/them).
--
-- 70.4 ("What do you say ...? Use the word in brackets") is a write-a-
-- sentence exercise, same shape as 38.2/50.1: the situation becomes the
-- template and the Key's full sentence becomes the answer, with the book's
-- slash-separated alternatives (e.g. "I've/I have") as accepted
-- alternatives. Item 1 (luggage) is the worked example and is dropped.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('articles-and-nouns', 'Articles and nouns', 9)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 69: Countable and uncountable 1
-- ============================================================

delete from units where slug = 'unit-69';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 69, 'unit-69', 'Countable and uncountable 1', null,
  'A countable noun can be singular (a banana) or plural (bananas) and is used with a/an or numbers. An uncountable noun (rice, music, money) has only one form, is never used with a/an or numbers, and is often used alone or with a ... of to mean a quantity.', 0
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Countable nouns can be singular or plural; uncountable nouns have only one form',
  'A countable noun can be singular (a banana) or plural (bananas), and we can use numbers with it: one banana, two bananas. Nouns usually countable: song, beach, note, accident, battery, cup. An uncountable noun (rice, music, money) has only one form — there is no plural, and we cannot use numbers with it (not "one rice", "two rices"). Nouns usually uncountable: music, sand, money, luck, electricity, water.', 0
from units where slug = 'unit-69';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'a/an with countable nouns, not with uncountable nouns',
  'You can use a/an with singular countable nouns: a beach, a student, an umbrella. You cannot use a singular countable noun alone, without a/the/my etc. — not "want banana", not "There''s been accident". You can use plural countable nouns alone to talk about things in general: I like bananas. We do not use a/an with uncountable nouns — not "a music", "a rice" — but you can often use a ... of: a bowl/packet/grain of rice. Uncountable nouns can be used alone, without the/my/some etc.: I eat rice every day.', 1
from units where slug = 'unit-69';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'some/any, many/few and much/little',
  'You can use some and any with plural countable nouns: We sang some songs. Did you buy any apples? You can also use some and any with uncountable nouns: We listened to some music. Did you buy any apple juice? We use many and few with plural countable nouns: We didn''t take many pictures. I have a few things to do. We use much and little with uncountable nouns: We didn''t do much shopping. I have a little work to do.', 2
from units where slug = 'unit-69';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-69'
join (values
  ('A', 'Kate was singing a song.', 'countable', 0),
  ('A', 'Kate was listening to music.', 'uncountable', 1),
  ('A', 'There''s a nice beach near here.', 'countable', 2),
  ('A', 'There''s sand in my shoes.', 'uncountable', 3),
  ('A', 'Do you have a ten-pound note?', 'countable', 4),
  ('A', 'Do you have any money?', 'uncountable', 5),
  ('A', 'It wasn''t your fault. It was an accident.', 'countable', 6),
  ('A', 'It wasn''t your fault. It was bad luck.', 'uncountable', 7),
  ('A', 'There are no batteries in the radio.', 'countable, plural', 8),
  ('A', 'There is no electricity in this house.', 'uncountable', 9),
  ('B', 'Do you want a banana? (not want banana)', null, 0),
  ('B', 'There''s been an accident. (not There''s been accident)', null, 1),
  ('B', 'I like bananas. (= bananas in general)', null, 2),
  ('B', 'Accidents can be prevented.', null, 3),
  ('B', 'I eat rice every day.', 'uncountable, no article', 4),
  ('B', 'There''s blood on your shirt.', null, 5),
  ('B', 'Can you hear music?', null, 6),
  ('C', 'We sang some songs.', null, 0),
  ('C', 'Did you buy any apples?', null, 1),
  ('C', 'We listened to some music.', null, 2),
  ('C', 'Did you buy any apple juice?', null, 3),
  ('C', 'We didn''t take many pictures.', null, 4),
  ('C', 'I have a few things to do.', null, 5),
  ('C', 'We didn''t do much shopping.', null, 6),
  ('C', 'I have a little work to do.', null, 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 69.1-69.3; 69.2 and 69.3 renumbered from
-- the book's item 3 / item 2 respectively — both have two worked examples)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '69.1', 'Some of these sentences need a/an. Correct the sentences where necessary.', 0
from units where slug = 'unit-69';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-69' where es.title = '69.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Joe goes everywhere by bike. He doesn''t have {0}.', 'car'),
  (2, 'Helen was listening to {0} when I arrived.', 'music (uncountable)'),
  (3, 'We went to {0} last weekend.', 'restaurant'),
  (4, 'I brush my teeth with {0}.', 'toothpaste (uncountable)'),
  (5, 'I use {0} to brush my teeth.', 'toothbrush'),
  (6, 'Can you tell me if there''s {0} near here?', 'bank'),
  (7, 'My brother works for {0}.', 'insurance company'),
  (8, 'I don''t like {0}.', 'violence (uncountable)'),
  (9, 'When we were in Rome, we stayed in {0}.', 'hotel'),
  (10, 'If you have {0}, I''ll try and help you.', 'problem'),
  (11, 'I like your suggestion. It''s {0}.', 'idea'),
  (12, 'Can you smell {0}?', 'paint (uncountable)'),
  (13, 'I like volleyball. It''s {0}.', 'game'),
  (14, 'Lisa doesn''t usually wear {0}.', 'jewellery (uncountable)'),
  (15, 'Jane was wearing {0}.', 'necklace'),
  (16, 'Does this city have {0}?', 'airport')
) as v(n, template, hint)
where es.title = '69.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '69.1'
join (values
  (1, 'a car'), (2, 'music'), (3, 'a very nice restaurant'), (4, 'toothpaste'),
  (5, 'a toothbrush'), (6, 'a bank'), (7, 'an insurance company'), (8, 'violence'),
  (9, 'a big hotel'), (10, 'a problem'), (11, 'an interesting idea'), (12, 'paint'),
  (13, 'a good game'), (14, 'jewellery'), (15, 'a beautiful necklace'), (16, 'an airport')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '69.2', 'Complete the sentences using the following words. Use a/an where necessary: biscuit, blood, coat, decision, electricity, ice, interview, key, moment, question.', 1
from units where slug = 'unit-69';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-69' where es.title = '69.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I couldn''t get into the house. I didn''t have {0}.', 'key'),
  (2, 'It''s very warm today. Why are you wearing {0}?', 'coat'),
  (3, 'Would you like {0} in your drink?', 'ice (uncountable)'),
  (4, 'Are you hungry? Have {0}!', 'biscuit'),
  (5, 'Our lives would be very difficult without {0}.', 'electricity (uncountable)'),
  (6, 'Excuse me, can I ask you {0}?', 'question'),
  (7, 'I''m not ready yet. Can you wait {0}, please?', 'moment'),
  (8, 'The heart pumps {0} through the body.', 'blood (uncountable)'),
  (9, 'We can''t delay much longer. We have to make {0} soon.', 'decision'),
  (10, 'I had {0} for a job yesterday. It went quite well.', 'interview')
) as v(n, template, hint)
where es.title = '69.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '69.2'
join (values
  (1, 'a key'), (2, 'a coat'), (3, 'ice'), (4, 'a biscuit'), (5, 'electricity'),
  (6, 'a question'), (7, 'a moment'), (8, 'blood'), (9, 'a decision'), (10, 'an interview')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '69.3', 'Complete the sentences using the following words. Sometimes the word needs to be plural, and sometimes you need a/an: air, day, friend, joke, language, meat, patience, people, queue, space, umbrella.', 2
from units where slug = 'unit-69';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-69' where es.title = '69.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There are seven {0} in a week.', 'day, plural'),
  (2, 'A vegetarian is a person who doesn''t eat {0}.', 'meat (uncountable)'),
  (3, 'Outside the cinema there was {0} of people waiting to see the film.', 'queue'),
  (4, 'I''m not good at telling {0}.', 'joke, plural'),
  (5, 'Last night I went out with some {0} of mine.', 'friend, plural'),
  (6, 'There were very few {0} in town today. The streets were almost empty.', 'people'),
  (7, 'I''m going out for a walk. I need some fresh {0}.', 'air (uncountable)'),
  (8, 'Paul always wants things quickly. He doesn''t have much {0}.', 'patience (uncountable)'),
  (9, 'I think it''s going to rain. Do you have {0} I could borrow?', 'umbrella'),
  (10, 'How many {0} can you speak?', 'language, plural'),
  (11, 'Our flat is very small. We don''t have much {0}.', 'space (uncountable)')
) as v(n, template, hint)
where es.title = '69.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '69.3'
join (values
  (1, 'days'), (2, 'meat'), (3, 'a queue'), (4, 'jokes'), (5, 'friends'),
  (6, 'people'), (7, 'air'), (8, 'patience'), (9, 'an umbrella'), (10, 'languages'), (11, 'space')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 70: Countable and uncountable 2
-- ============================================================

delete from units where slug = 'unit-70';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 70, 'unit-70', 'Countable and uncountable 2', null,
  'Many nouns are sometimes countable and sometimes uncountable, usually with a difference in meaning (a noise / noise, a paper / paper). Other nouns — such as accommodation, advice, furniture, information, luggage, news, traffic and weather — are always uncountable in English.', 1
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Nouns that are sometimes countable and sometimes uncountable',
  'Many nouns are sometimes countable and sometimes uncountable, usually with a difference in meaning: a noise (= a specific noise) vs. noise (= noise in general); a paper (= a newspaper) vs. paper (= material for writing on); a hair (= one single hair) vs. hair (= all the hair on your head, not "hairs"); a room (= a room in a house) vs. room (= space); an experience (= something that happened to you) vs. experience (= knowledge from doing something, not "experiences"); a time vs. time. Coffee/tea/juice/beer etc. are normally uncountable (I don''t like coffee very much), but you can say a coffee (= a cup of coffee), two coffees etc.: Two coffees and an orange juice, please.', 0
from units where slug = 'unit-70';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Nouns that are usually uncountable in English',
  'These nouns are usually uncountable in English: accommodation, advice, baggage, behaviour, bread, chaos, damage, furniture, information, luck, luggage, news, permission, progress, scenery, traffic, weather, work. We do not normally use a/an with them (not "a bread") and they are not usually plural (not "furnitures", "informations"). News is uncountable, not plural: The news was unexpected (not The news were). Travel (uncountable) means travelling in general — we do not say "a travel" for a single trip or journey: We had a very good trip/journey (not a good travel). Compare: a job / work; a view / scenery; a nice day / nice weather; a lot of bags / a lot of baggage; these chairs / this furniture; a good suggestion / good advice; a lot of cars / a lot of traffic.', 1
from units where slug = 'unit-70';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-70'
join (values
  ('A', 'Did you hear a noise just now?', '= a specific noise', 0),
  ('A', 'I can''t work here. There''s too much noise.', '= noise in general', 1),
  ('A', 'I bought a paper to read.', '= a newspaper', 2),
  ('A', 'I need some paper to write on.', '= material for writing on', 3),
  ('A', 'There''s a hair in my soup!', '= one single hair', 4),
  ('A', 'You''ve got very long hair. (not hairs)', '= all the hair on your head', 5),
  ('A', 'This is a nice room.', '= a room in a house', 6),
  ('A', 'You can''t sit here. There isn''t room.', '= space', 7),
  ('A', 'I was offered the job because I had a lot of experience. (not experiences)', null, 8),
  ('A', 'I had some interesting experiences while I was travelling.', '= things that happened to me', 9),
  ('A', 'Enjoy your trip. Have a great time!', null, 10),
  ('A', 'I can''t wait. I don''t have time.', null, 11),
  ('A', 'I don''t like coffee very much.', 'uncountable', 12),
  ('A', 'Two coffees and an orange juice, please.', '= two cups of coffee', 13),
  ('B', 'I''m going to buy some bread. (not a bread)', null, 0),
  ('B', 'Enjoy your holiday! I hope you have good weather. (not a good weather)', null, 1),
  ('B', 'Where are you going to put all your furniture? (not furnitures)', null, 2),
  ('B', 'Let me know if you need more information. (not informations)', null, 3),
  ('B', 'The news was unexpected. (not The news were)', null, 4),
  ('B', 'They spend a lot of money on travel.', null, 5),
  ('B', 'We had a very good trip/journey. (not a good travel)', null, 6),
  ('B', 'I''m looking for a job.', 'countable', 7),
  ('B', 'I''m looking for work. (not a work)', 'uncountable', 8),
  ('B', 'That''s a good suggestion.', 'countable', 9),
  ('B', 'That''s good advice.', 'uncountable', 10),
  ('B', 'There were a lot of cars.', 'countable', 11),
  ('B', 'There was a lot of traffic.', 'uncountable', 12)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 70.1-70.4; 70.1/70.2's own item 1 is the
-- worked example and is dropped, remaining items renumbered from 1)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '70.1', 'Which is correct?', 0
from units where slug = 'unit-70';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-70' where es.title = '70.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We live near a busy road so {0}.', 'there''s a lot of noise / there are a lot of noises'),
  (2, '{0} comes from the sun.', 'Light / A light'),
  (3, 'I thought there was somebody in the house because there was {0} on inside.', 'light / a light'),
  (4, 'I was in a hurry this morning. I didn''t have {0} for breakfast.', 'time / a time'),
  (5, 'We really enjoyed our holiday. We had {0}.', 'great time / a great time'),
  (6, 'Can I have {0}, please?', 'glass of water / a glass of water'),
  (7, 'Be careful. The window has been broken and there''s {0} on the floor.', 'broken glass / a broken glass'),
  (8, 'We stayed at a hotel. We had {0}.', 'very nice room / a very nice room'),
  (9, 'We have a big garage. There''s {0} for two cars.', 'room / a room')
) as v(n, template, hint)
where es.title = '70.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '70.1'
join (values
  (1, 'there''s a lot of noise'), (2, 'Light'), (3, 'a light'), (4, 'time'),
  (5, 'a great time'), (6, 'a glass of water'), (7, 'broken glass'),
  (8, 'a very nice room'), (9, 'room')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '70.2', 'Which is correct?', 1
from units where slug = 'unit-70';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-70' where es.title = '70.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We were very unfortunate. We had {0}.', 'bad luck / a bad luck'),
  (2, 'Our {0} from Paris to Moscow by train was very tiring.', 'travel / journey'),
  (3, 'When the fire alarm rang, there was {0}.', 'complete chaos / a complete chaos'),
  (4, 'Bad news {0} make people happy.', 'don''t / doesn''t'),
  (5, 'There''s {0} in this part of the country.', 'some lovely scenery / a lovely scenery'),
  (6, 'I like my job, but it''s {0}.', 'very hard work / a very hard work'),
  (7, 'I want to print some documents, but the printer is out of {0}.', 'paper / papers'),
  (8, 'The trip took a long time. There was {0}.', 'heavy traffic / a heavy traffic'),
  (9, '{0} too long. You should have {1} cut.', 'Your hair is / Your hairs are ... it / them')
) as v(n, template, hint)
where es.title = '70.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '70.2'
join (values
  (1, 0, 'bad luck'), (2, 0, 'journey'), (3, 0, 'complete chaos'), (4, 0, 'doesn''t'),
  (5, 0, 'some lovely scenery'), (6, 0, 'very hard work'), (7, 0, 'paper'),
  (8, 0, 'heavy traffic'), (9, 0, 'Your hair is'), (9, 1, 'it')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '70.3', 'Complete the sentences using the following words. Use the plural (-s) where necessary: advice, chair, damage, experience, experience, furniture, hair, permission, progress.', 2
from units where slug = 'unit-70';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-70' where es.title = '70.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We have no {0}, not even a bed or a table.', 'furniture (uncountable)'),
  (2, 'There is room for everybody to sit down. There are plenty of {0}.', 'chair, plural'),
  (3, 'Who is that woman with short {0}? Do you know her?', 'hair (uncountable)'),
  (4, 'Carla''s English is better than it was. She''s made good {0}.', 'progress (uncountable)'),
  (5, 'If you want to take pictures here, you need to ask for {0}.', 'permission (uncountable)'),
  (6, 'I didn''t know what I should do, so I asked Chris for {0}.', 'advice (uncountable)'),
  (7, 'I don''t think Dan should get the job. He doesn''t have enough {0}.', 'experience (uncountable)'),
  (8, 'Kate has done many interesting things. She could write a book about her {0}.', 'experience, plural'),
  (9, 'The {0} caused by the storm will cost a lot to repair.', 'damage (uncountable)')
) as v(n, template, hint)
where es.title = '70.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '70.3'
join (values
  (1, 'furniture'), (2, 'chairs'), (3, 'hair'), (4, 'progress'), (5, 'permission'),
  (6, 'advice'), (7, 'experience'), (8, 'experiences'), (9, 'damage')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '70.4', 'What do you say in these situations? Use the word in brackets in your sentence.', 3
from units where slug = 'unit-70';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-70' where es.title = '70.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You go to a tourist office. You want to know about places to visit in the town. (information) {0}', 'I''d like ...'),
  (2, 'You are a student. You want your teacher to advise you about which courses to do. (advice) {0}', 'Can you give ...?'),
  (3, 'You applied for a job and you''ve just heard that you were successful. You call Tom and say: (good news) Hi, Tom. {0} I got the job!', 'I''ve (just) got ...'),
  (4, 'You are at the top of a mountain. You can see a very long way. It''s beautiful. (view) {0}', 'It''s a beautiful view, isn''t it?'),
  (5, 'You look out of the window. The weather is horrible: cold, wet and windy. (weather) {0}', 'What ...!')
) as v(n, template, hint)
where es.title = '70.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '70.4'
join (values
  (1, 'I''d like some information about places to visit in the town.', array['I would like some information about places to visit in the town.']::text[]),
  (2, 'Can you give me some advice about which courses to do?', array['Can you give me some advice on which courses to do?']::text[]),
  (3, 'I''ve got some good news.', array['I''ve just got some good news.', 'I have some good news.', 'I have got some good news.']::text[]),
  (4, 'It''s a beautiful view, isn''t it?', array['It''s a beautiful view from here, isn''t it?']::text[]),
  (5, 'What horrible weather!', array['What awful weather!']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
