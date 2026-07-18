-- Appendix 6: Spelling.
--
-- Sourced from pdf/Appendix.pdf (extracted via `pdftotext -layout`).
-- 6.1's ending-type overview is a flat reference table
-- (appendix_table_rows); 6.2-6.6 are prose rules whose word-pair
-- examples (baby/babies, stop/stopping etc.) are folded into each
-- subsection's explanation text rather than appendix_examples, since
-- they're word pairs, not full quoted sentences.
--
-- Safe to re-run: this appendix section deletes itself first before
-- re-inserting.

delete from appendix_sections where slug = 'spelling';

insert into appendix_sections (number, slug, title, order_index)
values (6, 'spelling', 'Spelling', 5);

insert into appendix_subsections (appendix_section_id, label, heading, explanation, column_headers, order_index)
select id, '6.1', 'Nouns, verbs and adjectives can have the following endings',
  'When we use these endings, there are sometimes changes in spelling. These changes are listed in the sections below.',
  array['Ending', 'Examples'], 0
from appendix_sections where slug = 'spelling';

insert into appendix_table_rows (subsection_id, col_a, col_b, order_index)
select s.id, v.col_a, v.col_b, v.order_index
from appendix_subsections s
join appendix_sections sec on sec.id = s.appendix_section_id and sec.slug = 'spelling' and s.label = '6.1'
join (values
  ('noun + -s/-es (plural)', 'books, ideas, matches', 0),
  ('verb + -s/-es (after he/she/it)', 'works, enjoys, washes', 1),
  ('verb + -ing', 'working, enjoying, washing', 2),
  ('verb + -ed', 'worked, enjoyed, washed', 3),
  ('adjective + -er (comparative)', 'cheaper, quicker, brighter', 4),
  ('adjective + -est (superlative)', 'cheapest, quickest, brightest', 5),
  ('adjective + -ly (adverb)', 'cheaply, quickly, brightly', 6)
) as v(col_a, col_b, order_index) on true;

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '6.2', 'Nouns and verbs + -s/-es',
  'The ending is -es when the word ends in -s/-ss/-sh/-ch/-x: bus -> buses, miss -> misses, wash -> washes, match -> matches, search -> searches, box -> boxes. Note also: tomato -> tomatoes, potato -> potatoes, go -> goes, do -> does.',
  1
from appendix_sections where slug = 'spelling';

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '6.3', 'Words ending in -y (baby, carry, easy etc.)',
  'If a word ends in a consonant + y (-by/-ry/-sy/-vy etc.): y changes to ie before the ending -s (baby -> babies, story -> stories, country -> countries, secretary -> secretaries, hurry -> hurries, study -> studies, apply -> applies, try -> tries); y changes to i before the ending -ed (hurry -> hurried, study -> studied, apply -> applied, try -> tried); y changes to i before the endings -er and -est (easy -> easier -> easiest, heavy -> heavier -> heaviest, lucky -> luckier -> luckiest); y changes to i before the ending -ly (easy -> easily, heavy -> heavily, temporary -> temporarily); y does not change before -ing (hurrying, studying, applying, trying). y does not change if the word ends in a vowel + y (-ay/-ey/-oy/-uy): buy -> buys, play -> plays -> played, monkey -> monkeys, enjoy -> enjoys -> enjoyed. An exception is day -> daily; say -> said. Note also: pay -> paid, lay -> laid.',
  2
from appendix_sections where slug = 'spelling';

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '6.4', 'Verbs ending in -ie (die, lie, tie)',
  'If a verb ends in -ie, ie changes to y before the ending -ing: die -> dying, lie -> lying, tie -> tying.',
  3
from appendix_sections where slug = 'spelling';

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '6.5', 'Words ending in -e (hope, dance, wide etc.)',
  'Verbs: if a verb ends in -e, we leave out e before the ending -ing (hope -> hoping, smile -> smiling, dance -> dancing) — exceptions are be -> being and verbs ending in -ee (see -> seeing, agree -> agreeing). If a verb ends in -e, we add -d for the past of regular verbs (hope -> hoped, smile -> smiled, dance -> danced). Adjectives and adverbs: if an adjective ends in -e, we add -r and -st for the comparative and superlative (wide -> wider -> widest, late -> later -> latest, large -> larger -> largest). If an adjective ends in -e, we keep e before -ly in the adverb (polite -> politely, extreme -> extremely, absolute -> absolutely). If an adjective ends in -le (simple, terrible etc.), the adverb ending is -ply, -bly etc. (simple -> simply, terrible -> terribly, reasonable -> reasonably).',
  4
from appendix_sections where slug = 'spelling';

insert into appendix_subsections (appendix_section_id, label, heading, explanation, order_index)
select id, '6.6', 'Doubling consonants (stop/stopping/stopped, wet/wetter/wettest etc.)',
  'Sometimes a word ends in vowel + consonant, for example stop, plan, rub, big, wet, thin, regret, prefer. Before the endings -ing/-ed/-er/-est, we double the consonant at the end: stop -> stopping -> stopped, plan -> planning -> planned, rub -> rubbing -> rubbed, big -> bigger -> biggest, wet -> wetter -> wettest, thin -> thinner -> thinnest. If the word has more than one syllable (prefer, begin etc.), we double the consonant at the end only if the final syllable is stressed: preFER -> preferring -> preferred, perMIT -> permitting -> permitted, reGRET -> regretting -> regretted, beGIN -> beginning. If the final syllable is not stressed, we do not double the final consonant: VISit -> visiting -> visited, deVELop -> developing -> developed, HAPpen -> happening -> happened, reMEMber -> remembering -> remembered. In British English, verbs ending in -l have -ll- before -ing and -ed whether the final syllable is stressed or not: travel -> travelling -> travelled, cancel -> cancelling -> cancelled. For American spelling, see Appendix 7. Note that we do not double the final consonant if the word ends in two consonants (-rt, -lp, -ng etc.): start -> starting -> started, help -> helping -> helped, long -> longer -> longest. We do not double the final consonant if there are two vowel letters before it (-oil, -eed etc.): boil -> boiling -> boiled, need -> needing -> needed, explain -> explaining -> explained, cheap -> cheaper -> cheapest, loud -> louder -> loudest, quiet -> quieter -> quietest. We do not double y or w at the end of words, since at the end of words y and w are not consonants: stay -> staying -> stayed, grow -> growing, new -> newer -> newest.',
  5
from appendix_sections where slug = 'spelling';
