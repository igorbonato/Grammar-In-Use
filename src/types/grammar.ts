export type Unit = {
  id: string
  title: string
  shortTitle: string
}

export type Module = {
  id: string
  title: string
  units: Unit[]
}

export type TheoryExample = {
  sentence: string
  note: string
}

export type TheorySection = {
  id: string
  label: string
  heading: string
  explanation: string
  examples: TheoryExample[]
}

export type StructureRow = {
  pronoun: string
  form: string
  example: string
}

export type TheoryStructure = {
  positive: StructureRow[]
  negative: string
  question: string
}

export type SpellingNote = {
  rule: string
  example: string
}

export type TheoryContent = {
  title: string
  subtitle: string
  intro: string
  sections: TheorySection[]
  structure: TheoryStructure
  spellingNotes: SpellingNote[]
}

export type ExerciseBlank = {
  id: string
  blankIndex: number
  correctAnswer: string
  acceptedAlternatives: string[]
}

export type ExerciseSentence = {
  id: string
  sentenceNumber: number
  // indexed placeholders, e.g. 'The sun {0} in the west.'
  template: string
  hint: string | null
  blanks: ExerciseBlank[]
}

export type ExerciseSet = {
  id: string
  kind: 'main' | 'additional'
  title: string | null
  instruction: string | null
  sentences: ExerciseSentence[]
}

export type StudyGuideOption = {
  id: string
  letter: string
  text: string
  isCorrect: boolean
}

export type StudyGuideQuestion = {
  id: string
  questionNumber: string
  // indexed placeholder, single {0} — see src/lib/exerciseTemplate.ts
  template: string
  studyUnits: number[]
  options: StudyGuideOption[]
}

export type StudyGuideGroup = {
  moduleId: string
  moduleTitle: string
  questions: StudyGuideQuestion[]
}
