-- Additional exercises 37-41: "Phrasal verbs" (Units 137-145) — the
-- FINAL group, completing all 41 Additional exercises.
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 37 ("Which goes with which?") is a matching exercise —
-- same convention as 6.2/17.1/144.1 etc.: each A-statement's answer
-- is the matched B-reply's own text.
-- Exercise 38 ("Only one alternative is correct") is lettered A/B/C/D
-- — same "which is correct" convention as exercises 16/30.
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 37', 'Additional exercise 38', 'Additional exercise 39', 'Additional exercise 40', 'Additional exercise 41') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 37', 'A says something and B replies. Which goes with which?', 0
from units u where u.slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-137','unit-138','unit-139','unit-140','unit-141','unit-142','unit-143','unit-144','unit-145')
where es.title = 'Additional exercise 37' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'I''m too warm with my coat on. {0}'),
  (2, 'This jacket looks nice. {0}'),
  (3, 'Your reference number is 318044BK. {0}'),
  (4, 'This room is in a mess. {0}'),
  (5, 'What''s 45 euros in dollars? {0}'),
  (6, 'How was the mistake discovered? {0}'),
  (7, 'I''m not sure whether to accept their offer or not. {0}'),
  (8, 'I need a place to stay when I''m in London. {0}'),
  (9, 'It''s a subject he doesn''t like to talk about. {0}'),
  (10, 'I don''t know what this word means. {0}')
) as v(n, template)
where es.title = 'Additional exercise 37';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 37' and es.kind = 'additional'
join (values
  (1, 'Why don''t you take it off then?'),
  (2, 'Yes, why don''t you try it on?'),
  (3, 'Just a minute. I''ll write it down.'),
  (4, 'Don''t worry. I''ll clear it up.'),
  (5, 'Give me a moment. I''ll work it out.'),
  (6, 'Kate pointed it out.'),
  (7, 'I think you should turn it down.'),
  (8, 'That won''t be a problem. I can fix it up.'),
  (9, 'OK, I won''t bring it up.'),
  (10, 'You can look it up.')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 38', 'Only one alternative is correct. Which is it?', 1
from units u where u.slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-137','unit-138','unit-139','unit-140','unit-141','unit-142','unit-143','unit-144','unit-145')
where es.title = 'Additional exercise 38' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Here''s some good news. It will {0}. Which is correct — A turn you up, B put you up, C blow you up, or D cheer you up?'),
  (2, 'The children were behaving badly, so I {0}. Which is correct — A told them up, B told them off, C told them out, or D told them over?'),
  (3, 'The club committee is {0} of the president, the secretary and seven other members. Which is correct — A set up, B made up, C set out, or D made out?'),
  (4, 'Why did you decide not to apply for the job? What {0}? Which is correct — A put you off, B put you out, C turned you off, or D turned you away?'),
  (5, 'I had no idea that he was lying to me. I was completely {0}. Which is correct — A taken in, B taken down, C taken off, or D taken over?'),
  (6, 'Helen started a course at college, but she {0} after six months. Which is correct — A went out, B fell out, C turned out, or D dropped out?'),
  (7, 'You can''t predict everything. Often things don''t {0} as you expect. Which is correct — A make out, B break out, C turn out, or D get out?'),
  (8, 'What''s all this noise? What''s {0}? Which is correct — A going off, B getting off, C going on, or D getting on?'),
  (9, 'It''s a very busy airport. There are planes {0} or landing every few minutes. Which is correct — A going up, B taking off, C getting up, or D driving off?'),
  (10, 'The road was blocked by a bus that had {0}. Which is correct — A broken down, B dropped out, C driven off, or D held up?'),
  (11, 'How are you {0} in your new job? Are you enjoying it? Which is correct — A keeping on, B going on, C carrying on, or D getting on?')
) as v(n, template)
where es.title = 'Additional exercise 38';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 38' and es.kind = 'additional'
join (values
  (1, 'cheer you up'), (2, 'told them off'), (3, 'made up'), (4, 'put you off'),
  (5, 'taken in'), (6, 'dropped out'), (7, 'turn out'), (8, 'going on'),
  (9, 'taking off'), (10, 'broken down'), (11, 'getting on')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 39', 'Complete the sentences. Use two words each time.', 2
from units u where u.slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-137','unit-138','unit-139','unit-140','unit-141','unit-142','unit-143','unit-144','unit-145')
where es.title = 'Additional exercise 39' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'I didn''t notice that the two pictures were different until Amy pointed it {0} me.'),
  (2, 'I asked Max if he had any suggestions about what we should do, but he didn''t come {0} anything.'),
  (3, 'I''m glad Sarah is coming to the party. I''m really looking {0} seeing her again.'),
  (4, 'Things are changing all the time. It''s difficult to keep {0} all these changes.'),
  (5, 'I don''t want to run {0} food for the party. Are you sure we have enough?'),
  (6, 'We had a short break and then carried {0} our work.'),
  (7, 'I''ve had enough of being treated like this. I''m not going to put {0} it any more.'),
  (8, 'I didn''t enjoy the trip very much at the time, but when I look {0} it now, I realise it was a good experience and I''m glad I went on it.'),
  (9, 'The wedding was supposed to be a secret, so how did you find {0} it? Who told you?'),
  (10, 'There is a very nice atmosphere in the office where I work. Everybody gets {0} everybody else.')
) as v(n, template)
where es.title = 'Additional exercise 39';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 39' and es.kind = 'additional'
join (values
  (1, 'out to'), (2, 'up with'), (3, 'forward to'), (4, 'up with'), (5, 'out of'),
  (6, 'on with'), (7, 'up with'), (8, 'back on'), (9, 'out about'), (10, 'on with')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 40', 'Complete each sentence using a phrasal verb that has a similar meaning to the words in brackets.', 3
from units u where u.slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-137','unit-138','unit-139','unit-140','unit-141','unit-142','unit-143','unit-144','unit-145')
where es.title = 'Additional exercise 40' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Paul finally {0} an hour late.', '(arrived)'),
  (2, 'Here''s an application form. Can you {0} and sign it, please?', '(complete it)'),
  (3, 'Some houses will have to be {0} to make way for the new road.', '(demolished)'),
  (4, 'Be positive! You must never {0}!', '(stop trying)'),
  (5, 'I was very tired and {0} in front of the TV.', '(fell asleep)'),
  (6, 'After eight years together, they''ve decided to {0}.', '(separate)'),
  (7, 'The noise is terrible. I can''t {0} any longer.', '(tolerate it)'),
  (8, 'We don''t have a lot of money, but we have enough to {0}.', '(manage)'),
  (9, 'I''m sorry I''m late. The meeting {0} longer than I expected.', '(continued)'),
  (10, 'We need to make a decision today at the latest. We can''t {0} any longer.', '(delay it)')
) as v(n, template, hint)
where es.title = 'Additional exercise 40';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 40' and es.kind = 'additional'
join (values
  (1, 'turned up', array['showed up']::text[]),
  (2, 'fill it in', array['fill it out']::text[]),
  (3, 'knocked down', array['pulled down', 'torn down']::text[]),
  (4, 'give up', array[]::text[]),
  (5, 'dozed off', array['dropped off', 'nodded off']::text[]),
  (6, 'split up', array['break up']::text[]),
  (7, 'put up with it', array[]::text[]),
  (8, 'get by', array[]::text[]),
  (9, 'went on', array[]::text[]),
  (10, 'put it off', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 41', 'Complete the sentences. Use one word each time.', 4
from units u where u.slug = 'unit-137';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-137','unit-138','unit-139','unit-140','unit-141','unit-142','unit-143','unit-144','unit-145')
where es.title = 'Additional exercise 41' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'It was only a small fire and I managed to {0} it out with a bucket of water.'),
  (2, 'The house is empty right now, but I think the new tenants are {0} in next week.'),
  (3, 'I''ve {0} on weight. My clothes don''t fit any more.'),
  (4, 'Their house is really nice now. They''ve {0} it up really well.'),
  (5, 'I was talking to the woman next to me on the plane, and it {0} out that she works for the same company as my brother.'),
  (6, 'I don''t know what happened yet, but I''m going to {0} out.'),
  (7, 'There''s no need to get angry. {0} down!'),
  (8, 'If you''re going on a long walk, plan your route carefully before you {0} off.'),
  (9, 'Sarah has just phoned to say that she''ll be late. She''s been {0} up.'),
  (10, 'You''ve written my name wrong. It''s Martin, not Marin — you {0} out the T.'),
  (11, 'Three days at £45 a day — that {0} out at £135.'),
  (12, 'We had a really interesting discussion, but Jane didn''t {0} in. She just listened.'),
  (13, 'Jonathan is pretty fit. He {0} out in the gym every day.'),
  (14, 'Come and see us more often. You can {0} in any time you like.'),
  (15, 'We are still discussing the contract. There are still a couple of things to {0} out.'),
  (16, 'My alarm clock {0} off in the middle of the night and {1} me up.')
) as v(n, template)
where es.title = 'Additional exercise 41';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 41' and es.kind = 'additional'
join (values
  (1, 0, 'put', array[]::text[]),
  (2, 0, 'moving', array[]::text[]),
  (3, 0, 'put', array[]::text[]),
  (4, 0, 'done', array[]::text[]),
  (5, 0, 'turned', array['turns']::text[]),
  (6, 0, 'find', array[]::text[]),
  (7, 0, 'Calm', array[]::text[]),
  (8, 0, 'set', array[]::text[]),
  (9, 0, 'held', array[]::text[]),
  (10, 0, 'left', array['''ve left', 'have left', 'missed', '''ve missed', 'have missed']::text[]),
  (11, 0, 'works', array[]::text[]),
  (12, 0, 'join', array[]::text[]),
  (13, 0, 'works', array[]::text[]),
  (14, 0, 'drop', array['call']::text[]),
  (15, 0, 'sort', array['work']::text[]),
  (16, 0, 'went', array[]::text[]), (16, 1, 'woke', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
