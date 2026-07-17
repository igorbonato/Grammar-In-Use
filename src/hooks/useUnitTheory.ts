import { useQuery } from '@tanstack/react-query'
import { supabase } from '../lib/supabaseClient'
import type { TheoryContent } from '../types/grammar'

async function fetchUnitTheory(unitSlug: string): Promise<TheoryContent | null> {
  const { data: unit, error: unitError } = await supabase
    .from('units')
    .select('id, title, subtitle, intro')
    .eq('slug', unitSlug)
    .maybeSingle()

  if (unitError) throw unitError
  if (!unit) return null

  const [sectionsRes, structureRes, spellingRes] = await Promise.all([
    supabase
      .from('theory_sections')
      .select('id, label, heading, explanation, order_index, theory_examples(sentence, note, order_index)')
      .eq('unit_id', unit.id)
      .order('order_index'),
    supabase
      .from('theory_structure_rows')
      .select('row_type, subject_label, aux_form, example_text, order_index')
      .eq('unit_id', unit.id)
      .order('order_index'),
    supabase
      .from('theory_spelling_notes')
      .select('rule, example, order_index')
      .eq('unit_id', unit.id)
      .order('order_index'),
  ])

  if (sectionsRes.error) throw sectionsRes.error
  if (structureRes.error) throw structureRes.error
  if (spellingRes.error) throw spellingRes.error

  const structureRows = structureRes.data ?? []
  const positive = structureRows
    .filter(row => row.row_type === 'positive')
    .map(row => ({
      pronoun: row.subject_label ?? '',
      form: row.aux_form ?? '',
      example: row.example_text ?? '',
    }))
  const negative = structureRows.find(row => row.row_type === 'negative')?.example_text ?? ''
  const question = structureRows.find(row => row.row_type === 'question')?.example_text ?? ''

  return {
    title: unit.title,
    subtitle: unit.subtitle ?? '',
    intro: unit.intro ?? '',
    sections: (sectionsRes.data ?? []).map(section => ({
      id: section.id,
      label: section.label ?? '',
      heading: section.heading,
      explanation: section.explanation,
      examples: [...(section.theory_examples ?? [])]
        .sort((a, b) => a.order_index - b.order_index)
        .map(example => ({ sentence: example.sentence, note: example.note ?? '' })),
    })),
    structure: { positive, negative, question },
    spellingNotes: (spellingRes.data ?? []).map(note => ({ rule: note.rule, example: note.example })),
  }
}

export function useUnitTheory(unitSlug: string) {
  return useQuery({
    queryKey: ['unit-theory', unitSlug],
    queryFn: () => fetchUnitTheory(unitSlug),
  })
}
