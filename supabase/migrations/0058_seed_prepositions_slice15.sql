-- Marco 4 (slice 57): seeds the fifteenth slice of the "Prepositions"
-- module — unit 135 (Verb + preposition 4: of/for/from/on).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 135.4 item 9 ("I complimented her ___ her English") sits right at the
-- page break before unit 136 starts and was easy to miss on a first pass
-- of the extraction — recovered by reading a wider line range.
--
-- Safe to re-run: unit 135 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 135: Verb + preposition 4 of/for/from/on
-- ============================================================

delete from units where slug = 'unit-135';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 135, 'unit-135', 'Verb + preposition 4 of/for/from/on', null,
  'accuse/suspect somebody of; approve/disapprove of; die of/from; consist of. pay (somebody) for (but pay a bill/fine/rent, no preposition); thank/forgive/blame somebody for; apologise (to somebody) for; blame something ON somebody. suffer from; protect somebody/something from. depend/rely on; live on money/food; congratulate/compliment somebody on.', 14
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'verb + of',
  'accuse / suspect somebody of ...: Tina accused me of being selfish. Some students were suspected of cheating in the exam. approve / disapprove of ...: His parents don''t approve of what he does, but they can''t stop him. die of or die from an illness etc.: ''What did he die of?'' ''A heart attack.'' consist of ...: We had an enormous meal. It consisted of seven courses.', 0
from units where slug = 'unit-135';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'verb + for',
  'pay (somebody) for ...: We didn''t have enough money to pay for the meal. (not pay the meal) But we say ''pay a bill / a fine / a fee / tax / rent / a sum of money'' etc. (no preposition): We didn''t have enough money to pay the rent. thank / forgive somebody for ...: I''ll never forgive them for what they did. apologise (to somebody) for ...: When I realised I was wrong, I apologised (to them) for my mistake. blame somebody/something for ..., somebody is to blame for ...: Everybody blamed me for the accident. Everybody said that I was to blame for the accident. blame (a problem etc.) on ...: It wasn''t my fault. Don''t blame it on me.', 1
from units where slug = 'unit-135';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'verb + from',
  'suffer from an illness etc.: There''s been an increase in the number of people suffering from heart disease. protect somebody/something from ...: Sun cream protects the skin from the sun.', 2
from units where slug = 'unit-135';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'verb + on',
  'depend on ..., rely on ...: I don''t know what time we''ll arrive. It depends on the traffic. You can rely on Anna. She always keeps her promises. You can use depend + when/where/how etc. with or without on: ''Are you going to buy it?'' ''It depends how much it is.'' (or ''It depends on how much ...'') live on money/food: Michael''s salary is very low. It isn''t enough to live on. congratulate / compliment somebody on ...: I congratulated her on doing so well in her exams. The meal was really good. I complimented Mark on his cooking skills.', 3
