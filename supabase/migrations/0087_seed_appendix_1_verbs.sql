-- Appendix 1: Regular and irregular verbs.
--
-- Sourced from pdf/Appendix.pdf (extracted via `pdftotext -layout`).
-- 1.4's irregular verb list is genuinely one continuous alphabetical
-- sequence (be...lie, then light...write) printed in two columns for
-- space — order_index preserves that single alphabetical order.
--
-- Safe to re-run: this appendix section deletes itself first
-- (cascades to subsections/examples/table_rows/irregular_verbs)
-- before re-inserting.

delete from appendix_sections where slug = 'regular-and-irregular-verbs';

insert into appendix_sections (number, slug, title, order_index)
values (1, 'regular-and-irregular-verbs', 'Regular and irregular verbs', 0);

insert into appendix_subsections (appendix_section_id, label, heading, explanation, unit_refs, order_index)
select id, '1.1', 'Regular verbs',
  'If a verb is regular, the past simple and past participle end in -ed. For example: clean -> cleaned, finish -> finished, use -> used, paint -> painted, stop -> stopped, carry -> carried. For spelling rules, see Appendix 6. For the past simple (I cleaned / they finished / she carried etc.), see Unit 5. We use the past participle to make the perfect tenses and all the passive forms.',
  array[5, 7, 8, 15, 42, 43, 44], 0
from appendix_sections where slug = 'regular-and-irregular-verbs';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'regular-and-irregular-verbs'
join (values
  ('1.1', 'I have cleaned the windows.', 'present perfect — see Units 7-8', 0),
  ('1.1', 'They were still working. They hadn''t finished.', 'past perfect — see Unit 15', 1),
  ('1.1', 'He was carried out of the room.', 'past simple passive — see Units 42-44', 2),
  ('1.1', 'This gate has just been painted.', 'present perfect passive — see Units 42-44', 3)
) as v(label, sentence, note, order_index) on v.label = s.label;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '1.2', 'Irregular verbs',
  'When the past simple and past participle do not end in -ed (for example, I saw / I have seen), the verb is irregular. With some irregular verbs, all three forms (infinitive, past simple and past participle) are the same — for example, hit. With other irregular verbs, the past simple is the same as the past participle but different from the infinitive — for example, tell -> told. With other irregular verbs, all three forms are different — for example, wake -> woke/woken.',
  1
from appendix_sections where slug = 'regular-and-irregular-verbs';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'regular-and-irregular-verbs'
join (values
  ('1.2', 'Don''t hit me.', 'hit — infinitive', 0),
  ('1.2', 'Somebody hit me as I came into the room.', 'hit — past simple', 1),
  ('1.2', 'I''ve never hit anybody in my life.', 'hit — past participle, present perfect', 2),
  ('1.2', 'George was hit on the head by a stone.', 'hit — past participle, passive', 3),
  ('1.2', 'Can you tell me what to do?', 'tell — infinitive', 4),
  ('1.2', 'She told me to come back the next day.', 'tell — past simple', 5),
  ('1.2', 'Have you told anybody about your new job?', 'tell — past participle, present perfect', 6),
  ('1.2', 'I was told to come back the next day.', 'tell — past participle, passive', 7),
  ('1.2', 'I''ll wake you up.', 'wake — infinitive', 8),
  ('1.2', 'I woke up in the middle of the night.', 'wake — past simple', 9),
  ('1.2', 'The baby has woken up.', 'wake — past participle, present perfect', 10),
  ('1.2', 'I was woken up by a loud noise.', 'wake — past participle, passive', 11)
) as v(label, sentence, note, order_index) on v.label = s.label;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, unit_refs, order_index)
select id, '1.3', 'The following verbs can be regular or irregular',
  'burn -> burned or burnt, dream -> dreamed or dreamt [dremt], lean -> leaned or leant [lent], learn -> learned or learnt, smell -> smelled or smelt, spell -> spelled or spelt, spill -> spilled or spilt, spoil -> spoiled or spoilt. In British English the irregular form (burnt/learnt etc.) is more usual. For American English, see Appendix 7.',
  array[7], 2
