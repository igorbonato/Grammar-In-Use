-- Study guide — group 3: Future (questions 3.1-3.7).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'future');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '3.1', 'I''m tired. {0} to bed now. Goodnight.', array[19], 0
from modules where slug = 'future';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I go', false, 0),
  ('B', 'I''m going', true, 1)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '3.1' and q.module_id = (select id from modules where slug = 'future');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '3.2', '{0} tomorrow, so we can go out somewhere.', array[19, 21], 1
from modules where slug = 'future';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I''m not working', true, 0),
  ('B', 'I don''t work', false, 1),
  ('C', 'I won''t work', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '3.2' and q.module_id = (select id from modules where slug = 'future');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '3.3', 'That bag looks heavy. {0} you with it.', array[21], 2
from modules where slug = 'future';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I''m helping', false, 0),
  ('B', 'I help', false, 1),
  ('C', 'I''ll help', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '3.3' and q.module_id = (select id from modules where slug = 'future');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '3.4', 'I think the weather {0} nice later.', array[23, 22], 3
from modules where slug = 'future';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'will be', true, 0),
  ('B', 'is', false, 1),
  ('C', 'is going to be', true, 2),
  ('D', 'shall be', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '3.4' and q.module_id = (select id from modules where slug = 'future');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '3.5', '''Anna is in hospital.'' ''Yes, I know. {0} her this evening.''', array[23, 20], 4
from modules where slug = 'future';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I visit', false, 0),
  ('B', 'I''m going to visit', true, 1),
  ('C', 'I''ll visit', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '3.5' and q.module_id = (select id from modules where slug = 'future');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '3.6', 'We''re late. The film {0} by the time we get to the cinema.', array[24], 5
from modules where slug = 'future';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'will already start', false, 0),
  ('B', 'will be already started', false, 1),
  ('C', 'will already have started', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '3.6' and q.module_id = (select id from modules where slug = 'future');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '3.7', 'Don''t worry {0} late tonight.', array[25], 6
from modules where slug = 'future';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'if I''m', true, 0),
  ('B', 'when I''m', false, 1),
  ('C', 'when I''ll be', false, 2),
  ('D', 'if I''ll be', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '3.7' and q.module_id = (select id from modules where slug = 'future');
