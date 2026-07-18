import type { StudyGuideQuestion } from '../types/grammar'

export function correctLetters(question: StudyGuideQuestion): string[] {
  return question.options.filter(option => option.isCorrect).map(option => option.letter)
}

/** Correct iff the selected set of letters exactly equals the correct set (order-independent). */
export function isQuestionCorrect(question: StudyGuideQuestion, selectedLetters: string[]): boolean {
  const correct = new Set(correctLetters(question))
  const selected = new Set(selectedLetters)
  if (correct.size !== selected.size) return false
  for (const letter of correct) {
    if (!selected.has(letter)) return false
  }
  return true
}

export function computeGroupScore(questions: StudyGuideQuestion[], selections: Record<string, string[]>) {
  const correct = questions.filter(question => isQuestionCorrect(question, selections[question.id] ?? [])).length
  return { correct, total: questions.length }
}
