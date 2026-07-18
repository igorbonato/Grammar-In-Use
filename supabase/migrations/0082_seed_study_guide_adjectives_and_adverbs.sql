-- Study guide — group 13: Adjectives and adverbs (questions 13.1-13.15).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.1', 'Jane doesn''t enjoy her job any more. She''s {0} because every day she does exactly the same thing.', array[98], 0
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'boring', false, 0),
  ('B', 'bored', true, 1)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.1' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.2', 'Lisa was carrying a {0} bag.', array[99], 1
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'black small plastic', false, 0),
  ('B', 'small and black plastic', false, 1),
  ('C', 'small black plastic', true, 2),
  ('D', 'plastic small black', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.2' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.3', 'Maria''s English is excellent. She speaks {0}.', array[100], 2
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'perfectly English', false, 0),
  ('B', 'English perfectly', true, 1),
  ('C', 'perfect English', true, 2),
  ('D', 'English perfect', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.3' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.4', 'He {0} to find a job, but he had no luck.', array[101], 3
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'tried hard', true, 0),
  ('B', 'tried hardly', false, 1),
  ('C', 'hardly tried', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.4' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.5', 'I haven''t seen her for {0}, I''ve forgotten what she looks like.', array[102], 4
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'so long', true, 0),
  ('B', 'so long time', false, 1),
  ('C', 'a such long time', false, 2),
  ('D', 'such a long time', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.5' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.6', 'Don''t stand on that chair. It isn''t {0}.', array[103], 5
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'enough strong to stand on', false, 0),
  ('B', 'strong enough to stand on it', false, 1),
  ('C', 'strong enough to stand on', true, 2),
  ('D', 'strong enough for stand on', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.6' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.7', 'Sarah is doing OK at the moment. She has {0}.', array[104], 6
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'a quite good job', false, 0),
  ('B', 'quite a good job', true, 1),
  ('C', 'a pretty good job', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.7' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.8', 'The exam was quite easy — {0} I expected.', array[105], 7
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'more easy that', false, 0),
  ('B', 'more easy than', false, 1),
  ('C', 'easier than', true, 2),
  ('D', 'easier as', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.8' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.9', 'The more expensive the hotel, {0}.', array[106], 8
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'the service will be better', false, 0),
  ('B', 'will be better the service', false, 1),
  ('C', 'the better the service', true, 2),
  ('D', 'better the service will be', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.9' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.10', 'Patrick is a fast runner. I can''t run as fast as {0}.', array[107], 9
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'he', false, 0),
  ('B', 'him', true, 1),
  ('C', 'he can', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.10' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.11', 'What''s {0} you''ve ever made?', array[108], 10
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'most important decision', false, 0),
  ('B', 'the more important decision', false, 1),
  ('C', 'the decision more important', false, 2),
  ('D', 'the most important decision', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.11' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.12', 'Ben likes walking. {0}.', array[109], 11
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Every morning he walks to work', true, 0),
  ('B', 'He walks to work every morning', true, 1),
  ('C', 'He walks every morning to work', false, 2),
  ('D', 'He every morning walks to work', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.12' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.13', 'Joe never phones me. {0}.', array[110], 12
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Always I have to phone him', false, 0),
  ('B', 'I always have to phone him', true, 1),
  ('C', 'I have always to phone him', false, 2),
  ('D', 'I have to phone always him', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.13' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.14', 'Lucy {0}. She left last month.', array[111], 13
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'still doesn''t work here', false, 0),
  ('B', 'doesn''t still work here', false, 1),
  ('C', 'no more works here', false, 2),
  ('D', 'doesn''t work here any more', true, 3),
  ('E', 'no longer works here', true, 4)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.14' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '13.15', '{0} she can''t drive, she has a car.', array[112, 113], 14
from modules where slug = 'adjectives-and-adverbs';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'Even', false, 0),
  ('B', 'Even when', false, 1),
  ('C', 'Even if', false, 2),
  ('D', 'Even though', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '13.15' and q.module_id = (select id from modules where slug = 'adjectives-and-adverbs');
