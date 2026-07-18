-- Additional exercises 5-8: "Present and past" (Units 1-17, 110, Appendix 2).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Exercise 7 is one continuous 32-blank dialogue in the book — split
-- here into one exercise_sentences row per natural dialogue turn
-- (rather than one giant 32-blank row) for readability, using
-- blank_index for turns with more than one gap; still covers all 32
-- blanks in the Key.
-- Exercise 6 ("Make sentences from the words in brackets") has no
-- {0}-per-word template — each answer is a whole constructed
-- sentence, same "whole answer sentence" convention as 38.4/39.2/90.2
-- elsewhere in this project.
--
-- Linked to units 1-17 via exercise_set_units, matching this group's
-- own printed subtitle (Appendix 2 and unit 110 aren't linkable unit
-- rows, so only the numbered units are attached).
--
-- Safe to re-run: each exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title in ('Additional exercise 5', 'Additional exercise 6', 'Additional exercise 7', 'Additional exercise 8') and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 5',
  'Put the verb into the correct form: past simple (I did), past continuous (I was doing), past perfect (I had done) or past perfect continuous (I had been doing).', 0
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10','unit-11','unit-12','unit-13','unit-14','unit-15','unit-16','unit-17')
where es.title = 'Additional exercise 5' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Yesterday afternoon Sarah went to the station to meet Paul. When she {0} there, Paul {1} for her. His train {2} early.'),
  (2, 'When I got home, Ben {0} on the sofa. The TV was on, but he {1} it. He {2} asleep and {3} loudly. I {4} the TV off and just then he {5} up.'),
  (3, 'Last night I {0} to bed and {1} a book when suddenly I {2} a noise. I {3} up to see what it was, but I {4} anything, so I {5} back to bed.'),
  (4, 'Lisa had to go to New York last week, but she almost {0} the plane. She {1} in the queue at the check-in desk when she suddenly {2} that she {3} her passport at home. Fortunately she lives near the airport, so she {4} time to take a taxi home to get it. She {5} back to the airport just in time for her flight.'),
  (5, 'I {0} Peter and Lucy yesterday as I {1} through the park. They {2} to the Sports Centre where they {3} tennis. They {4} to a cafe and {5} me to join them, but I {6} to meet another friend and {7} time.')
) as v(n, template)
where es.title = 'Additional exercise 5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 5' and es.kind = 'additional'
join (values
  (1, 0, 'got', array[]::text[]), (1, 1, 'was already waiting', array[]::text[]), (1, 2, 'had arrived', array[]::text[]),
  (2, 0, 'was lying', array[]::text[]), (2, 1, 'wasn''t watching', array[]::text[]), (2, 2, '''d fallen', array['had fallen']::text[]),
    (2, 3, 'was snoring', array[]::text[]), (2, 4, 'turned', array[]::text[]), (2, 5, 'woke', array[]::text[]),
  (3, 0, '''d just gone', array['had just gone']::text[]), (3, 1, 'was reading', array[]::text[]), (3, 2, 'heard', array[]::text[]),
    (3, 3, 'got', array[]::text[]), (3, 4, 'didn''t see', array[]::text[]), (3, 5, 'went', array[]::text[]),
  (4, 0, 'missed', array[]::text[]), (4, 1, 'was standing', array[]::text[]), (4, 2, 'realised', array[]::text[]),
    (4, 3, '''d left', array['had left']::text[]), (4, 4, 'had', array[]::text[]), (4, 5, 'got', array[]::text[]),
  (5, 0, 'met', array[]::text[]), (5, 1, 'was walking', array[]::text[]), (5, 2, '''d been', array['had been']::text[]),
    (5, 3, '''d been playing', array['had been playing']::text[]), (5, 4, 'were going', array[]::text[]),
    (5, 5, 'invited', array[]::text[]), (5, 6, '''d arranged', array['had arranged']::text[]), (5, 7, 'didn''t have', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 6',
  'Make sentences from the words in brackets. Put the verb into the correct form: present perfect (I have done), present perfect continuous (I have been doing), past perfect (I had done) or past perfect continuous (I had been doing).', 1
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10','unit-11','unit-12','unit-13','unit-14','unit-15','unit-16','unit-17')
where es.title = 'Additional exercise 6' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Where''s my bag? I left it under this chair. {0}', 'somebody / take / it'),
  (2, 'We were all surprised when Jess and Nick got married last year. {0}', 'they / only / know / each other / a few weeks'),
  (3, 'It''s still raining. I wish it would stop. {0}', 'it / rain / all day'),
  (4, 'Suddenly I woke up. I was confused and didn''t know where I was. {0}', 'I / dream'),
  (5, 'It was lunchtime, but I wasn''t hungry. I didn''t want to eat anything. {0}', 'I / have / a big breakfast'),
  (6, 'Every year Robert and Tina spend a few days at the same hotel by the sea. {0}', 'they / go / there for years'),
  (7, 'I''ve got a headache. {0}', 'I / have / it / since I got up'),
  (8, 'Next month Gary is going to run in a marathon. {0}', 'he / train / very hard for it')
) as v(n, template, hint)
where es.title = 'Additional exercise 6';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 6' and es.kind = 'additional'
join (values
  (1, 'Somebody has taken it.', array[]::text[]),
  (2, 'They''d only known each other for a few weeks.', array['They had only known each other for a few weeks.']::text[]),
  (3, 'It''s been raining all day.', array['It has been raining all day.', 'It''s rained all day.', 'It has rained all day.']::text[]),
  (4, 'I''d been dreaming.', array['I had been dreaming.']::text[]),
  (5, 'I''d had a big breakfast.', array['I had had a big breakfast.']::text[]),
  (6, 'They''ve been going there for years.', array['They have been going there for years.']::text[]),
  (7, 'I''ve had it since I got up.', array['I have had it since I got up.']::text[]),
  (8, 'He''s been training very hard for it.', array['He has been training very hard for it.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 7',
  'Put the verb into the correct form. Sarah and Joe are old friends. They meet by chance at a train station.', 2
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10','unit-11','unit-12','unit-13','unit-14','unit-15','unit-16','unit-17')
where es.title = 'Additional exercise 7' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'SARAH: Hello, Joe. {0} you for ages. How are you?'),
  (2, 'JOE: I''m fine. How about you? {0} good.'),
  (3, 'SARAH: Thanks. You too. So, {0} somewhere or {1} somebody?'),
  (4, 'JOE: {0} to London for a business meeting.'),
  (5, 'SARAH: Oh. {0} away on business?'),
  (6, 'JOE: Quite often, yes. And you? Where {0}?'),
  (7, 'SARAH: Nowhere. {0} a friend. Unfortunately her train {1}. {2} here for nearly an hour.'),
  (8, 'JOE: How are your children? SARAH: They''re all fine, thanks. The youngest {0} school.'),
  (9, 'JOE: How {0}? {1} it?'),
  (10, 'SARAH: Yes, {0} it''s great.'),
  (11, 'JOE: {0} at the moment? The last time I {1} to you, {2} for an insurance company.'),
  (12, 'SARAH: That''s right. Unfortunately the company {0} out of business a couple of months after {1} work there, so {2} my job.'),
  (13, 'JOE: And {0} a job since then?'),
  (14, 'SARAH: Not a permanent job. {0} a few temporary jobs. By the way, {1} Matt recently?'),
  (15, 'JOE: Matt? He''s in Canada. SARAH: Really? How long {0} in Canada?'),
  (16, 'JOE: About a year now. {0} him a few days before {1}. {2} unemployed for months, so {3} to try his luck somewhere else. {4} to going.'),
  (17, 'SARAH: So, what {0} there?'),
  (18, 'JOE: I have no idea. {0} from him since {1}.')
) as v(n, template)
where es.title = 'Additional exercise 7';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 7' and es.kind = 'additional'
join (values
  (1, 0, 'I haven''t seen', array[]::text[]),
  (2, 0, 'You look', array['You''re looking']::text[]),
  (3, 0, 'are you going', array[]::text[]), (3, 1, 'are you meeting', array[]::text[]),
  (4, 0, 'I''m going', array[]::text[]),
  (5, 0, 'Do you often go', array[]::text[]),
  (6, 0, 'are you going', array[]::text[]),
  (7, 0, 'I''m meeting', array[]::text[]), (7, 1, 'has been delayed', array['is delayed']::text[]), (7, 2, 'I''ve been waiting', array[]::text[]),
  (8, 0, 'has just started', array['just started']::text[]),
  (9, 0, 'is she getting on', array[]::text[]), (9, 1, 'Does she like', array[]::text[]),
  (10, 0, 'she thinks', array[]::text[]),
  (11, 0, 'Are you working', array[]::text[]), (11, 1, 'spoke', array[]::text[]), (11, 2, 'you were working', array[]::text[]),
  (12, 0, 'went', array[]::text[]), (12, 1, 'I started', array['I''d started']::text[]), (12, 2, 'I lost', array[]::text[]),
  (13, 0, 'you haven''t had', array[]::text[]),
  (14, 0, 'I''ve had', array[]::text[]), (14, 1, 'have you seen', array[]::text[]),
  (15, 0, 'has he been', array[]::text[]),
  (16, 0, 'I saw', array[]::text[]), (16, 1, 'he went', array[]::text[]), (16, 2, 'He''d been', array['He had been']::text[]),
    (16, 3, 'he decided', array['he''d decided']::text[]), (16, 4, 'He was really looking forward', array[]::text[]),
  (17, 0, 'is he doing', array[]::text[]),
  (18, 0, 'I haven''t heard', array[]::text[]), (18, 1, 'he left', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 8', 'Put the verb into the most suitable form.', 3
from units u where u.slug = 'unit-1';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-1','unit-2','unit-3','unit-4','unit-5','unit-6','unit-7','unit-8','unit-9','unit-10','unit-11','unit-12','unit-13','unit-14','unit-15','unit-16','unit-17')
where es.title = 'Additional exercise 8' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'Who {0} the bicycle?'),
  (2, '''Do you still have a headache?'' ''No, {0}. I''m OK now.'''),
  (3, 'I was the last to leave the office last night. Everybody else {0} home when I {1}.'),
  (4, 'What {0} last weekend? {1} anywhere?'),
  (5, 'I like your car. How long {0} it?'),
  (6, 'It''s a shame the trip was cancelled. I {0} forward to it.'),
  (7, 'Jane is an experienced teacher and loves her job. {0} for 15 years.'),
  (8, 'Emily {0} a new dress last week, but {1} it yet.'),
  (9, 'A few days ago {0} a man at a party whose face {1} very familiar. At first I couldn''t think where {2} him before. Then suddenly {3} who {4}.'),
  (10, '{0} of Agatha Christie? {1} a writer who {2} in 1976. {3} more than 70 detective novels, but {4} any of them.'),
  (11, 'a: What {0}? b: I''ve no idea. {1} it before. Look it up in the dictionary.'),
  (12, 'a: {0} to the theatre in time for the play last night? b: No, we were late. By the time we got there, {1}.'),
  (13, 'I went to Sarah''s room and {0} on the door, but there {1} no answer. Either {2} out or {3} to see anyone.'),
  (14, 'Dan asked me how to use the photocopier. {0} it before, so {1} what to do.'),
  (15, 'Lisa {0} for a swim after work yesterday. {1} some exercise because {2} in an office all day in front of a computer.')
) as v(n, template)
where es.title = 'Additional exercise 8';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 8' and es.kind = 'additional'
join (values
  (1, 0, 'invented', array[]::text[]),
  (2, 0, 'it''s gone', array['it has gone']::text[]),
  (3, 0, 'had gone', array[]::text[]), (3, 1, 'left', array[]::text[]),
  (4, 0, 'did you do', array[]::text[]), (4, 1, 'Did you go', array[]::text[]),
  (5, 0, 'have you had', array[]::text[]),
  (6, 0, 'was looking', array['''d been looking', 'had been looking']::text[]),
  (7, 0, 'She''s been teaching', array['She has been teaching']::text[]),
  (8, 0, 'bought', array[]::text[]), (8, 1, 'she hasn''t worn', array['she didn''t wear']::text[]),
  (9, 0, 'I met', array[]::text[]), (9, 1, 'was', array[]::text[]), (9, 2, 'I''d seen', array['I had seen']::text[]), (9, 3, 'I remembered', array[]::text[]), (9, 4, 'he was', array[]::text[]),
  (10, 0, 'Have you heard', array[]::text[]), (10, 1, 'She was', array[]::text[]), (10, 2, 'died', array[]::text[]), (10, 3, 'She wrote', array[]::text[]), (10, 4, 'I haven''t read', array[]::text[]),
  (11, 0, 'does this word mean', array[]::text[]), (11, 1, 'I''ve never seen', array[]::text[]),
  (12, 0, 'Did you get', array[]::text[]), (12, 1, 'it had already started', array[]::text[]),
  (13, 0, 'knocked', array[]::text[]), (13, 1, 'was', array[]::text[]), (13, 2, 'she''d gone', array['she had gone']::text[]), (13, 3, 'she didn''t want', array[]::text[]),
  (14, 0, 'He''d never used', array['He had never used']::text[]), (14, 1, 'he didn''t know', array[]::text[]),
  (15, 0, 'went', array[]::text[]), (15, 1, 'She needed', array['She''d needed', 'She had needed']::text[]), (15, 2, 'she''d been sitting', array['she had been sitting']::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
