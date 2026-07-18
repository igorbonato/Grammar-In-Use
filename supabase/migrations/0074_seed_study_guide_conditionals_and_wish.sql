-- Study guide — group 5: Conditionals and wish (questions 5.1-5.5).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'conditionals-and-wish');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '5.1', 'I''m not tired enough to go to bed. If I {0} to bed now, I wouldn''t sleep.', array[38, 39], 0
from modules where slug = 'conditionals-and-wish';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'go', false, 0),
  ('B', 'went', true, 1),
  ('C', 'had gone', false, 2),
  ('D', 'would go', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '5.1' and q.module_id = (select id from modules where slug = 'conditionals-and-wish');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '5.2', 'If I were rich, {0} a lot.', array[39], 1
from modules where slug = 'conditionals-and-wish';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I''ll travel', false, 0),
  ('B', 'I can travel', false, 1),
  ('C', 'I would travel', true, 2),
  ('D', 'I travelled', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '5.2' and q.module_id = (select id from modules where slug = 'conditionals-and-wish');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '5.3', 'I wish I {0} have to work tomorrow, but unfortunately I do.', array[39, 41], 2
from modules where slug = 'conditionals-and-wish';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'don''t', false, 0),
  ('B', 'didn''t', true, 1),
  ('C', 'wouldn''t', false, 2),
  ('D', 'won''t', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '5.3' and q.module_id = (select id from modules where slug = 'conditionals-and-wish');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '5.4', 'The view was wonderful. I would have taken some pictures if {0} a camera with me.', array[40], 3
from modules where slug = 'conditionals-and-wish';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I had', false, 0),
  ('B', 'I would have', false, 1),
  ('C', 'I would have had', false, 2),
  ('D', 'I''d had', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '5.4' and q.module_id = (select id from modules where slug = 'conditionals-and-wish');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '5.5', 'The weather is horrible. I wish it {0} raining.', array[41], 4
from modules where slug = 'conditionals-and-wish';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'would stop', true, 0),
  ('B', 'stopped', false, 1),
  ('C', 'stops', false, 2),
  ('D', 'will stop', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '5.5' and q.module_id = (select id from modules where slug = 'conditionals-and-wish');
