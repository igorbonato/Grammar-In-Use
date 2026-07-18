-- Additional exercise 25: "Reported speech" (Units 47-48, 50).
--
-- Sourced from pdf/Additional exercises.pdf (extracted via
-- `pdftotext -table`). Cross-checked against
-- pdf/Key to Additional exercises.pdf (plain mode).
--
-- Each of the 7 scenarios is picture/speech-bubble based in the
-- book, reconstructed here from the surrounding narrative frame text
-- + the Key's full reported-speech answer, split at each of the
-- frame's own gaps (kept as one exercise_sentences row per scenario
-- with several blanks, same approach as exercises 7/24).
--
-- Safe to re-run: this exercise set deletes itself first (cascades
-- to its sentences/blanks) before re-inserting.

delete from exercise_sets where title = 'Additional exercise 25' and kind = 'additional';

insert into exercise_sets (unit_id, kind, title, instruction, order_index)
select u.id, 'additional', 'Additional exercise 25', 'Complete the sentences using reported speech.', 0
from units u where u.slug = 'unit-47';

insert into exercise_set_units (exercise_set_id, unit_id)
select es.id, u.id
from exercise_sets es
join units u on u.slug in ('unit-47', 'unit-48', 'unit-50')
where es.title = 'Additional exercise 25' and es.kind = 'additional';

insert into exercise_sentences (exercise_set_id, sentence_number, template, order_index)
select es.id, v.n, v.template, v.n - 1
from exercise_sets es, (values
  (1, 'A woman phoned at lunchtime yesterday and asked if she could speak to Paul. I told {0}. I asked {1}, but she said {2} later. But she never did.'),
  (2, 'I went to London recently, but my visit didn''t begin well. I had reserved a hotel room, but when I got to the hotel they told {0}. When I asked {1}, they said {2}, but {3}. There was nothing I could do. I just had to look for somewhere else to stay.'),
  (3, 'After getting off the plane, we had to queue for an hour to get through immigration. Finally, it was our turn. The immigration officer asked us {0}, and we told {1}. Then he wanted to know {2} and {3}. He seemed satisfied with our answers, checked our passports and wished us a pleasant stay.'),
  (4, 'a: What time is Sue arriving this afternoon? b: About three. She said {0}. a: Aren''t you going to meet her? b: No, she said not {1}. She said that {2}.'),
  (5, 'A few days ago a man phoned from a marketing company and started asking me questions. He wanted to know {0} and asked {1}. I don''t like people phoning and asking questions like that, so I told {2} and ended the call.'),
  (6, 'Sarah and Louise are in a restaurant waiting for Paul. SARAH: I wonder where Paul is. He said {0}. LOUISE: Maybe he got lost. SARAH: I don''t think so. He said {1}. And I told {2}.'),
  (7, 'Five minutes later. JOE: Is there anything to eat? JANE: You just said {0}. JOE: Well, I am now. I''d love a banana. JANE: A banana? But you said {1}. You told {2}.')
) as v(n, template)
where es.title = 'Additional exercise 25';

insert into exercise_blanks (sentence_id, blank_index, correct_answer, accepted_alternatives)
select sen.id, v.blank_index, v.correct_answer, v.accepted_alternatives
from exercise_sentences sen
join exercise_sets es on es.id = sen.exercise_set_id and es.title = 'Additional exercise 25' and es.kind = 'additional'
join (values
  (1, 0, 'her that Paul had gone out and I didn''t know when he''d be back', array[]::text[]),
  (1, 1, 'her if she wanted to leave a message', array['her whether she wanted to leave a message']::text[]),
  (1, 2, 'she''d try again', array[]::text[]),
  (2, 0, 'me that they had no record of a reservation in my name', array[]::text[]),
  (2, 1, 'them if they had any rooms free anyway', array['them whether they had any rooms free anyway']::text[]),
  (2, 2, 'they were sorry', array[]::text[]),
  (2, 3, 'the hotel was full', array[]::text[]),
  (3, 0, 'why we were visiting the country', array[]::text[]),
  (3, 1, 'him that we were on holiday', array[]::text[]),
  (3, 2, 'how long we intended to stay', array[]::text[]),
  (3, 3, 'where we would be staying during our visit', array[]::text[]),
  (4, 0, 'she''d phone us from the airport when she arrived', array['she''ll phone us from the airport when she arrives']::text[]),
  (4, 1, 'to come to the airport', array[]::text[]),
  (4, 2, 'she''d take the bus', array['she''ll take the bus']::text[]),
  (5, 0, 'what my job was', array['what my job is']::text[]),
  (5, 1, 'me how much I earned', array['how much I earn']::text[]),
  (5, 2, 'him to mind his own business', array[]::text[]),
  (6, 0, 'he''d be at the restaurant at 7.30', array[]::text[]),
  (6, 1, 'he knew where the restaurant was', array[]::text[]),
  (6, 2, 'him to phone me if there was a problem', array[]::text[]),
  (7, 0, 'you weren''t hungry', array[]::text[]),
  (7, 1, 'you didn''t like bananas', array[]::text[]),
  (7, 2, 'me not to buy any', array[]::text[])
) as v(sentence_number, blank_index, correct_answer, accepted_alternatives) on v.sentence_number = sen.sentence_number;
