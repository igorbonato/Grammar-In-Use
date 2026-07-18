-- Marco 4 (slice 44): seeds the second slice of the "Prepositions" module
-- — unit 122 (on time and in time; at the end and in the end).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- Safe to re-run: unit 122 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 122: on time and in time at the end and in the end
-- ============================================================

delete from units where slug = 'unit-122';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 122, 'unit-122', 'on time and in time at the end and in the end', null,
  'on time = punctual, at the planned time; in time (for/to do something) = soon enough (opposite: too late). at the end (of something) = when it finishes (opposite: at the beginning) — we never say "in the end of ..."; in the end = finally, the eventual result of a situation (opposite: at first).', 1
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'on time and in time',
  'on time = punctual, not late. If something happens on time, it happens at the time that was planned: The 11.45 train left on time. (= it left at 11.45) Please be on time. Don''t be late. The conference was well-organised. Everything began and finished on time. in time (for something / to do something) = soon enough: Will you be home in time for dinner? (= soon enough for dinner) I sent Amy a birthday present. I hope it arrives in time. (= on or before her birthday) I''m in a hurry. I want to get home in time to watch the game on TV. The opposite of in time is too late: I got home too late to watch the game on TV. You can say just in time (= almost too late): We got to the station just in time for our train. A child ran into the road in front of the car, but I managed to stop just in time.', 0
from units where slug = 'unit-122';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'at the end and in the end',
  'at the end (of something) = at the time when something ends. For example: at the end of the month, at the end of January, at the end of the game, at the end of the film, at the end of the course, at the end of the concert. I''m going away at the end of January / at the end of the month. At the end of the concert, everyone applauded. The players shook hands at the end of the game. We do not say ''in the end of ...''. For example, we do not say ''in the end of January''. The opposite of at the end is at the beginning: I''m going away at the beginning of January. (not in the beginning) in the end = finally. We use in the end when we say what the final result of a situation was: We had a lot of problems with our car. We sold it in the end. (= finally we sold it) He got more and more angry. In the end he just walked out of the room. Alan couldn''t decide where to go for his holidays. He didn''t go anywhere in the end. (not at the end) The opposite of in the end is at first: At first we didn''t get on very well, but in the end we became good friends.', 1
