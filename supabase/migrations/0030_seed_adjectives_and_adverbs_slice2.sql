-- Marco 4 (slice 29): seeds the second slice of the "Adjectives and
-- adverbs" module — units 100 (Adjectives and adverbs 1: quick/quickly)
-- and 101 (Adjectives and adverbs 2: well, fast, late, hard/hardly).
--
-- Sourced from pdf/Modulos/Adjectives and adverbs.pdf (extracted via
-- `pdftotext -layout`) and cross-checked against pdf/Key to Exercises.pdf
-- (plain mode).
--
-- 100.1 item 6 (renumbered 5) is the only three-blank item in this slice
-- (perfectly ... slowly ... clearly).
--
-- 100.3 item 7's Key gives two acceptable words ("financially or
-- completely") for one blank — seeded financially as correct_answer with
-- completely as an accepted_alternative.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

-- ============================================================
-- Unit 100: Adjectives and adverbs 1 (quick/quickly)
-- ============================================================

delete from units where slug = 'unit-100';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 100, 'unit-100', 'Adjectives and adverbs 1 (quick/quickly)', null,
  'Adjectives (quick/careful etc.) tell us about a noun and go before it: Sam is a careful driver. Adverbs (quickly/carefully etc.) tell us about a verb — how somebody does something or how something happens — and go with the verb: Sam drove carefully. Not all words ending in -ly are adverbs (friendly, lively, elderly, lonely, lovely are adjectives). Adverbs can also go before adjectives (reasonably cheap) or before other adverbs (incredibly quickly), and before past participles (seriously injured).', 2
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'adjective + -ly = adverb',
  'You can say: Our holiday was too short — the time passed very quickly. Two people were seriously injured in the accident. Quickly and seriously are adverbs. Many adverbs are adjective + -ly: quick → quickly, serious → seriously, careful → carefully, bad → badly, heavy → heavily, terrible → terribly. For spelling, see Appendix 6. Not all words ending in -ly are adverbs. Some adjectives end in -ly too, for example: friendly, lively, elderly, lonely, lovely. It was a lovely day.', 0
from units where slug = 'unit-100';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'adjective or adverb?',
  'Adjectives (quick/careful etc.) tell us about a noun (somebody or something). We use adjectives before nouns: Sam is a careful driver. (not a carefully driver) We didn''t go out because of the heavy rain. Adverbs (quickly/carefully etc.) tell us about a verb (how somebody does something or how something happens): Sam drove carefully along the narrow road. (not drove careful) We didn''t go out because it was raining heavily. (not raining heavy) Compare: She speaks perfect English. (adjective + noun) She speaks English perfectly. (verb + noun + adverb)', 1
from units where slug = 'unit-100';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'adjectives after be/look/feel/sound',
  'We use adjectives after some verbs, especially be, and also look/feel/sound etc. Compare: Please be quiet. / Please speak quietly. My exam results were really bad. / I did really badly in the exam. Why do you always look so serious? / Why do you never take me seriously? I feel happy. / The children were playing happily.', 2
from units where slug = 'unit-100';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'adverbs before adjectives/adverbs/participles',
  'You can also use adverbs before adjectives and other adverbs. For example: reasonably cheap (adverb + adjective), terribly sorry (adverb + adjective), incredibly quickly (adverb + adverb). It''s a reasonably cheap restaurant and the food is extremely good. I''m terribly sorry. I didn''t mean to push you. Maria learns languages incredibly quickly. The exam was surprisingly easy. You can also use an adverb before a past participle (injured/organised/written etc.): Two people were seriously injured in the accident. (not serious injured) The conference was badly organised.', 3
