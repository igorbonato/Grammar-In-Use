-- Study guide — group 7: Reported speech (questions 7.1-7.3).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'reported-speech');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '7.1', 'Paul left the room suddenly. He said he {0} to go.', array[48, 47], 0
from modules where slug = 'reported-speech';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'had', true, 0),
  ('B', 'has', false, 1),
  ('C', 'have', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '7.1' and q.module_id = (select id from modules where slug = 'reported-speech');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '7.2', '(You meet Joe in the street.) Joe, this is a surprise. Rachel said you {0} in hospital.', array[48, 47], 1
from modules where slug = 'reported-speech';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'are', false, 0),
  ('B', 'were', true, 1),
  ('C', 'was', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '7.2' and q.module_id = (select id from modules where slug = 'reported-speech');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '7.3', 'Anna {0} and left.', array[48], 2
from modules where slug = 'reported-speech';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'said goodbye to me', true, 0),
  ('B', 'said me goodbye', false, 1),
  ('C', 'told me goodbye', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '7.3' and q.module_id = (select id from modules where slug = 'reported-speech');
