-- Backfill exercise_sets.source_ref with the book's own 20 topic-group
-- titles for the 40 seeded Additional exercises (0094-0112).
--
-- This is a pure UPDATE against the pre-existing, previously-unused
-- source_ref column (Marco 2, supabase/migrations/0001_init.sql) — no
-- schema change, no remapping of unit_id or exercise_set_units. It
-- exists so the new /exercicios-adicionais page can group and label
-- exercises straight from the DB instead of duplicating the book's
-- table-of-contents structure in a client-side file.
--
-- Safe to re-run: plain UPDATE, idempotent.

update exercise_sets set source_ref = 'Present and past (Units 1-6)'
where kind = 'additional' and title = 'Additional exercise 1';

update exercise_sets set source_ref = 'Present and past (Units 1-14)'
where kind = 'additional' and title in ('Additional exercise 2', 'Additional exercise 3', 'Additional exercise 4');

update exercise_sets set source_ref = 'Present and past (Units 1-17, 110)'
where kind = 'additional' and title in ('Additional exercise 5', 'Additional exercise 6', 'Additional exercise 7', 'Additional exercise 8');

update exercise_sets set source_ref = 'Past continuous and used to (Units 6, 18)'
where kind = 'additional' and title = 'Additional exercise 9';

update exercise_sets set source_ref = 'The future (Units 19-25)'
where kind = 'additional' and title in ('Additional exercise 10', 'Additional exercise 11', 'Additional exercise 12', 'Additional exercise 13');

update exercise_sets set source_ref = 'Past, present and future (Units 1-25)'
where kind = 'additional' and title in ('Additional exercise 14', 'Additional exercise 15');

update exercise_sets set source_ref = 'Modal verbs (can/must/would etc.) (Units 26-36)'
where kind = 'additional' and title in ('Additional exercise 16', 'Additional exercise 17', 'Additional exercise 18');

update exercise_sets set source_ref = 'if (conditional) (Units 25, 38-40)'
where kind = 'additional' and title in ('Additional exercise 19', 'Additional exercise 20');

update exercise_sets set source_ref = 'Passive (Units 42-45)'
where kind = 'additional' and title in ('Additional exercise 22', 'Additional exercise 23', 'Additional exercise 24');

update exercise_sets set source_ref = 'Reported speech (Units 47-48, 50)'
where kind = 'additional' and title = 'Additional exercise 25';

update exercise_sets set source_ref = '-ing and to ... (Units 53-66)'
where kind = 'additional' and title in ('Additional exercise 26', 'Additional exercise 27', 'Additional exercise 28');

update exercise_sets set source_ref = 'a/an and the (Units 69-78)'
where kind = 'additional' and title = 'Additional exercise 29';

update exercise_sets set source_ref = 'Pronouns and determiners (Units 82-91)'
where kind = 'additional' and title = 'Additional exercise 30';

update exercise_sets set source_ref = 'Adjectives and adverbs (Units 98-108)'
where kind = 'additional' and title = 'Additional exercise 31';

update exercise_sets set source_ref = 'Conjunctions (Units 25, 38, 112-118)'
where kind = 'additional' and title = 'Additional exercise 32';

update exercise_sets set source_ref = 'Prepositions (time) (Units 12, 119-122)'
where kind = 'additional' and title = 'Additional exercise 33';

update exercise_sets set source_ref = 'Prepositions (position and other uses) (Units 123-128)'
where kind = 'additional' and title = 'Additional exercise 34';

update exercise_sets set source_ref = 'Noun/adjective + preposition (Units 129-131)'
where kind = 'additional' and title = 'Additional exercise 35';

update exercise_sets set source_ref = 'Verb + preposition (Units 132-136)'
where kind = 'additional' and title = 'Additional exercise 36';

update exercise_sets set source_ref = 'Phrasal verbs (Units 137-145)'
where kind = 'additional' and title in ('Additional exercise 37', 'Additional exercise 38', 'Additional exercise 39', 'Additional exercise 40', 'Additional exercise 41');
