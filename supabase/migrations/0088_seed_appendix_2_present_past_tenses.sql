-- Appendix 2: Present and past tenses.
--
-- Sourced from pdf/Appendix.pdf (extracted via `pdftotext -layout`).
-- This appendix is a 4-row x 2-column matrix in the book (simple vs.
-- continuous, for present/present perfect/past/past perfect) — no
-- special schema needed, just 8 subsections (no `label`, since the
-- book doesn't number them) with order_index 0-7 in row-major
-- reading order so the frontend's 2-column grid reproduces the
-- matrix layout.
--
-- Safe to re-run: this appendix section deletes itself first before
-- re-inserting.

delete from appendix_sections where slug = 'present-and-past-tenses';

insert into appendix_sections (number, slug, title, order_index)
values (2, 'present-and-past-tenses', 'Present and past tenses', 1);

insert into appendix_subsections (appendix_section_id, heading, unit_refs, order_index)
select id, v.heading, v.unit_refs, v.order_index
from appendix_sections sec, (values
  ('Present simple (I do)', array[2, 3, 4], 0),
  ('Present continuous (I am doing)', array[1, 3, 4], 1),
  ('Present perfect simple (I have done)', array[7, 8, 10, 11, 12, 13, 14], 2),
  ('Present perfect continuous (I have been doing)', array[9, 10, 11], 3),
  ('Past simple (I did)', array[5, 6, 13, 14], 4),
  ('Past continuous (I was doing)', array[6], 5),
  ('Past perfect (I had done)', array[15], 6),
  ('Past perfect continuous (I had been doing)', array[16], 7)
) as v(heading, unit_refs, order_index)
where sec.slug = 'present-and-past-tenses';

insert into appendix_examples (subsection_id, sentence, order_index)
select s.id, v.sentence, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'present-and-past-tenses'
join (values
  ('Present simple (I do)', 'Anna often plays tennis.', 0),
  ('Present simple (I do)', 'I work in a bank, but I don''t enjoy it much.', 1),
  ('Present simple (I do)', 'Do you like parties?', 2),
  ('Present simple (I do)', 'It doesn''t rain so much in summer.', 3),

  ('Present continuous (I am doing)', '''Where''s Anna?'' ''She''s playing tennis.''', 0),
  ('Present continuous (I am doing)', 'Please don''t disturb me now. I''m working.', 1),
  ('Present continuous (I am doing)', 'Hello! Are you enjoying the party?', 2),
  ('Present continuous (I am doing)', 'It isn''t raining at the moment.', 3),

  ('Present perfect simple (I have done)', 'Anna has played tennis many times.', 0),
  ('Present perfect simple (I have done)', 'I''ve lost my key. Have you seen it anywhere?', 1),
  ('Present perfect simple (I have done)', 'How long have you and Sam known each other?', 2),
  ('Present perfect simple (I have done)', '''Is it still raining?'' ''No, it has stopped.''', 3),
  ('Present perfect simple (I have done)', 'The house is dirty. I haven''t cleaned it for weeks.', 4),

  ('Present perfect continuous (I have been doing)', 'Anna is tired. She has been playing tennis.', 0),
  ('Present perfect continuous (I have been doing)', 'You''re out of breath. Have you been running?', 1),
  ('Present perfect continuous (I have been doing)', 'How long have you been learning English?', 2),
  ('Present perfect continuous (I have been doing)', 'It''s still raining. It has been raining all day.', 3),
  ('Present perfect continuous (I have been doing)', 'I haven''t been feeling well recently. Perhaps I should go to the doctor.', 4),

  ('Past simple (I did)', 'Anna played tennis yesterday afternoon.', 0),
  ('Past simple (I did)', 'I lost my key a few days ago.', 1),
  ('Past simple (I did)', 'There was a film on TV last night, but we didn''t watch it.', 2),
  ('Past simple (I did)', 'What did you do when you finished work yesterday?', 3),

  ('Past continuous (I was doing)', 'I saw Anna at the sports centre yesterday. She was playing tennis.', 0),
  ('Past continuous (I was doing)', 'I dropped my key when I was trying to open the door.', 1),
  ('Past continuous (I was doing)', 'The TV was on, but we weren''t watching it.', 2),
  ('Past continuous (I was doing)', 'What were you doing at this time yesterday?', 3),

  ('Past perfect (I had done)', 'It wasn''t her first game of tennis. She had played many times before.', 0),
  ('Past perfect (I had done)', 'They couldn''t get into the house because they had lost the key.', 1),
  ('Past perfect (I had done)', 'The house was dirty because I hadn''t cleaned it for weeks.', 2),

  ('Past perfect continuous (I had been doing)', 'Anna was tired yesterday evening because she had been playing tennis in the afternoon.', 0),
  ('Past perfect continuous (I had been doing)', 'James decided to go to the doctor because he hadn''t been feeling well.', 1)
) as v(heading, sentence, order_index) on v.heading = s.heading;
