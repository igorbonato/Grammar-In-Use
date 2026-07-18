-- Additional exercises 16-18: "Modal verbs (can/must/would etc.)" (Units 26-36, Appendix 4).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 16 ("Which alternatives are correct?") is lettered A/B/C
-- and several items accept two of the three letters as both correct
-- — modelled as correct_answer + accepted_alternatives, same as
-- every other "which is correct" exercise (the app's grading only
-- requires matching one accepted value, not selecting every correct
-- option, so this fits without any special-casing).
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 16', 'Additional exercise 17', 'Additional exercise 18') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 16',
  'Which alternatives are correct? Sometimes only one alternative is correct, and sometimes two of the alternatives are possible.', 0
from units u where u.slug = 'unit-26';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-26','unit-27','unit-28','unit-29','unit-30','unit-31','unit-32','unit-33','unit-34','unit-35','unit-36')
where es.title = 'Additional exercise 16' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'I can''t find the theatre tickets. They {0} out of my pocket.'),
  (2, 'Somebody ran in front of the car as I was driving. Luckily, I {0} just in time.'),
  (3, 'We have plenty of time. We {0} yet.'),
  (4, 'I didn''t go out yesterday. I {0} with my friends, but I didn''t feel like it.'),
  (5, 'I looked everywhere for Helen, but I {0} her.'),
  (6, '''What do you think of my theory?'' ''You {0} right, but I''m not sure.'''),
  (7, 'Our flight was delayed. We {0} for two hours.'),
  (8, 'I''m not sure whether I''ll be free on Saturday. I {0}.'),
  (9, 'At first they didn''t believe me when I told them what had happened, but in the end I {0} them that I was telling the truth.'),
  (10, 'I promised I''d call Amy this evening. I {0}.'),
  (11, 'Why did you leave without me? You {0} for me.'),
  (12, 'Lisa called me this morning. She suggested {0} lunch together.'),
  (13, 'That jacket looks good on you. {0} it more often.'),
  (14, 'Do you think I should buy a car? What {0} in my position?')
) as v(n, template)
where es.title = 'Additional exercise 16';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 16' and es.kind = 'additional'
join (values
  (1, 'must have fallen', array[]::text[]),
  (2, 'managed to stop', array[]::text[]),
  (3, 'don''t have to go', array['don''t need to go']::text[]),
  (4, 'could have gone', array[]::text[]),
  (5, 'couldn''t find', array['wasn''t able to find']::text[]),
  (6, 'could be', array['might be']::text[]),
  (7, 'had to wait', array[]::text[]),
  (8, 'may have to work', array['might have to work']::text[]),
  (9, 'was able to convince', array['managed to convince']::text[]),
  (10, 'mustn''t forget', array[]::text[]),
  (11, 'should have waited', array[]::text[]),
  (12, 'we have', array['we should have']::text[]),
  (13, 'You should wear', array['You ought to wear']::text[]),
  (14, 'would you do', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 17', 'Complete the sentences using the words in brackets.', 1
from units u where u.slug = 'unit-26';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-26','unit-27','unit-28','unit-29','unit-30','unit-31','unit-32','unit-33','unit-34','unit-35','unit-36')
where es.title = 'Additional exercise 17' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I ate too much and now I feel sick. I {0} so much.', '(shouldn''t / eat)'),
  (2, 'I wonder why Tom didn''t call me. He {0}.', '(must / forget)'),
  (3, 'Why did you go home so early? You {0} home so early.', '(needn''t / go)'),
  (4, 'You''ve signed the contract. It {0} now.', '(can''t / change)'),
  (5, 'I''m not sure where the children are. They {0} TV.', '(may / watch)'),
  (6, 'I saw Laura standing outside the cinema. She {0} for somebody.', '(must / wait)'),
  (7, 'He was in prison at the time that the crime was committed. He {0} it.', '(couldn''t / do)'),
  (8, 'Why are you so late? You {0} here an hour ago.', '(should / be)'),
  (9, 'Why didn''t you contact me? You {0} me.', '(could / phone)'),
  (10, 'I''m surprised you weren''t told that the road was dangerous. You {0} about it.', '(should / warn)'),
  (11, 'We had a great day at the beach yesterday. You {0} with us.', '(ought / come)')
) as v(n, template, hint)
where es.title = 'Additional exercise 17';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 17' and es.kind = 'additional'
join (values
  (1, 'shouldn''t have eaten'),
  (2, 'must have forgotten'),
  (3, 'needn''t have gone'),
  (4, 'can''t be changed'),
  (5, 'may be watching'),
  (6, 'must have been waiting'),
  (7, 'couldn''t have done'),
  (8, 'should have been'),
  (9, 'could have phoned'),
  (10, 'should have been warned'),
  (11, 'ought to have come')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 18',
  'Complete B''s sentences using can/could/might/must/should/would + the verb in brackets. In some sentences you need to use have: must have ... / should have ... etc. In some sentences you need the negative (can''t/couldn''t etc.).', 2
from units u where u.slug = 'unit-26';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-26','unit-27','unit-28','unit-29','unit-30','unit-31','unit-32','unit-33','unit-34','unit-35','unit-36')
where es.title = 'Additional exercise 18' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: What''s the weather like? Is it raining? b: Not at the moment, but it {0} later.', '(rain)'),
  (2, 'a: Where''s Julia? b: I''m not sure. She {0} out.', '(go)'),
  (3, 'a: I didn''t see you at Michael''s party last week. b: No, I had to work that night, so I {0}.', '(go)'),
  (4, 'a: I think I saw Ben in town this morning. b: No, you {0} him this morning. He''s away on holiday.', '(see)'),
  (5, 'a: What time will we get to Sue''s house? b: Well, it takes about one and a half hours, so if we leave at 3 o''clock, we {0} there by 4.30.', '(get)'),
  (6, 'a: When was the last time you saw Max? b: Years ago. I {0} him if I saw him now.', '(recognise)'),
  (7, 'a: Did you hear the explosion? b: What explosion? a: There was a loud explosion about an hour ago. You {0} it.', '(hear)'),
  (8, 'a: We weren''t sure which way to go. In the end we turned right. b: You went the wrong way. You {0} left.', '(turn)')
) as v(n, template, hint)
where es.title = 'Additional exercise 18';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 18' and es.kind = 'additional'
join (values
  (1, 'could rain', array['might rain']::text[]),
  (2, 'might have gone', array['could have gone']::text[]),
  (3, 'couldn''t go', array[]::text[]),
  (4, 'couldn''t have seen', array['can''t have seen']::text[]),
  (5, 'should get', array[]::text[]),
  (6, 'wouldn''t recognise', array['might not recognise']::text[]),
  (7, 'must have heard', array[]::text[]),
  (8, 'should have turned', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
