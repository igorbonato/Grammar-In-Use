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

export type Exercise = {
  id: number
  instruction?: string
  prompt: string
  prefix?: string
  suffix?: string
  blank: string
  answer: string
  hint?: string
}
