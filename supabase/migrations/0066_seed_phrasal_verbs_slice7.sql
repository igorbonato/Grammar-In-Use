-- Marco 4 (slice 65): seeds the seventh slice of the "Phrasal verbs"
-- module — unit 143 (Phrasal verbs 7: up (1)).
--
-- Sourced from pdf/Modulos/Phrasal verbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against
-- pdf/Key to Exercises.pdf (plain mode).
--
-- 143.1 is picture-based (4 small pictures) — a theory_images
-- placeholder plus each scene rebuilt from its picture caption.
--
-- Safe to re-run: unit 143 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 143: Phrasal verbs 7 up (1)
-- ============================================================

delete from units where slug = 'unit-143';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 143, 'unit-143', 'Phrasal verbs 7 up (1)', null,
  'go up / come up / walk up (to ...) = approach. catch up (with somebody) = move faster so you reach them. keep up (with somebody) = continue at the same speed or level. set up an organisation/company/business/system/website = start it. take up a hobby/sport/activity = start doing it. fix up a meeting = arrange it. grow up = become an adult; bring up a child = raise/look after a child. clean up / clear up / tidy up = make something clean, tidy; wash up = wash the plates and dishes after a meal. end up somewhere/doing something = that''s what happens in the end. give up = stop trying; give something up = stop doing it. make up something / be made up of something = consist of. take up space or time = use it. turn up / show up = arrive, appear. use something up = use all of it.', 6
from modules where slug = 'phrasal-verbs';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'go up, come up, walk up (to ...) = approach',
  'catch up (with somebody), catch somebody up = move faster than people in front of you so that you reach them. keep up (with somebody) = continue at the same speed or level.', 0
from units where slug = 'unit-143';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'set up, take up, fix up',
  'set up an organisation, a company, a business, a system, a website etc. = start it. take up a hobby, a sport, an activity etc. = start doing it. fix up a meeting etc. = arrange it.', 1
from units where slug = 'unit-143';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'grow up, bring up',
  'grow up = become an adult. bring up a child = raise, look after a child.', 2
from units where slug = 'unit-143';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'clean up, clear up, tidy up, wash up',
  'clean up, clear up, tidy up = make something clean, tidy etc. wash up = wash the plates, dishes etc. after a meal.', 3
from units where slug = 'unit-143';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'E', 'end up, give up, make up, take up, turn up, use up',
  'end up somewhere, end up doing something etc. = that''s what happens in the end. give up = stop trying; give something up = stop doing it. make up something, be made up of something = consist of. take up space or time = use space or time. turn up, show up = arrive, appear. use something up = use all of it so that nothing is left.', 4