from units where slug = 'unit-100';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-100'
join (values
  ('A', 'Our holiday was too short — the time passed very quickly.', null, 0),
  ('A', 'Two people were seriously injured in the accident.', null, 1),
  ('A', 'It was a lovely day.', 'lovely is an adjective, not an adverb', 2),
  ('B', 'Sam is a careful driver.', 'not a carefully driver', 0),
  ('B', 'We didn''t go out because of the heavy rain.', null, 1),
  ('B', 'Sam drove carefully along the narrow road.', 'not drove careful', 2),
  ('B', 'We didn''t go out because it was raining heavily.', 'not raining heavy', 3),
  ('B', 'She speaks perfect English.', 'adjective + noun', 4),
  ('B', 'She speaks English perfectly.', 'verb + noun + adverb', 5),
  ('C', 'Please be quiet.', null, 0),
  ('C', 'Please speak quietly.', null, 1),
  ('C', 'My exam results were really bad.', null, 2),
  ('C', 'I did really badly in the exam.', null, 3),
  ('C', 'Why do you always look so serious?', null, 4),
  ('C', 'Why do you never take me seriously?', null, 5),
  ('C', 'I feel happy.', null, 6),
  ('C', 'The children were playing happily.', null, 7),
  ('D', 'It''s a reasonably cheap restaurant and the food is extremely good.', null, 0),
  ('D', 'I''m terribly sorry. I didn''t mean to push you.', null, 1),
  ('D', 'Maria learns languages incredibly quickly.', null, 2),
  ('D', 'The exam was surprisingly easy.', null, 3),
  ('D', 'Two people were seriously injured in the accident.', 'not serious injured', 4),
  ('D', 'The conference was badly organised.', null, 5)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 100.1-100.4; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '100.1', 'Complete each sentence with an adverb. The first letters of the adverb are given.', 0
from units where slug = 'unit-100';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-100' where es.title = '100.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I had no problem finding a place to live. I found a flat quite {0}.', '(ea...)'),
  (2, 'We had to wait a long time, but we didn''t complain. We waited {0}.', '(pat...)'),
  (3, 'Nobody knew that Simon was coming to see us. He arrived {0}.', '(unex...)'),
  (4, 'Mike keeps fit by playing tennis {0}.', '(reg...)'),
  (5, 'I don''t speak French very well, but I can understand {0} if people speak {1} and {2}.', '(per...) ... (sl...) ... (cl...)')
) as v(n, template, hint)
where es.title = '100.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '100.1'
join (values
  (1, 0, 'easily'), (2, 0, 'patiently'), (3, 0, 'unexpectedly'), (4, 0, 'regularly'),
  (5, 0, 'perfectly'), (5, 1, 'slowly'), (5, 2, 'clearly')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '100.2', 'Put in the correct word.', 1
from units where slug = 'unit-100';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-100' where es.title = '100.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I think you behaved very {0}.', '(selfish / selfishly)'),
  (2, 'The weather changed {0}.', '(sudden / suddenly)'),
  (3, 'There was a {0} change in the weather.', '(sudden / suddenly)'),
  (4, 'Liz fell and hurt herself really {0}.', '(bad / badly)'),
  (5, 'I think I have flu. I feel {0}.', '(awful / awfully)'),
  (6, 'Tanya is {0} upset about losing her job.', '(terrible / terribly)'),
  (7, 'I could sit in this chair all day. It''s very {0}.', '(comfortable / comfortably)'),
  (8, 'I explained everything as {0} as I could.', '(clear / clearly)'),
  (9, 'Be careful on that ladder. It doesn''t look very {0}.', '(safe / safely)'),
  (10, 'Have a good trip and I hope you have a {0} journey.', '(safe / safely)'),
  (11, 'I''m glad you had a good trip and got home {0}.', '(safe / safely)')
) as v(n, template, hint)
where es.title = '100.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '100.2'
join (values
  (1, 'selfishly'), (2, 'suddenly'), (3, 'sudden'), (4, 'badly'), (5, 'awful'),
  (6, 'terribly'), (7, 'comfortable'), (8, 'clearly'), (9, 'safe'), (10, 'safe'), (11, 'safely')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '100.3', 'Complete each sentence using a word from the box. Sometimes you need the adjective (careful etc.) and sometimes the adverb (carefully etc.): careful(ly), complete(ly), dangerous(ly), financial(ly), fluent(ly), frequent(ly), nervous(ly), perfect(ly), permanent(ly), special(ly).', 2
from units where slug = 'unit-100';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-100' where es.title = '100.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'He''s late sometimes, but it doesn''t happen {0}.', null),
  (2, 'Maria''s English is very {0} although she makes quite a lot of mistakes.', null),
  (3, 'I cooked this meal {0} for you, so I hope you like it.', null),
  (4, 'Everything was very quiet. There was {0} silence.', null),
  (5, 'I tried on the shoes and they fitted me {0}.', null),
  (6, 'I''d like to buy a car, but it''s {0} impossible for me at the moment.', null),
  (7, 'I''m staying here only a few weeks. I won''t be living here {0}.', null),
  (8, 'Do you usually feel {0} before exams?', null),
  (9, 'Dan likes to take risks. He lives {0}.', null)
) as v(n, template, hint)
where es.title = '100.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '100.3'
join (values
  (1, 'frequently', array[]::text[]),
  (2, 'fluent', array[]::text[]),
  (3, 'specially', array[]::text[]),
  (4, 'complete', array[]::text[]),
  (5, 'perfectly', array[]::text[]),
  (6, 'financially', array['completely']::text[]),
  (7, 'permanently', array[]::text[]),
  (8, 'nervous', array[]::text[]),
  (9, 'dangerously', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '100.4', 'Choose two words (one from each box) to complete each sentence: absolutely, badly, completely, happily, reasonably, seriously, slightly, unnecessarily, unusually; changed, cheap, damaged, enormous, ill, long, married, planned, quiet.', 3
from units where slug = 'unit-100';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-100' where es.title = '100.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Will''s mother is {0} in hospital.', null),
  (2, 'This house is so big! It''s {0}.', null),
  (3, 'It wasn''t a serious accident. The car was only {0}.', null),
  (4, 'Our children are normally very lively, but they''re {0} today.', null),
  (5, 'When I returned home after 20 years, everything had {0}.', null),
  (6, 'The movie was {0}. It could have been much shorter.', null),
  (7, 'I''m surprised Amy and Joe have separated. I thought they were {0}.', null),
  (8, 'A lot went wrong during our holiday because it was {0}.', null)
) as v(n, template, hint)
where es.title = '100.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '100.4'
join (values
  (1, 'seriously ill'), (2, 'absolutely enormous'), (3, 'slightly damaged'), (4, 'unusually quiet'),
  (5, 'completely changed'), (6, 'unnecessarily long'), (7, 'happily married'), (8, 'badly planned')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 101: Adjectives and adverbs 2 (well, fast, late, hard/hardly)
-- ============================================================

delete from units where slug = 'unit-101';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 101, 'unit-101', 'Adjectives and adverbs 2 (well, fast, late, hard/hardly)', null,
  'Good is an adjective; its adverb is well (also used with past participles: well-known, well-paid). fast, hard and late are both adjectives and adverbs (a fast runner / run fast). hardly is a different word from hard — it means "very little, almost not" (I hardly know her) and goes before the verb; hardly ever means "almost never", and hardly can combine with any/anybody/anyone/anything/anywhere.', 3
from modules where slug = 'adjectives-and-adverbs';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'good and well',
  'Good is an adjective. The adverb is well: Your English is good. but You speak English well. Sophie is a good pianist. but Sophie plays the piano well. We use well (not good) with past participles (known/educated etc.). For example: well-known, well-educated, well-paid, well-behaved. Sophie''s father is a well-known writer. Well is also an adjective meaning ''in good health'': ''How are you today?'' ''I''m very well, thanks.''', 0
from units where slug = 'unit-101';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'fast, hard and late',
  'These words are both adjectives and adverbs: Darren is a fast runner. (adjective) Darren can run fast. (adverb) It''s hard to find a job right now. (adjective) Kate works hard. (adverb, not works hardly) Sorry I''m late. (adjective) I got up late. (adverb) lately = recently: Have you seen Kate lately?', 1
from units where slug = 'unit-101';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'hardly',
  'hardly = very little, almost not: Sarah wasn''t very friendly at the party. She hardly spoke to me. (= she spoke to me very little) We''ve only met once or twice. We hardly know each other. Compare hard and hardly: He tried hard to find a job, but he had no luck. (= he tried a lot, with a lot of effort) I''m not surprised he didn''t find a job. He hardly tried. (= he tried very little) Hardly goes before the verb: We hardly know each other. (not We know each other hardly) I can hardly do something = it''s very difficult for me, almost impossible: Your writing is terrible. I can hardly read it. (= it is almost impossible to read it) My leg was hurting. I could hardly walk.', 2
from units where slug = 'unit-101';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'hardly + any/anybody/anything/anywhere, hardly ever',
  'You can use hardly + any/anybody/anyone/anything/anywhere: There''s hardly anything in the fridge. ''How much money do we have?'' ''Hardly any.'' (= very little, almost none) These two cameras are very similar. There''s hardly any difference between them. The exam results were bad. Hardly anybody in our class passed. (= very few students passed) She was very quiet. She said hardly anything. or She hardly said anything. hardly ever = almost never: I''m nearly always at home in the evenings. I hardly ever go out. Hardly also means ''certainly not''. For example: It''s hardly surprising that you''re tired. You haven''t slept for three days. (= it''s certainly not surprising) The situation is serious, but it''s hardly a crisis. (= it''s certainly not a crisis)', 3
from units where slug = 'unit-101';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-101'
join (values
  ('A', 'Your English is good. but You speak English well.', null, 0),
  ('A', 'Sophie is a good pianist. but Sophie plays the piano well.', null, 1),
  ('A', 'Sophie''s father is a well-known writer.', null, 2),
  ('A', '''How are you today?'' ''I''m very well, thanks.''', null, 3),
  ('B', 'Darren is a fast runner. Darren can run fast.', null, 0),
  ('B', 'It''s hard to find a job right now. Kate works hard.', 'not works hardly', 1),
  ('B', 'Sorry I''m late. I got up late.', null, 2),
  ('B', 'Have you seen Kate lately?', 'lately = recently', 3),
  ('C', 'Sarah wasn''t very friendly at the party. She hardly spoke to me.', '= she spoke to me very little', 0),
  ('C', 'We''ve only met once or twice. We hardly know each other.', null, 1),
  ('C', 'He tried hard to find a job, but he had no luck.', '= he tried a lot, with a lot of effort', 2),
  ('C', 'I''m not surprised he didn''t find a job. He hardly tried.', '= he tried very little', 3),
  ('C', 'We hardly know each other.', 'not We know each other hardly', 4),
  ('C', 'Your writing is terrible. I can hardly read it.', '= it is almost impossible to read it', 5),
  ('C', 'My leg was hurting. I could hardly walk.', null, 6),
  ('D', 'There''s hardly anything in the fridge.', null, 0),
  ('D', '''How much money do we have?'' ''Hardly any.''', '= very little, almost none', 1),
  ('D', 'These two cameras are very similar. There''s hardly any difference between them.', null, 2),
  ('D', 'The exam results were bad. Hardly anybody in our class passed.', '= very few students passed', 3),
  ('D', 'She was very quiet. She said hardly anything. or She hardly said anything.', null, 4),
  ('D', 'I''m nearly always at home in the evenings. I hardly ever go out.', 'hardly ever = almost never', 5),
  ('D', 'It''s hardly surprising that you''re tired. You haven''t slept for three days.', '= it''s certainly not surprising', 6),
  ('D', 'The situation is serious, but it''s hardly a crisis.', '= it''s certainly not a crisis', 7)
) as v(label, sentence, note, order_index) on v.label = ts.label;

-- ------------------------------------------------------------
-- Exercises (main, book's own 101.1-101.5; each renumbered from 1,
-- dropping the book's own worked example(s) at the start of each exercise)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '101.1', 'Put in good or well.', 0
from units where slug = 'unit-101';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-101' where es.title = '101.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Joe''s exam results were very {0}.', null),
  (2, 'Joe did {0} in his exams.', null),
  (3, 'I didn''t sleep {0} last night.', null),
  (4, 'I like your hat. It looks {0} on you.', null),
  (5, 'Can you speak up? I can''t hear you very {0}.', null),
  (6, 'I''ve met her a few times, but I don''t know her {0}.', null),
  (7, 'Lucy speaks German {0}. She''s {1} at languages.', null)
) as v(n, template, hint)
where es.title = '101.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '101.1'
join (values
  (1, 0, 'good'), (2, 0, 'well'), (3, 0, 'well'), (4, 0, 'good'),
  (5, 0, 'well'), (6, 0, 'well'), (7, 0, 'well'), (7, 1, 'good')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '101.2', 'Complete these sentences using well + the following words: behaved, informed, kept, known, paid, written.', 1
from units where slug = 'unit-101';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-101' where es.title = '101.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I''m surprised you haven''t heard of her. She is quite {0}.', null),
  (2, 'Our neighbours'' garden is neat and tidy. It is very {0}.', null),
  (3, 'I enjoyed the book. It''s a great story and it''s very {0}.', null),
  (4, 'Tanya knows about everything. She is very {0}.', null),
  (5, 'Jane works very hard in her job, but she isn''t very {0}.', null)
) as v(n, template, hint)
where es.title = '101.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '101.2'
join (values
  (1, 'well-known'), (2, 'well-kept'), (3, 'well-written'), (4, 'well-informed'), (5, 'well-paid')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '101.3', 'Which is right?', 2
from units where slug = 'unit-101';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-101' where es.title = '101.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'I wasn''t in a hurry, so I was walking {0}.', '(slow / slowly)'),
  (2, 'I haven''t been to the cinema {0}.', '(late / lately)'),
  (3, 'Slow down! You''re walking too {0} for me.', '(fast / quick)'),
  (4, 'I tried {0} to remember her name, but I couldn''t.', '(hard / hardly)'),
  (5, 'This coat is practically unused. I''ve {0} worn it.', '(hard / hardly)'),
  (6, 'Laura is a good tennis player. She hits the ball very {0}.', '(hard / hardly)'),
  (7, 'It''s really dark in here. I can {0}.', '(hardly see / see hardly)'),
  (8, 'Ben is going to run a marathon. He''s been training {0}.', '(hard / hardly)')
) as v(n, template, hint)
where es.title = '101.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '101.3'
join (values
  (1, 'slowly'), (2, 'lately'), (3, 'fast'), (4, 'hard'),
  (5, 'hardly'), (6, 'hard'), (7, 'hardly see'), (8, 'hard')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '101.4', 'Complete the sentences. Use hardly + the following verbs (in the correct form): change, hear, know, recognise, say, sleep, speak.', 3
from units where slug = 'unit-101';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-101' where es.title = '101.4' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'You''re speaking very quietly. I can {0} you.', null),
  (2, 'I don''t feel good this morning. I {0} last night.', null),
  (3, 'We were so shocked when we heard the news, we could {0}.', null),
  (4, 'Kate was very quiet this evening. She {0} anything.', null),
  (5, 'Gary looks just like he looked 15 years ago. He has {0}.', null),
  (6, 'David looked different without his beard. I {0} him.', null)
) as v(n, template, hint)
where es.title = '101.4';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, 0, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '101.4'
join (values
  (1, 'hardly hear'), (2, 'hardly slept'), (3, 'hardly speak'),
  (4, 'hardly said'), (5, 'hardly changed'), (6, 'hardly recognised')
) as v(sentence_number, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '101.5', 'Complete these sentences with hardly + any/anybody/anything/anywhere/ever.', 4
from units where slug = 'unit-101';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-101' where es.title = '101.5' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'It was a very warm day and there was {0} wind.', null),
  (2, '''Do you know much about computers?'' ''No, {0}.''', null),
  (3, 'The hotel was almost empty. There was {0} staying there.', null),
  (4, 'I listen to the radio a lot, but I {0} watch TV.', null),
  (5, 'It was very crowded in the room. There was {0} to sit.', null),
  (6, 'We used to be good friends, but we {0} see each other now.', null),
  (7, 'We invited lots of people to the party, but {0} came.', null),
  (8, 'It didn''t take us long to drive there. There was {0} traffic.', null),
  (9, 'There isn''t much to do in this town. There''s {0} to go.', null)
) as v(n, template, hint)
where es.title = '101.5';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, 0, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '101.5'
join (values
  (1, 'hardly any', array[]::text[]),
  (2, 'hardly anything', array[]::text[]),
  (3, 'hardly anybody', array['hardly anyone']::text[]),
  (4, 'hardly ever', array[]::text[]),
  (5, 'hardly anywhere', array[]::text[]),
  (6, 'hardly ever', array['hardly']::text[]),
  (7, 'hardly anybody', array['hardly anyone']::text[]),
  (8, 'hardly any', array[]::text[]),
  (9, 'hardly anywhere', array[]::text[])
) as v(sentence_number, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
