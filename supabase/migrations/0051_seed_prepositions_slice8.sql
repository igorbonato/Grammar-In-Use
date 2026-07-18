-- Marco 4 (slice 50): seeds the eighth slice of the "Prepositions" module
-- — unit 128 (by).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 128.4 item 11 (renumbered 10) is the only three-blank item in this
-- module so far.
--
-- Safe to re-run: unit 128 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 128: by
-- ============================================================

delete from units where slug = 'unit-128';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 128, 'unit-128', 'by', null,
  'by mistake/accident/chance (no the/a); by car/train/plane/bus/bike (but in my car, on the train, on foot); by post/card/hand for how something is done. In the passive, something is done by somebody (with by + noun for the doer, but with + noun for the tool used). by also means "next to" (sit by me), and shows a difference between two amounts (won by ten per cent).', 7
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'by mistake / by accident / by chance',
  'You can say that something happens by mistake / by accident / by chance: We hadn''t arranged to meet. We met by chance. But we say ''do something on purpose'' (= you mean to do it): I didn''t do it on purpose. It was an accident. Note that we say by chance, by accident etc. (not by the chance / by an accident). In these expressions we use by + noun without the or a.', 0
from units where slug = 'unit-128';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'by car / by train etc.',
  'We use by ... to say how somebody travels. For example, you can travel: by car, by train, by plane, by boat, by ship, by bus, by bike etc. Jess usually goes to work by bus / by bike / by car. We do not use by if we say my car / the train / a taxi etc. We say: by car but in my car (not by my car); by train but on the train (not by the train). We use in for cars and taxis: They didn''t come in their car. They came in a taxi. We use on for bikes and public transport (buses, trains etc.): We travelled on the 6.45 train, which arrived at 8.30. Note that we usually say on foot (not usually by foot): Did you come here by car or on foot? We also use by to say how we do other things. For example, you can: send something by post, pay by card / by cheque, do something by hand. Can I pay by credit card? But note that we say pay cash or pay in cash (not usually by cash).', 1
from units where slug = 'unit-128';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'the passive with by',
  'We say that ''something is done by ...'' (passive): Have you ever been bitten by a dog? The programme was watched by millions of people. Compare by and with: The door must have been opened with a key. (not by a key) (= somebody used a key to open it) The door must have been opened by somebody with a key. We say: a play by Shakespeare, a painting by Rembrandt, a novel by Tolstoy etc. Have you read any poems by Shakespeare? ''Who is this painting by? Picasso?'' ''I have no idea.''', 2
from units where slug = 'unit-128';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'by = next to',
  'By also means ''next to / beside'': The light switch is by the door. Come and sit by me. (= next to me)', 3
from units where slug = 'unit-128';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'by = the difference between two things',
  'You can also use by ... to show the difference between two things: Clare''s salary has increased by ten per cent. (= it''s now ten per cent more than before) Carl won the race by five metres. (= he was five metres in front of the other runners)', 4
