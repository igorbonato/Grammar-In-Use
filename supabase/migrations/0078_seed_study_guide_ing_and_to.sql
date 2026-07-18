-- Study guide — group 9: -ing and to ... (questions 9.1-9.18).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.1', 'You can''t stop people {0} what they want.', array[53, 62], 0
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'doing', true, 0),
  ('B', 'do', false, 1),
  ('C', 'to do', false, 2),
  ('D', 'from doing', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.1' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.2', 'I''d better go now. I promised {0} late.', array[54, 36], 1
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'not being', false, 0),
  ('B', 'not to be', true, 1),
  ('C', 'to not be', false, 2),
  ('D', 'I wouldn''t be', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.2' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.3', 'Do you want {0} with you or do you want to go alone?', array[55], 2
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'me coming', false, 0),
  ('B', 'me to come', true, 1),
  ('C', 'that I come', false, 2),
  ('D', 'that I will come', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.3' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.4', 'I know I locked the door. I clearly remember {0} it.', array[56], 3
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'locking', true, 0),
  ('B', 'to lock', false, 1),
  ('C', 'to have locked', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.4' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.5', 'She tried to be serious, but she couldn''t help {0}.', array[57], 4
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'laughing', true, 0),
  ('B', 'to laugh', false, 1),
  ('C', 'that she laughed', false, 2),
  ('D', 'laugh', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.5' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.6', 'Paul lives in Berlin now. He likes {0} there.', array[58], 5
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'living', true, 0),
  ('B', 'to live', false, 1)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.6' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.7', 'It''s not my favourite job, but I like {0} the kitchen as often as possible.', array[58], 6
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'cleaning', false, 0),
  ('B', 'clean', false, 1),
  ('C', 'to clean', true, 2),
  ('D', 'that I clean', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.7' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.8', 'I''m tired. I''d rather {0} out this evening, if you don''t mind.', array[59], 7
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'not going', false, 0),
  ('B', 'not to go', false, 1),
  ('C', 'don''t go', false, 2),
  ('D', 'not go', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.8' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.9', 'I''d rather {0} anyone what I said.', array[59], 8
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'you don''t tell', false, 0),
  ('B', 'not you tell', false, 1),
  ('C', 'you didn''t tell', true, 2),
  ('D', 'you wouldn''t tell', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.9' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.10', 'Are you looking forward {0} on holiday?', array[60, 62], 9
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'going', false, 0),
  ('B', 'to go', false, 1),
  ('C', 'to going', true, 2),
  ('D', 'that you go', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.10' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.11', 'When Lisa first came to Britain, she wasn''t used {0} on the left.', array[61], 10
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'driving', false, 0),
  ('B', 'to driving', true, 1),
  ('C', 'to drive', false, 2),
  ('D', 'drive', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.11' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.12', 'I''m thinking {0} a house. Do you think that''s a good idea?', array[62, 66], 11
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'to buy', false, 0),
  ('B', 'of to buy', false, 1),
  ('C', 'of buying', true, 2),
  ('D', 'about buying', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.12' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.13', 'I had no trouble {0} a place to stay. In fact it was surprisingly easy.', array[63], 12
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'find', false, 0),
  ('B', 'found', false, 1),
  ('C', 'to find', false, 2),
  ('D', 'finding', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.13' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.14', 'I called the restaurant {0} a table.', array[64], 13
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'for reserve', false, 0),
  ('B', 'to reserve', true, 1),
  ('C', 'for reserving', false, 2),
  ('D', 'for to reserve', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.14' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.15', 'James doesn''t speak clearly. {0}.', array[65], 14
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'It is hard to understand him', true, 0),
  ('B', 'He is hard to understand', true, 1),
  ('C', 'He is hard to understand him', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.15' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.16', 'The path was icy, so we walked very carefully. We were afraid {0}.', array[66], 15
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'of falling', true, 0),
  ('B', 'from falling', false, 1),
  ('C', 'to fall', false, 2),
  ('D', 'to falling', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.16' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.17', 'I didn''t hear you {0} in. You must have been very quiet.', array[67], 16
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'come', true, 0),
  ('B', 'to come', false, 1),
  ('C', 'came', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.17' and q.module_id = (select id from modules where slug = 'ing-and-to');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '9.18', '{0} a hotel, we looked for somewhere to eat.', array[68], 17
from modules where slug = 'ing-and-to';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Finding', false, 0),
  ('B', 'After finding', true, 1),
  ('C', 'Having found', true, 2),
  ('D', 'We found', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '9.18' and q.module_id = (select id from modules where slug = 'ing-and-to');
