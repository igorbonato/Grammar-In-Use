-- Study guide — group 1: Present and past (questions 1.1-1.6).
--
-- Sourced from pdf/Study guide.pdf, extracted with `pdftotext -table`
-- (the two-column "sentence | STUDY UNIT" layout only lines up
-- correctly in table mode — plain -layout scrambles the STUDY UNIT
-- column onto the wrong row). Correct-option letters cross-checked
-- against pdf/Key to Study guide.pdf (plain mode).
--
-- Safe to re-run: this group deletes its own questions first
-- (cascades to their options) before re-inserting.

delete from study_guide_questions
where module_id = (select id from modules where slug = 'present-past');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '1.1', 'At first I didn''t like my job, but {0} to enjoy it now.', array[1, 3], 0
from modules where slug = 'present-past';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I''m starting', true, 0),
  ('B', 'I start', false, 1)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '1.1' and q.module_id = (select id from modules where slug = 'present-past');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '1.2', 'I don''t understand this sentence. What {0}?', array[2, 49], 1
from modules where slug = 'present-past';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'does mean this word', false, 0),
  ('B', 'does this word mean', true, 1),
  ('C', 'means this word', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '1.2' and q.module_id = (select id from modules where slug = 'present-past');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '1.3', 'Robert {0} away two or three times a year.', array[2, 3, 110], 2
from modules where slug = 'present-past';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'is going usually', false, 0),
  ('B', 'is usually going', false, 1),
  ('C', 'usually goes', true, 2),
  ('D', 'goes usually', false, 3)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '1.3' and q.module_id = (select id from modules where slug = 'present-past');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '1.4', 'How {0} now? Better than before?', array[4], 3
from modules where slug = 'present-past';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'you are feeling', false, 0),
  ('B', 'do you feel', true, 1),
  ('C', 'are you feeling', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '1.4' and q.module_id = (select id from modules where slug = 'present-past');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '1.5', 'It was a boring weekend. {0} anything.', array[5], 4
from modules where slug = 'present-past';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'I didn''t', false, 0),
  ('B', 'I don''t do', false, 1),
  ('C', 'I didn''t do', true, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '1.5' and q.module_id = (select id from modules where slug = 'present-past');

insert into study_guide_questions (module_id, question_number, template, study_units, order_index)
select id, '1.6', 'Matt {0} while we were having dinner.', array[6, 14], 5
from modules where slug = 'present-past';

insert into study_guide_options (question_id, letter, option_text, is_correct, order_index)
select q.id, v.letter, v.option_text, v.is_correct, v.order_index
from study_guide_questions q, (values
  ('A', 'phoned', true, 0),
  ('B', 'was phoning', false, 1),
  ('C', 'has phoned', false, 2)
) as v(letter, option_text, is_correct, order_index)
where q.question_number = '1.6' and q.module_id = (select id from modules where slug = 'present-past');
