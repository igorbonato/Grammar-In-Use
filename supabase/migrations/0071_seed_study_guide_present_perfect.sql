-- Study guide — group 2: Present perfect and past (questions 2.1-2.16).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.1', 'James is on holiday. He {0} to Italy.', array[7], 0
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'is gone', false, 0),
  ('B', 'has gone', true, 1),
  ('C', 'has been', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.1' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.2', 'Everything is going well. There {0} any problems so far.', array[8], 1
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'weren''t', false, 0),
  ('B', 'have been', false, 1),
  ('C', 'haven''t been', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.2' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.3', 'Sarah has lost her passport again. This is the second time this {0}.', array[8], 2
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'has happened', true, 0),
  ('B', 'happens', false, 1),
  ('C', 'happened', false, 2),
  ('D', 'is happening', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.3' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.4', 'Why are you out of breath? {0}?', array[9], 3
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Are you running', false, 0),
  ('B', 'Have you run', false, 1),
  ('C', 'Have you been running', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.4' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.5', 'Where''s the book I gave you? What {0} with it?', array[10], 4
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'have you done', true, 0),
  ('B', 'have you been doing', false, 1),
  ('C', 'are you doing', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.5' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.6', '''How long {0} Jane?'' ''A long time. Since we were at school.''', array[11, 10], 5
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'do you know', false, 0),
  ('B', 'have you known', true, 1),
  ('C', 'have you been knowing', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.6' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.7', 'Sally has been working here {0}.', array[12], 6
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'for six months', true, 0),
  ('B', 'since six months', false, 1),
  ('C', 'six months ago', false, 2),
  ('D', 'six months', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.7' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.8', 'It''s two years {0} Joe.', array[12], 7
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'that I don''t see', false, 0),
  ('B', 'that I haven''t seen', false, 1),
  ('C', 'since I didn''t see', false, 2),
  ('D', 'since I last saw', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.8' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.9', 'It {0} raining for a while, but now it''s raining again.', array[13], 8
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'stopped', true, 0),
  ('B', 'has stopped', false, 1),
  ('C', 'was stopped', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.9' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.10', 'My mother {0} in Italy.', array[13], 9
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'grew up', true, 0),
  ('B', 'has grown up', false, 1),
  ('C', 'had grown up', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.10' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.11', '{0} a lot of sweets when you were a child?', array[14], 10
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Have you eaten', false, 0),
  ('B', 'Had you eaten', false, 1),
  ('C', 'Did you eat', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.11' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.12', 'Jack {0} in New York for ten years. Now he lives in Los Angeles.', array[14, 11], 11
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'lived', true, 0),
  ('B', 'has lived', false, 1),
  ('C', 'has been living', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.12' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.13', 'The people sitting next to me on the plane were nervous. {0} before.', array[15], 12
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'They haven''t flown', false, 0),
  ('B', 'They didn''t fly', false, 1),
  ('C', 'They hadn''t flown', true, 2),
  ('D', 'They''d never flown', true, 3),
  ('E', 'They weren''t flying', false, 4)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.13' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.14', 'Katherine was lying on the sofa. She was tired because {0} very hard.', array[16], 13
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'she was working', false, 0),
  ('B', 'she''s been working', false, 1),
  ('C', 'she''d been working', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.14' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.15', '{0} a car when you were living in Paris?', array[17, 14], 14
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Had you', false, 0),
  ('B', 'Were you having', false, 1),
  ('C', 'Have you had', false, 2),
  ('D', 'Did you have', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.15' and q.module_id = (select id from modules where slug = 'present-perfect');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '2.16', 'I {0} tennis a lot, but I don''t play very much now.', array[18], 15
from modules where slug = 'present-perfect';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'was playing', false, 0),
  ('B', 'was used to play', false, 1),
  ('C', 'used to play', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '2.16' and q.module_id = (select id from modules where slug = 'present-perfect');
