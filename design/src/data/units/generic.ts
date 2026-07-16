import type { Exercise, TheoryContent } from '../../types/grammar'

export const genericContent: TheoryContent = {
  title: 'Coming soon',
  subtitle: 'Unit content',
  intro: 'This unit\'s content is being prepared. Select Unit 1 to see the full interactive lesson.',
  sections: [],
  structure: { positive: [], negative: '', question: '' },
  spellingNotes: [],
}

export const genericExercises: Exercise[] = [
  {
    id: 1,
    prompt: 'Select Unit 1 to see the full exercise set.',
    prefix: 'Select Unit 1 to see',
    suffix: 'the full exercise set.',
    blank: '',
    answer: '',
    hint: 'Navigate to Unit 1',
  },
]
