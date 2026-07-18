-- Additional exercises 14-15: "Past, present and future" (Units 1-25).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 14 ("Use your own ideas...") looked open-ended by
-- instruction wording, but the Key gives one fixed grammar pattern
-- per item (same lesson as 47.2/51.3/59.1/Additional exercise 4) —
-- seeded normally, item 1 dropped as the book's own worked example.
-- Exercise 15 is Robert's one continuous 24-blank email — split into
-- one exercise_sentences row per paragraph (rather than one giant
-- row) for readability, same approach as exercise 7's dialogue.
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 14', 'Additional exercise 15') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 14', 'Use your own ideas to complete B''s sentences.', 0
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in (
  'unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10',
  'unit-11','unit-12','unit-13','unit-14','unit-15','unit-16','unit-17','unit-18','unit-19','unit-20',
  'unit-21','unit-22','unit-23','unit-24','unit-25'
)
where es.title = 'Additional exercise 14' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'a: Is that a new coat? b: No, I {0} it a long time.'),
  (2, 'a: Is that a new phone? b: Yes, I {0} it a few weeks ago.'),
  (3, 'a: I can''t talk to you right now. You can see I''m very busy. b: OK. I {0} back in about half an hour.'),
  (4, 'a: This is a nice restaurant. Do you come here often? b: No, it''s the first time I {0} here.'),
  (5, 'a: Do you do any sport? b: No, I {0} football, but I gave it up.'),
  (6, 'a: I''m sorry I''m late. b: That''s OK. I {0} long.'),
  (7, 'a: When you went to the US last year, was it your first visit? b: No, I {0} there twice before.'),
  (8, 'a: Do you have any plans for the weekend? b: Yes, I {0} to a party on Saturday night.'),
  (9, 'a: Do you know what Steve''s doing these days? b: No, I {0} him for ages.'),
  (10, 'a: Will you still be here by the time I get back? b: No, I {0} by then.')
) as v(n, template)
where es.title = 'Additional exercise 14';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 14' and es.kind = 'additional'
join (values
  (1, 'I''ve had', array['I have had']::text[]),
  (2, 'I bought', array['I got']::text[]),
  (3, 'I''ll come', array['I will come', 'I''ll be', 'I will be']::text[]),
  (4, 'I''ve been', array['I have been', 'I''ve eaten', 'I have eaten']::text[]),
  (5, 'I used to play', array[]::text[]),
  (6, 'I haven''t been waiting', array['I haven''t been here']::text[]),
  (7, 'I''d been', array['I had been', 'I was']::text[]),
  (8, 'I''m going', array['I am going']::text[]),
  (9, 'I haven''t seen', array['I haven''t heard from']::text[]),
  (10, 'I''ll have gone', array['I will have gone', 'I''ll have left', 'I will have left']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 15',
  'Robert is travelling in North America. He sends an email to a friend in Winnipeg (Canada). Put the verb into the most suitable form.', 1
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in (
  'unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10',
  'unit-11','unit-12','unit-13','unit-14','unit-15','unit-16','unit-17','unit-18','unit-19','unit-20',
  'unit-21','unit-22','unit-23','unit-24','unit-25'
)
where es.title = 'Additional exercise 15' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Hi. I''ve just arrived in Minneapolis. {0} for more than a month now, and {1} to think about coming home. Everything {2} so far {3} really interesting, and {4} some really kind people.'),
  (2, '{0} Kansas City a week ago. {1} there with Emily, the aunt of a friend from college. She was really helpful and hospitable and although {2} to stay only a couple of days, {3} staying more than a week.'),
  (3, '{0} the journey from Kansas City to here. {1} the Greyhound bus and {2} some really interesting people — everybody was really friendly.'),
  (4, 'So now I''m here, and {0} here for a few days before {1} up to Canada. I''m not sure exactly when {2} to Winnipeg — it depends what happens while {3} here. But {4} you know as soon as {5} myself.'),
  (5, '{0} with a family here — they''re friends of some people I know at home. Tomorrow {1} some people they know who {2} a house by a lake. It isn''t finished yet, but {3} interesting to see what it''s like.'),
  (6, 'Anyway, that''s all for now. {0} in touch again soon. Robert')
) as v(n, template)
where es.title = 'Additional exercise 15';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 15' and es.kind = 'additional'
join (values
  (1, 0, 'I''ve been travelling', array[]::text[]),
  (1, 1, 'I''m beginning', array[]::text[]),
  (1, 2, 'I''ve seen', array[]::text[]),
  (1, 3, 'has been', array[]::text[]),
  (1, 4, 'I''ve met', array[]::text[]),
  (2, 0, 'I left', array[]::text[]),
  (2, 1, 'I stayed', array['I was staying']::text[]),
  (2, 2, 'I''d planned', array['I was planning']::text[]),
  (2, 3, 'I ended up', array[]::text[]),
  (3, 0, 'I enjoyed', array[]::text[]),
  (3, 1, 'I took', array[]::text[]),
  (3, 2, 'met', array[]::text[]),
  (4, 0, 'I''m staying', array['I''m going to stay', 'I''ll be staying', 'I''ll stay']::text[]),
  (4, 1, 'I continue', array[]::text[]),
  (4, 2, 'I''ll get', array[]::text[]),
  (4, 3, 'I''m', array[]::text[]),
  (4, 4, 'I''ll let', array[]::text[]),
  (4, 5, 'I know', array[]::text[]),
  (5, 0, 'I''m staying', array[]::text[]),
  (5, 1, 'we''re going to visit', array['we''re visiting']::text[]),
  (5, 2, 'are building', array['have been building']::text[]),
  (5, 3, 'it will be', array[]::text[]),
  (6, 0, 'I''ll be', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