from units where slug = 'unit-128';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-128'
join (values
  ('A', 'We hadn''t arranged to meet. We met by chance.', null, 0),
  ('A', 'I didn''t do it on purpose. It was an accident.', null, 1),
  ('B', 'Jess usually goes to work by bus / by bike / by car.', null, 0),
  ('B', 'They didn''t come in their car. They came in a taxi.', null, 1),
  ('B', 'We travelled on the 6.45 train, which arrived at 8.30.', null, 2),
  ('B', 'Did you come here by car or on foot?', null, 3),
  ('B', 'Can I pay by credit card?', null, 4),
  ('C', 'Have you ever been bitten by a dog?', null, 0),
  ('C', 'The door must have been opened with a key.', 'not by a key', 1),
  ('C', 'Have you read any poems by Shakespeare?', null, 2),
  ('D', 'The light switch is by the door.', null, 0),
  ('D', 'Come and sit by me.', '= next to me', 1),
  ('E', 'Clare''s salary has increased by ten per cent.', null, 0),
  ('E', 'Carl won the race by five metres.', null, 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 128.1-128.5; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '128.1', 'Complete the sentences. Choose from the box: by mistake, by hand, by chance, by email, on purpose.', 0
from units where slug = 'unit-128';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-128' where es.title = '128.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Kate and James keep in touch with one another mainly {0}.', null),
  (2, 'I didn''t intend to take your umbrella. I took it {0}.', null),
  (3, 'I think he arrived late {0}. He wanted to keep us waiting.', null),
  (4, 'Some things are planned. Other things happen {0}.', null),
  (5, 'Don''t put my sweater in the washing machine. It has to be washed {0}.', null)
) as v(n, template, hint)
where es.title = '128.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '128.1'
join (values
  (1, 'by email'), (2, 'by mistake'), (3, 'on purpose'), (4, 'by chance'), (5, 'by hand')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '128.2', 'Put in by, in or on.', 1
from units where slug = 'unit-128';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-128' where es.title = '128.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I saw Jane this morning. She was {0} the bus.', null),
  (2, 'How did you get here? Did you come {0} train?', null),
  (3, 'I couldn''t find a seat {0} the train. It was full.', null),
  (4, 'How much will it cost to the airport {0} taxi?', null),
  (5, 'Did you come here {0} Sarah''s car or yours?', null),
  (6, 'The injured man was taken to hospital {0} ambulance.', null),
  (7, 'How long does it take to cross the Atlantic {0} ship?', null),
  (8, 'He doesn''t drive much. He goes everywhere {0} bike or {1} foot.', null)
) as v(n, template, hint)
where es.title = '128.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '128.2'
join (values
  (1, 0, 'on'), (2, 0, 'by'), (3, 0, 'on'), (4, 0, 'by'), (5, 0, 'in'),
  (6, 0, 'by'), (7, 0, 'by'), (8, 0, 'by'), (8, 1, 'on')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '128.3', 'Complete these sentences about books, paintings etc. Choose from the box: by mosquitoes, by one of our players, by lightning, by Beethoven, by Leonardo da Vinci, by a professional photographer.', 2
from units where slug = 'unit-128';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-128' where es.title = '128.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'These pictures were taken {0}.', null),
  (2, 'I hate getting bitten {0}.', null),
  (3, '''Mona Lisa'' is a famous painting {0}.', null),
  (4, 'We lost the game because of a mistake {0}.', null),
  (5, 'The plane was damaged {0}, but landed safely.', null),
  (6, 'This music is {0}, but I can''t remember what it''s called.', null)
) as v(n, template, hint)
where es.title = '128.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '128.3'
join (values
  (1, 'by a professional photographer'), (2, 'by mosquitoes'), (3, 'by Leonardo da Vinci'),
  (4, 'by one of our players'), (5, 'by lightning'), (6, 'by Beethoven')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '128.4', 'Put in by, in, on or with.', 3
from units where slug = 'unit-128';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-128' where es.title = '128.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We managed to put the fire out {0} a fire extinguisher.', null),
  (2, 'Who''s that man standing {0} the window?', null),
  (3, 'Do you travel much {0} bus?', null),
  (4, 'We travelled {0} my friend''s car because it is larger and more comfortable than mine.', null),
  (5, 'It was only {0} accident that I discovered the error.', null),
  (6, 'These pictures were taken {0} a very good camera.', null),
  (7, 'My friends live in a beautiful house {0} the sea.', null),
  (8, 'There were only a few people {0} the plane. It was almost empty.', null),
  (9, 'The new railway line will reduce the journey time {0} two hours (from five hours to three).', null),
  (10, 'There was a small table {0} the bed {1} a lamp and a clock {2} it.', null)
) as v(n, template, hint)
where es.title = '128.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '128.4'
join (values
  (1, 0, 'with'), (2, 0, 'by'), (3, 0, 'by'), (4, 0, 'in'), (5, 0, 'by'),
  (6, 0, 'with'), (7, 0, 'by'), (8, 0, 'on'), (9, 0, 'by'),
  (10, 0, 'by'), (10, 1, 'with'), (10, 2, 'on')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '128.5', 'Complete the sentences using by.', 4
from units where slug = 'unit-128';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-128' where es.title = '128.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Ten years ago the population of the country was 50 million. Now it is 56 million. In the last ten years the population has {0}', null),
  (2, 'There was an election. Helen won. She got 25 votes and James got 23. Helen won {0}', null),
  (3, 'I went to Kate''s office to see her, but she had left work five minutes before I arrived. I missed {0}', null)
) as v(n, template, hint)
where es.title = '128.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '128.5'
join (values
  (1, 'gone up by 6 million.', array['increased by 6 million.', 'grown by 6 million.', 'risen by 6 million.']::text[]),
  (2, 'by two votes.', array[]::text[]),
  (3, 'her by five minutes.', array['Kate by five minutes.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
