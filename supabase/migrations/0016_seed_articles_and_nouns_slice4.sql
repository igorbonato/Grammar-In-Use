-- Marco 4 (slice 15): seeds the fourth slice of the "Articles and nouns"
-- module — units 77-78 (Names with and without the 1, Names with and
-- without the 2).
--
-- Sourced from pdf/Modulos/Articles and nouns.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (re-extracted without -layout for the relevant pages, same workaround
-- as the last two slices).
--
-- 78.1 ("Use the map to answer the questions") is genuinely map-based, no
-- fill-in text of its own in the book — same situation as 46.1 in 0008.
-- Since the Key gives every place name and street unambiguously, the
-- questions become the templates and the Key's answers the correct
-- values, with a theory_images placeholder describing the map (Igor can
-- crop/upload the real map later).
--
-- 77.2 uses the "OK convention" from unit-3's 3.1 again: some of its items
-- are already correct as given (Africa is much larger than Europe = OK),
-- others need the inserted once or twice.
--
-- 77.1, 77.2 (which has TWO worked examples, same gotcha as 69.2/69.3/
-- 71.1/71.2 in prior slices), 77.3, 78.2 and 78.3 all have their own item 1
-- as the book's worked example (or, for 77.2, items 1 and 2); dropped and
-- the remaining items renumbered from 1.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 77: Names with and without the 1
-- ============================================================

delete from units where slug = 'unit-77';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 77, 'unit-77', 'Names with and without the 1', null,
  'We do not use the with names of people, or with most names of places — continents, countries, cities, mountains. But we do use the with names containing Republic/Kingdom/States, with oceans/seas/rivers/canals/deserts, with plural names (the Netherlands, the Alps), and with the north/south etc. of a place (though not with northern/southern + place).', 8
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'no the with names of people and most places',
  'We do not use the with names of people (Helen, Helen Taylor) or with most names of places: continents (Africa, South America), countries/states (France, Japan, Texas), islands (Sicily, Tasmania), cities/towns (Cairo, Bangkok), mountains (Everest, Kilimanjaro). But we normally use the in names with Republic, Kingdom, States etc.: the Czech Republic, the United Kingdom (the UK), the Dominican Republic, the United States of America (the USA). Compare: Have you been to Canada or the United States?', 0
from units where slug = 'unit-77';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Mr/Doctor/President + name; Mount, Lake (no the)',
  'When we use Mr/Ms/Captain/Doctor etc. + a name, we do not use the: Mr Johnson, Doctor Johnson, Captain Johnson, President Johnson, Uncle Robert, Saint Catherine, Queen Catherine (not the ...). Compare: We called the doctor. We called Doctor Johnson (not the Doctor Johnson). We use Mount and Lake before a name in the same way (without the): Mount Everest, Mount Etna, Lake Superior, Lake Victoria (not the ...). They live near the lake, but They live near Lake Superior (not the Lake Superior).', 1
from units where slug = 'unit-77';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'the with oceans, seas, rivers, canals and deserts',
  'We use the with the names of oceans, seas, rivers and canals: the Atlantic (Ocean), the Indian Ocean, the Mediterranean (Sea), the Red Sea, the Channel (between France and Britain), the Amazon, the Nile, the Suez Canal. We use the with the names of deserts: the Sahara (Desert), the Gobi Desert.', 2
from units where slug = 'unit-77';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'the with plural names of people and places',
  'We use the with plural names of people and places: people — the Taylors (= the Taylor family), the Johnsons; countries — the Netherlands, the Philippines, the United States; groups of islands — the Canaries (or the Canary Islands), the Bahamas; mountain ranges — the Andes, the Alps, the Urals. The highest mountain in the Andes is (Mount) Aconcagua.', 3
from units where slug = 'unit-77';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'the north (of Brazil) — but northern Brazil',
  'We say the north (of Brazil), the southeast (of Spain), but northern Brazil, southeastern Spain (without the). Compare: Sweden is in northern Europe; Spain is in the south. We also use north/south etc. (without the) in the names of some regions and countries: North America, South Africa, southeast Asia. Note that on maps, the is not usually included in the name.', 4