from units where slug = 'unit-143';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-143'
join (values
  ('A', 'A man came up to me in the street and asked me for money.', null, 0),
  ('A', 'I''m not ready to go yet. You go on and I''ll catch up with you.', 'or I''ll catch you up', 1),
  ('A', 'You''re walking too fast. I can''t keep up (with you).', null, 2),
  ('A', 'You''re doing well. Keep it up!', null, 3),
  ('B', 'The government has set up a committee to investigate the problem.', null, 0),
  ('B', 'Laura took up photography a few years ago. She takes really good pictures.', null, 1),
  ('B', 'We''ve fixed up a meeting for next Monday.', null, 2),
  ('C', 'Amy was born in Hong Kong but grew up in Australia.', null, 0),
  ('C', 'Her parents died when she was a child and she was brought up by her grandparents.', null, 1),
  ('D', 'Look at this mess! Who''s going to tidy up?', 'or ... to tidy it up', 0),
  ('D', 'I hate washing up.', 'or I hate doing the washing-up', 1),
  ('E', 'There was a fight in the street and three men ended up in hospital.', null, 0),
  ('E', 'I couldn''t find a hotel and ended up sleeping on a bench at the station.', null, 1),
  ('E', 'Sue got bored with her job and decided to give it up.', '= stop doing it', 2),
  ('E', 'Children under 16 make up half the population of the city.', null, 3),
  ('E', 'Air is made up mainly of nitrogen and oxygen.', '= Air consists of ...', 4),
  ('E', 'Most of the space in the room was taken up by a large table.', null, 5),
  ('E', 'We arranged to meet David last night, but he didn''t turn up.', null, 6),
  ('E', 'I''m going to make soup. We have a lot of vegetables and I want to use them up.', null, 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 143.1-143.3; each renumbered from 1,
-- dropping the book's own worked example(s))
-- ------------------------------------------------------------

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: four small pictures used in exercise 143.1 — Kate walking up to a front door and ringing the doorbell; Tom, a long way behind other runners, catching up with them; Tanya running fast ahead of Paul, who cannot keep up with her]', 0
from units where slug = 'unit-143';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '143.1', 'Look at the pictures and complete the sentences. Use three words each time, including a verb from Section A.', 0
from units where slug = 'unit-143';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-143' where es.title = '143.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Kate {0} the front door of the house and rang the doorbell.', null),
  (2, 'Tom was a long way behind the other runners, but he managed to {0} them.', null),
  (3, 'Tanya was running too fast for Paul. He couldn''t {0} her.', null)
) as v(n, template, hint)
where es.title = '143.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '143.1'
join (values
  (1, 'went up to', array['walked up to']::text[]),
  (2, 'catch up with', array[]::text[]),
  (3, 'keep up with', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '143.2', 'Complete the sentences. Use a verb (in the correct form) + up. Choose from: end, end, give, give, grow, make, take, take, turn, use, wash.', 1
from units where slug = 'unit-143';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-143' where es.title = '143.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m feeling very tired now. I''ve {0} all my energy.', null),
  (2, 'After dinner I {0} and put the dishes away.', null),
  (3, 'People often ask children what they want to be when they {0}.', null),
  (4, 'We arranged to meet Tom, but he didn''t {0}.', null),
  (5, 'Two years ago James {0} his studies to be a professional footballer.', null),
  (6, 'I don''t do any sports right now, but I''m thinking of {0} tennis.', null),
  (7, 'You don''t have enough determination. You {0} too easily.', null),
  (8, 'Karen travelled a lot for a few years and {0} in Canada, where she still lives.', null),
  (9, 'I do a lot of gardening. It {0} most of my free time.', null),
  (10, 'There are two universities in the city. Students {0} 20 per cent of the population.', null)
) as v(n, template, hint)
where es.title = '143.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '143.2'
join (values
  (1, 'used up', array[]::text[]),
  (2, 'washed up', array[]::text[]),
  (3, 'grow up', array[]::text[]),
  (4, 'turn up', array['show up']::text[]),
  (5, 'gave up', array[]::text[]),
  (6, 'taking up', array[]::text[]),
  (7, 'give up', array[]::text[]),
  (8, 'ended up', array[]::text[]),
  (9, 'takes up', array[]::text[]),
  (10, 'make up', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '143.3', 'Complete the sentences. Use a verb + up (with any other necessary words). Choose from: bring, catch, fix, give, give, go, keep, keep, make, set, tidy.', 2
from units where slug = 'unit-143';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-143' where es.title = '143.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'The room is in a mess. I''d better {0}.', null),
  (2, 'We expect to go away on holiday in July, but we haven''t {0} yet.', null),
  (3, 'Steven is having problems at school. He can''t {0} the rest of the class.', null),
  (4, 'I {0} in the country, but I have always preferred cities.', null),
  (5, 'Our team lost the game. We started well, but we couldn''t {0}.', null),
  (6, 'I saw Mike at the party, so I {0} him and said hello.', null),
  (7, 'Helen has her own website. A friend of hers helped her to {0}.', null),
  (8, 'Ben was learning to play the guitar, but he found it hard and in the end he {0}.', null),
  (9, 'When I was on holiday, I joined a tour group. The group {0} two Americans, three Japanese, five Germans and myself.', null)
) as v(n, template, hint)
where es.title = '143.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '143.3'
join (values
  (1, 'tidy it up', array['tidy up']::text[]),
  (2, 'fixed it up', array[]::text[]),
  (3, 'keep up with', array[]::text[]),
  (4, 'was brought up', array[]::text[]),
  (5, 'keep it up', array[]::text[]),
  (6, 'went up to', array[]::text[]),
  (7, 'set it up', array[]::text[]),
  (8, 'gave it up', array['gave up']::text[]),
  (9, 'was made up of', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
