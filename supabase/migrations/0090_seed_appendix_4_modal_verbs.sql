-- Appendix 4: Modal verbs (can/could/will/would etc.)
--
-- Sourced from pdf/Appendix.pdf (extracted via `pdftotext -layout`).
-- The book's "compare X / Y / Z" tables (a modal label on the left,
-- an example + meaning gloss on the right) are flattened into
-- appendix_examples, using each example's `note` to carry the modal
-- label + meaning gloss — same shape ExampleBox already renders for
-- unit theory's "(= meaning)" annotations.
--
-- Safe to re-run: this appendix section deletes itself first before
-- re-inserting.

delete from appendix_sections where slug = 'modal-verbs';

insert into appendix_sections (number, slug, title, order_index)
values (4, 'modal-verbs', 'Modal verbs (can/could/will/would etc.)', 3);

insert into appendix_subsections (appendix_section_id, label, heading, explanation, unit_refs, order_index)
select id, '4.1', 'Compare can/could etc. for actions',
  'This appendix is a summary of modal verbs. For more information, see Units 21-41.',
  array[21, 41], 0
from appendix_sections where slug = 'modal-verbs';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'modal-verbs' and s.label = '4.1'
join (values
  ('I can go out tonight.', 'can — there is nothing to stop me', 0),
  ('I can''t go out tonight.', 'can (negative)', 1),
  ('I could go out tonight, but I''m not very keen.', 'could — possible but not decided', 2),
  ('I couldn''t go out last night.', 'could (negative) — I wasn''t able', 3),
  ('Can I go out tonight?', 'can/may — do you allow me?', 4),
  ('I think I''ll go out tonight.', 'will', 5),
  ('I promise I won''t go out.', 'will (negative)', 6),
  ('I would go out tonight, but I have too much to do.', 'would', 7),
  ('I promised I wouldn''t go out.', 'would (negative)', 8),
  ('Shall I go out tonight?', 'shall — do you think it is a good idea?', 9),
  ('I should go out tonight.', 'should/ought to — it would be a good thing to do', 10),
  ('I must go out tonight.', 'must — it is necessary', 11),
  ('I mustn''t go out tonight.', 'must (negative) — it is necessary that I do not go out', 12),
  ('I needn''t go out tonight.', 'needn''t — it is not necessary', 13),
  ('I could have gone out last night, but I decided to stay at home.', 'could have', 14),
  ('I would have gone out last night, but I had too much to do.', 'would have', 15),
  ('I should have gone out last night. I''m sorry I didn''t.', 'should have/ought to have', 16),
  ('I needn''t have gone out last night.', 'needn''t have — I went out, but it was not necessary', 17)
) as v(sentence, note, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, order_index)
select id, '4.2', 'We use will/would/may etc. to say whether something is possible, impossible, probable, certain etc.', 1
from appendix_sections where slug = 'modal-verbs';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'modal-verbs' and s.label = '4.2'
join (values
  ('''What time will she be here?'' ''She''ll be here soon.''', 'will', 0),
  ('She would be here now, but she''s been delayed.', 'would', 1),
  ('She should be here soon.', 'should/ought to — I expect she will be here soon', 2),
  ('She might be here now. I''m not sure.', 'may/might/could — it''s possible that she is here', 3),
  ('She must be here. I saw her come in.', 'must', 4),
  ('She can''t possibly be here. I know for certain that she''s away on holiday.', 'can''t', 5),
  ('She will have arrived by now.', 'will have — before now', 6),
  ('She would have arrived earlier, but she was delayed.', 'would have', 7),
  ('I wonder where she is. She should have arrived by now.', 'should have/ought to have', 8),
  ('She might have arrived. I''m not sure.', 'may/might/could have — it''s possible that she has arrived', 9),
  ('She must have arrived by now.', 'must have — I''m sure, there is no other possibility', 10),
  ('She can''t possibly have arrived yet. It''s much too early.', 'can''t have — it''s impossible', 11)
) as v(sentence, note, order_index) on true;
