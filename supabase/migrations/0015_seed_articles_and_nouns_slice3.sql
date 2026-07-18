-- Marco 4 (slice 14): seeds the third slice of the "Articles and nouns"
-- module — units 74-76 (the 2: school/the school, the 3: children/the
-- children, the 4: the giraffe/the telephone/the old).
--
-- Sourced from pdf/Modulos/Articles and nouns.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (re-extracted without -layout for the relevant pages, same workaround
-- as the previous slice, since the Key's 3-column layout garbles under
-- -layout).
--
-- 75.1 ("Choose four of these things and write what you think about them")
-- is skipped as open-ended: the Key itself labels its answers "Example
-- answers" and they are genuine personal opinions (do you like cats,
-- zoos, snow, boxing etc.), same reasoning as every prior "write about
-- yourself" exercise.
--
-- 76.1 item 4c ("And the currency of your country?") and 76.4's last row
-- ("and your country") are both dropped for the same reason — the correct
-- answer depends on which country the learner is from, not fixed in the
-- Key (which itself just has "...").
--
-- 74.1, 74.2, 74.3, 74.4, 75.2, 75.3, 76.1, 76.3 and 76.4 all have their
-- own item 1 as the book's worked example (already answered inline);
-- dropped and the remaining items renumbered from 1, per the established
-- convention.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 74: the 2 (school / the school etc.)
-- ============================================================

delete from units where slug = 'unit-74';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 74, 'unit-74', 'the 2 (school / the school etc.)', null,
  'We use school/prison/hospital/university/college/church without the when thinking of the general idea or purpose of the place (as a student, patient or prisoner); we use the when referring to a specific building, visited for another reason. We also say go to bed/be in bed, go to work/be at work, and go home (without the).', 5
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'school and the school',
  'We say a child goes to school or is at school (as a student) — we are not thinking of a specific school, but of school as a general idea, children learning in a classroom. If somebody is not a student — for example a parent visiting — they go to the school (= a specific building): Ellie is at school now (as a student). Ellie''s mother has gone to the school to see the teacher (as a visitor). She''s at the school now.', 0
from units where slug = 'unit-74';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'prison, hospital, university, college, church',
  'We use prison (or jail), hospital, university, college and church in a similar way — no the when thinking of the general idea of what these places are used for. Compare: When I leave school, I plan to go to university/college (as a student) — I went to the university to meet Professor Thomas (as a visitor, not as a student). Joe had an accident and was taken to hospital. He''s still in hospital now (as a patient) — Jane has gone to the hospital to visit Joe. She''s at the hospital now (as a visitor). Ken''s brother is in prison for robbery (he is a prisoner) — Ken went to the prison to visit his brother (as a visitor). Sarah''s father goes to church every Sunday (for a religious service) — Some workmen went to the church to repair the roof (a specific building). With most other places, you need the — for example the station, the cinema.', 1
from units where slug = 'unit-74';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'bed, work, home (no the)',
  'We say go to bed / be in bed etc. (not the bed): I''m going to bed now. Goodnight. Do you ever have breakfast in bed? But: I sat down on the bed (a specific piece of furniture). We say go to work / be at work / start work / finish work etc. (not the work): Chris didn''t go to work yesterday. What time do you usually finish work? We say go home / come home / arrive home / get home / be (at) home / do something at home etc.: It''s late. Let''s go home. I don''t go out to work. I work at home.', 2
