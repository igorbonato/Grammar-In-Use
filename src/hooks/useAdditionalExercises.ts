import { useQuery } from '@tanstack/react-query'
import { supabase } from '../lib/supabaseClient'
import type { AdditionalExerciseGroup } from '../types/grammar'

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

type RawSetUnit = {
  units: { unit_number: number } | null
}

type RawSet = {
  id: string
  title: string | null
  instruction: string | null
  source_ref: string | null
  order_index: number
  exercise_sentences: RawSentence[] | null
  exercise_set_units: RawSetUnit[] | null
}

function exerciseNumber(title: string | null): number {
  const match = title?.match(/(\d+)\s*$/)
  return match ? Number(match[1]) : 0
}

async function fetchAdditionalExercises(): Promise<AdditionalExerciseGroup[]> {
  const { data, error } = await supabase
    .from('exercise_sets')
    .select(
      `id, title, instruction, source_ref, order_index,
      exercise_sentences (
        id, sentence_number, template, hint, order_index,
        exercise_blanks ( id, blank_index, correct_answer, accepted_alternatives )
      ),
      exercise_set_units ( units ( unit_number ) )`,
    )
    .eq('kind', 'additional')

  if (error) throw error

  const sets = (data ?? []) as unknown as RawSet[]

  const exercises = sets.map(set => ({
    id: set.id,
    title: set.title,
    instruction: set.instruction,
    sourceRef: set.source_ref ?? 'Additional exercises',
    unitRefs: [...new Set((set.exercise_set_units ?? []).map(su => su.units?.unit_number).filter((n): n is number => n != null))].sort(
      (a, b) => a - b,
    ),
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

  const groupsByRef = new Map<string, typeof exercises>()
  for (const exercise of exercises) {
    const list = groupsByRef.get(exercise.sourceRef) ?? []
    list.push(exercise)
    groupsByRef.set(exercise.sourceRef, list)
  }

  const groups: AdditionalExerciseGroup[] = [...groupsByRef.entries()].map(([sourceRef, groupExercises]) => ({
    sourceRef,
    exercises: [...groupExercises]
      .sort((a, b) => exerciseNumber(a.title) - exerciseNumber(b.title))
      .map(({ sourceRef: _sourceRef, ...exercise }) => exercise),
  }))

  return groups.sort((a, b) => exerciseNumber(a.exercises[0]?.title ?? null) - exerciseNumber(b.exercises[0]?.title ?? null))
}

export function useAdditionalExercises() {
  return useQuery({
    queryKey: ['additional-exercises'],
    queryFn: fetchAdditionalExercises,
  })
}
