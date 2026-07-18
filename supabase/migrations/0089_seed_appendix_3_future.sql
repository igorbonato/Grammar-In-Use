-- Appendix 3: The future.
--
-- Sourced from pdf/Appendix.pdf (extracted via `pdftotext -layout`).
-- 3.1 ("List of future forms") is a two-column reference (example
-- sentence -> form name + unit ref) — modelled with appendix_table_rows
-- like Appendix 5/7's tables, since it's a flat lookup, not prose.
--
-- Safe to re-run: this appendix section deletes itself first before
-- re-inserting.

delete from appendix_sections where slug = 'the-future';

insert into appendix_sections (number, slug, title, order_index)
values (3, 'the-future', 'The future', 2);

insert into appendix_subsections (appendix_section_id, label, heading, column_headers, order_index)
select id, '3.1', 'List of future forms', array['Example', 'Form'], 0
from appendix_sections where slug = 'the-future';

insert into appendix_table_rows (subsection_id, col_a, col_b, unit_refs, order_index)
select s.id, v.col_a, v.col_b, v.unit_refs, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'the-future' and s.label = '3.1'
join (values
  ('I''m leaving tomorrow.', 'present continuous', array[19], 0),
  ('My train leaves at 9.30.', 'present simple', array[19], 1),
  ('I''m going to leave tomorrow.', '(be) going to', array[20, 23], 2),
  ('I''ll leave tomorrow.', 'will', array[21, 22, 23], 3),
  ('I''ll be leaving tomorrow.', 'future continuous', array[24], 4),
  ('I''ll have left by this time tomorrow.', 'future perfect', array[24], 5),
  ('I hope to see you before I leave tomorrow.', 'present simple', array[25], 6)
) as v(col_a, col_b, unit_refs, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, unit_refs, order_index)
select id, '3.2', 'Future actions',
  'We use the present continuous (I''m doing) for arrangements. We use the present simple (I leave / it leaves etc.) for timetables, programmes etc. We use (be) going to ... to say what somebody has already decided to do. We use will (''ll) when we decide or agree to do something at the time of speaking.',
  array[19, 20, 21], 1
from appendix_sections where slug = 'the-future';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'the-future' and s.label = '3.2'
join (values
  ('I''m leaving tomorrow. I''ve got my plane ticket.', 'present continuous — arrangements', 0),
  ('''When are they getting married?'' ''On 24 July.''', 'present continuous — arrangements', 1),
  ('My train leaves at 11.30.', 'present simple — timetables', 2),
  ('What time does the film begin?', 'present simple — timetables', 3),
  ('I''ve decided not to stay here any longer. I''m going to leave tomorrow.', '(be) going to — already decided', 4),
  ('''Your shoes are dirty.'' ''Yes, I know. I''m going to clean them.''', '(be) going to — already decided', 5),
  ('I''ll leave tomorrow.', 'will — decided at the moment of speaking', 6),
  ('That bag looks heavy. I''ll help you with it.', 'will — decided at the moment of speaking', 7),
  ('I won''t tell anybody what happened. I promise.', 'won''t = will not', 8)
) as v(sentence, note, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '3.3', 'Future happenings and situations',
  'Most often we use will to talk about future happenings (''something will happen'') or situations (''something will be''). We use (be) going to when the situation now shows what is going to happen in the future.',
  2
from appendix_sections where slug = 'the-future';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'the-future' and s.label = '3.3'
join (values
  ('I don''t think John is happy at work. I think he''ll leave soon.', 'will — future happenings', 0),
  ('This time next year I''ll be in Japan. Where will you be?', 'will — future situations', 1),
  ('Look at those black clouds. It''s going to rain.', '(be) going to — evidence now', 2)
) as v(sentence, note, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, unit_refs, order_index)
select id, '3.4', 'Future continuous and future perfect',
  'Will be (do)ing = will be in the middle of (doing something). We also use will be -ing for future actions. We use will have (done) to say that something will already be complete before a time in the future.',
  array[24], 3
from appendix_sections where slug = 'the-future';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'the-future' and s.label = '3.4'
join (values
  ('This time next week I''ll be on holiday. I''ll be lying on a beach or swimming in the sea.', 'will be doing', 0),
  ('What time will you be leaving tomorrow?', 'will be -ing — future actions, see Unit 24C', 1),
  ('I won''t be here this time tomorrow. I''ll have already left.', 'will have done', 2)
) as v(sentence, note, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, unit_refs, order_index)
select id, '3.5', 'We use the present (not will) after when/if/while/before etc.',
  null, array[25], 4
from appendix_sections where slug = 'the-future';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'the-future' and s.label = '3.5'
join (values
  ('I hope to see you before I leave tomorrow.', 'not before I will leave', 0),
  ('When you are in London again, come and see us.', 'not When you will be', 1),
  ('If we don''t hurry, we''ll be late.', null, 2)
) as v(sentence, note, order_index) on true;
