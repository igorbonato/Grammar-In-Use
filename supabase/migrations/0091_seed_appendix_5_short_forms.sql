-- Appendix 5: Short forms (I'm / you've / didn't etc.)
--
-- Sourced from pdf/Appendix.pdf (extracted via `pdftotext -layout`).
-- 5.2 and 5.3 each combine a flat reference table (appendix_table_rows,
-- column_headers set) with explanatory prose + examples in the same
-- subsection — the book itself mixes both in one numbered subsection.
--
-- Safe to re-run: this appendix section deletes itself first before
-- re-inserting.

delete from appendix_sections where slug = 'short-forms';

insert into appendix_sections (number, slug, title, order_index)
values (5, 'short-forms', 'Short forms (I''m / you''ve / didn''t etc.)', 4);

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '5.1', 'Short forms and contractions',
  'In spoken English we usually say I''m / you''ve / didn''t etc. (short forms or contractions) rather than I am / you have / did not etc. We also use these short forms in informal writing (for example, a letter or message to a friend). When we write short forms, we use an apostrophe ('') for the missing letter(s): I''m = I am, you''ve = you have, didn''t = did not.',
  0
from appendix_sections where slug = 'short-forms';

insert into appendix_subsections (appendix_section_id, label, heading, explanation, column_headers, order_index)
select id, '5.2', 'List of short forms',
  '''s can be is or has, but let''s = let us. ''d can be would or had. We use some of these short forms (especially ''s) after question words (who/what etc.) and after that/there/here, and also after a noun. You cannot use ''m / ''s / ''re / ''ve / ''ll / ''d at the end of a sentence, because the verb is stressed in that position.',
  array['Short form', 'Meaning', 'Used with'], 1
from appendix_sections where slug = 'short-forms';

insert into appendix_table_rows (subsection_id, col_a, col_b, col_c, order_index)
select s.id, v.col_a, v.col_b, v.col_c, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'short-forms' and s.label = '5.2'
join (values
  ('''m', 'am', 'I''m', 0),
  ('''s', 'is or has', 'he''s, she''s, it''s', 1),
  ('''re', 'are', 'you''re, we''re, they''re', 2),
  ('''ve', 'have', 'I''ve, you''ve, we''ve, they''ve', 3),
  ('''ll', 'will', 'I''ll, he''ll, she''ll, you''ll, we''ll, they''ll', 4),
  ('''d', 'would or had', 'I''d, he''d, she''d, you''d, we''d, they''d', 5)
) as v(col_a, col_b, col_c, order_index) on true;

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'short-forms' and s.label = '5.2'
join (values
  ('She''s ill.', '= She is ill', 0),
  ('She''s gone away.', '= She has gone', 1),
  ('Let''s go now.', 'let''s = let us', 2),
  ('I''d see a doctor if I were you.', '= I would see', 3),
  ('I''d never seen her before.', '= I had never seen', 4),
  ('Who''s that woman over there?', '= who is', 5),
  ('What''s happened?', '= what has', 6),
  ('Do you think there''ll be many people at the party?', '= there will', 7),
  ('Katherine''s going out tonight.', '= Katherine is', 8),
  ('My best friend''s just got married.', '= My best friend has', 9),
  ('''Are you tired?'' ''Yes, I am.''', 'not Yes, I''m — short forms can''t end a sentence', 10),
  ('Do you know where she is?', 'not Do you know where she''s?', 11)
) as v(sentence, note, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, column_headers, order_index)
select id, '5.3', 'Negative short forms',
  'Negative short forms for is and are can be: he isn''t / she isn''t / it isn''t, or he''s not / she''s not / it''s not; you aren''t / we aren''t / they aren''t, or you''re not / we''re not / they''re not.',
  array['Short form', 'Meaning'], 2
from appendix_sections where slug = 'short-forms';

insert into appendix_table_rows (subsection_id, col_a, col_b, order_index)
select s.id, v.col_a, v.col_b, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'short-forms' and s.label = '5.3'
join (values
  ('isn''t', 'is not', 0),
  ('aren''t', 'are not', 1),
  ('wasn''t', 'was not', 2),
  ('weren''t', 'were not', 3),
  ('don''t', 'do not', 4),
  ('doesn''t', 'does not', 5),
  ('didn''t', 'did not', 6),
  ('haven''t', 'have not', 7),
  ('hasn''t', 'has not', 8),
  ('hadn''t', 'had not', 9),
  ('can''t', 'cannot', 10),
  ('won''t', 'will not', 11),
  ('shan''t', 'shall not', 12),
  ('couldn''t', 'could not', 13),
  ('wouldn''t', 'would not', 14),
  ('shouldn''t', 'should not', 15),
  ('mustn''t', 'must not', 16),
  ('needn''t', 'need not', 17),
  ('daren''t', 'dare not', 18)
) as v(col_a, col_b, order_index) on true;
