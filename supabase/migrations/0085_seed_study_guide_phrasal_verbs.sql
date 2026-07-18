-- Study guide — group 16: Phrasal verbs (questions 16.1-16.9).
-- This is the LAST group in the Study guide, completing all 161
-- questions across all 16 module groups.
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.1', 'These shoes are uncomfortable. I''m going to {0}.', array[137], 0
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'take off', false, 0),
  ('B', 'take them off', true, 1),
  ('C', 'take off them', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.1' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.2', 'They were playing cards, so I {0}.', array[138], 1
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'joined in', true, 0),
  ('B', 'came in', false, 1),
  ('C', 'got in', false, 2),
  ('D', 'broke in', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.2' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.3', 'Nobody believed Paul at first, but he {0} to be right.', array[139], 2
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'worked out', false, 0),
  ('B', 'came out', false, 1),
  ('C', 'found out', false, 2),
  ('D', 'turned out', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.3' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.4', 'We can''t {0} making a decision. We have to decide now.', array[140], 3
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'put away', false, 0),
  ('B', 'put over', false, 1),
  ('C', 'put off', true, 2),
  ('D', 'put out', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.4' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.5', '''Have you finished painting the kitchen?'' ''Nearly. I''ll {0} tomorrow.''', array[141], 4
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'finish it up', false, 0),
  ('B', 'finish it over', false, 1),
  ('C', 'finish it off', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.5' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.6', 'You can always rely on Paul. He''ll never {0}.', array[142], 5
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'put you up', false, 0),
  ('B', 'let you down', true, 1),
  ('C', 'take you over', false, 2),
  ('D', 'see you off', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.6' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.7', 'Children under 16 {0} half the population of the city.', array[143], 6
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'make up', true, 0),
  ('B', 'put up', false, 1),
  ('C', 'take up', false, 2),
  ('D', 'bring up', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.7' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.8', 'I''m surprised to hear that Kate and Paul have {0}. They seemed very happy together.', array[144], 7
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'broken up', true, 0),
  ('B', 'ended up', false, 1),
  ('C', 'finished up', false, 2),
  ('D', 'split up', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.8' and q.module_id = (select id from modules where slug = 'phrasal-verbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '16.9', 'I parked in a no-parking zone, but I {0} it.', array[145], 8
from modules where slug = 'phrasal-verbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'came up with', false, 0),
  ('B', 'got away with', true, 1),
  ('C', 'made off with', false, 2),
  ('D', 'got on with', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '16.9' and q.module_id = (select id from modules where slug = 'phrasal-verbs');