from units where slug = 'unit-135';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-135'
join (values
  ('A', 'Tina accused me of being selfish.', null, 0),
  ('A', 'His parents don''t approve of what he does.', null, 1),
  ('A', 'It consisted of seven courses.', null, 2),
  ('B', 'We didn''t have enough money to pay for the meal.', 'not pay the meal', 0),
  ('B', 'We didn''t have enough money to pay the rent.', null, 1),
  ('B', 'I''ll never forgive them for what they did.', null, 2),
  ('B', 'Everybody blamed me for the accident.', null, 3),
  ('B', 'Don''t blame it on me.', null, 4),
  ('C', 'People suffering from heart disease.', null, 0),
  ('C', 'Sun cream protects the skin from the sun.', null, 1),
  ('D', 'It depends on the traffic.', null, 0),
  ('D', 'You can rely on Anna.', null, 1),
  ('D', 'It isn''t enough to live on.', null, 2),
  ('D', 'I congratulated her on doing so well in her exams.', null, 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 135.1-135.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each
-- exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '135.1', 'Put in the correct preposition. If no preposition is necessary, leave the space empty.', 0
from units where slug = 'unit-135';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-135' where es.title = '135.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Are you going to apologise {0} what you did?', null),
  (2, 'The apartment consists {0} three rooms, a kitchen and bathroom.', null),
  (3, 'I was accused {0} lying, but I was telling the truth.', null),
  (4, 'We finished our meal, paid {0} the bill, and left the restaurant.', null),
  (5, 'The accident was my fault, so I had to pay {0} the repairs.', null),
  (6, 'Some people are dying {0} hunger, while others eat too much.', null),
  (7, 'I called Helen to thank her {0} the present she sent me.', null),
  (8, 'The government is popular. Most people approve {0} its policies.', null),
  (9, 'Do you blame the government {0} our economic problems?', null),
  (10, 'When something goes wrong, you always blame it {0} other people.', null),
  (11, 'Forgive me {0} interrupting, but I''d like to ask you something.', null)
) as v(n, template, hint)
where es.title = '135.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '135.1'
join (values
  (1, 'for', array[]::text[]),
  (2, 'of', array[]::text[]),
  (3, 'of', array[]::text[]),
  (4, '', array[]::text[]),
  (5, 'for', array[]::text[]),
  (6, 'of', array['from']::text[]),
  (7, 'for', array[]::text[]),
  (8, 'of', array[]::text[]),
  (9, 'for', array[]::text[]),
  (10, 'on', array[]::text[]),
  (11, 'for', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '135.2', 'Complete the second sentence so that it means the same as the first.', 1
from units where slug = 'unit-135';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-135' where es.title = '135.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The misunderstanding was my fault, so I apologised. I apologised {0}', null),
  (2, 'Jane won the tournament, so I congratulated her. I congratulated {0}', null),
  (3, 'He has enemies, and he has a bodyguard to protect him. He has a bodyguard to protect {0}', null),
  (4, 'Sandra eats only bread and eggs. Sandra lives {0}', null),
  (5, 'You can''t say that the bad weather is my fault. You can''t blame {0}', null),
  (6, 'The police thought my friend had stolen a car. The police suspected {0}', null)
) as v(n, template, hint)
where es.title = '135.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '135.2'
join (values
  (1, 'for the misunderstanding.', array[]::text[]),
  (2, 'her on winning the tournament.', array[]::text[]),
  (3, 'him from his enemies.', array[]::text[]),
  (4, 'on bread and eggs.', array[]::text[]),
  (5, 'me for the bad weather.', array['the bad weather on me.']::text[]),
  (6, 'my friend of stealing a car.', array['that my friend had stolen a car.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '135.3', 'Complete the sentences using these verbs (in the correct form) + a preposition: accuse, apologise, congratulate, depend, live, pay, suffer.', 2
from units where slug = 'unit-135';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-135' where es.title = '135.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'When you went to the theatre with Paul, who {0} the tickets?', null),
  (2, 'It''s not pleasant when you are {0} something you didn''t do.', null),
  (3, 'We hope to go to the beach tomorrow, but it {0} the weather.', null),
  (4, 'Things are cheap there. You can {0} very little money.', null),
  (5, 'You were rude to Lisa. I think you should {0} her.', null),
  (6, 'Alex {0} back pain. He spends too much time working at his desk.', null),
  (7, 'I called Jack to {0} him {1} passing his driving test.', null)
) as v(n, template, hint)
where es.title = '135.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '135.3'
join (values
  (1, 0, 'paid for'),
  (2, 0, 'accused of'),
  (3, 0, 'depends on'),
  (4, 0, 'live on'),
  (5, 0, 'apologise to'),
  (6, 0, 'suffers from'),
  (7, 0, 'congratulate'), (7, 1, 'on')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '135.4', 'Put in the correct preposition. If no preposition is necessary, leave the space empty.', 3
from units where slug = 'unit-135';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-135' where es.title = '135.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Vaccinations may protect you {0} a number of diseases.', null),
  (2, 'You know you can always rely {0} me if you need any help.', null),
  (3, 'Sophie will have to borrow money to pay {0} her college fees.', null),
  (4, 'She''s often unwell. She suffers {0} very bad headaches.', null),
  (5, 'I don''t know whether I''ll go out tonight. It depends {0} how I feel.', null),
  (6, 'Anna doesn''t have a job. She depends {0} her parents for money.', null),
  (7, 'My usual breakfast consists {0} fruit, cereal and coffee.', null),
  (8, 'I complimented her {0} her English. It was really good.', null)
) as v(n, template, hint)
where es.title = '135.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '135.4'
join (values
  (1, 'from', array[]::text[]),
  (2, 'on', array[]::text[]),
  (3, '', array[]::text[]),
  (4, 'from', array[]::text[]),
  (5, '', array['on']::text[]),
  (6, 'on', array[]::text[]),
  (7, 'of', array[]::text[]),
  (8, 'on', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
