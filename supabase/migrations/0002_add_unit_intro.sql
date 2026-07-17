-- Adds the intro paragraph shown at the top of a unit's theory panel,
-- above the Structure table. Missed in 0001_init.sql: theory_sections
-- covers the lettered rule sections (A/B/C...), but not this overview text.

alter table units add column intro text;
