-- Appendix 7: American English — the FINAL appendix, completing all 7.
--
-- Sourced from pdf/Appendix.pdf (extracted via `pdftotext -layout`).
-- The book prints this as one long British|American comparison table
-- spanning two pages, with a left-margin column of unit numbers that
-- wraps across several print lines per topic (e.g. "7A-B and 13A /
-- 17C / 21D and 22D" is one wrapped list of five unit refs for a
-- single topic, not five separate topics) — grouped by topic here,
-- with each row's unit_refs taken from its own wrapped margin list.
-- Two table-shaped subsections (7.1 units 1-74 range, 7.2 units
-- 79-144 range + spelling/vocabulary differences), matching the
-- book's own two-page split.
--
-- Safe to re-run: this appendix section deletes itself first before
-- re-inserting.

delete from appendix_sections where slug = 'american-english';

insert into appendix_sections (number, slug, title, order_index)
values (7, 'american-english', 'American English', 6);

insert into appendix_subsections (appendix_section_id, label, heading, explanation, column_headers, order_index)
select id, '7.1', 'Grammatical differences (units 1-74)',
  'There are a few grammatical differences between British English and American English.',
  array['British', 'American'], 0
from appendix_sections where slug = 'american-english';

insert into appendix_table_rows (subsection_id, col_a, col_b, unit_refs, order_index)
select s.id, v.col_a, v.col_b, v.unit_refs, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'american-english' and s.label = '7.1'
join (values
  ('The present perfect is often used for new or recent happenings: I''ve lost my key. Have you seen it? Sally isn''t here. She''s gone out.',
   'The past simple is more common for new or recent happenings: I lost my key. Did you see it? Sally isn''t here. She went out.',
   array[7, 13, 17, 21, 22], 0),
  ('The present perfect is used with just and already: I''m not hungry. I''ve just had lunch. ''What time is Mark leaving?'' ''He''s already left.''',
   'The past simple is more common with just and already: I''m not hungry. I just had lunch. ''What time is Mark leaving?'' ''He already left.''',
   array[28, 32, 34, 51, 59], 1),
  ('have a bath, have a shower', 'take a bath, take a shower', array[70], 2),
  ('have a break, have a holiday', 'take a break, take a vacation', array[74], 3),
  ('Will or shall can be used with I/we: I will/shall be late this evening.',
   'Shall is unusual: I will be late this evening.', array[]::int[], 4),
  ('Shall I ... ? and shall we ... ? are used to ask for advice etc.: Which way shall we go?',
   'Should I ... ? and should we ... ? are used to ask for advice etc.: Which way should we go?', array[]::int[], 5),
  ('British speakers use can''t to say they believe something is not probable: Sarah hasn''t contacted me. She can''t have got my message.',
   'American speakers use must not in this situation: Sarah hasn''t contacted me. She must not have gotten my message.', array[]::int[], 6),
  ('You can use needn''t or don''t need to: We needn''t hurry. or We don''t need to hurry.',
   'Needn''t is unusual. The usual form is don''t need to: We don''t need to hurry.', array[]::int[], 7),
  ('insist, demand etc. + should: I insisted that he should apologise. We demanded that something should be done about the problem.',
   'insist, demand etc. + subjunctive: I insisted that he apologize. We demanded that something be done about the problem.', array[34], 8),
  ('Have you? / Isn''t she? etc.: ''Lisa isn''t very well today.'' ''Isn''t she? What''s wrong with her?''',
   'You have? / She isn''t? etc.: ''Lisa isn''t very well today.'' ''She isn''t? What''s wrong with her?''', array[]::int[], 9),
  ('I''d rather you did something: Are you going to tell Anna, or would you rather I told her?',
   'I''d rather you do something: Are you going to tell Anna, or would you rather I tell her?', array[]::int[], 10),
  ('Accommodation is usually uncountable: There is plenty of excellent accommodation in the city.',
   'Accommodation can be countable: There are plenty of excellent accommodations in the city.', array[]::int[], 11),
  ('to/in hospital (without the): Joe had an accident and was taken to hospital.',
   'to/in the hospital: Joe had an accident and was taken to the hospital.', array[]::int[], 12)
) as v(col_a, col_b, unit_refs, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, column_headers, order_index)
select id, '7.2', 'Grammatical, vocabulary and spelling differences (units 79-144)', array['British', 'American'], 1
from appendix_sections where slug = 'american-english';

insert into appendix_table_rows (subsection_id, col_a, col_b, unit_refs, order_index)
select s.id, v.col_a, v.col_b, v.unit_refs, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'american-english' and s.label = '7.2'
join (values
  ('Nouns like government/team/family etc. can have a singular or plural verb: The team is/are playing well.',
   'These nouns normally take a singular verb in American English: The team is playing well.', array[79, 121, 124, 131, 137], 0),
  ('at the weekend / at weekends: Will you be here at the weekend?',
   'on the weekend / on weekends: Will you be here on the weekend?', array[141, 142], 1),
  ('at the front / at the back (of a group etc.): (in a theatre) Let''s sit at the front.',
   'in the front / in the back (of a group etc.): (in a theater) Let''s sit in the front.', array[144], 2),
  ('different from or different to: The film was different from/to what I''d expected.',
   'different from or different than: The movie was different from/than what I''d expected.', array[]::int[], 3),
  ('round or around: He turned round. or He turned around.',
   'around (not usually round): He turned around.', array[]::int[], 4),
  ('fill in or fill out (a form etc.): Please fill in this form. or Please fill out this form.',
   'fill out (a form): Please fill out this form.', array[]::int[], 5),
  ('get on (with somebody): Richard gets on well with his neighbours.',
   'get along (with somebody): Richard gets along well with his neighbors.', array[]::int[], 6),
  ('knock down (a building): Some old houses were knocked down to make way for a new shopping centre.',
   'tear down a building: Some old houses were torn down to make way for a new shopping mall.', array[]::int[], 7),
  ('do up a house etc.: That old house looks great now that it has been done up.',
   'fix up a house etc.: That old house looks great now that it has been fixed up.', array[]::int[], 8),
  ('Burn, spell etc. can be regular or irregular (burned or burnt, spelled or spelt etc.). See Appendix 1.3.',
   'Burn, spell etc. are normally regular (burned, spelled etc.). See Appendix 6.6.', array[]::int[], 9),
  ('The past participle of get is got: Your English has got much better. (= has become much better)',
   'The past participle of get is gotten: Your English has gotten much better.', array[]::int[], 10),
  ('Have got is also an alternative to have: I''ve got a car. (= I have a car)',
   'Have got = have (as in British English): I''ve got a car.', array[]::int[], 11),
  ('British spelling: travel -> travelling/travelled, cancel -> cancelling/cancelled.',
   'American spelling: travel -> traveling/traveled, cancel -> canceling/canceled.', array[]::int[], 12)
) as v(col_a, col_b, unit_refs, order_index) on true;
