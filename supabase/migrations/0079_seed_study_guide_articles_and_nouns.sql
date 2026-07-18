-- Study guide — group 10: Articles and nouns (questions 10.1-10.14).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.1', 'It wasn''t your fault. It was {0}.', array[69], 0
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'accident', false, 0),
  ('B', 'an accident', true, 1),
  ('C', 'some accident', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.1' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.2', 'Where are you going to put all your {0}?', array[70], 1
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'furniture', true, 0),
  ('B', 'furnitures', false, 1)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.2' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.3', '''Where are you going?'' ''I''m going to buy {0}.''', array[70], 2
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'a bread', false, 0),
  ('B', 'some bread', true, 1),
  ('C', 'a loaf of bread', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.3' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.4', 'Sandra is {0}. She works at a large hospital.', array[71, 72], 3
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'nurse', false, 0),
  ('B', 'a nurse', true, 1),
  ('C', 'the nurse', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.4' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.5', 'Helen works six days {0} week.', array[72], 4
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'in', false, 0),
  ('B', 'for', false, 1),
  ('C', 'a', true, 2),
  ('D', 'the', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.5' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.6', 'There are millions of stars in {0}.', array[73], 5
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'space', true, 0),
  ('B', 'a space', false, 1),
  ('C', 'the space', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.6' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.7', 'Every day {0} starts at 9 and finishes at 3.', array[74], 6
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'school', true, 0),
  ('B', 'a school', false, 1),
  ('C', 'the school', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.7' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.8', '{0} changed a lot in the last thirty years.', array[75], 7
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Life has', true, 0),
  ('B', 'The life has', false, 1),
  ('C', 'The lives have', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.8' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.9', 'When {0} invented?', array[76], 8
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'was camera', false, 0),
  ('B', 'were cameras', false, 1),
  ('C', 'were the cameras', false, 2),
  ('D', 'was the camera', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.9' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.10', 'Have you been to {0}?', array[77], 9
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Canada or United States', false, 0),
  ('B', 'the Canada or the United States', false, 1),
  ('C', 'Canada or the United States', true, 2),
  ('D', 'the Canada or United States', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.10' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.11', 'On our first day in Moscow, we visited {0}.', array[78], 10
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Kremlin', false, 0),
  ('B', 'a Kremlin', false, 1),
  ('C', 'the Kremlin', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.11' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.12', 'I have some news for you. {0}.', array[79, 70], 11
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'It''s good news', true, 0),
  ('B', 'They are good news', false, 1),
  ('C', 'It''s a good news', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.12' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.13', 'It took us quite a long time to get here. It was {0} journey.', array[80], 12
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'three hour', false, 0),
  ('B', 'a three-hours', false, 1),
  ('C', 'a three-hour', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.13' and q.module_id = (select id from modules where slug = 'articles-and-nouns');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '10.14', 'This isn''t my book. It''s {0}.', array[81], 13
from modules where slug = 'articles-and-nouns';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'my sister', false, 0),
  ('B', 'my sister''s', true, 1),
  ('C', 'from my sister', false, 2),
  ('D', 'of my sister', false, 3),
  ('E', 'of my sister''s', false, 4)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '10.14' and q.module_id = (select id from modules where slug = 'articles-and-nouns');
