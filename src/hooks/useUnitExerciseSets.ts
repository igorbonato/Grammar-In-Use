import { useQuery } from '@tanstack/react-query'
import { supabase } from '../lib/supabaseClient'
import type { ExerciseSet } from '../types/grammar'

type RawBlank = {
  id: string
  blank_index: number
  correct_answer: string
  accepted_alternatives: string[] | null
}

type RawSentence = {
  id: string
  sentence_number: number
  template: string
  hint: string | null
  order_index: number
  exercise_blanks: RawBlank[] | null
}

type RawSet = {
  id: string
  kind: string
  title: string | null
  instruction: string | null
  order_index: number
  exercise_sentences: RawSentence[] | null
}

async function fetchUnitExerciseSets(unitSlug: string): Promise<ExerciseSet[]> {
  const { data: unit, error: unitError } = await supabase
    .from('units')
    .select('id')
    .eq('slug', unitSlug)
    .maybeSingle()

  if (unitError) throw unitError
  if (!unit) return []

  const { data, error } = await supabase
    .from('exercise_set_units')
    .select(
      `exercise_sets (
        id, kind, title, instruction, order_index,
        exercise_sentences (
          id, sentence_number, template, hint, order_index,
          exercise_blanks ( id, blank_index, correct_answer, accepted_alternatives )
        )
      )`,
    )
    .eq('unit_id', unit.id)

  if (error) throw error

  const sets = (data ?? [])
    .map(row => row.exercise_sets as unknown as RawSet | null)
    .filter((set): set is RawSet => set != null)

  return [...sets]
    .sort((a, b) => a.order_index - b.order_index)
    .map(set => ({
      id: set.id,
      kind: set.kind === 'additional' ? 'additional' : 'main',
      title: set.title,
      instruction: set.instruction,
      sentences: [...(set.exercise_sentences ?? [])]
        .sort((a, b) => a.order_index - b.order_index)
        .map(sentence => ({
          id: sentence.id,
          sentenceNumber: sentence.sentence_number,
          template: sentence.template,
          hint: sentence.hint,
          blanks: [...(sentence.exercise_blanks ?? [])]
            .sort((a, b) => a.blank_index - b.blank_index)
            .map(blank => ({
              id: blank.id,
              blankIndex: blank.blank_index,
              correctAnswer: blank.correct_answer,
              acceptedAlternatives: blank.accepted_alternatives ?? [],
            })),
        })),
    }))
}

export function useUnitExerciseSets(unitSlug: string) {
  return useQuery({
    queryKey: ['unit-exercise-sets', unitSlug],
    queryFn: () => fetchUnitExerciseSets(unitSlug),
  })
}
