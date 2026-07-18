import { useQuery } from '@tanstack/react-query'
import { supabase } from '../lib/supabaseClient'
import type { AppendixSection } from '../types/grammar'

type RawExample = {
  sentence: string
  note: string | null
  order_index: number
}

type RawTableRow = {
  id: string
  col_a: string
  col_b: string
  col_c: string | null
  unit_refs: number[] | null
  order_index: number
}

type RawIrregularVerb = {
  id: string
  infinitive: string
  past_simple: string
  past_participle: string
  note: string | null
  order_index: number
}

type RawSubsection = {
  id: string
  label: string | null
  heading: string
  explanation: string | null
  column_headers: string[] | null
  unit_refs: number[] | null
  order_index: number
  appendix_examples: RawExample[] | null
  appendix_table_rows: RawTableRow[] | null
  irregular_verbs: RawIrregularVerb[] | null
}

type RawSection = {
  id: string
  number: number
  slug: string
  title: string
  order_index: number
  appendix_subsections: RawSubsection[] | null
}

async function fetchAppendix(): Promise<AppendixSection[]> {
  const { data, error } = await supabase
    .from('appendix_sections')
    .select(
      `id, number, slug, title, order_index,
      appendix_subsections (
        id, label, heading, explanation, column_headers, unit_refs, order_index,
        appendix_examples ( sentence, note, order_index ),
        appendix_table_rows ( id, col_a, col_b, col_c, unit_refs, order_index ),
        irregular_verbs ( id, infinitive, past_simple, past_participle, note, order_index )
      )`,
    )

  if (error) throw error

  const sections = (data ?? []) as unknown as RawSection[]

  return [...sections]
    .sort((a, b) => a.order_index - b.order_index)
    .map(section => ({
      id: section.id,
      number: section.number,
      slug: section.slug,
      title: section.title,
      subsections: [...(section.appendix_subsections ?? [])]
        .sort((a, b) => a.order_index - b.order_index)
        .map(sub => ({
          id: sub.id,
          label: sub.label,
          heading: sub.heading,
          explanation: sub.explanation,
          unitRefs: sub.unit_refs ?? [],
          columnHeaders: sub.column_headers,
          examples: [...(sub.appendix_examples ?? [])]
            .sort((a, b) => a.order_index - b.order_index)
            .map(ex => ({ sentence: ex.sentence, note: ex.note ?? '' })),
          tableRows: [...(sub.appendix_table_rows ?? [])]
            .sort((a, b) => a.order_index - b.order_index)
            .map(row => ({
              id: row.id,
              colA: row.col_a,
              colB: row.col_b,
              colC: row.col_c,
              unitRefs: row.unit_refs ?? [],
            })),
          irregularVerbs: [...(sub.irregular_verbs ?? [])]
            .sort((a, b) => a.order_index - b.order_index)
            .map(v => ({
              id: v.id,
              infinitive: v.infinitive,
              pastSimple: v.past_simple,
              pastParticiple: v.past_participle,
              note: v.note,
            })),
        })),
    }))
    .filter(section => section.subsections.length > 0)
}

export function useAppendix() {
  return useQuery({
    queryKey: ['appendix'],
    queryFn: fetchAppendix,
  })
}
