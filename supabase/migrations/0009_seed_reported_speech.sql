-- Marco 4 (slice 7): seeds the "Reported speech" module — units 47-48
-- (Reported speech 1 (he said that ...), Reported speech 2).
--
-- Sourced from pdf/Modulos/Reported speech.pdf (extracted via
-- `pdftotext -layout`, same workaround as previous modules —
-- pdftoppm/poppler isn't available locally) and cross-checked against
-- pdf/Key to Exercises.pdf. This PDF is a clean 1:1 match with the book
-- chapter (units 47-48 only — confirmed by grepping the extracted text for
-- unit-number headers across the whole file); "UNIT 49" (Questions and
-- auxiliary verbs) starts right after in the Key, confirming the boundary.
--
-- NOTE on how these migrations get applied: there is no GitHub-to-Supabase
-- auto-deploy configured for this project (an earlier assumption recorded
-- in prior migration headers was wrong) — Igor applies each migration file
-- manually by pasting its full contents into the Supabase Studio SQL
-- Editor. This file doesn't need anything different because of that; just
-- noting it so nobody re-adds an "applies automatically on push" claim.
--
-- 47.2 ("Use your own ideas to complete your answers") looks free-form
-- like the genuinely open-ended exercises skipped elsewhere (e.g. 39.4),
-- but it isn't: each item is a fixed contradiction of a given statement,
-- and the Key lists a specific expected rephrasing (labelled "Example
-- answers" only because minor wording varies) — seeded normally, using the
-- Key's first-listed phrasing as the answer and the rest as alternatives.
--
-- No exercise in this chapter was skipped as open-ended.
--
-- Additional exercise 25 (page 316) is referenced at the end of unit 47
-- but, consistent with every module so far, deferred — not attempted this
-- round.
--
-- Consolidated into a single migration, same pattern as 0003-0008.
--
-- Safe to re-run: each unit deletes itself first (cascades to its
-- theory/exercise rows) before re-inserting.

insert into modules (slug, title, order_index)
values ('reported-speech', 'Reported speech', 6)
on conflict (slug) do nothing;

-- ============================================================
-- Unit 47: Reported speech 1 (he said that ...)
-- ============================================================

delete from units where slug = 'unit-47';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 47, 'unit-47', 'Reported speech 1 (he said that ...)', null,
  'Reported speech reports what somebody said without repeating their exact words. The main verb (and usually the rest of the sentence) shifts back a tense: am/is -> was, do/does -> did, will -> would, can -> could etc. that is optional.', 0
from modules where slug = 'reported-speech';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'Direct speech vs reported speech',
  'Direct speech repeats somebody''s exact words in quotation marks: Paul said, "I''m feeling ill." Reported speech reports what somebody said without quoting them exactly: Paul said that he was feeling ill.', 0
from units where slug = 'unit-47';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Verb tenses shift back in reported speech',
  'The main verb of a reported sentence is usually past (Paul said that ... / I told her that ...), and the rest of the sentence usually shifts back too: am/is -> was, are -> were, do/does -> did, have/has -> had, will -> would, can -> could, and regular present verbs (want/like/know/go etc.) -> past (wanted/liked/knew/went etc.). You can leave out that: Paul said (that) he was feeling ill.', 1
from units where slug = 'unit-47';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'Past simple can stay the same, or shift to past perfect',
  'The past simple (did/saw/knew etc.) can stay the same in reported speech, or you can change it to the past perfect (had done/had seen/had known etc.): Paul said (that) he woke up feeling ill, so he didn''t go to work. or Paul said (that) he had woken up feeling ill, so he hadn''t gone to work.', 2
from units where slug = 'unit-47';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-47'
join (values
  ('A', 'Paul said, "I''m feeling ill."', 'direct speech', 0),
  ('A', 'Paul said that he was feeling ill.', 'reported speech', 1),
  ('B', 'I told Lisa that I didn''t have any money.', null, 0),
  ('B', 'Paul said he was feeling ill.', 'that can be left out', 1),
  ('B', 'Anna said that she had lost her phone.', 'direct: "I''ve lost my phone."', 2),
  ('B', 'She said that she wanted to buy a car.', 'direct: "I want to buy a car."', 3),
  ('B', 'She said that she couldn''t come to the party on Friday.', 'direct: "I can''t come to the party on Friday."', 4),
  ('B', 'She said that she was going away for a few days and would phone me when she got back.', 'direct: "I''m going away for a few days. I''ll phone you when I get back."', 5),
  ('C', 'Paul said (that) he woke up feeling ill, so he didn''t go to work.', null, 0),
  ('C', 'Paul said (that) he had woken up feeling ill, so he hadn''t gone to work.', 'same meaning, shifted further back', 1)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: illustration of Paul with a speech bubble "I''m feeling ill", next to the reported version "Paul said that he was feeling ill" — showing direct speech turning into reported speech]', 0
from units where slug = 'unit-47';

-- ------------------------------------------------------------
-- Exercises (main, book's own 47.1-47.2)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '47.1', 'You talked to some friends of yours. Read what they said (direct speech). Later the same day you tell another friend what they said (reported speech). Complete the sentences.', 0
from units where slug = 'unit-47';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-47' where es.title = '47.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'you: Shall we walk to the station? tom: No, it''s too far. Let''s get a taxi. I wanted to walk to the station, but Tom said {0}.', null),
  (2, 'you: Have you been invited to the party? anna: Yes, but I don''t want to go. Anna has been invited to the party but she told me {0}.', null),
  (3, 'you: When are you going away, Dan? dan: I''ll let you know next week. I asked Dan about his travel plans. He said {0}.', null),
  (4, 'you: Do you ever see Rachel these days? ben: I haven''t seen her for a while. I asked Ben about Rachel, but he told me {0}.', null),
  (5, 'you: Where can I borrow a guitar? kate: You can borrow mine. I needed to borrow a guitar and Kate said {0}.', null),
  (6, 'you: How''s your job, Sue? sue: I''m not enjoying it very much. I asked Sue about her job. She said {0}.', null),
  (7, 'you: Do you still have your car? james: No, I sold it a few months ago. I asked James about his car. He told me {0}.', null),
  (8, 'you: What''s the name of the cafe we went to? sarah: I don''t know. I asked Sarah the name of the cafe we went to but she said {0}.', null),
  (9, 'you: How many students are there in your class, Amy? amy: Twenty. I asked Amy about her school and she told me {0}.', null)
) as v(n, template, hint)
where es.title = '47.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '47.1'
join (values
  (1, 0, 'that it was too far', array['it was too far']::text[]),
  (2, 0, 'that she didn''t want to go', array['she didn''t want to go']::text[]),
  (3, 0, 'that he would let me know next week', array['he would let me know next week']::text[]),
  (4, 0, 'that he hadn''t seen her for a while', array['he hadn''t seen her for a while']::text[]),
  (5, 0, 'that I could borrow hers', array['I could borrow hers']::text[]),
  (6, 0, 'that she wasn''t enjoying it very much', array['she wasn''t enjoying it very much']::text[]),
  (7, 0, 'that he sold it a few months ago', array['he sold it a few months ago', 'that he''d sold it a few months ago', 'that he had sold it a few months ago']::text[]),
  (8, 0, 'that she didn''t know', array['she didn''t know']::text[]),
  (9, 0, 'that there were twenty students in her class', array['there were twenty students in her class']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '47.2', 'Somebody says something to you which is not what you expected. Complete your answers.', 1
from units where slug = 'unit-47';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-47' where es.title = '47.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'a: Sue is coming to the party tonight. b: Is she? I saw her a few days ago and she said {0}.', null),
  (2, 'a: Sarah gets on fine with Paul. b: Does she? Last week you said {0}.', null),
  (3, 'a: Joe knows lots of people. b: That''s not what he told me. He said {0}.', null),
  (4, 'a: Jane will be here next week. b: Oh, really? When I spoke to her, she said {0}.', null),
  (5, 'a: I''m going out tonight. b: Are you? I thought you said {0}.', null),
  (6, 'a: I speak French quite well. b: Do you? But earlier you said {0}.', null),
  (7, 'a: I haven''t seen Ben recently. b: That''s strange. He told me {0}.', null)
) as v(n, template, hint)
where es.title = '47.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '47.2'
join (values
  (1, 0, 'she wasn''t coming', array['she was going somewhere else', 'she couldn''t come']::text[]),
  (2, 0, 'they didn''t like each other', array['they didn''t get on with each other', 'they couldn''t stand each other']::text[]),
  (3, 0, 'he didn''t know anyone', array[]::text[]),
  (4, 0, 'she would be away', array['she was going away']::text[]),
  (5, 0, 'you were staying at home', array[]::text[]),
  (6, 0, 'you couldn''t speak any other languages', array['you didn''t speak any other languages']::text[]),
  (7, 0, 'he''d seen you last weekend', array['he saw you last weekend']::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

-- ============================================================
-- Unit 48: Reported speech 2
-- ============================================================

delete from units where slug = 'unit-48';

insert into units (module_id, unit_number, slug, title, subtitle, intro, order_index)
select id, 48, 'unit-48', 'Reported speech 2', null,
  'You don''t always need to shift the verb back if the situation described is still true or hasn''t changed; you do need to if what was said turns out to be different from reality. Use tell when you say who you''re speaking to (tell somebody); otherwise use say. tell/ask somebody to (do something) reports instructions and requests.', 1
from modules where slug = 'reported-speech';

-- ------------------------------------------------------------
-- Theory
-- ------------------------------------------------------------

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'A', 'You don''t always need to change the verb',
  'If the situation is still the same/true, it isn''t necessary to change the verb to the past: "Paul said that his new job is boring" (his job is still boring now). You can also change it to the past: "Paul said that his new job was boring." But if the situation has changed or finished, you need to use a past verb: "Paul said (that) he had to go" (not has to go).', 0
from units where slug = 'unit-48';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'B', 'Use the past when reality differs from what was said',
  'You need to use the past in reported speech when what was said is different from what is really true: "Rachel said you were in hospital" (not "you are in hospital" — you''re saying this to Joe himself, on the street, so it''s clear he isn''t in hospital).', 1
from units where slug = 'unit-48';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'C', 'say and tell',
  'If you say who somebody is talking to, use tell: "Rachel told me that you were in hospital" (not Rachel said me). "What did you tell the police?" (not say the police). Otherwise use say: "Rachel said that you were in hospital" (not Rachel told that ...). You can "say something to somebody": "Anna said goodbye to me and left" (not Anna said me goodbye).', 2
from units where slug = 'unit-48';

insert into theory_sections (unit_id, label, heading, explanation, order_index)
select id, 'D', 'tell/ask somebody to ...',
  'We say tell somebody to ... and ask somebody to ...: "Drink plenty of water," the doctor said to me -> The doctor told me to drink plenty of water. "Don''t work too hard," I said to Joe -> I told Joe not to work too hard. "Can you help me, please," Jackie said to me -> Jackie asked me to help her. You can also say "Somebody said (not) to do something": Paul said not to worry about him (but not Paul said me).', 3
from units where slug = 'unit-48';

insert into theory_examples (section_id, sentence, note, order_index)
select ts.id, v.sentence, v.note, v.order_index
from theory_sections ts
join units u on u.id = ts.unit_id and u.slug = 'unit-48'
join (values
  ('A', 'Paul said that his new job is boring.', 'his job is still boring now', 0),
  ('A', 'Helen told me that she wants to go to Canada next year.', 'she still wants to go', 1),
  ('A', 'Paul said that his new job was boring.', 'also correct', 2),
  ('A', 'Paul left the room suddenly. He said (that) he had to go.', 'not has to go — the situation has changed', 3),
  ('B', 'Rachel said you were in hospital.', 'not "you are in hospital" — talking to Joe himself, on the street', 0),
  ('C', 'Rachel told me that you were in hospital.', 'not Rachel said me', 0),
  ('C', 'What did you tell the police?', 'not say the police', 1),
  ('C', 'Rachel said that you were in hospital.', 'not Rachel told that ...', 2),
  ('C', 'Anna said goodbye to me and left.', 'not Anna said me goodbye', 3),
  ('D', 'The doctor told me to drink plenty of water.', 'direct: "Drink plenty of water," the doctor said to me', 0),
  ('D', 'I told Joe not to work too hard.', 'direct: "Don''t work too hard," I said to Joe', 1),
  ('D', 'Jackie asked me to help her.', 'direct: "Can you help me, please," Jackie said to me', 2),
  ('D', 'Paul said not to worry about him.', 'but not Paul said me', 3)
) as v(label, sentence, note, order_index) on v.label = ts.label;

insert into theory_images (unit_id, storage_path, alt_text, order_index)
select id, 'placeholder',
  '[PLACEHOLDER_IMG: Rachel telling the reader "Have you heard? Joe is in hospital", then the reader meeting Joe in the street and saying "Rachel said you were in hospital" — illustrating why the reported verb stays past even though Joe is clearly not in hospital]', 0
from units where slug = 'unit-48';

-- ------------------------------------------------------------
-- Exercises (main, book's own 48.1-48.3)
-- ------------------------------------------------------------

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '48.1', 'Here are some things that Sarah said to you earlier. But later Sarah says something different to you. What do you say?', 0
from units where slug = 'unit-48';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-48' where es.title = '48.1' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sarah earlier: "I don''t like fish." Sarah now: "Let''s have fish for dinner." {0}', null),
  (2, 'Sarah earlier: "I can''t drive." Sarah now: "I''m going to buy a car." {0}', null),
  (3, 'Sarah earlier: "Jane has a very well-paid job." Sarah now: "Jane is always short of money." {0}', null),
  (4, 'Sarah earlier: "I don''t have any brothers or sisters." Sarah now: "My sister lives in Paris." {0}', null),
  (5, 'Sarah earlier: "I''ve never been to the United States." Sarah now: "I think New York is a great place." {0}', null),
  (6, 'Sarah earlier: "I''m working tomorrow evening." Sarah now: "Let''s go out tomorrow evening." {0}', null),
  (7, 'Sarah earlier: "Jane is a friend of mine." Sarah now: "I''ve never spoken to Jane." {0}', null)
) as v(n, template, hint)
where es.title = '48.1';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '48.1'
join (values
  (1, 0, 'But you said you didn''t like fish.', array[]::text[]),
  (2, 0, 'But you said you couldn''t drive.', array[]::text[]),
  (3, 0, 'But you said she had a very well-paid job.', array[]::text[]),
  (4, 0, 'But you said you didn''t have any brothers or sisters.', array[]::text[]),
  (5, 0, 'But you said you''d never been to the United States.', array['But you said you had never been to the United States.']::text[]),
  (6, 0, 'But you said you were working tomorrow evening.', array[]::text[]),
  (7, 0, 'But you said she was a friend of yours.', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '48.2', 'Complete the sentences with say or tell (in the correct form). Use only one word each time.', 1
from units where slug = 'unit-48';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-48' where es.title = '48.2' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, '{0} us about your holiday. Did you have a nice time?', null),
  (2, 'Don''t just stand there! {0} something!', null),
  (3, 'I wonder where Sue is. She {0} she would be here at 8 o''clock.', null),
  (4, 'Dan {0} me that he was bored with his job.', null),
  (5, 'The doctor {0} that I should rest for at least a week.', null),
  (6, 'Gary couldn''t help me. He {0} me to ask Chris.', null),
  (7, 'Gary couldn''t help me. He {0} to ask Chris.', null),
  (8, 'Don''t {0} anybody what I {1}. It''s a secret just between us.', null),
  (9, '''Did Kate {0} you what happened?'' ''No, she didn''t {1} anything to me.''', null)
) as v(n, template, hint)
where es.title = '48.2';

insert into exercise_blanks (sentence_id, blank_index, correct_answer)
select sen.id, v.blank_index, v.correct_answer
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '48.2'
join (values
  (1, 0, 'Tell'),
  (2, 0, 'Say'),
  (3, 0, 'said'),
  (4, 0, 'told'),
  (5, 0, 'said'),
  (6, 0, 'told'),
  (7, 0, 'said'),
  (8, 0, 'tell'), (8, 1, 'said'),
  (9, 0, 'tell'), (9, 1, 'say')
) as v(sentence_number, blank_index, correct_answer) on v.sentence_number = sen.sentence_number;

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select id, 'main', '48.3', 'Complete the sentences using reported speech.', 2
from units where slug = 'unit-48';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id from exercise_sets es join units u on u.slug = 'unit-48' where es.title = '48.3' and es.unit_id = u.id;

insert into exercise_sentences (exercise_set_id, sentence_number, template, hint, order_index)
select es.id, v.n, v.template, v.hint, v.n - 1
from exercise_sets es, (values
  (1, 'Sarah was driving too fast, so I asked {0}.', null),
  (2, 'Sue was nervous about the situation. I told {0}.', null),
  (3, 'I couldn''t move the piano alone, so I {0}.', null),
  (4, 'The security guard looked at me suspiciously and {0}.', null),
  (5, 'The man started asking me personal questions, so I {0}.', null),
  (6, 'Carl was in love with Maria, so he {0}.', null),
  (7, 'I didn''t want to delay Helen, so I {0}.', null)
) as v(n, template, hint)
where es.title = '48.3';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = '48.3'
join (values
  (1, 0, 'her to slow down', array[]::text[]),
  (2, 0, 'her not to worry', array[]::text[]),
  (3, 0, 'asked Tom to give me a hand', array['asked Tom to help me']::text[]),
  (4, 0, 'asked me to open my bag', array[]::text[]),
  (5, 0, 'told him to mind his own business', array[]::text[]),
  (6, 0, 'asked her to marry him', array[]::text[]),
  (7, 0, 'told her not to wait for me if I was late', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, alternatives) on v.sentence_number = sen.sentence_number;
