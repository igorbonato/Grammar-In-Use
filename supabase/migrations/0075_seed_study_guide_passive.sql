-- Study guide — group 6: Passive (questions 6.1-6.7).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'passive');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '6.1', 'We {0} by a loud noise during the night.', array[42], 0
from modules where slug = 'passive';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'woke up', false, 0),
  ('B', 'are woken up', false, 1),
  ('C', 'were woken up', true, 2),
  ('D', 'were waking up', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '6.1' and q.module_id = (select id from modules where slug = 'passive');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '6.2', 'A new supermarket is going to {0} next year.', array[43], 1
from modules where slug = 'passive';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'build', false, 0),
  ('B', 'be built', true, 1),
  ('C', 'be building', false, 2),
  ('D', 'building', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '6.2' and q.module_id = (select id from modules where slug = 'passive');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '6.3', 'There''s somebody walking behind us. I think {0}.', array[43], 2
from modules where slug = 'passive';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'we are following', false, 0),
  ('B', 'we are being following', false, 1),
  ('C', 'we are followed', false, 2),
  ('D', 'we are being followed', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '6.3' and q.module_id = (select id from modules where slug = 'passive');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '6.4', '''Where {0}?'' ''In Chicago.''', array[44], 3
from modules where slug = 'passive';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'were you born', true, 0),
  ('B', 'are you born', false, 1),
  ('C', 'have you been born', false, 2),
  ('D', 'did you born', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '6.4' and q.module_id = (select id from modules where slug = 'passive');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '6.5', 'There was a fight, but nobody {0}.', array[44], 4
from modules where slug = 'passive';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'was hurt', true, 0),
  ('B', 'got hurt', true, 1),
  ('C', 'hurt', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '6.5' and q.module_id = (select id from modules where slug = 'passive');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '6.6', 'Jane {0} to phone me last night, but she didn''t.', array[45], 5
from modules where slug = 'passive';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'supposed', false, 0),
  ('B', 'is supposed', false, 1),
  ('C', 'was supposed', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '6.6' and q.module_id = (select id from modules where slug = 'passive');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '6.7', 'Where {0}? Which hairdresser did you go to?', array[46], 6
from modules where slug = 'passive';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'did you cut your hair', false, 0),
  ('B', 'have you cut your hair', false, 1),
  ('C', 'did you have cut your hair', false, 2),
  ('D', 'did you have your hair cut', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '6.7' and q.module_id = (select id from modules where slug = 'passive');
