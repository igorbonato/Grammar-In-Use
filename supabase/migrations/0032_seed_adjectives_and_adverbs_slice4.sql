-- Marco 4 (slice 31): seeds the fourth slice of the "Adjectives and
-- adverbs" module — unit 104 (quite, pretty, rather and fairly), seeded
-- alone since it doesn't pair as cleanly with a neighbouring unit as the
-- rest of this module.
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`, re-extracted in plain mode for 104.2's scrambled
-- word-order items) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 104.3 ("Use your own ideas to complete these sentences. Use rather +
-- adjective") is skipped as open-ended — the Key itself labels it
-- "Example answers" for genuinely personal completions, same policy as
-- every prior module.
--
-- 104.4 ("What does quite mean in these sentences? Tick the right
-- meaning.") is a two-category tick-box exercise in the book, not a
-- fill-in-blank — adapted into a short-answer format asking which of the
-- two meanings applies (''more than a little'' vs ''completely''), the
-- same two labels the book itself uses for the two columns.
--
-- Safe to re-run: unit 104 deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 104: quite, pretty, rather and fairly
-- ============================================================

delete from units where slug = 'unit-104';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 104, 'unit-104', 'quite, pretty, rather and fairly', null,
  'Quite and pretty both mean "less than very, but more than a little" (she''s quite/pretty famous); pretty is informal and spoken. Rather is similar but often used for negative ideas (rather cloudy) — for positive ideas it means "unusually/surprisingly" (rather good). Fairly is weaker than the others (fairly big = not very big). Quite also has a separate meaning, "completely", with certain adjectives like sure/right/true/different/impossible (quite sure = completely sure).', 6
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'quite and pretty',
  'Quite and pretty are similar in meaning (= less than ''very'', but more than ''a little''): I''m surprised you haven''t heard of her. She''s quite famous. or She''s pretty famous. (= less than ''very famous'', but more than ''a little famous'') Anna lives quite near me, so we see each other pretty often. Pretty is an informal word and is used mainly in spoken English. Quite goes before a/an: We live in quite an old house. (not a quite old house) Compare: Sarah has quite a good job. Sarah has a pretty good job. You can also use quite (but not pretty) in the following ways: quite a/an + noun (without an adjective) — I didn''t expect to see them. It was quite a surprise. (= quite a big surprise) quite a lot (of ...) — There were quite a lot of guests at the wedding. quite + verb, especially like and enjoy — I quite like tennis, but it''s not my favourite sport.', 0
from units where slug = 'unit-104';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'rather',
  'Rather is similar to quite and pretty. We often use rather for negative ideas (things we think are not good): The weather isn''t so good. It''s rather cloudy. Paul is rather shy. He doesn''t talk very much. Quite is also possible in these examples. When we use rather for positive ideas (good/nice etc.), it means ''unusually'' or ''surprisingly'': These oranges are rather good. Where did you get them?', 1
from units where slug = 'unit-104';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'fairly',
  'Fairly is weaker than quite/rather/pretty. For example, if something is fairly good, it is not very good and it could be better: My room is fairly big, but I''d prefer a bigger one. We see each other fairly often, but not as often as we used to.', 2
from units where slug = 'unit-104';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'quite = completely',
  'Quite also means ''completely''. For example: ''Are you sure?'' ''Yes, quite sure.'' (= completely sure) Quite means ''completely'' with a number of adjectives, especially: sure, certain, right, wrong, true, safe, clear, obvious, different, unnecessary, incredible, extraordinary, amazing, impossible. She was quite different from what I expected. (= completely different) Everything they said was quite true. (= completely true) We also use quite (= completely) with some verbs. For example: I quite agree with you. (= I completely agree) not quite = not completely: I don''t quite understand what you mean. ''Are you ready yet?'' ''Not quite.'' (= not completely) Compare the two meanings of quite: The story is quite interesting. (= less than ''very interesting'') The story is quite true. (= completely true)', 3
from units where slug = 'unit-104';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-104'
join (values
  ('A', 'She''s quite famous. or She''s pretty famous.', 'less than very famous, but more than a little famous', 0),
  ('A', 'Anna lives quite near me, so we see each other pretty often.', null, 1),
  ('A', 'We live in quite an old house.', 'not a quite old house', 2),
  ('A', 'Sarah has quite a good job. Sarah has a pretty good job.', null, 3),
  ('A', 'It was quite a surprise.', '= quite a big surprise', 4),
  ('A', 'There were quite a lot of guests at the wedding.', null, 5),
  ('A', 'I quite like tennis, but it''s not my favourite sport.', null, 6),
  ('B', 'The weather isn''t so good. It''s rather cloudy.', null, 0),
  ('B', 'Paul is rather shy. He doesn''t talk very much.', null, 1),
  ('B', 'These oranges are rather good. Where did you get them?', '= unusually/surprisingly good', 2),
  ('C', 'My room is fairly big, but I''d prefer a bigger one.', null, 0),
  ('C', 'We see each other fairly often, but not as often as we used to.', null, 1),
  ('D', '''Are you sure?'' ''Yes, quite sure.''', '= completely sure', 0),
  ('D', 'She was quite different from what I expected.', '= completely different', 1),
  ('D', 'Everything they said was quite true.', '= completely true', 2),
  ('D', 'I quite agree with you.', '= I completely agree', 3),
  ('D', 'I don''t quite understand what you mean.', 'not quite = not completely', 4),
  ('D', '''Are you ready yet?'' ''Not quite.''', '= not completely', 5),
  ('D', 'The story is quite interesting.', '= less than very interesting', 6),
  ('D', 'The story is quite true.', '= completely true', 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 104.1-104.2, 104.4-104.5; 104.3 skipped as
-- open-ended. Each renumbered from 1, dropping the book's own worked
-- example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '104.1', 'Complete the sentences using quite ... . Choose from: famous, hungry, late, noisy, often, old, surprised.', 0
from units where slug = 'unit-104';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-104' where es.title = '104.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m {0}. Is there anything to eat?', null),
  (2, 'We go to the cinema {0} — maybe once a month.', null),
  (3, 'We live near a very busy road, so it''s often {0}.', null),
  (4, 'I didn''t expect Lisa to contact me. I was {0} when she phoned.', null),
  (5, 'I went to bed {0} last night, so I''m a bit tired this morning.', null),
  (6, 'I don''t know exactly when this house was built, but it''s {0}.', null)
) as v(n, template, hint)
where es.title = '104.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '104.1'
join (values
  (1, 'quite hungry'), (2, 'quite often'), (3, 'quite noisy'),
  (4, 'quite surprised'), (5, 'quite late'), (6, 'quite old')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '104.2', 'Put the words in the right order to complete the sentences.', 1
from units where slug = 'unit-104';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-104' where es.title = '104.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Tom likes to sing. He has {0}.', '(voice / quite / good / a)'),
  (2, 'The bus stop wasn''t near the hotel. We had to walk {0}.', '(quite / way / a / long)'),
  (3, 'It''s not so warm today. There''s {0}.', '(a / wind / cold / pretty)'),
  (4, 'The roads were busy. There was {0}.', '(lot / traffic / a / of / quite)'),
  (5, 'I''m tired. I''ve had {0}.', '(pretty / day / a / busy)'),
  (6, 'Sarah hasn''t been working here long. She {0}.', '(fairly / started / recently)')
) as v(n, template, hint)
where es.title = '104.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '104.2'
join (values
  (1, 'quite a good voice'), (2, 'quite a long way'), (3, 'a pretty cold wind'),
  (4, 'quite a lot of traffic'), (5, 'a pretty busy day'), (6, 'started fairly recently')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '104.4', 'What does quite mean in these sentences — more than "a little" (less than "very"), or "completely"?', 2
from units where slug = 'unit-104';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-104' where es.title = '104.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Anna''s English is quite good. What does quite mean here?', '(more than a little / completely)'),
  (2, 'I couldn''t believe it. It was quite incredible. What does quite mean here?', '(more than a little / completely)'),
  (3, 'My bedroom is quite big. What does quite mean here?', '(more than a little / completely)'),
  (4, 'I''m quite tired. I think I''ll go to bed. What does quite mean here?', '(more than a little / completely)'),
  (5, 'I quite agree with you. What does quite mean here?', '(more than a little / completely)')
) as v(n, template, hint)
where es.title = '104.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '104.4'
join (values
  (1, 'more than a little'), (2, 'completely'), (3, 'more than a little'),
  (4, 'more than a little'), (5, 'completely')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '104.5', 'Complete these sentences using quite ... . Choose from: different, impossible, right, safe, sure, true.', 3
from units where slug = 'unit-104';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-104' where es.title = '104.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You won''t fall. The ladder is {0}.', null),
  (2, 'I''m afraid I can''t do what you ask. It''s {0}.', null),
  (3, 'I completely agree with you. You are {0}.', null),
  (4, 'You can''t compare the two things. They are {0}.', null),
  (5, 'I think I saw them go out, but I''m not {0}.', null)
) as v(n, template, hint)
where es.title = '104.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '104.5'
join (values
  (1, 'quite safe'), (2, 'quite impossible'), (3, 'quite right'), (4, 'quite different'), (5, 'quite sure')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;
