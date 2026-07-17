-- Marco 4 (slice 10): seeds the first slice of the "-ing and to ..." module
-- — units 53-58 (Verb + -ing, Verb + to ..., Verb (+ object) + to ...,
-- Verb + -ing or to ... 1/2/3).
--
-- Sourced from pdf/Modulos/-ing and to ….pdf (extracted via
-- `pdftotext -layout`, same workaround as previous modules — pdftoppm/
-- poppler isn't available locally) and cross-checked against pdf/Key to
-- Exercises.pdf.
--
-- Unlike the last few modules, this PDF is genuinely one large book
-- chapter spanning units 53-68 (16 units, confirmed by grepping unit-
-- number headers across the whole file) — not a false grouping like
-- Modals.pdf, and not a clean single module either. Asked Igor how to
-- handle it: he chose to keep "-ing and to ..." as ONE module (matching
-- the book's own single chapter), seeded across multiple migration slices
-- instead of splitting it into several separate modules. This migration is
-- slice 1 (units 53-58, the core verb-pattern group); units 59-68 are a
-- follow-up. The module row uses `on conflict (slug) do nothing` so the
-- follow-up migration can extend it safely.
--
-- Reminder: migrations are applied by pasting the full file into the
-- Supabase Studio SQL Editor by hand — there is no GitHub auto-deploy for
-- this project.
--
-- Open-ended own-answer exercises are skipped: 53.4 ("Use your own ideas
-- to complete these sentences") and 58.1 ("Write sentences about
-- yourself. Do you like these activities?") — both confirmed genuinely
-- personal via the Key's "Example answers" label with answers that vary in
-- substance, not just wording (unlike 47.2/51.3 in earlier migrations,
-- where "Example answers" just meant flexible phrasing of one fixed idea).
--
-- 54.1 and 55.2 ("Complete the sentences for these situations") are
-- picture-based dialogues (unnamed characters in small illustrations) —
-- the exact pronouns in the Key (he/she/they) are used as given, with the
-- dialogue lines quoted directly in the template since that's all the text
-- extraction preserves of the scene.
--
-- 55.4 (three-way "which is right?") is adapted the same way prior
-- multiple-choice exercises were (38.2, 46.1, 50.1): the sentence with
-- both options becomes the template with a blank, the correct option
-- becomes the answer.
--
-- 56.3 groups its items under three headword clusters (1a-1f for
-- "remember", 2a-2d for "regret", 3a-3d for "go on"); flattened into
-- sequential exercise_sentences rows here (13 total, skipping the three
-- worked examples 1a/54.1's item1/etc.) but the book's own sub-labels are
-- kept inline in each template's text for reference.
--
-- Additional exercises 26-28 (pages 317-19) are referenced at the end of
-- units 54, 55 and 56 but, consistent with every module so far, deferred.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('ing-and-to', '-ing and to ...', 8)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 53: Verb + -ing (enjoy doing / stop doing etc.)
-- ============================================================

delete from units where slug = 'unit-53';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 53, 'unit-53', 'Verb + -ing (enjoy doing / stop doing etc.)', null,
  'After verbs like enjoy, mind, suggest, stop, finish, consider, admit, deny, avoid, risk, imagine and fancy, we use -ing, not to ... . The same is true after give up, put off, go on/carry on and keep/keep on.', 0
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'enjoy, mind, suggest + -ing (not to ...)',
  'After enjoy, mind and suggest we use -ing, not to: "I enjoy reading" (not I enjoy to read), "Would you mind closing the door?" (not mind to close), "Chris suggested going to the cinema" (not suggested to go). Other verbs followed by -ing: stop, finish, consider, recommend, admit, deny, avoid, risk, imagine, fancy. The negative form is not -ing: "I enjoy not having to get up early."', 0
from units where slug = 'unit-53';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'give up, put off, go on, keep (on) + -ing',
  'We also use -ing after give up (= stop), put off (= delay until later), go on/carry on (= continue), and keep/keep on (= do something continuously or repeatedly): "I''ve given up buying newspapers." "You shouldn''t put off telling him what happened."', 1
from units where slug = 'unit-53';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'verb + somebody + -ing',
  'With some verbs you can use the structure verb + somebody + -ing: "You can''t stop people doing what they want." "I can''t imagine George riding a motorbike." "I don''t remember her saying that." "Sorry to keep you waiting so long."', 2
from units where slug = 'unit-53';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'having done, for finished actions',
  'When you talk about finished actions, you can say having done/stolen/said etc.: "They admitted having stolen the money." But it isn''t necessary to use having (done) — you can also say "They admitted stealing the money." "I now regret saying that" or "I now regret having said that."', 3
from units where slug = 'unit-53';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'admit/deny/suggest/recommend + that ...',
  'Other structures are possible with admit, deny, suggest and recommend — you can use that: "They denied (that) they had done anything wrong" (= They denied doing ...). "Chris suggested (that) we go to the cinema" (= Chris suggested going ...). "I recommend (that) you travel by train" (= I recommend travelling ...).', 4
from units where slug = 'unit-53';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-53'
join (values
  ('A', 'I enjoy reading.', 'not I enjoy to read', 0),
  ('A', 'Would you mind closing the door?', 'not mind to close', 1),
  ('A', 'Chris suggested going to the cinema.', 'not suggested to go', 2),
  ('A', 'Suddenly everybody stopped talking. There was silence.', null, 3),
  ('A', 'He tried to avoid answering my question.', null, 4),
  ('A', 'I don''t fancy going out this evening.', '= I''m not enthusiastic about it', 5),
  ('A', 'They said they were innocent. They denied doing anything wrong.', null, 6),
  ('A', 'When I''m on holiday, I enjoy not having to get up early.', 'negative form', 7),
  ('B', 'I''ve given up buying newspapers. I don''t read them any more.', null, 0),
  ('B', 'You shouldn''t put off telling him what happened.', null, 1),
  ('B', 'Katherine doesn''t want to retire. She wants to go on working.', 'or ... to carry on working', 2),
  ('B', 'You keep interrupting when I''m talking.', 'or You keep on interrupting ...', 3),
  ('C', 'You can''t stop people doing what they want.', null, 0),
  ('C', 'I can''t imagine George riding a motorbike.', null, 1),
  ('C', 'Did she really say that? I don''t remember her saying that.', null, 2),
  ('C', 'Sorry to keep you waiting so long.', null, 3),
  ('D', 'They admitted having stolen the money.', null, 0),
  ('D', 'They admitted stealing the money.', 'having isn''t necessary', 1),
  ('D', 'I now regret saying that.', 'or I now regret having said that', 2),
  ('E', 'They denied (that) they had done anything wrong.', '= They denied doing ...', 0),
  ('E', 'Chris suggested (that) we go to the cinema.', '= Chris suggested going ...', 1),
  ('E', 'I recommend (that) you travel by train.', '= I recommend travelling ...', 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of somebody asking "Would you mind closing the door?" — used as the unit''s opening example of verb + -ing]', 0
from units where slug = 'unit-53';

-- ------------------------------------------------------------
-- Exercises (main, book's own 53.1-53.3; 53.4 skipped — open-ended,
-- "use your own ideas")
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '53.1', 'Complete the sentences for each situation. Use -ing.', 0
from units where slug = 'unit-53';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-53' where es.title = '53.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: Do you want to play tennis? b: No, not really. He didn''t fancy {0}.', null),
  (2, 'a: Let''s go for a walk. b: Good idea! She suggested {0}.', null),
  (3, 'a: You caused the accident. b: No, I didn''t. He denied {0}.', null),
  (4, 'a: Can you wait a few minutes? b: Sure, no problem. They didn''t mind {0}.', null),
  (5, 'a: You didn''t tell the truth. b: That''s right. I didn''t. She admitted {0}.', null)
) as v(n, template, hint)
where es.title = '53.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '53.1'
join (values
  (1, 0, 'playing tennis', array[]::text[]),
  (2, 0, 'going for a walk', array[]::text[]),
  (3, 0, 'causing the accident', array[]::text[]),
  (4, 0, 'waiting a few minutes', array[]::text[]),
  (5, 0, 'not telling the truth', array['lying']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '53.2', 'Complete the sentences. Choose from these verbs (in the correct form): answer, apply, forget, interrupt, listen, live, lose, make, pay, read, travel, try.', 1
from units where slug = 'unit-53';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-53' where es.title = '53.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m trying to concentrate. Please stop {0} so much noise!', null),
  (2, 'I enjoy {0} to music.', null),
  (3, 'I considered {0} for the job, but in the end I decided against it.', null),
  (4, 'Have you finished {0} the newspaper yet?', null),
  (5, 'We need to change our routine. We can''t go on {0} like this.', null),
  (6, 'It''s better to avoid {0} during the rush hour.', null),
  (7, 'My memory is getting worse. I keep {0} things.', null),
  (8, 'I''ve put off {0} this bill so many times. I really must do it today.', null),
  (9, 'I''ve given up {0} to learn Japanese. I was making no progress.', null),
  (10, 'If you gamble, you risk {0} your money.', null),
  (11, 'Would you mind not {0} me all the time? Let me speak!', null)
) as v(n, template, hint)
where es.title = '53.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '53.2'
join (values
  (1, 0, 'making'), (2, 0, 'listening'), (3, 0, 'applying'), (4, 0, 'reading'),
  (5, 0, 'living'), (6, 0, 'travelling'), (7, 0, 'forgetting'), (8, 0, 'paying'),
  (9, 0, 'trying'), (10, 0, 'losing'), (11, 0, 'interrupting')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '53.3', 'Put the words in the right order.', 2
from units where slug = 'unit-53';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-53' where es.title = '53.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s OK if you want to drive my car. {0}', '(driving / don''t / it / you / mind)'),
  (2, 'What a stupid thing to do! {0}', '(imagine / so stupid / being / you / anybody)'),
  (3, 'We can''t control the weather. {0}', '(raining / stop / it / can''t)'),
  (4, 'I''ll be as quick as I can. {0}', '(waiting / want / keep / you / don''t / to)')
) as v(n, template, hint)
where es.title = '53.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '53.3'
join (values
  (1, 0, 'I don''t mind you driving it.'),
  (2, 0, 'Can you imagine anybody being so stupid?'),
  (3, 0, 'We can''t stop it raining.'),
  (4, 0, 'I don''t want to keep you waiting.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 54: Verb + to ... (decide to ... / forget to ... etc.)
-- ============================================================

delete from units where slug = 'unit-54';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 54, 'unit-54', 'Verb + to ... (decide to ... / forget to ... etc.)', null,
  'After verbs like offer, agree, refuse, decide, plan, arrange, fail, hope, promise, forget, manage, afford, learn, threaten and tend, we use to ... . seem, appear, pretend and claim also take to ... . After some verbs (ask, know, decide, remember, forget, learn, explain, understand, wonder) you can use a question word + to ... .', 1
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Verbs followed by to ... (infinitive)',
  'After verbs like offer, agree, refuse, decide, plan, arrange, fail, hope, promise, forget, manage, afford, learn, threaten, tend etc. you use to ...: "We decided to take a taxi home." "Dan tends to talk too much." The negative is not to ...: "We decided not to go out because of the weather." Some verbs (enjoy, think, suggest etc.) use -ing instead, not to ...: "I enjoy reading" (not enjoy to read).', 0
from units where slug = 'unit-54';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'dare',
  'After dare you can use the infinitive with or without to: "I didn''t dare to tell him" or "I didn''t dare tell him." But after dare not (or daren''t), we do not use to: "I daren''t tell him what happened" (not I daren''t to tell him).', 1
from units where slug = 'unit-54';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'seem, appear, pretend, claim + to ...',
  'We also use to ... after seem, appear, pretend and claim: "They seem to have plenty of money." "Ann pretended not to see me." You can also use to be -ing (continuous infinitive) and to have (done) (perfect infinitive): "I pretended to be reading the newspaper." "I seem to have lost them." "She claimed not to have seen me."', 2
from units where slug = 'unit-54';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'question word + to ...',
  'After verbs like ask, know, decide, remember, forget, learn, explain, understand, wonder, you can use a question word (what/how etc.) + to ...: "We asked how to get to the station." "Have you decided where to go on holiday?" "I don''t know what to do." Also show/tell/ask/advise/teach somebody what/how/where to do something: "Can somebody show me how to use this camera?"', 3
from units where slug = 'unit-54';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-54'
join (values
  ('A', 'It was a long way to walk, so we decided to take a taxi home.', null, 0),
  ('A', 'Simon was in a difficult situation, so I agreed to help him.', null, 1),
  ('A', 'I waved to Karen, but failed to attract her attention.', null, 2),
  ('A', 'How old were you when you learnt to drive?', 'or ... learnt how to drive?', 3),
  ('A', 'We decided not to go out because of the weather.', null, 4),
  ('A', 'I promised not to be late.', null, 5),
  ('A', 'Andy suggested meeting for coffee.', 'not suggested to meet', 6),
  ('A', 'Are you thinking of buying a car?', 'not thinking to buy', 7),
  ('B', 'I didn''t dare to tell him.', 'or I didn''t dare tell him', 0),
  ('B', 'I daren''t tell him what happened.', 'not I daren''t to tell him', 1),
  ('C', 'They seem to have plenty of money.', null, 0),
  ('C', 'Ann pretended not to see me when she passed me in the street.', null, 1),
  ('C', 'I pretended to be reading the newspaper.', '= I pretended that I was reading', 2),
  ('C', 'Have you seen my keys? I seem to have lost them.', '= it seems that I have lost them', 3),
  ('C', 'She claimed not to have seen me.', '= she claimed that she hadn''t seen me', 4),
  ('D', 'We asked how to get to the station.', null, 0),
  ('D', 'Have you decided where to go on holiday?', null, 1),
  ('D', 'I don''t know what to do.', null, 2),
  ('D', 'Can somebody show me how to use this camera?', null, 3),
  ('D', 'Ask Jack. He''ll tell you what to do.', null, 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 54.1-54.5)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '54.1', 'Complete the sentences for these situations.', 0
from units where slug = 'unit-54';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-54' where es.title = '54.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '"Please help me." "OK." {0}', null),
  (2, '"Can I carry your bag for you?" "No, thanks. I can manage." {0}', null),
  (3, '"Let''s meet at 8 o''clock." "OK, fine." {0}', null),
  (4, '"What''s your name?" "I''m not going to tell you." {0}', null),
  (5, '"Please don''t tell anyone." "I won''t. I promise." {0}', null)
) as v(n, template, hint)
where es.title = '54.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '54.1'
join (values
  (1, 0, 'She agreed to help him.', array[]::text[]),
  (2, 0, 'He offered to carry her bag.', array['He offered to carry her bag for her.']::text[]),
  (3, 0, 'They arranged to meet at 8 o''clock.', array[]::text[]),
  (4, 0, 'She refused to tell him her name.', array['She refused to give him her name.']::text[]),
  (5, 0, 'She promised not to tell anyone.', array['She promised she wouldn''t tell anyone.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '54.2', 'Complete the sentences. Use a suitable verb.', 1
from units where slug = 'unit-54';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-54' where es.title = '54.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There was a lot of traffic, but we managed {0} to the airport in time.', null),
  (2, 'We couldn''t afford {0} in London. It''s too expensive.', null),
  (3, 'I can''t play a musical instrument, but I''d like to learn {0} the guitar.', null),
  (4, 'I don''t want Mark to know what happened. I decided not {0} him.', null),
  (5, 'We were all afraid to speak. Nobody dared {0} anything.', null)
) as v(n, template, hint)
where es.title = '54.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '54.2'
join (values
  (1, 0, 'to get', array[]::text[]),
  (2, 0, 'to live', array[]::text[]),
  (3, 0, 'to play', array[]::text[]),
  (4, 0, 'to tell', array[]::text[]),
  (5, 0, 'say', array['to say']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '54.3', 'Put the verb into the correct form, to ... or -ing.', 2
from units where slug = 'unit-54';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-54' where es.title = '54.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ve decided {0} for another job. I need a change.', '(look)'),
  (2, 'I''m not going anywhere! I refuse {0}.', '(move)'),
  (3, 'I''m not in a hurry. I don''t mind {0}.', '(wait)'),
  (4, 'Tina ran in a marathon last week, but she failed {0}.', '(finish)'),
  (5, 'I wish that dog would stop {0}. It''s driving me crazy.', '(bark)'),
  (6, 'They didn''t know I was listening to them. I pretended {0} asleep.', '(be)'),
  (7, 'We were hungry, so I suggested {0} dinner early.', '(have)'),
  (8, 'Hurry up! I don''t want to risk {0} the train.', '(miss)'),
  (9, 'David is very quiet. He tends not {0} much.', '(say)')
) as v(n, template, hint)
where es.title = '54.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '54.3'
join (values
  (1, 0, 'to look'), (2, 0, 'to move'), (3, 0, 'waiting'), (4, 0, 'to finish'),
  (5, 0, 'barking'), (6, 0, 'to be'), (7, 0, 'having'), (8, 0, 'missing'), (9, 0, 'to say')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '54.4', 'Make a new sentence using the verb in brackets.', 3
from units where slug = 'unit-54';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-54' where es.title = '54.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Tom is worried about something. {0}', '(appear)'),
  (2, 'You know a lot of people. {0}', '(seem)'),
  (3, 'My English is getting better. {0}', '(seem)'),
  (4, 'That car has broken down. {0}', '(appear)'),
  (5, 'Rachel is enjoying her job. {0}', '(seem)'),
  (6, 'They have solved the problem. {0}', '(claim)')
) as v(n, template, hint)
where es.title = '54.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '54.4'
join (values
  (1, 0, 'Tom appears to be worried about something.'),
  (2, 0, 'You seem to know a lot of people.'),
  (3, 0, 'My English seems to be getting better.'),
  (4, 0, 'That car appears to have broken down.'),
  (5, 0, 'Rachel seems to be enjoying her job.'),
  (6, 0, 'They claim to have solved the problem.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '54.5', 'Complete each sentence using what/how/where/whether + these verbs: do, get, go, put, ride, use.', 4
from units where slug = 'unit-54';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-54' where es.title = '54.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Would you know {0} if there was a fire in the building?', null),
  (2, 'You''ll never forget {0} a bike once you''ve learnt.', null),
  (3, 'I''ve been invited to the party, but I haven''t decided {0} or not.', null),
  (4, 'My room is very untidy. I''ve got so many things and I don''t know {0} them.', null),
  (5, 'I have some clothes to wash. Can you show me {0} the washing machine?', null)
) as v(n, template, hint)
where es.title = '54.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '54.5'
join (values
  (1, 0, 'what to do'), (2, 0, 'how to ride'), (3, 0, 'whether to go'),
  (4, 0, 'where to put'), (5, 0, 'how to use')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 55: Verb (+ object) + to ... (I want you to ...)
-- ============================================================

delete from units where slug = 'unit-55';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 55, 'unit-55', 'Verb (+ object) + to ... (I want you to ...)', null,
  'want, expect, would like/love/prefer, ask and help can take to ... directly or object + to ... . tell, advise, remind, warn, invite, encourage, persuade, get, force, teach, allow and enable always need an object before to ... . make and let take the object + bare infinitive (no to), except in the passive.', 2
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'want / expect / would like + (object) + to ...',
  'want, expect, ask, help, would like, would prefer can be followed directly by to ..., or by object + to ...: "We expected to be late." "We expected Dan to be late." "Would you like to go now?" "Would you like me to go now?" We do not usually say "want that": "Do you want me to come with you?" (not want that I come). help can be used with or without to: "Can you help me to move this table?" or "Can you help me move this table?"', 0
from units where slug = 'unit-55';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'verb + object + to ... (tell, advise, warn, invite etc.)',
  'Verbs like tell, advise, remind, warn, invite, encourage, persuade, get, force, teach, allow, enable have the structure verb + object + to ...: "I wouldn''t advise you to stay there." "Can you remind me to call Sam tomorrow?" In these examples the verb can be passive: "I was warned not to touch the switch." "Are we allowed to park here?" We do not use suggest with to ...: "Jane suggested that I ask you for advice" (not Jane suggested me to ask).', 1
from units where slug = 'unit-55';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'make and let (without to)',
  'We say "make somebody do something" and "let somebody do something", without to: "I made him promise that he wouldn''t tell anybody" (not made him to promise). "Hot weather makes me feel tired." "Her parents wouldn''t let her go out alone." "Let me carry your bag for you." But in the passive we say "(be) made to do" (with to): "We were made to wait for two hours."', 2
from units where slug = 'unit-55';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-55'
join (values
  ('A', 'We expected to be late.', null, 0),
  ('A', 'We expected Dan to be late.', null, 1),
  ('A', 'Would you like to go now?', null, 2),
  ('A', 'Would you like me to go now?', null, 3),
  ('A', 'He doesn''t want to know.', null, 4),
  ('A', 'He doesn''t want anybody to know.', null, 5),
  ('A', 'Do you want me to come with you?', 'not want that I come', 6),
  ('A', 'Can you help me to move this table?', 'or Can you help me move this table?', 7),
  ('B', 'It''s not a nice hotel. I wouldn''t advise you to stay there.', null, 0),
  ('B', 'Can you remind me to call Sam tomorrow?', null, 1),
  ('B', 'Joe said the switch was dangerous and warned me not to touch it.', null, 2),
  ('B', 'I didn''t move the piano by myself. I got somebody to help me.', null, 3),
  ('B', 'Who taught you to drive?', null, 4),
  ('B', 'They don''t allow people to park in front of the building.', null, 5),
  ('B', 'I was warned not to touch the switch.', 'passive', 6),
  ('B', 'Are we allowed to park here?', 'passive', 7),
  ('B', 'Jane suggested that I ask you for advice.', 'not Jane suggested me to ask', 8),
  ('C', 'I made him promise that he wouldn''t tell anybody what happened.', 'not made him to promise', 0),
  ('C', 'Hot weather makes me feel tired.', '= causes me to feel tired', 1),
  ('C', 'Her parents wouldn''t let her go out alone.', '= wouldn''t allow her to go out', 2),
  ('C', 'Let me carry your bag for you.', null, 3),
  ('C', 'We were made to wait for two hours.', '= They made us wait ...', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 55.1-55.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '55.1', 'Complete the questions. Use do you want me to ... ? or would you like me to ... ? with these verbs: come, lend, repeat, show, shut, wait.', 0
from units where slug = 'unit-55';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-55' where es.title = '55.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Do you have enough money, or {0}?', null),
  (2, 'Shall I leave the window open, or {0}?', null),
  (3, 'Do you know how to use the printer, or {0}?', null),
  (4, 'Did you hear what I said, or {0}?', null),
  (5, 'Can I go now, or {0}?', null)
) as v(n, template, hint)
where es.title = '55.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '55.1'
join (values
  (1, 0, 'do you want me to lend you some'),
  (2, 0, 'would you like me to shut it'),
  (3, 0, 'would you like me to show you'),
  (4, 0, 'do you want me to repeat it'),
  (5, 0, 'do you want me to wait')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '55.2', 'Complete the sentences for these situations.', 1
from units where slug = 'unit-55';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-55' where es.title = '55.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '"Why don''t you come and stay with us?" "That would be nice." {0}', null),
  (2, '"Don''t forget to call Joe." "No, I won''t forget." {0}', null),
  (3, '"Be careful." "Don''t worry. I will." {0}', null),
  (4, '"Can you give me a hand?" "Sure." {0}', null)
) as v(n, template, hint)
where es.title = '55.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '55.2'
join (values
  (1, 0, 'They invited him to stay with them.'),
  (2, 0, 'He reminded her to call Joe.'),
  (3, 0, 'She warned him to be careful.'),
  (4, 0, 'He asked her to give him a hand.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '55.3', 'Complete the second sentence so that the meaning is similar to the first sentence.', 2
from units where slug = 'unit-55';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-55' where es.title = '55.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I was surprised that it rained. {0}', null),
  (2, 'Don''t stop him doing what he wants. {0}', null),
  (3, 'Tom looks older when he wears glasses. {0}', null),
  (4, 'I think you should know the truth. {0}', null),
  (5, 'At first I didn''t want to apply for the job, but Sarah persuaded me. {0}', null),
  (6, 'My lawyer said I shouldn''t say anything to the police. {0}', null),
  (7, 'I was told that I shouldn''t believe everything he says. {0}', null),
  (8, 'If you''ve got a car, you are able to get around more easily. {0}', null)
) as v(n, template, hint)
where es.title = '55.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '55.3'
join (values
  (1, 0, 'I didn''t expect it to rain.'),
  (2, 0, 'Let him do what he wants.'),
  (3, 0, 'Tom''s glasses make him look older.'),
  (4, 0, 'I want you to know the truth.'),
  (5, 0, 'Sarah persuaded me to apply for the job.'),
  (6, 0, 'My lawyer advised me not to say anything to the police.'),
  (7, 0, 'I was warned not to believe everything he says.'),
  (8, 0, 'Having a car enables you to get around more easily.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '55.4', 'Which is right?', 3
from units where slug = 'unit-55';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-55' where es.title = '55.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m in a difficult position. What do you advise me {0}?', '(do / to do)'),
  (2, 'The film was very sad. It made me {0}.', '(cry / to cry)'),
  (3, 'Lisa''s parents always encouraged her {0} hard at school.', '(study / to study)'),
  (4, 'Please don''t interrupt me. Let me {0}.', '(finish / to finish)'),
  (5, 'You can''t make people {0} things they don''t want to do.', '(do / to do)'),
  (6, 'You can''t force people {0} things they don''t want to do.', '(do / to do)'),
  (7, 'Sarah won''t let me {0} her car. She doesn''t trust me.', '(drive / to drive)'),
  (8, 'Why did you change your decision? What made you {0} your mind?', '(change / to change)'),
  (9, 'If you enter a country with a tourist visa, you are not allowed {0} there.', '(work / to work)')
) as v(n, template, hint)
where es.title = '55.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '55.4'
join (values
  (1, 0, 'to do'), (2, 0, 'cry'), (3, 0, 'to study'), (4, 0, 'finish'), (5, 0, 'do'),
  (6, 0, 'to do'), (7, 0, 'drive'), (8, 0, 'change'), (9, 0, 'to work')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 56: Verb + -ing or to ... 1 (remember, regret etc.)
-- ============================================================

delete from units where slug = 'unit-56';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 56, 'unit-56', 'Verb + -ing or to ... 1 (remember, regret etc.)', null,
  'remember, regret and go on change meaning depending on -ing or to ... . begin, start, continue, intend and bother can take either with no difference in meaning.', 3
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', '-ing verbs vs to ... verbs',
  'Some verbs are followed by -ing (admit, avoid, consider, deny, enjoy, fancy, finish, imagine, keep (on), mind, postpone, risk, stop, suggest — see Unit 53); others by to ... (afford, agree, arrange, decide, deserve, fail, forget, hope, learn, manage, offer, plan, promise, refuse, tend — see Unit 54).', 0
from units where slug = 'unit-56';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'remember, regret, go on: different meanings with -ing or to ...',
  'remember doing something = you did it and now remember this; remember to do something = you remembered that you had to do it, so you did it: "I clearly remember locking it" vs "I remembered to lock the door." regret doing something = you did it and now you''re sorry about it; regret to say/tell/inform = a formal way of saying you''re sorry you have to say something. go on doing something = continue the same thing; go on to do something = do or say something new: "The president paused and then went on talking" vs "He went on to talk about foreign policy."', 1
from units where slug = 'unit-56';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'begin, start, continue, intend, bother: no difference',
  'We use the following verbs with -ing or to ... with no difference in meaning: begin, start, continue, intend, bother: "It started raining" or "It started to rain." Normally we do not use -ing after -ing: "It''s starting to rain" (not usually It''s starting raining).', 2
from units where slug = 'unit-56';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-56'
join (values
  ('A', 'admit, avoid, consider, deny, enjoy, fancy, finish, imagine, keep (on), mind, postpone, risk, stop, suggest — followed by -ing.', null, 0),
  ('A', 'afford, agree, arrange, decide, deserve, fail, forget, hope, learn, manage, offer, plan, promise, refuse, tend — followed by to ...', null, 1),
  ('B', 'I clearly remember locking the door.', '= I locked it, and now I remember this', 0),
  ('B', 'I remembered to lock the door, but I forgot to shut the windows.', '= I remembered that I had to lock it, so I did', 1),
  ('B', 'Remember to buy some bananas.', '= don''t forget to buy them', 2),
  ('B', 'I now regret saying what I said. I shouldn''t have said it.', null, 3),
  ('B', 'I regret to say that we are unable to accept your offer.', 'formal letter', 4),
  ('B', 'The president paused for a moment and then went on talking.', '= continued the same thing', 5),
  ('B', 'After discussing the economy, the president went on to talk about foreign policy.', '= moved on to something new', 6),
  ('C', 'It started raining.', 'or It started to rain', 0),
  ('C', 'Andy intends buying a house.', 'or Andy intends to buy ...', 1),
  ('C', 'Don''t bother locking the door.', 'or Don''t bother to lock ...', 2),
  ('C', 'It''s starting to rain.', 'not usually It''s starting raining', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 56.1-56.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '56.1', 'Put the verb into the correct form, -ing or to ... .', 0
from units where slug = 'unit-56';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-56' where es.title = '56.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I don''t enjoy {0} very much.', '(drive)'),
  (2, 'I can''t afford {0} away. I don''t have enough money.', '(go)'),
  (3, 'Have you ever considered {0} to live in another country?', '(go)'),
  (4, 'We were unlucky to lose the game. We played well and deserved {0}.', '(win)'),
  (5, 'Why do you keep {0} me questions? Leave me alone!', '(ask)'),
  (6, 'Please stop {0} me questions!', '(ask)'),
  (7, 'I refuse {0} any more questions.', '(answer)'),
  (8, 'The driver of one of the cars admitted {0} the accident.', '(cause)'),
  (9, 'Mark needed our help, and we promised {0} what we could.', '(do)'),
  (10, 'I don''t mind {0} alone, but I''d rather be with other people.', '(be)'),
  (11, 'The wall was quite high, but I managed {0} over it.', '(climb)'),
  (12, 'Sarah doesn''t know about the meeting. I forgot {0} her.', '(tell)'),
  (13, 'I''ve enjoyed {0} to you. I hope {1} you again soon.', '(talk, see)')
) as v(n, template, hint)
where es.title = '56.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '56.1'
join (values
  (1, 0, 'driving'), (2, 0, 'to go'), (3, 0, 'going'), (4, 0, 'to win'), (5, 0, 'asking'),
  (6, 0, 'asking'), (7, 0, 'to answer'), (8, 0, 'causing'), (9, 0, 'to do'), (10, 0, 'being'),
  (11, 0, 'to climb'), (12, 0, 'to tell'), (13, 0, 'talking'), (13, 1, 'to see')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '56.2', 'Tom can remember some things about his childhood, but he can''t remember others. Write sentences with He remembers ... or He doesn''t remember ... .', 1
from units where slug = 'unit-56';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-56' where es.title = '56.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'He cried on his first day at school. He doesn''t remember this. {0}', null),
  (2, 'Once he fell into the river. He remembers this. {0}', null),
  (3, 'He said he wanted to be a doctor. He doesn''t remember this. {0}', null),
  (4, 'Once he was bitten by a dog. He doesn''t remember this. {0}', null),
  (5, 'His sister was born when he was four. He remembers this. {0}', null)
) as v(n, template, hint)
where es.title = '56.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '56.2'
join (values
  (1, 0, 'He doesn''t remember crying on his first day at school.', array[]::text[]),
  (2, 0, 'He remembers falling into the river.', array[]::text[]),
  (3, 0, 'He doesn''t remember saying he wanted to be a doctor.', array['He doesn''t remember wanting to be a doctor.']::text[]),
  (4, 0, 'He doesn''t remember being bitten by a dog.', array[]::text[]),
  (5, 0, 'He remembers his sister being born when he was four.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '56.3', 'Complete the sentences with a suitable verb in the correct form, -ing or to ... .', 2
from units where slug = 'unit-56';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-56' where es.title = '56.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '(1b) He says we''ve met before, but I don''t remember {0} him.', null),
  (2, '(1c) Someone must have taken my bag. I clearly remember {0} it by the window and now it isn''t there.', null),
  (3, '(1d) When you see Steve, remember {0} hello to him from me.', null),
  (4, '(1e) a: You lent me some money a few months ago. b: Did I? Are you sure? I don''t remember {0} you any money.', null),
  (5, '(1f) a: Did you remember {0} your sister? b: No, I forgot. I''ll phone her tomorrow.', null),
  (6, '(2a) The course I did wasn''t very good, but I don''t regret {0} it.', null),
  (7, '(2b) I knew they were in trouble, but I regret {0} I did nothing to help them.', null),
  (8, '(2c) It started to get cold, and he regretted not {0} his coat.', null),
  (9, '(2d) I now regret {0} my job. It was a big mistake.', null),
  (10, '(3a) Ben joined the company nine years ago. He became assistant manager after two years, and a few years later he went on {0} manager of the company.', null),
  (11, '(3b) I can''t go on {0} here any more. I want a different job.', null),
  (12, '(3c) When I came into the room, Lisa was reading a book. She looked up and said hello, and then went on {0} her book.', null),
  (13, '(3d) Food prices have gone up again. How are we going to manage if prices go on {0}?', null)
) as v(n, template, hint)
where es.title = '56.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '56.3'
join (values
  (1, 0, 'meeting', array[]::text[]),
  (2, 0, 'leaving', array['putting']::text[]),
  (3, 0, 'to say', array[]::text[]),
  (4, 0, 'lending', array[]::text[]),
  (5, 0, 'to call', array['to phone']::text[]),
  (6, 0, 'doing', array[]::text[]),
  (7, 0, 'to say', array[]::text[]),
  (8, 0, 'wearing', array['having', 'taking', 'putting on']::text[]),
  (9, 0, 'leaving', array['giving up']::text[]),
  (10, 0, 'to become', array[]::text[]),
  (11, 0, 'working', array[]::text[]),
  (12, 0, 'reading', array[]::text[]),
  (13, 0, 'going up', array['rising', 'increasing']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 57: Verb + -ing or to ... 2 (try, need, help)
-- ============================================================

delete from units where slug = 'unit-57';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 57, 'unit-57', 'Verb + -ing or to ... 2 (try, need, help)', null,
  'try to do = attempt to do; try doing = do it as an experiment. need to do = it''s necessary for you to do it; something needs doing = it needs to be done (passive meaning). help to do / help do can be used with or without to; can''t help doing = can''t stop yourself doing it.', 4
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'try to ... and try -ing',
  'try to do = attempt to do, make an effort: "I tried to keep my eyes open, but I couldn''t." try something / try doing something = do it as an experiment or test, to see what happens: "Try pressing the green button" (= perhaps this will help). Compare: "I tried to move the table, but it was too heavy" (so I couldn''t) vs "I tried moving the table to the other side of the room" (I moved it to see if it looked better).', 0
from units where slug = 'unit-57';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'need to ... and need -ing',
  'I need to do something = it is necessary for me to do it: "He needs to work harder." You can also say that something needs -ing (with a passive meaning): "My phone needs charging" (= it needs to be charged). "It needs thinking about carefully" (= it needs to be thought about).', 1
from units where slug = 'unit-57';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'help and can''t help',
  'You can say help to do or help do (with or without to): "Everybody helped to clean up" or "Everybody helped clean up." I can''t help doing something = I can''t stop myself doing it: "She tried to be serious, but she couldn''t help laughing" (= she couldn''t stop herself laughing). "I''m sorry I''m so nervous. I can''t help it" (= I can''t help being nervous).', 2
from units where slug = 'unit-57';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-57'
join (values
  ('A', 'I was very tired. I tried to keep my eyes open, but I couldn''t.', null, 0),
  ('A', 'These cakes are delicious. You should try one.', '= have one to see if you like it', 1),
  ('A', 'We tried every hotel in the town, but they were all full.', '= we went to every hotel to see if they had a room', 2),
  ('A', 'Try pressing the green button.', '= perhaps this will help solve the problem', 3),
  ('A', 'I tried to move the table, but it was too heavy.', 'so I couldn''t move it', 4),
  ('A', 'I tried moving the table to the other side of the room.', 'I moved it to see if it looked better', 5),
  ('B', 'He needs to work harder if he wants to make progress.', null, 0),
  ('B', 'I don''t need to come to the meeting, do I?', null, 1),
  ('B', 'My phone needs charging.', '= it needs to be charged', 2),
  ('B', 'Does your suit need cleaning?', '= ... need to be cleaned', 3),
  ('B', 'It''s a difficult problem. It needs thinking about carefully.', '= it needs to be thought about carefully', 4),
  ('C', 'Everybody helped to clean up after the party.', 'or Everybody helped clean up ...', 0),
  ('C', 'Can you help me move this table?', 'or Can you help me to move ...', 1),
  ('C', 'I don''t like him, but he has a lot of problems. I can''t help feeling sorry for him.', null, 2),
  ('C', 'She tried to be serious, but she couldn''t help laughing.', '= she couldn''t stop herself laughing', 3),
  ('C', 'I''m sorry I''m so nervous. I can''t help it.', '= I can''t help being nervous', 4)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of a phone with a low battery, captioned "My phone needs charging" — illustrating need + -ing with a passive meaning]', 0
from units where slug = 'unit-57';

-- ------------------------------------------------------------
-- Exercises (main, book's own 57.1-57.4)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '57.1', 'Put the verb into the correct form.', 0
from units where slug = 'unit-57';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-57' where es.title = '57.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I tried {0} the shelf, but I wasn''t tall enough.', '(reach)'),
  (2, 'I rang the doorbell, but there was no answer. Then I tried {0} on the window, but there was still no answer.', '(knock)'),
  (3, 'We tried {0} the fire out, but without success. We had to call the fire brigade.', '(put)'),
  (4, 'Please leave me alone. I''m trying {0}.', '(concentrate)'),
  (5, 'Sue needed to borrow some money. She tried {0} Carl, but he didn''t have any.', '(ask)'),
  (6, 'Mr Bennett isn''t here right now. Please try {0} later.', '(call)'),
  (7, 'The woman''s face was familiar. I tried {0} where I''d seen her before.', '(remember)'),
  (8, 'If you have a problem with the computer, try {0} it.', '(restart)')
) as v(n, template, hint)
where es.title = '57.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '57.1'
join (values
  (1, 0, 'to reach'), (2, 0, 'knocking'), (3, 0, 'to put'), (4, 0, 'to concentrate'),
  (5, 0, 'asking'), (6, 0, 'calling'), (7, 0, 'to remember'), (8, 0, 'restarting')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '57.2', 'For each situation, write a sentence with need(s) + one of the following verbs: clean, cut, empty, paint, tighten.', 1
from units where slug = 'unit-57';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-57' where es.title = '57.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The grass is very long. {0}', null),
  (2, 'The windows are dirty. {0}', null),
  (3, 'The screws are loose. {0}', null),
  (4, 'The bin is full. {0}', null)
) as v(n, template, hint)
where es.title = '57.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '57.2'
join (values
  (1, 0, 'It needs cutting.'), (2, 0, 'They need cleaning.'),
  (3, 0, 'They need tightening.'), (4, 0, 'It needs emptying.')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '57.3', 'Which is right?', 2
from units where slug = 'unit-57';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-57' where es.title = '57.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'These clothes are dirty. They all need {0}.', '(washing / to wash)'),
  (2, 'My grandmother isn''t able to look after herself any more. She needs {0} after.', '(looking / to look)'),
  (3, 'I can''t make a decision right now. I need {0} about it.', '(thinking / to think)'),
  (4, 'Your hair is getting very long. It will need {0} soon.', '(cutting / to cut)'),
  (5, 'I need a change. I need {0} away for a while.', '(going / to go)'),
  (6, 'That shirt looks fine. You don''t need {0} it.', '(ironing / to iron)'),
  (7, 'That shirt looks fine. It doesn''t need {0}.', '(ironing / to iron)')
) as v(n, template, hint)
where es.title = '57.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '57.3'
join (values
  (1, 0, 'washing'), (2, 0, 'looking'), (3, 0, 'to think'), (4, 0, 'cutting'),
  (5, 0, 'to go'), (6, 0, 'to iron'), (7, 0, 'ironing')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '57.4', 'Put the verb into the correct form.', 3
from units where slug = 'unit-57';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-57' where es.title = '57.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''ve lost my phone. Can you help me {0} for it?', '(look)'),
  (2, 'They were talking very loudly. We couldn''t help {0} what they said.', '(overhear)'),
  (3, 'He looks so funny. Whenever I see him, I can''t help {0}.', '(smile)'),
  (4, 'The fine weather helped {0} it a really nice holiday.', '(make)'),
  (5, 'Did you help {0} the meeting?', '(organise)'),
  (6, 'I think about what happened all the time. I can''t help {0} about it.', '(think)'),
  (7, 'I can''t help you {0} a job. You have to find one yourself.', '(get)')
) as v(n, template, hint)
where es.title = '57.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '57.4'
join (values
  (1, 0, 'look', array['to look']::text[]),
  (2, 0, 'overhearing', array[]::text[]),
  (3, 0, 'smiling', array[]::text[]),
  (4, 0, 'make', array['to make']::text[]),
  (5, 0, 'organise', array['to organise']::text[]),
  (6, 0, 'thinking', array[]::text[]),
  (7, 0, 'get', array['to get']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 58: Verb + -ing or to ... 3 (like / would like etc.)
-- ============================================================

delete from units where slug = 'unit-58';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 58, 'unit-58', 'Verb + -ing or to ... 3 (like / would like etc.)', null,
  'like/love/hate can take -ing or to ... for repeated actions, but -ing for situations that already exist. would like/love/hate/prefer are usually followed by to ... . would like to have (done) = you regret now that you didn''t or couldn''t do something.', 5
from modules where slug = 'ing-and-to';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'like / love / hate + -ing or to ...',
  'For repeated actions you can use -ing or to ... after like/love/hate: "Do you like getting up early?" or "Do you like to get up early?" But we use -ing (not to ...) for a situation that already exists: "Paul lives in Berlin now. He likes living there." There''s sometimes a difference: I like doing something = I do it and enjoy it; I like to do something = I choose to do it (but maybe don''t enjoy it). Note that enjoy and mind always take -ing: "I enjoy cleaning the kitchen" (not enjoy to clean).', 0
from units where slug = 'unit-58';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'would like / would love / would hate / would prefer + to ...',
  'would like/would love etc. are usually followed by to ...: "I''d like to go away for a few days." Compare I like and I would like: "I like playing tennis" (= in general) vs "I''d like to play tennis today" (= I want to today). would mind is followed by -ing: "Would you mind closing the door, please?" (not mind to close).', 1
from units where slug = 'unit-58';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'would like to have (done)',
  'I would like to have done something = I regret now that I didn''t or couldn''t do it: "It''s a shame we didn''t see Anna. I would like to have seen her again." The same structure is used after would love/would hate/would prefer: "I would hate to have been in his position."', 2
from units where slug = 'unit-58';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-58'
join (values
  ('A', 'Do you like getting up early?', 'or Do you like to get up early?', 0),
  ('A', 'Stephanie hates flying.', 'or Stephanie hates to fly', 1),
  ('A', 'Paul lives in Berlin now. He likes living there.', 'he lives there now and likes it', 2),
  ('A', 'I like cleaning the kitchen.', '= I do it and I enjoy it', 3),
  ('A', 'I like to clean the kitchen as often as possible.', '= I choose to, but maybe don''t enjoy it', 4),
  ('A', 'I enjoy cleaning the kitchen.', 'not I enjoy to clean', 5),
  ('B', 'I''d like to go away for a few days.', null, 0),
  ('B', 'I wouldn''t like to go on holiday alone.', null, 1),
  ('B', 'I like playing tennis. / I like to play tennis.', '= I like it in general', 2),
  ('B', 'I''d like to play tennis today.', '= I want to play today', 3),
  ('B', 'Would you mind closing the door, please?', 'not mind to close', 4),
  ('C', 'It''s a shame we didn''t see Anna. I would like to have seen her again.', null, 0),
  ('C', 'We''d like to have gone away, but we were too busy at home.', null, 1),
  ('C', 'Poor David! I would hate to have been in his position.', null, 2)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of somebody trying to be serious but unable to stop laughing, captioned "She couldn''t help laughing" — cross-referenced from Unit 57''s can''t help + -ing]', 0
from units where slug = 'unit-58';

-- ------------------------------------------------------------
-- Exercises (main, book's own 58.2-58.4; 58.1 skipped — open-ended,
-- "write sentences about yourself")
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '58.2', 'Make sentences using -ing or to ... . Sometimes either form is possible.', 0
from units where slug = 'unit-58';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-58' where es.title = '58.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Jane is a biology teacher. She likes her job. {0}', '(She / like / teach / biology)'),
  (2, 'Joe always has his camera with him and takes a lot of pictures. {0}', '(He / like / take / pictures)'),
  (3, 'I used to work in a supermarket. I didn''t like it much. {0}', '(I / not / like / work / there)'),
  (4, 'Rachel is studying medicine. She likes it. {0}', '(She / like / study / medicine)'),
  (5, 'Dan is famous, but he doesn''t like it. {0}', '(He / not / like / be / famous)'),
  (6, 'Jennifer is a very careful person. She doesn''t take many risks. {0}', '(She / not / like / take / risks)'),
  (7, 'I don''t like surprises. {0}', '(I / like / know / things / in advance)')
) as v(n, template, hint)
where es.title = '58.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '58.2'
join (values
  (1, 0, 'She likes teaching biology.', array[]::text[]),
  (2, 0, 'He likes taking pictures.', array['He likes to take pictures.']::text[]),
  (3, 0, 'I didn''t like working there.', array[]::text[]),
  (4, 0, 'She likes studying medicine.', array[]::text[]),
  (5, 0, 'He doesn''t like being famous.', array[]::text[]),
  (6, 0, 'She doesn''t like taking risks.', array['She doesn''t like to take risks.']::text[]),
  (7, 0, 'I like to know things in advance.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '58.3', 'Complete the sentences with a verb in the correct form, -ing or to ... . In two sentences either form is possible.', 1
from units where slug = 'unit-58';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-58' where es.title = '58.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '"Would you like {0} down?" "No, thanks. I''ll stand."', null),
  (2, 'The music is very loud. Would you mind {0} it down?', null),
  (3, 'How do you relax? What do you like {0} in your spare time?', null),
  (4, 'When I have to take a train, I''m always worried that I''ll miss it. So I like {0} to the station in plenty of time.', null),
  (5, 'I enjoy {0} busy. I don''t like it when there''s nothing to do.', null),
  (6, 'I would love {0} to your wedding, but I''m afraid I''ll be away.', null),
  (7, 'I don''t like {0} in this part of town. I want to move somewhere else.', null),
  (8, 'Do you have a minute? I''d like {0} to you about something.', null),
  (9, 'If there''s bad news and good news, I like {0} the bad news first.', null),
  (10, 'Shall we leave now, or would you prefer {0} a little?', null),
  (11, 'Steve wants to win every time. He hates {0}.', null)
) as v(n, template, hint)
where es.title = '58.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '58.3'
join (values
  (1, 0, 'to sit', array[]::text[]),
  (2, 0, 'turning', array[]::text[]),
  (3, 0, 'doing', array['to do']::text[]),
  (4, 0, 'to get', array[]::text[]),
  (5, 0, 'being', array[]::text[]),
  (6, 0, 'to come', array['to go']::text[]),
  (7, 0, 'living', array['being']::text[]),
  (8, 0, 'to talk', array[]::text[]),
  (9, 0, 'to have', array['to know', 'to get', 'to hear', 'to be told']::text[]),
  (10, 0, 'to wait', array[]::text[]),
  (11, 0, 'losing', array['to lose']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '58.4', 'Write sentences using would ... to have (done). Use the verbs in brackets.', 2
from units where slug = 'unit-58';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-58' where es.title = '58.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It''s a shame I didn''t see the programme. {0}', '(like)'),
  (2, 'I''m glad I didn''t lose my watch. {0}', '(hate)'),
  (3, 'It''s too bad I didn''t meet your parents. {0}', '(love)'),
  (4, 'I''m glad I wasn''t alone. {0}', '(not / like)'),
  (5, 'We should have travelled by train. {0}', '(prefer)')
) as v(n, template, hint)
where es.title = '58.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '58.4'
join (values
  (1, 0, 'I would like to have seen the programme.', array['I''d like to have seen the programme.']::text[]),
  (2, 0, 'I would hate to have lost my watch.', array['I''d hate to have lost my watch.']::text[]),
  (3, 0, 'I would love to have met your parents.', array['I''d love to have met your parents.']::text[]),
  (4, 0, 'I wouldn''t like to have been alone.', array[]::text[]),
  (5, 0, 'I would prefer to have travelled by train.', array['I''d prefer to have travelled by train.']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
