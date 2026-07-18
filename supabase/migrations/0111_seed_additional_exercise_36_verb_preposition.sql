-- Additional exercise 36: "Verb + preposition" (Units 132-136).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode). No worked
-- example — the Key starts at item 1, so all 20 items are seeded.
-- Reuses the empty-string "no preposition needed" convention for
-- items 3, 6, 10, 14 and the first gap of 18 and 20.
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 36' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 36', 'Complete each sentence with a preposition where necessary. If no preposition is necessary, leave the space empty.', 0
from units u where u.slug = 'unit-132';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-132','unit-133','unit-134','unit-135','unit-136')
where es.title = 'Additional exercise 36' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'She works quite hard. You can''t accuse her {0} being lazy.'),
  (2, 'Who''s going to look {0} your children while you''re at work?'),
  (3, 'The problem is becoming serious. We have to discuss {0} it.'),
  (4, 'The problem is becoming serious. We have to do something {0} it.'),
  (5, 'I prefer this chair {0} the other one. It''s more comfortable.'),
  (6, 'I need to call {0} the office to tell them I won''t be at work today.'),
  (7, 'The river divides the city {0} two parts.'),
  (8, '''What do you think {0} your new boss?'' ''She''s all right, I suppose.'''),
  (9, 'Can somebody please explain {0} me what I have to do?'),
  (10, 'I said hello to her, but she didn''t answer {0} me.'),
  (11, '''Do you like staying at hotels?'' ''It depends {0} the hotel.'''),
  (12, '''Have you ever been to Borla?'' ''No, I''ve never heard {0} it. Where is it?'''),
  (13, 'You remind me {0} somebody I knew a long time ago. You look just like her.'),
  (14, 'This is wonderful news! I can''t believe {0} it.'),
  (15, 'George is not an idealist — he believes {0} being practical.'),
  (16, 'What''s funny? What are you laughing {0}?'),
  (17, 'What did you do with all the money you had? What did you spend it {0}?'),
  (18, 'If Alex asks {0} you {1} money, don''t give him any.'),
  (19, 'I apologised {0} Sarah {1} keeping her waiting so long.'),
  (20, 'Lisa was very helpful. I thanked {0} her {1} everything she''d done.')
) as v(n, template)
where es.title = 'Additional exercise 36';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 36' and es.kind = 'additional'
join (values
  (1, 0, 'of', array[]::text[]),
  (2, 0, 'after', array[]::text[]),
  (3, 0, '', array[]::text[]),
  (4, 0, 'about', array[]::text[]),
  (5, 0, 'to', array[]::text[]),
  (6, 0, '', array[]::text[]),
  (7, 0, 'into', array[]::text[]),
  (8, 0, 'of', array['about']::text[]),
  (9, 0, 'to', array[]::text[]),
  (10, 0, '', array[]::text[]),
  (11, 0, 'on', array[]::text[]),
  (12, 0, 'of', array[]::text[]),
  (13, 0, 'of', array[]::text[]),
  (14, 0, '', array[]::text[]),
  (15, 0, 'in', array[]::text[]),
  (16, 0, 'at', array['about']::text[]),
  (17, 0, 'on', array[]::text[]),
  (18, 0, '', array[]::text[]), (18, 1, 'for', array[]::text[]),
  (19, 0, 'to', array[]::text[]), (19, 1, 'for', array[]::text[]),
  (20, 0, '', array[]::text[]), (20, 1, 'for', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
