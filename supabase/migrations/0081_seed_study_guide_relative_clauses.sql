-- Study guide — group 12: Relative clauses (questions 12.1-12.6).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'relative-clauses');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '12.1', 'I don''t like stories {0} have unhappy endings.', array[92], 0
from modules where slug = 'relative-clauses';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'that', true, 0),
  ('B', 'they', false, 1),
  ('C', 'which', true, 2),
  ('D', 'who', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '12.1' and q.module_id = (select id from modules where slug = 'relative-clauses');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '12.2', 'I didn''t believe them at first, but in fact everything {0} was true.', array[93], 1
from modules where slug = 'relative-clauses';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'they said', true, 0),
  ('B', 'that they said', true, 1),
  ('C', 'what they said', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '12.2' and q.module_id = (select id from modules where slug = 'relative-clauses');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '12.3', 'We helped some people {0}.', array[94], 2
from modules where slug = 'relative-clauses';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'their car had broken down', false, 0),
  ('B', 'which car had broken down', false, 1),
  ('C', 'whose car had broken down', true, 2),
  ('D', 'that their car had broken down', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '12.3' and q.module_id = (select id from modules where slug = 'relative-clauses');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '12.4', 'Anna told me about her new job, {0} a lot.', array[95], 3
from modules where slug = 'relative-clauses';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'that she''s enjoying', false, 0),
  ('B', 'which she''s enjoying', true, 1),
  ('C', 'she''s enjoying', false, 2),
  ('D', 'she''s enjoying it', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '12.4' and q.module_id = (select id from modules where slug = 'relative-clauses');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '12.5', 'Sarah couldn''t meet us, {0} was a shame.', array[96], 4
from modules where slug = 'relative-clauses';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'that', false, 0),
  ('B', 'it', false, 1),
  ('C', 'what', false, 2),
  ('D', 'which', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '12.5' and q.module_id = (select id from modules where slug = 'relative-clauses');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '12.6', 'George showed me some pictures {0} by his father.', array[97, 92], 5
from modules where slug = 'relative-clauses';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'painting', false, 0),
  ('B', 'painted', true, 1),
  ('C', 'that were painted', true, 2),
  ('D', 'they were painted', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '12.6' and q.module_id = (select id from modules where slug = 'relative-clauses');