from appendix_sections where slug = 'regular-and-irregular-verbs';

insert into appendix_examples (subsection_id, sentence, note, order_index)
select s.id, v.sentence, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'regular-and-irregular-verbs'
join (values
  ('1.3', 'I leant out of the window.', 'or I leaned out of the window', 0),
  ('1.3', 'The dinner has been spoiled.', 'or The dinner has been spoilt', 1)
) as v(label, sentence, note, order_index) on v.label = s.label;

insert into appendix_subsections (appendix_section_id, label, heading, order_index)
select id, '1.4', 'List of irregular verbs', 3
from appendix_sections where slug = 'regular-and-irregular-verbs';

insert into irregular_verbs (subsection_id, infinitive, past_simple, past_participle, note, order_index)
select s.id, v.infinitive, v.past_simple, v.past_participle, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'regular-and-irregular-verbs'
  and s.label = '1.4'
join (values
  ('be', 'was/were', 'been', null::text, 0),
  ('beat', 'beat', 'beaten', null, 1),
  ('become', 'became', 'become', null, 2),
  ('begin', 'began', 'begun', null, 3),
  ('bend', 'bent', 'bent', null, 4),
  ('bet', 'bet', 'bet', null, 5),
  ('bite', 'bit', 'bitten', null, 6),
  ('blow', 'blew', 'blown', null, 7),
  ('break', 'broke', 'broken', null, 8),
  ('bring', 'brought', 'brought', null, 9),
  ('broadcast', 'broadcast', 'broadcast', null, 10),
  ('build', 'built', 'built', null, 11),
  ('burst', 'burst', 'burst', null, 12),
  ('buy', 'bought', 'bought', null, 13),
  ('catch', 'caught', 'caught', null, 14),
  ('choose', 'chose', 'chosen', null, 15),
  ('come', 'came', 'come', null, 16),
  ('cost', 'cost', 'cost', null, 17),
  ('creep', 'crept', 'crept', null, 18),
  ('cut', 'cut', 'cut', null, 19),
  ('deal', 'dealt', 'dealt', null, 20),
  ('dig', 'dug', 'dug', null, 21),
  ('do', 'did', 'done', null, 22),
  ('draw', 'drew', 'drawn', null, 23),
  ('drink', 'drank', 'drunk', null, 24),
  ('drive', 'drove', 'driven', null, 25),
  ('eat', 'ate', 'eaten', null, 26),
  ('fall', 'fell', 'fallen', null, 27),
  ('feed', 'fed', 'fed', null, 28),
  ('feel', 'felt', 'felt', null, 29),
  ('fight', 'fought', 'fought', null, 30),
  ('find', 'found', 'found', null, 31),
  ('flee', 'fled', 'fled', null, 32),
  ('fly', 'flew', 'flown', null, 33),
  ('forbid', 'forbade', 'forbidden', null, 34),
  ('forget', 'forgot', 'forgotten', null, 35),
  ('forgive', 'forgave', 'forgiven', null, 36),
  ('freeze', 'froze', 'frozen', null, 37),
  ('get', 'got', 'got/gotten', null, 38),
  ('give', 'gave', 'given', null, 39),
  ('go', 'went', 'gone', null, 40),
  ('grow', 'grew', 'grown', null, 41),
  ('hang', 'hung', 'hung', null, 42),
  ('have', 'had', 'had', null, 43),
  ('hear', 'heard', 'heard', null, 44),
  ('hide', 'hid', 'hidden', null, 45),
  ('hit', 'hit', 'hit', null, 46),
  ('hold', 'held', 'held', null, 47),
  ('hurt', 'hurt', 'hurt', null, 48),
  ('keep', 'kept', 'kept', null, 49),
  ('kneel', 'knelt', 'knelt', null, 50),
  ('know', 'knew', 'known', null, 51),
  ('lay', 'laid', 'laid', null, 52),
  ('lead', 'led', 'led', null, 53),
  ('leave', 'left', 'left', null, 54),
  ('lend', 'lent', 'lent', null, 55),
  ('let', 'let', 'let', null, 56),
  ('lie', 'lay', 'lain', null, 57)
) as v(infinitive, past_simple, past_participle, note, order_index) on true;

