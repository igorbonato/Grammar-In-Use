-- Additional exercises 26-28: "-ing and to ..." (Units 53-66).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 27 ("Make sentences from the words in brackets") uses the
-- established "whole answer sentence" convention.
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 26', 'Additional exercise 27', 'Additional exercise 28') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 26', 'Put the verbs into the correct form.', 0
from units u where u.slug = 'unit-53';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-53','unit-54','unit-55','unit-56','unit-57','unit-58','unit-59','unit-60','unit-61','unit-62','unit-63','unit-64','unit-65','unit-66')
where es.title = 'Additional exercise 26' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I can''t make a decision. I keep {0} my mind.', '(change)'),
  (2, 'He had made his decision and refused {0} his mind.', '(change)'),
  (3, 'Why did you change your decision? What made you {0} your mind?', '(change)'),
  (4, 'It was a really good holiday. I really enjoyed {0} by the sea again.', '(be)'),
  (5, 'Did I really tell you I was unhappy? I don''t remember {0} that.', '(say)'),
  (6, '''Remember {0} Tom tomorrow.'' ''OK. I won''t forget.''', '(call)'),
  (7, 'The water here is not very good. I''d avoid {0} it if I were you.', '(drink)'),
  (8, 'I pretended {0} interested in the conversation, but really it was very boring.', '(be)'),
  (9, 'I got up and looked out of the window {0} what the weather was like.', '(see)'),
  (10, 'I don''t have far to go. It''s not worth {0} a taxi.', '(take)'),
  (11, 'I have a friend who claims {0} able to speak five languages.', '(be)'),
  (12, 'I like {0} carefully about things before {1} a decision.', '(think, make)'),
  (13, 'I had a flat in the centre of town but I didn''t like {0} there, so I decided {1}.', '(live, move)'),
  (14, 'Steve used {0} a footballer. He had to stop {1} because of an injury.', '(be, play)'),
  (15, 'After {0} by the police, the man admitted {1} the car but denied {2} at 100 miles an hour.', '(stop, steal, drive)'),
  (16, 'a: How do you make this machine {0}? b: I''m not sure. Try {1} that button and see what happens.', '(work) (press)')
) as v(n, template, hint)
where es.title = 'Additional exercise 26';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 26' and es.kind = 'additional'
join (values
  (1, 0, 'changing'), (2, 0, 'to change'), (3, 0, 'change'), (4, 0, 'being'), (5, 0, 'saying'),
  (6, 0, 'to call'), (7, 0, 'drinking'), (8, 0, 'to be'), (9, 0, 'to see'), (10, 0, 'taking'), (11, 0, 'to be'),
  (12, 0, 'thinking'), (12, 1, 'making'),
  (13, 0, 'living'), (13, 1, 'to move'),
  (14, 0, 'to be'), (14, 1, 'playing'),
  (15, 0, 'being stopped'), (15, 1, 'stealing'), (15, 2, 'driving'),
  (16, 0, 'work'), (16, 1, 'pressing')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 27', 'Make sentences from the words in brackets.', 1
from units u where u.slug = 'unit-53';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-53','unit-54','unit-55','unit-56','unit-57','unit-58','unit-59','unit-60','unit-61','unit-62','unit-63','unit-64','unit-65','unit-66')
where es.title = 'Additional exercise 27' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m feeling a bit tired. {0}', '(I / not / fancy / go / out)'),
  (2, 'James isn''t very reliable. {0}', '(he / tend / forget / things)'),
  (3, 'I''ve got a lot of luggage. {0}', '(you / mind / help / me?)'),
  (4, 'There''s nobody at home. {0}', '(everybody / seem / go out)'),
  (5, 'We don''t like our apartment. {0}', '(we / think / move)'),
  (6, 'The vase was very valuable. {0}', '(I / afraid / touch / it)'),
  (7, 'I wanted to get to the station in plenty of time. {0}', '(I / afraid / miss / my train)'),
  (8, 'I don''t recommend the movie. {0}', '(it / not / worth / see)'),
  (9, 'I''m very tired after that long walk. {0}', '(I / not / used / walk / so far)'),
  (10, 'Sue is on holiday. She called me yesterday and sounded happy. {0}', '(she / seem / enjoy / herself)'),
  (11, 'Dan took lots of pictures while he was on holiday. {0}', '(he / insist / show / them to me)'),
  (12, 'I don''t want to do the shopping. {0}', '(I''d rather / somebody else / do / it)')
) as v(n, template, hint)
where es.title = 'Additional exercise 27';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 27' and es.kind = 'additional'
join (values
  (1, 'I don''t fancy going out.', array[]::text[]),
  (2, 'He tends to forget things.', array[]::text[]),
  (3, 'Would you mind helping me?', array['Do you mind helping me?']::text[]),
  (4, 'Everybody seems to have gone out.', array[]::text[]),
  (5, 'We''re thinking of moving.', array['We are thinking of moving.']::text[]),
  (6, 'I was afraid to touch it.', array[]::text[]),
  (7, 'I was afraid of missing my train.', array[]::text[]),
  (8, 'It''s not worth seeing.', array['It is not worth seeing.']::text[]),
  (9, 'I''m not used to walking so far.', array[]::text[]),
  (10, 'She seems to be enjoying herself.', array['She seemed to be enjoying herself.']::text[]),
  (11, 'He insisted on showing them to me.', array[]::text[]),
  (12, 'I''d rather somebody else did it.', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 28', 'Complete the second sentence so that the meaning is similar to the first.', 2
from units u where u.slug = 'unit-53';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-53','unit-54','unit-55','unit-56','unit-57','unit-58','unit-59','unit-60','unit-61','unit-62','unit-63','unit-64','unit-65','unit-66')
where es.title = 'Additional exercise 28' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t read newspapers any more. I''ve given up {0}.'),
  (2, 'I''d prefer not to go out tonight. I''d rather {0}.'),
  (3, 'He finds it difficult to sleep at night. He has trouble {0}.'),
  (4, 'Shall I phone you this evening? Do you want {0}?'),
  (5, 'Nobody saw me come in. I came in without {0}.'),
  (6, 'Some people said I was a cheat. I was accused {0}.'),
  (7, 'It will be good to see them again. I''m looking forward {0}.'),
  (8, 'What do you think I should do? What do you advise me {0}?'),
  (9, 'It''s a pity I couldn''t go out with you last night. I''d like {0}.'),
  (10, 'I wish I''d taken your advice. I regret {0}.')
) as v(n, template)
where es.title = 'Additional exercise 28';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 28' and es.kind = 'additional'
join (values
  (1, 'reading newspapers', array[]::text[]),
  (2, 'not go out tonight', array['stay at home tonight']::text[]),
  (3, 'sleeping at night', array[]::text[]),
  (4, 'me to phone you this evening', array[]::text[]),
  (5, 'anybody seeing me', array['anyone seeing me', 'being seen']::text[]),
  (6, 'of being a cheat', array['of cheating']::text[]),
  (7, 'to seeing them again', array[]::text[]),
  (8, 'to do', array[]::text[]),
  (9, 'to have gone out with you last night', array[]::text[]),
  (10, 'not taking your advice', array['that I didn''t take your advice']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
