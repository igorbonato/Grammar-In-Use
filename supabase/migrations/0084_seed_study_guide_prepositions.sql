-- Study guide — group 15: Prepositions (questions 15.1-15.17).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.1', 'Bye! I''ll see you {0}.', array[121], 0
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'at Friday morning', false, 0),
  ('B', 'on Friday morning', true, 1),
  ('C', 'in Friday morning', false, 2),
  ('D', 'Friday morning', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.1' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.2', 'I''m going away {0} the end of January.', array[122], 1
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'at', true, 0),
  ('B', 'on', false, 1),
  ('C', 'in', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.2' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.3', 'When we were in Italy, we spent a few days {0} Venice.', array[123, 125], 2
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'at', false, 0),
  ('B', 'to', false, 1),
  ('C', 'in', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.3' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.4', 'Our apartment is {0} the second floor of the building.', array[124], 3
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'at', false, 0),
  ('B', 'on', true, 1),
  ('C', 'in', false, 2),
  ('D', 'to', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.4' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.5', 'I saw Steve {0} a conference on Saturday.', array[125], 4
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'at', true, 0),
  ('B', 'on', false, 1),
  ('C', 'in', false, 2),
  ('D', 'to', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.5' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.6', 'What time did you {0} the hotel?', array[126], 5
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'arrive to', false, 0),
  ('B', 'arrive at', true, 1),
  ('C', 'arrive in', false, 2),
  ('D', 'get to', true, 3),
  ('E', 'get in', false, 4)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.6' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.7', 'I''m going {0} holiday next week. I''ll be away for two weeks.', array[127], 6
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'at', false, 0),
  ('B', 'on', true, 1),
  ('C', 'in', false, 2),
  ('D', 'for', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.7' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.8', 'We travelled {0} 6.45 train, which arrived at 8.30.', array[128], 7
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'in the', false, 0),
  ('B', 'on the', true, 1),
  ('C', 'by the', false, 2),
  ('D', 'by', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.8' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.9', '''Who is this painting {0}? Picasso?'' ''I have no idea.''', array[128], 8
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'of', false, 0),
  ('B', 'from', false, 1),
  ('C', 'by', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.9' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.10', 'The accident was my fault, so I had to pay for the damage {0} the other car.', array[129], 9
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'of', false, 0),
  ('B', 'for', false, 1),
  ('C', 'to', true, 2),
  ('D', 'on', false, 3),
  ('E', 'at', false, 4)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.10' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.11', 'I like them very much. They have always been very nice {0} me.', array[130], 10
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'of', false, 0),
  ('B', 'for', false, 1),
  ('C', 'to', true, 2),
  ('D', 'with', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.11' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.12', 'I''m not very good {0} repairing things.', array[131], 11
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'at', true, 0),
  ('B', 'for', false, 1),
  ('C', 'in', false, 2),
  ('D', 'about', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.12' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.13', 'I don''t understand this sentence. Can you {0}?', array[132], 12
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'explain to me this word', false, 0),
  ('B', 'explain me this word', false, 1),
  ('C', 'explain this word to me', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.13' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.14', 'If you''re worried about the problem, you should do something {0} it.', array[133], 13
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'for', false, 0),
  ('B', 'about', true, 1),
  ('C', 'against', false, 2),
  ('D', 'with', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.14' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.15', '''Who is Tom Hart?'' ''I have no idea. I''ve never heard {0} him.''', array[134], 14
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'about', false, 0),
  ('B', 'from', false, 1),
  ('C', 'after', false, 2),
  ('D', 'of', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.15' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.16', 'I don''t know what time we''ll arrive. It depends {0} the traffic.', array[135], 15
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'of', false, 0),
  ('B', 'for', false, 1),
  ('C', 'from', false, 2),
  ('D', 'on', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.16' and q.module_id = (select id from modules where slug = 'prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '15.17', 'I prefer tea {0} coffee.', array[136, 59], 16
from modules where slug = 'prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'to', true, 0),
  ('B', 'than', false, 1),
  ('C', 'against', false, 2),
  ('D', 'over', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '15.17' and q.module_id = (select id from modules where slug = 'prepositions');