from units where slug = 'unit-74';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-74'
join (values
  ('A', 'Ellie is at school now.', 'as a student, general idea', 0),
  ('A', 'School starts at 9 and finishes at 3.', null, 1),
  ('A', 'Ellie''s mother has gone to the school to see her daughter''s teacher.', 'a specific building, as a visitor', 2),
  ('A', 'She''s at the school now.', 'specific building', 3),
  ('B', 'When I leave school, I plan to go to university.', 'as a student', 0),
  ('B', 'I went to the university to meet Professor Thomas.', 'as a visitor, not as a student', 1),
  ('B', 'Joe had an accident last week. He was taken to hospital. He''s still in hospital now.', 'as a patient', 2),
  ('B', 'Jane has gone to the hospital to visit Joe. She''s at the hospital now.', 'as a visitor', 3),
  ('B', 'Ken''s brother is in prison for robbery.', 'he is a prisoner', 4),
  ('B', 'Ken went to the prison to visit his brother.', 'as a visitor', 5),
  ('B', 'Sarah''s father goes to church every Sunday.', 'for a religious service', 6),
  ('B', 'Some workmen went to the church to repair the roof.', 'a specific building', 7),
  ('C', 'I''m going to bed now. Goodnight.', null, 0),
  ('C', 'Do you ever have breakfast in bed?', null, 1),
  ('C', 'I sat down on the bed.', 'a specific piece of furniture', 2),
  ('C', 'Chris didn''t go to work yesterday.', null, 3),
  ('C', 'What time do you usually finish work?', null, 4),
  ('C', 'It''s late. Let''s go home.', null, 5),
  ('C', 'I don''t go out to work. I work at home.', null, 6)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 74.1-74.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '74.1', 'Complete the sentences with school or the school.', 0
from units where slug = 'unit-74';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-74' where es.title = '74.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When he was younger, Ben hated {0}, but he enjoys it now.', null),
  (2, 'There were some parents waiting outside {0} to meet their children.', null),
  (3, 'What time does {0} start in the morning?', null),
  (4, 'How do your children get to and from {0}? Do you take them?', null),
  (5, 'What was the name of {0} you attended?', null),
  (6, 'What does Emily want to do when she leaves {0}?', null),
  (7, 'My children walk to {0}. {1} isn''t very far.', null)
) as v(n, template, hint)
where es.title = '74.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '74.1'
join (values
  (1, 0, 'school'), (2, 0, 'the school'), (3, 0, 'school'), (4, 0, 'school'),
  (5, 0, 'the school'), (6, 0, 'school'), (7, 0, 'school'), (7, 1, 'The school')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '74.2', 'Which is right?', 1
from units where slug = 'unit-74';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-74' where es.title = '74.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Neil left school and got a job. He didn''t want to go to {0}.', 'university / the university'),
  (2, 'In your country, what proportion of the population study at {0}?', 'university / the university'),
  (3, 'This is a small town, but {0} is the biggest in the country.', 'university / the university'),
  (4, 'My brother has always been healthy. He''s never been in {0}.', 'hospital / the hospital'),
  (5, 'When my friend was ill, I went to {0} to see her.', 'hospital / the hospital'),
  (6, 'When I was visiting my friend, I met Lisa, who is a nurse at {0}.', 'hospital / the hospital'),
  (7, 'I saw an accident. A woman was injured and was taken to {0}.', 'hospital / the hospital'),
  (8, 'Why is she in {0}? What crime did she commit?', 'prison / the prison'),
  (9, 'There was a fire at {0}. Firefighters were called to put it out.', 'prison / the prison'),
  (10, 'Do you think too many people are sent to {0}?', 'prison / the prison'),
  (11, 'John''s mother is a regular churchgoer. She goes to {0} every Sunday.', 'church / the church'),
  (12, 'John himself doesn''t go to {0}.', 'church / the church'),
  (13, 'The village is very nice. You should visit {0}. It''s interesting.', 'church / the church')
) as v(n, template, hint)
where es.title = '74.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '74.2'
join (values
  (1, 'university'), (2, 'university'), (3, 'the university'),
  (4, 'hospital'), (5, 'the hospital'), (6, 'the hospital'), (7, 'hospital'),
  (8, 'prison'), (9, 'the prison'), (10, 'prison'),
  (11, 'church'), (12, 'church'), (13, 'the church')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '74.3', 'Complete the sentences. Choose from the box: bed, the bed, in bed, home, at home, like home, work, to work, after work.', 2
from units where slug = 'unit-74';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-74' where es.title = '74.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'How do you usually go {0} in the morning? By bus?', null),
  (2, 'Sam likes to go to {0} early and get up early.', null),
  (3, 'I don''t have my phone. I left it {0}.', null),
  (4, '''Have you seen my keys?'' ''Yes, they''re on {0}.''', null),
  (5, 'Shall we meet {0} tomorrow evening?', null),
  (6, 'I like to read {0} before going to sleep.', null),
  (7, 'It was a long tiring journey. We arrived {0} very late.', null),
  (8, 'Tom usually finishes {0} at five o''clock.', null),
  (9, 'It''s nice to travel around, but there''s no place {0}.', null)
) as v(n, template, hint)
where es.title = '74.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '74.3'
join (values
  (1, 'to work'), (2, 'bed'), (3, 'at home'), (4, 'the bed'), (5, 'after work'),
  (6, 'in bed'), (7, 'home'), (8, 'work'), (9, 'like home')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '74.4', 'Complete the sentences. Choose at/in/to + hospital, school etc.', 3
from units where slug = 'unit-74';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-74' where es.title = '74.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'In your country, from what age do children have to go {0}?', null),
  (2, 'Mark didn''t go out last night. He {0}.', 'stayed at home / stayed home'),
  (3, 'There is a lot of traffic in the morning when people are going {0}.', null),
  (4, 'When Sophie leaves school, she wants to study psychology {0}.', null),
  (5, 'Ben never gets up before 9 o''clock. It''s 8.30 now, so he is still {0}.', null),
  (6, 'The accident wasn''t serious. Nobody had to go {0}.', null),
  (7, 'If people commit crimes, they may end up {0}.', null)
) as v(n, template, hint)
where es.title = '74.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '74.4'
join (values
  (1, 'to school', array[]::text[]),
  (2, 'stayed at home', array['stayed home']::text[]),
  (3, 'to work', array[]::text[]),
  (4, 'at university', array[]::text[]),
  (5, 'in bed', array[]::text[]),
  (6, 'to hospital', array[]::text[]),
  (7, 'in prison', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 75: the 3 (children / the children)
-- ============================================================

delete from units where slug = 'unit-75';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 75, 'unit-75', 'the 3 (children / the children)', null,
  'We do not use the when talking about things or people in general — dogs, doctors, music, most shops. We use the when we mean specific people or things: the children (my children), the music (in that film), the sugar (on the table).', 6
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'general statements: no the',
  'When we are talking about things or people in general, we do not use the: I''m afraid of dogs (not the dogs — dogs in general, not a specific group). Doctors are usually paid more than teachers. Do you know anybody who collects stamps? Life has changed a lot in the last thirty years. Do you like classical music / Chinese food / fast cars? My favourite sport is football/skiing/athletics. My favourite subject at school was history/physics/English. We say most people / most shops / most big cities etc. (not the most ...): Most shops accept credit cards (not The most shops).', 0
from units where slug = 'unit-75';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'general vs. specific',
  'We use the when we mean specific things or people. Compare: Children learn from playing (= children in general) — We took the children to the zoo (= a specific group, perhaps the speaker''s children). I couldn''t live without music — The film wasn''t very good, but I liked the music (= the music in the film). All cars have wheels. Sugar isn''t very good for you. — All the cars in this car park belong to people who work here. Can you pass the sugar, please? (= the sugar on the table). English people drink a lot of tea (= English people in general) — The English people I know drink a lot of tea (= only the English people I know, not English people in general).', 1
from units where slug = 'unit-75';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'the difference is not always clear-cut',
  'The difference between "something in general" and "something specific" is not always very clear. Compare: I like working with people (= people in general) — I like the people I work with (= a specific group of people). I like working with people who say what they think (not all people, but "people who say what they think" is still a general idea) — The coffee we had after dinner wasn''t very good (= specific coffee). Do you like coffee? (= coffee in general) — Do you like strong black coffee? (not all coffee, but "strong black coffee" is still a general idea).', 2
from units where slug = 'unit-75';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-75'
join (values
  ('A', 'I''m afraid of dogs. (not the dogs)', null, 0),
  ('A', 'Doctors are usually paid more than teachers.', null, 1),
  ('A', 'Do you know anybody who collects stamps?', null, 2),
  ('A', 'Life has changed a lot in the last thirty years.', null, 3),
  ('A', 'Do you like classical music, Chinese food, fast cars?', null, 4),
  ('A', 'My favourite sport is football.', null, 5),
  ('A', 'My favourite subject at school was history.', null, 6),
  ('A', 'Most shops accept credit cards. (not The most shops)', null, 7),
  ('B', 'Children learn from playing.', '= children in general', 0),
  ('B', 'We took the children to the zoo.', '= a specific group, perhaps the speaker''s children', 1),
  ('B', 'I couldn''t live without music.', null, 2),
  ('B', 'The film wasn''t very good, but I liked the music.', '= the music in the film', 3),
  ('B', 'All cars have wheels.', null, 4),
  ('B', 'Can you pass the sugar, please?', '= the sugar on the table', 5),
  ('B', 'English people drink a lot of tea.', '= English people in general', 6),
  ('B', 'The English people I know drink a lot of tea.', '= only the English people I know', 7),
  ('C', 'I like working with people.', '= people in general', 0),
  ('C', 'I like the people I work with.', '= a specific group of people', 1),
  ('C', 'The coffee we had after dinner wasn''t very good.', '= specific coffee', 2),
  ('C', 'Do you like coffee?', '= coffee in general', 3),
  ('C', 'Do you like strong black coffee?', 'still a general idea', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 75.2-75.4; 75.1 skipped — open-ended,
-- "Example answers" for genuinely personal opinions)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '75.2', 'Which is right?', 0
from units where slug = 'unit-75';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-75' where es.title = '75.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Look at {0} on that tree. They''re very big.', 'apples / the apples'),
  (2, 'Who are {0} in this picture?', 'people / the people'),
  (3, 'It annoys me when {0} throw rubbish on the ground.', 'people / the people'),
  (4, 'My memory isn''t good. I''m not good at remembering {0}.', 'names / the names'),
  (5, 'What were {0} of those people we met last night?', 'names / the names'),
  (6, '{0} began in 1914 and ended in 1918.', 'First World War / The First World War'),
  (7, 'A pacifist is somebody who is against {0}.', 'war / the war'),
  (8, 'He''s lazy. He doesn''t like {0}.', 'hard work / the hard work'),
  (9, 'Did you finish {0} you were doing yesterday?', 'work / the work')
) as v(n, template, hint)
where es.title = '75.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '75.2'
join (values
  (1, 'the apples'), (2, 'the people'), (3, 'people'), (4, 'names'), (5, 'the names'),
  (6, 'The First World War'), (7, 'war'), (8, 'hard work'), (9, 'the work')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '75.3', 'Complete the sentences using the following. Use the where necessary: basketball, grass, patience, people, questions, meat, information, hotels, biology, water, spiders, lies.', 1
from units where slug = 'unit-75';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-75' where es.title = '75.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Some people are afraid of {0}.', 'spiders'),
  (2, 'A vegetarian is somebody who doesn''t eat {0}.', 'meat'),
  (3, 'The test wasn''t hard. I answered {0} without difficulty.', 'questions'),
  (4, 'Do you know {0} who live in the flat next to yours?', 'people'),
  (5, '{0} is the study of plants and animals.', 'biology'),
  (6, 'It''s better to tell the truth. Telling {0} often causes problems.', 'lies'),
  (7, 'We couldn''t find anywhere to stay in the town. {0} were all full.', 'hotels'),
  (8, 'Don''t swim in this pool. {0} doesn''t look very clean.', 'water'),
  (9, 'Don''t sit on {0}. It''s wet after the rain.', 'grass'),
  (10, 'You need {0} to teach young children.', 'patience')
) as v(n, template, hint)
where es.title = '75.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '75.3'
join (values
  (1, 'spiders'), (2, 'meat'), (3, 'the questions'), (4, 'the people'), (5, 'Biology'),
  (6, 'lies'), (7, 'The hotels'), (8, 'The water'), (9, 'the grass'), (10, 'patience')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '75.4', 'Which is right?', 2
from units where slug = 'unit-75';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-75' where es.title = '75.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Steve is very good at telling {0}.', 'stories / the stories'),
  (2, 'I can''t sing this song. I don''t know {0}.', 'words / the words'),
  (3, 'Don''t stay in that hotel. It''s noisy and {0} are very small.', 'rooms / the rooms'),
  (4, 'I don''t have a car, so I use {0} most of the time.', 'public transport / the public transport'),
  (5, '{0} on the top shelf belong to me.', 'All books / All the books'),
  (6, '{0} is strange sometimes. Some very strange things happen.', 'Life / The life'),
  (7, 'We enjoyed our holiday. {0} was good.', 'Weather / The weather'),
  (8, 'Everybody needs {0} to live.', 'water / the water'),
  (9, 'I don''t like {0} with unhappy endings.', 'films / the films')
) as v(n, template, hint)
where es.title = '75.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '75.4'
join (values
  (1, 'stories'), (2, 'the words'), (3, 'the rooms'), (4, 'public transport'),
  (5, 'All the books'), (6, 'Life'), (7, 'The weather'), (8, 'water'), (9, 'films')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 76: the 4 (the giraffe / the telephone / the old etc.)
-- ============================================================

delete from units where slug = 'unit-76';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 76, 'unit-76', 'the 4 (the giraffe / the telephone / the old etc.)', null,
  'We use the + singular noun to talk about a type of animal, machine or musical instrument in general (The giraffe is the tallest of all animals. Can you play the guitar?). We use the + adjective (the old, the rich, the unemployed) for groups of people, and the with certain nationality adjectives (the French, the Chinese) to mean the people of that country.', 7
from modules where slug = 'articles-and-nouns';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'the + singular noun for a type (the giraffe, the guitar)',
  'The giraffe is the tallest of all animals. The bicycle is an excellent means of transport. When was the camera invented? The dollar is the currency of the United States. In these examples, the ... does not mean one specific thing — the giraffe = a specific type of animal, not a specific giraffe. We use the ... in this way to talk about a type of animal, machine etc., and for musical instruments: Can you play the guitar? The piano is my favourite instrument. Compare a and the: I''d like to have a piano, but I can''t play the piano. We saw a giraffe at the zoo, but The giraffe is my favourite animal. Note that man (without the) = human beings in general, the human race: What do you know about the origins of man? (not the man).', 0
from units where slug = 'unit-76';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'the + adjective for groups of people (the old, the rich)',
  'We use the + adjective (without a noun) to talk about groups of people: the old, the elderly, the rich, the poor, the homeless, the unemployed, the sick, the injured. the old = old people, the rich = rich people etc.: Do you think the rich should pay higher taxes? We need to do more to help the homeless. Note that we say the old (not the olds), the poor (not the poors) etc. The rich, the homeless etc. are plural — for one person, we say a rich man (not a rich), a homeless person (not a homeless).', 1
from units where slug = 'unit-76';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'the French, the Chinese (nationality words)',
  'We use the + a few nationality adjectives that end in -ch or -sh to mean the people of that country: the French, the Dutch, the British, the English, the Spanish. The meaning is plural: The French are famous for their food (not French are ...). We do not say "a French" or "an English" (singular) — we say a French woman / an English guy. We also use the + nationality words ending in -ese or -ss: the Chinese, the Portuguese, the Swiss — these words can also be singular (a Chinese, a Swiss etc.). With other nationality words, the plural ends in -s, usually without the: an Italian → Italians, a Mexican → Mexicans, a Thai → Thais. In all cases you can use adjective + people: French/Chinese/Mexican people are very friendly.', 2
from units where slug = 'unit-76';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-76'
join (values
  ('A', 'The giraffe is the tallest of all animals.', null, 0),
  ('A', 'The bicycle is an excellent means of transport.', null, 1),
  ('A', 'When was the camera invented?', null, 2),
  ('A', 'The dollar is the currency of the United States.', null, 3),
  ('A', 'Can you play the guitar?', null, 4),
  ('A', 'The piano is my favourite instrument.', null, 5),
  ('A', 'I''d like to have a piano, but I can''t play the piano.', null, 6),
  ('A', 'We saw a giraffe at the zoo, but The giraffe is my favourite animal.', null, 7),
  ('A', 'What do you know about the origins of man? (not the man)', null, 8),
  ('B', 'Do you think the rich should pay higher taxes?', null, 0),
  ('B', 'We need to do more to help the homeless.', null, 1),
  ('B', 'a rich man (not a rich)', null, 2),
  ('B', 'a homeless person (not a homeless)', null, 3),
  ('C', 'The French are famous for their food. (not French are ...)', null, 0),
  ('C', 'I met a French woman / an English guy.', null, 1),
  ('C', 'Italians / Mexicans / Thais are very friendly.', null, 2),
  ('C', 'French / Chinese / Mexican people are very friendly.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 76.1-76.4; 76.1 item 4c and 76.4's "your
-- country" row skipped — depend on the learner's own country, not fixed
-- in the Key)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '76.1', 'Answer the questions. Choose the right answer from the box. Don''t forget the.', 0
from units where slug = 'unit-76';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-76' where es.title = '76.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Which animal can run the fastest? (elephant, cheetah, tiger, kangaroo, rabbit, giraffe) {0}', null),
  (2, 'Which of these animals is found in Australia? (elephant, cheetah, tiger, kangaroo, rabbit, giraffe) {0}', null),
  (3, 'Which of these birds has a long neck? (penguin, owl, eagle, pigeon, swan, parrot) {0}', null),
  (4, 'Which of these birds cannot fly? (penguin, owl, eagle, pigeon, swan, parrot) {0}', null),
  (5, 'Which bird flies at night? (penguin, owl, eagle, pigeon, swan, parrot) {0}', null),
  (6, 'Which of these inventions is the oldest? (wheel, laser, telescope) {0}', null),
  (7, 'Which one is the most recent? (wheel, laser, telescope) {0}', null),
  (8, 'Which one was especially important for astronomy? (wheel, laser, telescope) {0}', null),
  (9, 'What is the currency of India? (rupee, dollar, euro, rouble, peso, yen) {0}', null),
  (10, 'What is the currency of Canada? (rupee, dollar, euro, rouble, peso, yen) {0}', null)
) as v(n, template, hint)
where es.title = '76.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '76.1'
join (values
  (1, 'the cheetah', array[]::text[]),
  (2, 'the kangaroo', array['the rabbit']::text[]),
  (3, 'the swan', array[]::text[]),
  (4, 'the penguin', array[]::text[]),
  (5, 'the owl', array[]::text[]),
  (6, 'the wheel', array[]::text[]),
  (7, 'the laser', array[]::text[]),
  (8, 'the telescope', array[]::text[]),
  (9, 'the rupee', array[]::text[]),
  (10, 'the dollar', array['the Canadian dollar']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '76.2', 'Put in the or a.', 1
from units where slug = 'unit-76';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-76' where es.title = '76.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Can you play {0} musical instrument?', null),
  (2, 'Jessica plays {0} violin in an orchestra.', null),
  (3, 'There was {0} piano in the corner of the room.', null),
  (4, 'I wish I could play {0} piano.', null),
  (5, 'Our society is based on {0} family.', null),
  (6, 'Martin comes from {0} large family.', null),
  (7, '{0} computer has changed the way we live.', null),
  (8, 'When was {0} bicycle invented?', null),
  (9, 'Do you have {0} car?', null)
) as v(n, template, hint)
where es.title = '76.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '76.2'
join (values
  (1, 'a'), (2, 'the'), (3, 'a'), (4, 'the'), (5, 'the'), (6, 'a'), (7, 'The'), (8, 'the'), (9, 'a')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '76.3', 'Complete these sentences. Use the + adjective. Choose from: elderly, injured, rich, sick, unemployed, young.', 2
from units where slug = 'unit-76';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-76' where es.title = '76.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Helen is a nurse. She''s spent her life caring for {0}.', null),
  (2, 'Life is all right if you have a job, but things are hard for {0}.', null),
  (3, 'Ambulances arrived at the scene of the accident and took {0} to hospital.', null),
  (4, 'More and more people are living longer. How are we going to care for {0}?', null),
  (5, 'It''s nice to have lots of money, but {0} have their problems too.', null)
) as v(n, template, hint)
where es.title = '76.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '76.3'
join (values
  (1, 'the sick'), (2, 'the unemployed'), (3, 'the injured'), (4, 'the elderly'), (5, 'the rich')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '76.4', 'What do you call the people of these countries? Give the word for one person (a/an ...) and for the people in general.', 3
from units where slug = 'unit-76';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-76' where es.title = '76.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Germany: one person = {0}. People in general = {1}.', null),
  (2, 'France: one person = {0}. People in general = {1}.', null),
  (3, 'Russia: one person = {0}. People in general = {1}.', null),
  (4, 'Japan: one person = {0}. People in general = {1}.', null),
  (5, 'Brazil: one person = {0}. People in general = {1}.', null),
  (6, 'England: one person = {0}. People in general = {1}.', null)
) as v(n, template, hint)
where es.title = '76.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '76.4'
join (values
  (1, 0, 'a German', array[]::text[]), (1, 1, 'Germans', array['German people']::text[]),
  (2, 0, 'a Frenchman', array['a Frenchwoman']::text[]), (2, 1, 'the French', array['French people']::text[]),
  (3, 0, 'a Russian', array[]::text[]), (3, 1, 'Russians', array['Russian people']::text[]),
  (4, 0, 'a Japanese', array[]::text[]), (4, 1, 'the Japanese', array['Japanese people']::text[]),
  (5, 0, 'a Brazilian', array[]::text[]), (5, 1, 'Brazilians', array['Brazilian people']::text[]),
  (6, 0, 'an Englishman', array['an Englishwoman']::text[]), (6, 1, 'the English', array['English people']::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
