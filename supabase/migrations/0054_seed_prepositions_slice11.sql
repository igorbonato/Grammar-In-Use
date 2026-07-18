-- Marco 4 (slice 53): seeds the eleventh slice of the "Prepositions"
-- module — unit 131 (Adjective + preposition 2).
--
-- Sourced from pdf/Modulos/Prepositions.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 131.2 ("Write sentences about yourself. Are you good at these things or
-- not?") is skipped as open-ended — the Key labels it "Example answers"
-- for genuinely personal completions, same policy as every prior module.
--
-- Safe to re-run: unit 131 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 131: Adjective + preposition 2
-- ============================================================

delete from units where slug = 'unit-131';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 131, 'unit-131', 'Adjective + preposition 2', null,
  'afraid/scared/frightened/terrified, fond/proud/ashamed/jealous/envious, suspicious/critical/tolerant, aware/conscious, capable/incapable, full/short, typical, certain/sure — all take of. good/bad/hopeless etc. take at; married/engaged/similar take to; different takes from or to; interested takes in; keen/dependent take on (but independent of); crowded takes with; famous/responsible take for.', 10
from modules where slug = 'prepositions';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'adjective + of',
  'afraid / scared / frightened / terrified of ...: ''Are you afraid of spiders?'' ''Yes, I''m terrified of them.'' fond / proud / ashamed / jealous / envious of ...: Why is he so jealous of other people? suspicious / critical / tolerant of ...: They didn''t trust me. They were suspicious of my motives. aware / conscious of ...: ''Did you know he was married?'' ''No, I wasn''t aware of that.'' capable / incapable of ...: I''m sure you are capable of doing the job well. full / short of ...: Amy is a very active person. She''s always full of energy. I''m a bit short of money. Can you lend me some? typical of ...: He''s late again. It''s typical of him to keep everybody waiting. certain / sure of or about ...: I think she''s arriving this evening, but I''m not sure of that. or ... not sure about that.', 0
from units where slug = 'unit-131';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'adjective + at / to / from / in / on / with / for',
  'good / bad / brilliant / better / hopeless etc. at ...: I''m not very good at repairing things. (not good in repairing things) married / engaged to ...: Louise is married to an American. (not married with) but Louise is married with three children. (= she is married and has three children) similar to ...: Your handwriting is similar to mine. different from or different to ...: The film was different from what I''d expected. or ... different to what I''d expected. interested in ...: Are you interested in art? keen on ...: We stayed at home. Chris wasn''t keen on going out. dependent on ... (but independent of ...): I don''t want to be dependent on anybody. crowded with (people etc.): The streets were crowded with tourists. (but ... full of tourists) famous for ...: The Italian city of Florence is famous for its art treasures. responsible for ...: Who was responsible for all that noise last night?', 1
from units where slug = 'unit-131';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-131'
join (values
  ('A', '''Are you afraid of spiders?'' ''Yes, I''m terrified of them.''', null, 0),
  ('A', 'Why is he so jealous of other people?', null, 1),
  ('A', 'They were suspicious of my motives.', null, 2),
  ('A', 'I''m a bit short of money.', null, 3),
  ('A', 'It''s typical of him to keep everybody waiting.', null, 4),
  ('B', 'I''m not very good at repairing things.', 'not good in repairing things', 0),
  ('B', 'Louise is married to an American.', 'not married with', 1),
  ('B', 'Your handwriting is similar to mine.', null, 2),
  ('B', 'The film was different from what I''d expected.', 'or different to', 3),
  ('B', 'Are you interested in art?', null, 4),
  ('B', 'Chris wasn''t keen on going out.', null, 5),
  ('B', 'The streets were crowded with tourists.', 'but full of tourists', 6),
  ('B', 'Florence is famous for its art treasures.', null, 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 131.1, 131.3-131.5; 131.2 skipped as
-- open-ended. Each renumbered from 1, dropping the book's own worked
-- example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '131.1', 'Complete the sentences using an adjective + of. Choose from: ashamed, aware, capable, envious, proud, scared, typical.', 0
from units where slug = 'unit-131';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-131' where es.title = '131.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My children have done very well. I''m {0} them.', null),
  (2, 'What I did was very bad. I''m {0} myself.', null),
  (3, 'She always behaves like that. It''s {0} her.', null),
  (4, 'He wouldn''t be able to run his own business. He''s not {0} it.', null),
  (5, 'I don''t like going up ladders. I''m {0} heights.', null),
  (6, 'Nobody told me she was ill. I wasn''t {0} it.', null),
  (7, 'I wish I had what Sarah has. I''m {0} her.', null)
) as v(n, template, hint)
where es.title = '131.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '131.1'
join (values
  (1, 'proud of'), (2, 'ashamed of'), (3, 'typical of'), (4, 'capable of'),
  (5, 'scared of'), (6, 'aware of'), (7, 'envious of')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '131.3', 'Complete the sentences using an adjective + preposition. Choose from: afraid, capable, different, interested, proud, responsible, similar.', 1
from units where slug = 'unit-131';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-131' where es.title = '131.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Your camera is {0} mine, but it isn''t exactly the same.', null),
  (2, 'Don''t worry. I''ll look after you. There''s nothing to be {0}.', null),
  (3, 'I never watch the news on TV. I''m not {0} the news.', null),
  (4, 'The editor is the person who is {0} what appears in a newspaper.', null),
  (5, 'Sarah is a keen gardener and is very {0} her garden.', null),
  (6, 'I was surprised when I first met Tina. She was {0} what I expected.', null),
  (7, 'Ben could become world champion one day. He''s {0} it.', null)
) as v(n, template, hint)
where es.title = '131.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '131.3'
join (values
  (1, 'similar to', array[]::text[]),
  (2, 'afraid of', array[]::text[]),
  (3, 'interested in', array[]::text[]),
  (4, 'responsible for', array[]::text[]),
  (5, 'proud of', array[]::text[]),
  (6, 'different from', array['different to']::text[]),
  (7, 'capable of', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '131.4', 'Complete the second sentence so that it means the same as the first.', 2
from units where slug = 'unit-131';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-131' where es.title = '131.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'There was a lot of furniture in the room. The room was full {0}', null),
  (2, 'I don''t like sport very much. I''m not very keen {0}', null),
  (3, 'We don''t have enough time. We''re short {0}', null),
  (4, 'Helen does her job very well. Helen is very good {0}', null),
  (5, 'Steven''s wife is a doctor. Steven is married {0}', null),
  (6, 'I don''t trust Robert. I''m suspicious {0}', null),
  (7, 'My problem is not the same as yours. My problem is different {0}', null)
) as v(n, template, hint)
where es.title = '131.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '131.4'
join (values
  (1, 'of furniture.', array[]::text[]),
  (2, 'on sport.', array[]::text[]),
  (3, 'of time.', array[]::text[]),
  (4, 'at her job.', array[]::text[]),
  (5, 'to a doctor.', array[]::text[]),
  (6, 'of him.', array['of Robert.']::text[]),
  (7, 'from yours.', array['from your problem.', 'to yours.', 'to your problem.']::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '131.5', 'Put in the correct preposition.', 3
from units where slug = 'unit-131';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-131' where es.title = '131.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'My home town is not a very interesting place. It''s not famous {0} anything.', null),
  (2, 'Kate is very fond {0} her younger brother.', null),
  (3, 'You look bored. You don''t seem interested {0} what I''m saying.', null),
  (4, '''Our flight departs at 10.35.'' ''Are you sure {0} that?''', null),
  (5, 'I wanted to go out for a meal, but nobody else was keen {0} the idea.', null),
  (6, 'These days everybody is aware {0} the dangers of smoking.', null),
  (7, 'The station platform was crowded {0} people waiting for the train.', null),
  (8, 'Mark has no money of his own. He''s completely dependent {0} his parents.', null),
  (9, 'We''re short {0} staff in our office right now. We need more people to do the work.', null)
) as v(n, template, hint)
where es.title = '131.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '131.5'
join (values
  (1, 'for'), (2, 'of'), (3, 'in'), (4, 'of'), (5, 'on'),
  (6, 'of'), (7, 'with'), (8, 'on'), (9, 'of')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
