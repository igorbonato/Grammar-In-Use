-- Additional exercises 22-24: "Passive" (Units 42-45).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 24's four short newspaper reports (Castle Fire, Shop
-- Robbery, Road Delays, Accident) are each kept as one
-- exercise_sentences row with several blanks, matching how the book
-- itself numbers each report's gaps as one continuous set.
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 22', 'Additional exercise 23', 'Additional exercise 24') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 22', 'Put the verb into the most suitable passive form.', 0
from units u where u.slug = 'unit-42';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-42','unit-43','unit-44','unit-45')
where es.title = 'Additional exercise 22' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'We didn''t play football yesterday. The game {0}.', '(cancel)'),
  (2, 'The TV {0}. It''s working again now.', '(repair)'),
  (3, 'The village church {0} at the moment. The work is almost finished.', '(restore)'),
  (4, 'The tower is the oldest part of the church. {0} to be over 600 years old.', '(it / believe)'),
  (5, 'If I didn''t do my job properly, {0}.', '(I / would / fire)'),
  (6, 'a: I left a newspaper on the desk last night and it isn''t there now. b: {0} away.', '(it / might / throw)'),
  (7, 'Joe learnt to swim when he was very young. {0} by his mother.', '(he / teach)'),
  (8, 'After {0}, I was taken to the police station.', '(arrest)'),
  (9, '''{0}?'' ''No, never.''', '(you / ever / arrest)'),
  (10, 'Two people {0} to {1} in an accident at a factory in Birmingham early this morning.', '(report) (injure)')
) as v(n, template, hint)
where es.title = 'Additional exercise 22';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 22' and es.kind = 'additional'
join (values
  (1, 0, 'was cancelled', array[]::text[]),
  (2, 0, 'has been repaired', array[]::text[]),
  (3, 0, 'is being restored', array[]::text[]),
  (4, 0, 'It''s believed', array['It is believed']::text[]),
  (5, 0, 'I''d be fired', array['I would be fired']::text[]),
  (6, 0, 'It might have been thrown', array[]::text[]),
  (7, 0, 'He was taught', array[]::text[]),
  (8, 0, 'being arrested', array['having been arrested']::text[]),
  (9, 0, 'Have you ever been arrested', array[]::text[]),
  (10, 0, 'are reported', array[]::text[]), (10, 1, 'have been injured', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 23', 'Put the verb into the correct form, active or passive.', 1
from units u where u.slug = 'unit-42';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-42','unit-43','unit-44','unit-45')
where es.title = 'Additional exercise 23' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '''Is your car still for sale?'' ''No, I {0} it.''', '(sell)'),
  (2, 'a: Is the house at the end of the street still for sale? b: No, it {0}.', '(sell)'),
  (3, 'Sometimes mistakes {0}. It''s inevitable.', '(make)'),
  (4, 'It''s not a good idea to leave your car unlocked. It {0}.', '(might / steal)'),
  (5, 'My bag has disappeared. It {0}.', '(must / steal)'),
  (6, 'I can''t find my umbrella. Somebody {0} it by mistake.', '(must / take)'),
  (7, 'It''s a serious problem. I don''t know how it {0}.', '(can / solve)'),
  (8, 'We didn''t leave early enough. We {0} earlier.', '(should / leave)'),
  (9, 'Very often when I travel by plane, my flight {0}.', '(delay)'),
  (10, 'A new bridge {0} across the river. Work started last year and the bridge {1} to open next year.', '(build) (expect)')
) as v(n, template, hint)
where es.title = 'Additional exercise 23';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 23' and es.kind = 'additional'
join (values
  (1, 0, '''ve sold', array['have sold', 'sold']::text[]),
  (2, 0, '''s been sold', array['has been sold', 'was sold']::text[]),
  (3, 0, 'are made', array[]::text[]),
  (4, 0, 'might be stolen', array[]::text[]),
  (5, 0, 'must have been stolen', array[]::text[]),
  (6, 0, 'must have taken', array[]::text[]),
  (7, 0, 'can be solved', array[]::text[]),
  (8, 0, 'should have left', array[]::text[]),
  (9, 0, 'is delayed', array[]::text[]),
  (10, 0, 'is being built', array[]::text[]), (10, 1, 'is expected', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 24', 'Read these newspaper reports and put the verbs into the most suitable form.', 2
from units u where u.slug = 'unit-42';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-42','unit-43','unit-44','unit-45')
where es.title = 'Additional exercise 24' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Castle Fire. Winton Castle was damaged in a fire last night. The fire, which {0} at about 9 o''clock, spread very quickly. Nobody {1}, but two people had to {2} from an upstairs room. A number of paintings {3}. It {4} how the fire started.'),
  (2, 'Shop Robbery. In Paxham yesterday a shop assistant {0} to hand over £500 after {1} by a man with a knife. The man escaped in a car which {2} earlier in the day. The car {3} in a car park where it {4} by the thief. A man {5} in connection with the robbery and {6} by the police.'),
  (3, 'Road Delays. Repair work started yesterday on the Paxham–Longworth road. The road {0} and there will be long delays. Drivers {1} to use an alternative route if possible. The work {2} to last two weeks. Next Sunday the road {3}, and traffic {4}.'),
  (4, 'Accident. A woman {0} to hospital after her car collided with a lorry near Norstock yesterday. She {1} home later after treatment. The road {2} for an hour after the accident, and traffic had to {3}. A police inspector said afterwards: ''The woman was lucky. She could {4}.''')
) as v(n, template)
where es.title = 'Additional exercise 24';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 24' and es.kind = 'additional'
join (values
  (1, 0, 'was discovered', array[]::text[]),
  (1, 1, 'was injured', array[]::text[]),
  (1, 2, 'be rescued', array[]::text[]),
  (1, 3, 'are believed to have been destroyed', array[]::text[]),
  (1, 4, 'is not known', array[]::text[]),
  (2, 0, 'was forced', array[]::text[]),
  (2, 1, 'being threatened', array[]::text[]),
  (2, 2, 'had been stolen', array[]::text[]),
  (2, 3, 'was later found', array[]::text[]),
  (2, 4, 'had been abandoned', array[]::text[]),
  (2, 5, 'has been arrested', array['was arrested']::text[]),
  (2, 6, 'is still being questioned', array[]::text[]),
  (3, 0, 'is being resurfaced', array[]::text[]),
  (3, 1, 'are asked', array['are being asked', 'have been asked']::text[]),
  (3, 2, 'is expected', array[]::text[]),
  (3, 3, 'will be closed', array['is going to be closed']::text[]),
  (3, 4, 'will be diverted', array['is going to be diverted']::text[]),
  (4, 0, 'was taken', array[]::text[]),
  (4, 1, 'was allowed', array[]::text[]),
  (4, 2, 'was blocked', array[]::text[]),
  (4, 3, 'be diverted', array[]::text[]),
  (4, 4, 'have been killed', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
