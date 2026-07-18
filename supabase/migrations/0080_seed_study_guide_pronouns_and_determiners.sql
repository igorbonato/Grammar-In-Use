-- Study guide — group 11: Pronouns and determiners (questions 11.1-11.12).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.1', 'What time shall we {0} tomorrow?', array[82], 0
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'meet', true, 0),
  ('B', 'meet us', false, 1),
  ('C', 'meet ourselves', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.1' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.2', 'I''m going to a wedding on Saturday. {0} is getting married.', array[83], 1
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'A friend of me', false, 0),
  ('B', 'A friend of mine', true, 1),
  ('C', 'One my friends', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.2' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.3', 'They live on a busy road. {0} a lot of noise from the traffic.', array[84], 2
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'It must be', false, 0),
  ('B', 'It must have', false, 1),
  ('C', 'There must have', false, 2),
  ('D', 'There must be', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.3' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.4', 'He''s lazy. He never does {0} work.', array[85], 3
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'some', false, 0),
  ('B', 'any', true, 1),
  ('C', 'no', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.4' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.5', '''What would you like to eat?'' ''I don''t mind. {0} — whatever you have.''', array[85], 4
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Something', false, 0),
  ('B', 'Anything', true, 1),
  ('C', 'Nothing', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.5' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.6', 'The course didn''t go well. {0} of the students were happy.', array[86], 5
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'All', false, 0),
  ('B', 'No-one', false, 1),
  ('C', 'None', true, 2),
  ('D', 'Nobody', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.6' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.7', 'We went shopping and spent {0} money.', array[87], 6
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'a lot of', true, 0),
  ('B', 'much', false, 1),
  ('C', 'lots of', true, 2),
  ('D', 'many', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.7' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.8', 'I was ill yesterday. I spent {0} in bed.', array[88], 7
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'the most of day', false, 0),
  ('B', 'most of day', false, 1),
  ('C', 'the most of the day', false, 2),
  ('D', 'most of the day', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.8' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.9', 'I asked two people how to get to the station, but {0} of them knew.', array[89], 8
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'none', false, 0),
  ('B', 'either', false, 1),
  ('C', 'both', false, 2),
  ('D', 'neither', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.9' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.10', 'Our holiday was a disaster. {0} went wrong.', array[90], 9
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Everything', true, 0),
  ('B', 'All', false, 1),
  ('C', 'All things', false, 2),
  ('D', 'All of things', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.10' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.11', 'The bus service is excellent. There''s a bus {0} ten minutes.', array[90, 91], 10
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'each', false, 0),
  ('B', 'every', true, 1),
  ('C', 'all', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.11' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '11.12', 'There were four books on the table. {0} a different colour.', array[91], 11
from modules where slug = 'pronouns-and-determiners';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Each of books was', false, 0),
  ('B', 'Each of the books was', true, 1),
  ('C', 'Each book was', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '11.12' and q.module_id = (select id from modules where slug = 'pronouns-and-determiners');