from units where slug = 'unit-77';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-77'
join (values
  ('A', 'Have you been to Canada or the United States?', null, 0),
  ('A', 'France (not the France)', null, 1),
  ('A', 'the Czech Republic', null, 2),
  ('A', 'the United Kingdom (the UK)', null, 3),
  ('B', 'We called the doctor.', null, 0),
  ('B', 'We called Doctor Johnson. (not the Doctor Johnson)', null, 1),
  ('B', 'They live near the lake.', null, 2),
  ('B', 'They live near Lake Superior. (not the Lake Superior)', null, 3),
  ('C', 'the Atlantic (Ocean)', null, 0),
  ('C', 'the Indian Ocean', null, 1),
  ('C', 'the Mediterranean (Sea)', null, 2),
  ('C', 'the Nile', null, 3),
  ('C', 'the Suez Canal', null, 4),
  ('C', 'the Sahara (Desert)', null, 5),
  ('D', 'the Taylors', '= the Taylor family', 0),
  ('D', 'the Netherlands', null, 1),
  ('D', 'the Philippines', null, 2),
  ('D', 'the Canaries (or the Canary Islands)', null, 3),
  ('D', 'The highest mountain in the Andes is (Mount) Aconcagua.', null, 4),
  ('E', 'Sweden is in northern Europe; Spain is in the south.', null, 0),
  ('E', 'North America, South Africa, southeast Asia', 'without the', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 77.1-77.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '77.1', 'Which is right?', 0
from units where slug = 'unit-77';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-77' where es.title = '77.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I was ill. {0} told me to rest for a few days.', 'Doctor / The doctor'),
  (2, '{0} is an expert on heart disease.', 'Doctor Thomas / The Doctor Thomas'),
  (3, 'I''m looking for {0}. Do you know where she is?', 'Professor Brown / the Professor Brown'),
  (4, 'In the United States, {0} is elected for four years.', 'President / the President'),
  (5, '{0} was assassinated in 1963.', 'President Kennedy / The President Kennedy'),
  (6, 'The officer I spoke to at the police station was {0}.', 'Inspector Roberts / the Inspector Roberts'),
  (7, 'Do you know {0}? They''re a very nice couple.', 'Wilsons / the Wilsons'),
  (8, 'Julia spent three years as a student in {0}.', 'United States / the United States'),
  (9, '{0} has a population of about 66 million.', 'France / The France')
) as v(n, template, hint)
where es.title = '77.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '77.1'
join (values
  (1, 'The doctor'), (2, 'Doctor Thomas'), (3, 'Professor Brown'), (4, 'the President'),
  (5, 'President Kennedy'), (6, 'Inspector Roberts'), (7, 'the Wilsons'),
  (8, 'the United States'), (9, 'France')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '77.2', 'Some of these sentences are OK, but some need the (sometimes more than once). Correct the sentences where necessary.', 1
from units where slug = 'unit-77';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-77' where es.title = '77.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} is much larger than Europe.', null),
  (2, 'Last year I visited Mexico and {0}.', null),
  (3, 'Southern England is warmer than {0}.', null),
  (4, 'Thailand and Cambodia are in {0}.', null),
  (5, 'Chicago is on {0}.', null),
  (6, 'Next year we''re going skiing in {0}.', null),
  (7, '{0} consists of Great Britain and Northern Ireland.', null),
  (8, '{0} are a group of islands in {1}.', null),
  (9, 'I''ve never been to {0}.', null),
  (10, '{0} flows into {1}.', null)
) as v(n, template, hint)
where es.title = '77.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '77.2'
join (values
  (1, 0, 'Africa'), (2, 0, 'the United States'), (3, 0, 'the north'), (4, 0, 'southeast Asia'),
  (5, 0, 'Lake Michigan'), (6, 0, 'the Swiss Alps'), (7, 0, 'The UK'),
  (8, 0, 'The Seychelles'), (8, 1, 'the Indian Ocean'), (9, 0, 'South Africa'),
  (10, 0, 'The River Volga'), (10, 1, 'the Caspian Sea')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '77.3', 'Here are some geography questions. Choose the right answer and use the if necessary.', 2
from units where slug = 'unit-77';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-77' where es.title = '77.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Where is Argentina? {0}', null),
  (2, 'Which is the longest river in Africa? {0}', null),
  (3, 'Of which country is Stockholm the capital? {0}', null),
  (4, 'Of which country is Washington the capital? {0}', null),
  (5, 'What is the name of the mountain range in the west of North America? {0}', null),
  (6, 'What is the name of the sea between Africa and Europe? {0}', null),
  (7, 'Which is the smallest continent in the world? {0}', null),
  (8, 'What is the name of the ocean between North America and Asia? {0}', null),
  (9, 'What is the name of the ocean between Africa and Australia? {0}', null),
  (10, 'Which river flows through London? {0}', null),
  (11, 'Which river flows through Vienna, Budapest and Belgrade? {0}', null),
  (12, 'Of which country is Bangkok the capital? {0}', null),
  (13, 'What joins the Atlantic and Pacific Oceans? {0}', null),
  (14, 'Which is the longest river in South America? {0}', null)
) as v(n, template, hint)
where es.title = '77.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '77.3'
join (values
  (1, 'South America', array['in South America']::text[]),
  (2, 'the Nile', array[]::text[]),
  (3, 'Sweden', array[]::text[]),
  (4, 'the United States', array[]::text[]),
  (5, 'the Rockies', array[]::text[]),
  (6, 'the Mediterranean', array[]::text[]),
  (7, 'Australia', array[]::text[]),
  (8, 'the Pacific', array[]::text[]),
  (9, 'the Indian Ocean', array[]::text[]),
  (10, 'the Thames', array[]::text[]),
  (11, 'the Danube', array[]::text[]),
  (12, 'Thailand', array[]::text[]),
  (13, 'the Panama Canal', array[]::text[]),
  (14, 'the Amazon', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 78: Names with and without the 2
-- ============================================================

delete from units where slug = 'unit-78';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 78, 'unit-78', 'Names with and without the 2', null,
  'We do not use the with names of streets/parks/squares, or with two-word names like Manchester Airport. Most other buildings (hotels, theatres, museums) have names with the, as do names with of. Shops/restaurants named after people (McDonald''s), companies and airlines usually have no the, while most newspapers and organisations do.', 9
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'names without the (streets, and two-word names like Manchester Airport)',
  'We do not use the with names of most city streets/roads/squares/parks etc.: Union Street, Fifth Avenue, Hyde Park, Abbey Road, Broadway, Times Square (not the ...). Names of many public buildings and institutions, and some geographical names, are two words, the first being the name of a place or person: Manchester Airport, Harvard University. These are usually without the — in the same way, Victoria Station, Canterbury Cathedral, Edinburgh Castle, Buckingham Palace, Cambridge University, Sydney Harbour (not the ...). Compare: Buckingham Palace (not the ...) but the Royal Palace (Royal is an adjective, not a name like Buckingham).', 0
from units where slug = 'unit-78';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'most other buildings have names with the',
  'Most other buildings have names with the: hotels — the Sheraton Hotel, the Holiday Inn; theatres/cinemas — the Palace Theatre, the Odeon; museums — the Guggenheim Museum, the National Gallery; other buildings — the Empire State (Building), the White House, the Eiffel Tower. We often leave out the noun: the Palace (Theatre), the Guggenheim (Museum), the Sheraton (Hotel). Some names are only the + noun: the Acropolis, the Kremlin, the Pentagon.', 1
from units where slug = 'unit-78';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'names with of usually have the',
  'Names with of usually have the: the Bank of England, the Museum of Modern Art, the Great Wall of China, the Tower of London. Note that we say the University of Cambridge but Cambridge University (without the).', 2
from units where slug = 'unit-78';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'names ending in -''s or -s (no the)',
  'Many shops, restaurants, hotels etc. are named after people. These names end in -''s or -s. We do not use the with these names: McDonald''s, Barclays (bank), Joe''s Diner, Macy''s (not the ...). Churches are often named after saints (St = Saint): St John''s Church, St Patrick''s Cathedral (not the ...).', 3
from units where slug = 'unit-78';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'newspapers/organisations with the; companies without',
  'Most newspapers and many organisations have names with the: the Washington Post, the Financial Times, the Sun, the European Union, the BBC, the Red Cross. Names of companies, airlines etc. are usually without the: Fiat, Sony, Singapore Airlines, Kodak, IBM, Yale University Press (not the Fiat).', 4
from units where slug = 'unit-78';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-78'
join (values
  ('A', 'Union Street (not the ...)', null, 0),
  ('A', 'Manchester Airport', null, 1),
  ('A', 'Harvard University', null, 2),
  ('A', 'Victoria Station (not the ...)', null, 3),
  ('A', 'Buckingham Palace (not the ...) but the Royal Palace', null, 4),
  ('B', 'the Sheraton Hotel', null, 0),
  ('B', 'the Palace Theatre', null, 1),
  ('B', 'the Guggenheim Museum', null, 2),
  ('B', 'the White House', null, 3),
  ('B', 'the Eiffel Tower', null, 4),
  ('B', 'the Acropolis', null, 5),
  ('B', 'the Kremlin', null, 6),
  ('C', 'the Bank of England', null, 0),
  ('C', 'the Museum of Modern Art', null, 1),
  ('C', 'the Great Wall of China', null, 2),
  ('C', 'the University of Cambridge', '= Cambridge University', 3),
  ('D', 'McDonald''s (not the ...)', null, 0),
  ('D', 'Joe''s Diner', null, 1),
  ('D', 'St John''s Church (not the ...)', null, 2),
  ('E', 'the Washington Post', null, 0),
  ('E', 'the BBC', null, 1),
  ('E', 'Fiat (not the Fiat)', null, 2),
  ('E', 'IBM', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 78.1-78.3; 78.1 is map-based with no
-- fill-in text of its own, same shape as 46.1 in 0008)
-- ------------------------------------------------------------

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: a small street map used in exercise 78.1, showing Market Street, Carter Road, Park Road, George Street and Forest Avenue, with the Odeon cinema, Turner''s supermarket, the Crown Hotel, St Peter''s church, the City Museum, Blackstone''s bookshop, Mario''s restaurant and Victoria Park marked on it]', 0
from units where slug = 'unit-78';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '78.1', 'Use the map to answer the questions. Write the name of the place and the street it is in. Use the if necessary.', 0
from units where slug = 'unit-78';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-78' where es.title = '78.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Is there a supermarket near here? {0}', 'map'),
  (2, 'Is there a hotel near here? {0}', 'map'),
  (3, 'Is there a church near here? {0}', 'map'),
  (4, 'Is there a museum near here? {0}', 'map'),
  (5, 'Is there a bookshop near here? {0}', 'map'),
  (6, 'Is there a restaurant near here? {0}', 'map'),
  (7, 'Is there a park near here? {0}', 'map')
) as v(n, template, hint)
where es.title = '78.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '78.1'
join (values
  (1, 'Yes, Turner''s in Carter Road.'), (2, 'Yes, the Crown Hotel in Park Road.'),
  (3, 'Yes, St Peter''s in Market Street.'), (4, 'Yes, the City Museum in George Street.'),
  (5, 'Yes, Blackstone''s in Forest Avenue.'), (6, 'Yes, Mario''s in George Street.'),
  (7, 'Yes, Victoria Park at the end of Market Street.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '78.2', 'Where are the following? Use the where necessary: Acropolis, Broadway, Buckingham Palace, Eiffel Tower, Kremlin, White House, Gatwick Airport, Times Square.', 1
from units where slug = 'unit-78';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-78' where es.title = '78.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} is in Paris.', null),
  (2, '{0} is in London.', null),
  (3, '{0} is in Washington.', null),
  (4, '{0} is in Moscow.', null),
  (5, '{0} is in New York.', null),
  (6, '{0} is in Athens.', null),
  (7, '{0} is near London.', null)
) as v(n, template, hint)
where es.title = '78.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '78.2'
join (values
  (1, 'The Eiffel Tower'), (2, 'Buckingham Palace'), (3, 'The White House'), (4, 'The Kremlin'),
  (5, 'Broadway'), (6, 'The Acropolis'), (7, 'Gatwick Airport')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '78.3', 'Which is right?', 2
from units where slug = 'unit-78';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-78' where es.title = '78.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Many tourists in London visit {0}.', 'St Paul''s Cathedral / the St Paul''s Cathedral'),
  (2, 'The biggest park in New York is {0}.', 'Central Park / The Central Park'),
  (3, 'I''d like to go to China and see {0}.', 'Great Wall / the Great Wall'),
  (4, '{0} is situated about 12 kilometres from the city centre.', 'Dublin Airport / The Dublin Airport'),
  (5, '''Which cinema are we going to this evening?'' ''{0}.''', 'Classic / The Classic'),
  (6, 'Jack is a student at {0}.', 'Liverpool University / the Liverpool University'),
  (7, 'You should go to {0}. It''s very interesting.', 'National Museum / the National Museum'),
  (8, 'If you''re looking for a department store, I would recommend {0}.', 'Harrison''s / the Harrison''s'),
  (9, 'Andy is a flight attendant. He works for {0}.', 'Cathay Pacific / the Cathay Pacific'),
  (10, '''Which newspaper do you want?'' ''{0}.''', 'Morning News / The Morning News'),
  (11, 'We went to Italy and saw {0} of Pisa.', 'Leaning Tower / the Leaning Tower'),
  (12, 'This book is published by {0}.', 'Cambridge University Press / the Cambridge University Press'),
  (13, 'The building across the street is {0}.', 'College of Art / the College of Art'),
  (14, '{0} is in {1}.', 'Imperial Hotel / The Imperial Hotel ... Baker Street / the Baker Street'),
  (15, '{0} is at the entrance to {1}.', 'Statue of Liberty / The Statue of Liberty ... New York Harbor / the New York Harbor')
) as v(n, template, hint)
where es.title = '78.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '78.3'
join (values
  (1, 0, 'St Paul''s Cathedral'), (2, 0, 'Central Park'), (3, 0, 'the Great Wall'),
  (4, 0, 'Dublin Airport'), (5, 0, 'The Classic'), (6, 0, 'Liverpool University'),
  (7, 0, 'the National Museum'), (8, 0, 'Harrison''s'), (9, 0, 'Cathay Pacific'),
  (10, 0, 'The Morning News'), (11, 0, 'the Leaning Tower'), (12, 0, 'Cambridge University Press'),
  (13, 0, 'the College of Art'),
  (14, 0, 'The Imperial Hotel'), (14, 1, 'Baker Street'),
  (15, 0, 'The Statue of Liberty'), (15, 1, 'New York Harbor')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
