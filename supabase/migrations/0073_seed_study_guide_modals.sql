-- Study guide — group 4: Modals (questions 4.1-4.13).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.1', 'The fire spread quickly, but everybody {0} from the building.', array[26], 0
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'was able to escape', true, 0),
  ('B', 'managed to escape', true, 1),
  ('C', 'could escape', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.1' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.2', 'I''m so tired I {0} for a week.', array[27], 1
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'can sleep', false, 0),
  ('B', 'could sleep', true, 1),
  ('C', 'could have slept', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.2' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.3', 'The story {0} be true, but I don''t think it is.', array[27, 29], 2
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'might', true, 0),
  ('B', 'can', false, 1),
  ('C', 'could', true, 2),
  ('D', 'may', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.3' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.4', 'Why did you stay at a hotel? You {0} with me.', array[27], 3
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'can stay', false, 0),
  ('B', 'could stay', false, 1),
  ('C', 'could have stayed', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.4' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.5', 'I lost one of my gloves. I {0} it somewhere.', array[28], 4
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'must drop', false, 0),
  ('B', 'must have dropped', true, 1),
  ('C', 'must be dropping', false, 2),
  ('D', 'must have been dropping', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.5' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.6', '''Why wasn''t Amy at the meeting yesterday?'' ''She {0} about it.''', array[29], 5
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'might not know', false, 0),
  ('B', 'may not know', false, 1),
  ('C', 'might not have known', true, 2),
  ('D', 'may not have known', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.6' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.7', 'What {0} to get a new driving licence?', array[31], 6
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'have I to do', false, 0),
  ('B', 'do I have to do', true, 1),
  ('C', 'I must do', false, 2),
  ('D', 'I have to', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.7' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.8', 'We have plenty of time. We {0} hurry.', array[32], 7
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'don''t need to', true, 0),
  ('B', 'mustn''t', false, 1),
  ('C', 'needn''t', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.8' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.9', 'You missed a great party last night. You {0}. Why didn''t you?', array[33], 8
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'must have come', false, 0),
  ('B', 'should have come', true, 1),
  ('C', 'ought to have come', true, 2),
  ('D', 'had to come', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.9' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.10', 'Jane won the lottery. I suggested {0} a car with the money she won.', array[34], 9
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'that she buy', true, 0),
  ('B', 'that she should buy', true, 1),
  ('C', 'her to buy', false, 2),
  ('D', 'that she bought', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.10' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.11', 'You''re always at home. You {0} out more often.', array[35], 10
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'should go', true, 0),
  ('B', 'had better go', false, 1),
  ('C', 'had better to go', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.11' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.12', 'It''s late. It''s time {0} home.', array[35], 11
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'we go', false, 0),
  ('B', 'we must go', false, 1),
  ('C', 'we should go', false, 2),
  ('D', 'we went', true, 3),
  ('E', 'to go', true, 4)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.12' and q.module_id = (select id from modules where slug = 'modals');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '4.13', '{0} a little longer, but I really have to go now.', array[36], 12
from modules where slug = 'modals';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I''d stay', true, 0),
  ('B', 'I''ll stay', false, 1),
  ('C', 'I can stay', false, 2),
  ('D', 'I''d have stayed', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '4.13' and q.module_id = (select id from modules where slug = 'modals');