insert into irregular_verbs (subsection_id, infinitive, past_simple, past_participle, note, order_index)
select s.id, v.infinitive, v.past_simple, v.past_participle, v.note, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'regular-and-irregular-verbs'
  and s.label = '1.4'
join (values
  ('light', 'lit', 'lit', null::text, 58),
  ('lose', 'lost', 'lost', null, 59),
  ('make', 'made', 'made', null, 60),
  ('mean', 'meant', 'meant', null, 61),
  ('meet', 'met', 'met', null, 62),
  ('pay', 'paid', 'paid', null, 63),
  ('put', 'put', 'put', null, 64),
  ('read', 'read', 'read', 'pronounced [red] in the past forms', 65),
  ('ride', 'rode', 'ridden', null, 66),
  ('ring', 'rang', 'rung', null, 67),
  ('rise', 'rose', 'risen', null, 68),
  ('run', 'ran', 'run', null, 69),
  ('say', 'said', 'said', null, 70),
  ('see', 'saw', 'seen', null, 71),
  ('seek', 'sought', 'sought', null, 72),
  ('sell', 'sold', 'sold', null, 73),
  ('send', 'sent', 'sent', null, 74),
  ('set', 'set', 'set', null, 75),
  ('sew', 'sewed', 'sewn/sewed', null, 76),
  ('shake', 'shook', 'shaken', null, 77),
  ('shine', 'shone', 'shone', null, 78),
  ('shoot', 'shot', 'shot', null, 79),
  ('show', 'showed', 'shown/showed', null, 80),
  ('shrink', 'shrank', 'shrunk', null, 81),
  ('shut', 'shut', 'shut', null, 82),
  ('sing', 'sang', 'sung', null, 83),
  ('sink', 'sank', 'sunk', null, 84),
  ('sit', 'sat', 'sat', null, 85),
  ('sleep', 'slept', 'slept', null, 86),
  ('slide', 'slid', 'slid', null, 87),
  ('speak', 'spoke', 'spoken', null, 88),
  ('spend', 'spent', 'spent', null, 89),
  ('spit', 'spat', 'spat', null, 90),
  ('split', 'split', 'split', null, 91),
  ('spread', 'spread', 'spread', null, 92),
  ('spring', 'sprang', 'sprung', null, 93),
  ('stand', 'stood', 'stood', null, 94),
  ('steal', 'stole', 'stolen', null, 95),
  ('stick', 'stuck', 'stuck', null, 96),
  ('sting', 'stung', 'stung', null, 97),
  ('stink', 'stank', 'stunk', null, 98),
  ('strike', 'struck', 'struck', null, 99),
  ('swear', 'swore', 'sworn', null, 100),
  ('sweep', 'swept', 'swept', null, 101),
  ('swim', 'swam', 'swum', null, 102),
  ('swing', 'swung', 'swung', null, 103),
  ('take', 'took', 'taken', null, 104),
  ('teach', 'taught', 'taught', null, 105),
  ('tear', 'tore', 'torn', null, 106),
  ('tell', 'told', 'told', null, 107),
  ('think', 'thought', 'thought', null, 108),
  ('throw', 'threw', 'thrown', null, 109),
  ('understand', 'understood', 'understood', null, 110),
  ('wake', 'woke', 'woken', null, 111),
  ('wear', 'wore', 'worn', null, 112),
  ('weep', 'wept', 'wept', null, 113),
  ('win', 'won', 'won', null, 114),
  ('write', 'wrote', 'written', null, 115)
) as v(infinitive, past_simple, past_participle, note, order_index) on true;
