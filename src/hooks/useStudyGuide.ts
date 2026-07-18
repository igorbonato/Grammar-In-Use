import { useQuery } from '@tanstack/react-query'
import { supabase } from '../lib/supabaseClient'
import type { StudyGuideGroup } from '../types/grammar'

type RawOption = {
  id: string
  letter: string
  option_text: string
  is_correct: boolean
  order_index: number
}

type RawQuestion = {
  id: string
  question_number: string
  template: string
  study_units: number[] | null
  order_index: number
  study_guide_options: RawOption[] | null
}

type RawModule = {
  id: string
  slug: string
  title: string
  order_index: number
  study_guide_questions: RawQuestion[] | null
}

async function fetchStudyGuide(): Promise<StudyGuideGroup[]> {
  const { data, error } = await supabase
    .from('modules')
    .select(
      `id, slug, title, order_index,
      study_guide_questions (
        id, question_number, template, study_units, order_index,
        study_guide_options ( id, letter, option_text, is_correct, order_index )
      )`,
    )

  if (error) throw error

  const modules = (data ?? []) as unknown as RawModule[]

  return [...modules]
    .sort((a, b) => a.order_index - b.order_index)
    .map(mod => ({
      moduleId: mod.slug,
      moduleTitle: mod.title,
      questions: [...(mod.study_guide_questions ?? [])]
        .sort((a, b) => a.order_index - b.order_index)
        .map(question => ({
          id: question.id,
          questionNumber: question.question_number,
          template: question.template,
          studyUnits: question.study_units ?? [],
          options: [...(question.study_guide_options ?? [])]
            .sort((a, b) => a.order_index - b.order_index)
            .map(option => ({
              id: option.id,
              letter: option.letter,
              text: option.option_text,
              isCorrect: option.is_correct,
            })),
        })),
    }))
    .filter(group => group.questions.length > 0)
}

export function useStudyGuide() {
  return useQuery({
    queryKey: ['study-guide'],
    queryFn: fetchStudyGuide,
  })
}
