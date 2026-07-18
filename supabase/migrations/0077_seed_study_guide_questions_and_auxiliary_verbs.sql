-- Study guide — group 8: Questions and auxiliary verbs (questions 8.1-8.5).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'questions-and-auxiliary-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '8.1', '''What time {0}?'' ''At 8.30.''', array[49], 0
from modules where slug = 'questions-and-auxiliary-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'starts the film', false, 0),
  ('B', 'does start the film', false, 1),
  ('C', 'does the film start', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '8.1' and q.module_id = (select id from modules where slug = 'questions-and-auxiliary-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '8.2', '''Do you know where {0}?'' ''No, he didn''t say.''', array[50], 1
from modules where slug = 'questions-and-auxiliary-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Tom has gone', true, 0),
  ('B', 'has Tom gone', false, 1),
  ('C', 'has gone Tom', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '8.2' and q.module_id = (select id from modules where slug = 'questions-and-auxiliary-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '8.3', 'The police officer stopped us and asked us where {0}.', array[50], 2
from modules where slug = 'questions-and-auxiliary-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'were we going', false, 0),
  ('B', 'are we going', false, 1),
  ('C', 'we are going', false, 2),
  ('D', 'we were going', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '8.3' and q.module_id = (select id from modules where slug = 'questions-and-auxiliary-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '8.4', '''Do you think it will rain?'' ''{0}.''', array[51], 3
from modules where slug = 'questions-and-auxiliary-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I hope not', true, 0),
  ('B', 'I don''t hope', false, 1),
  ('C', 'I don''t hope so', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '8.4' and q.module_id = (select id from modules where slug = 'questions-and-auxiliary-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '8.5', '''You don''t know where Karen is, {0}?'' ''Sorry, I have no idea.''', array[52], 4
from modules where slug = 'questions-and-auxiliary-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'don''t you', false, 0),
  ('B', 'do you', true, 1),
  ('C', 'is she', false, 2),
  ('D', 'are you', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '8.5' and q.module_id = (select id from modules where slug = 'questions-and-auxiliary-verbs');
