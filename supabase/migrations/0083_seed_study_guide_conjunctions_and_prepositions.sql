-- Study guide — group 14: Conjunctions and prepositions (questions 14.1-14.8).
-- Same sourcing/validation approach as 0070 — see that file's header.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.1', 'I couldn''t sleep {0} very tired.', array[113], 0
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'although I was', true, 0),
  ('B', 'despite I was', false, 1),
  ('C', 'despite of being', false, 2),
  ('D', 'in spite of being', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.1' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.2', 'You should insure your bike {0} stolen.', array[114], 1
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'in case it will be', false, 0),
  ('B', 'if it will be', false, 1),
  ('C', 'in case it is', true, 2),
  ('D', 'if it is', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.2' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.3', 'The club is for members only. You {0} you''re a member.', array[115], 2
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'can''t go in if', false, 0),
  ('B', 'can go in only if', true, 1),
  ('C', 'can''t go in unless', true, 2),
  ('D', 'can go in unless', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.3' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.4', 'Yesterday we watched TV all evening {0} we didn''t have anything better to do.', array[116], 3
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'when', false, 0),
  ('B', 'as', true, 1),
  ('C', 'while', false, 2),
  ('D', 'since', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.4' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.5', '''What''s that noise?'' ''It sounds {0} a baby crying.''', array[117, 118], 4
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'as', false, 0),
  ('B', 'like', true, 1),
  ('C', 'as if', false, 2),
  ('D', 'as though', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.5' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.6', 'They are very kind to me. They treat me {0} their own son.', array[118], 5
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'like I''m', false, 0),
  ('B', 'as if I''m', false, 1),
  ('C', 'as if I was', true, 2),
  ('D', 'as if I were', true, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.6' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.7', 'I''m going to be in Moscow next week. I hope the weather will be good {0}.', array[119], 6
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'while I''ll be there', false, 0),
  ('B', 'while I''m there', true, 1),
  ('C', 'during my visit', true, 2),
  ('D', 'during I''m there', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.7' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '14.8', 'Joe is away at the moment. I don''t know exactly when he''s coming back, but I''m sure he''ll be back {0} Monday.', array[120], 7
from modules where slug = 'conjunctions-and-prepositions';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'by', true, 0),
  ('B', 'until', false, 1)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '14.8' and q.module_id = (select id from modules where slug = 'conjunctions-and-prepositions');