from units where slug = 'unit-122';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-122'
join (values
  ('A', 'The 11.45 train left on time.', '= it left at 11.45', 0),
  ('A', 'Please be on time. Don''t be late.', null, 1),
  ('A', 'Will you be home in time for dinner?', '= soon enough for dinner', 2),
  ('A', 'I got home too late to watch the game on TV.', null, 3),
  ('A', 'We got to the station just in time for our train.', null, 4),
  ('B', 'I''m going away at the end of January.', null, 0),
  ('B', 'At the end of the concert, everyone applauded.', null, 1),
  ('B', 'I''m going away at the beginning of January.', 'not in the beginning', 2),
  ('B', 'We had a lot of problems with our car. We sold it in the end.', '= finally we sold it', 3),
  ('B', 'He got more and more angry. In the end he just walked out of the room.', null, 4),
  ('B', 'At first we didn''t get on very well, but in the end we became good friends.', null, 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 122.1-122.5; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '122.1', 'Complete the sentences with on time or in time.', 0
from units where slug = 'unit-122';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-122' where es.title = '122.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The film was supposed to start at 8.30, but it didn''t begin {0}.', null),
  (2, 'The train service isn''t very good. The trains are rarely {0}.', null),
  (3, 'We nearly missed our train. We got to the station just {0}.', null),
  (4, 'We want to start the meeting {0}, so please don''t be late.', null),
  (5, 'I''ve just washed this shirt. I want to wear it this evening, so I hope it will be dry {0}.', null),
  (6, 'I almost forgot that it was Joe''s birthday. Fortunately I remembered {0}.', null),
  (7, 'Why are you never {0}? You always keep everybody waiting.', null),
  (8, 'It is hoped that the new stadium will be ready {0} for the tournament later this year.', null)
) as v(n, template, hint)
where es.title = '122.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '122.1'
join (values
  (1, 'on time'), (2, 'on time'), (3, 'in time'), (4, 'on time'),
  (5, 'in time'), (6, 'in time'), (7, 'on time'), (8, 'in time')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '122.2', 'Read the situations and make sentences using just in time.', 1
from units where slug = 'unit-122';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-122' where es.title = '122.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You were walking home. Just after you got home, it started to rain very heavily. I {0}', '(get / home)'),
  (2, 'Your friend was going to sit on the chair you had just painted. You said, ''Don''t sit on that chair!'', so he didn''t. I {0}', '(stop / him)'),
  (3, 'You and a friend went to the cinema. You were late, and you thought you would miss the beginning of the film. But the film began just as you sat down in the cinema. We {0}', '(get / cinema / beginning / film)')
) as v(n, template, hint)
where es.title = '122.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '122.2'
join (values
  (1, 'got home just in time.', array[]::text[]),
  (2, 'stopped him just in time.', array[]::text[]),
  (3, 'got to the cinema just in time for the beginning of the film.', array['got to the cinema just in time to see the beginning of the film.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '122.3', 'Complete the sentences using at the end + the following: the course, the game, the interview, the month, the race.', 2
from units where slug = 'unit-122';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-122' where es.title = '122.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I get paid {0}.', null),
  (2, 'The students had a party {0}.', null),
  (3, 'Two of the runners collapsed {0}.', null),
  (4, 'I was surprised when I was offered the job {0}.', null)
) as v(n, template, hint)
where es.title = '122.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '122.3'
join (values
  (1, 'at the end of the month'), (2, 'at the end of the course'),
  (3, 'at the end of the race'), (4, 'at the end of the interview')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '122.4', 'Write sentences with in the end. Use the verb in brackets.', 3
from units where slug = 'unit-122';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-122' where es.title = '122.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Anna got more and more fed up with her job. {0}', '(resign)'),
  (2, 'I tried to learn Japanese, but I found it too difficult. {0}', '(give up)'),
  (3, 'We couldn''t decide whether to go to the party or not. {0}', '(not / go)')
) as v(n, template, hint)
where es.title = '122.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '122.4'
join (values
  (1, 'In the end she resigned.', array['She resigned in the end.', 'In the end she resigned from her job.']::text[]),
  (2, 'In the end I gave up.', array['I gave up in the end.', 'In the end I gave up trying to learn Japanese.']::text[]),
  (3, 'In the end we decided not to go.', array['In the end we didn''t go.', 'We decided not to go in the end.', 'We didn''t go in the end.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '122.5', 'Put in at or in.', 4
from units where slug = 'unit-122';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-122' where es.title = '122.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It took Gary a long time to find work. {0} the end he got a job as a bus driver.', null),
  (2, 'I couldn''t decide what to buy Amy for her birthday. I didn''t buy her anything {0} the end.', null),
  (3, 'I''m going away {0} the end of this week.', null),
  (4, 'We waited ages for a bus. {0} the end we had to get a taxi.', null),
  (5, '{0} the end of the lesson, all the students left the classroom.', null),
  (6, 'We had a few problems at first, but {0} the end everything was OK.', null),
  (7, 'You were in a difficult position. What did you do {0} the end?', null),
  (8, 'The journey took a very long time, but we got there {0} the end.', null),
  (9, 'Are you going away {0} the beginning of August or {1} the end?', null)
) as v(n, template, hint)
where es.title = '122.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '122.5'
join (values
  (1, 0, 'In'), (2, 0, 'in'), (3, 0, 'at'), (4, 0, 'In'), (5, 0, 'At'),
  (6, 0, 'in'), (7, 0, 'in'), (8, 0, 'in'), (9, 0, 'at'), (9, 1, 'at')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;
