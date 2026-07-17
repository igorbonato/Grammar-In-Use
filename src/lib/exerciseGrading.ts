import type { ExerciseBlank, ExerciseSentence } from '../types/grammar'

export type BlankStatus = 'idle' | 'empty' | 'correct' | 'wrong'

function normalize(value: string): string {
  return value.trim().toLowerCase()
}

export function isBlankCorrect(blank: ExerciseBlank, value: string): boolean {
  const normalized = normalize(value)
  if (!normalized) return false
  if (normalized === normalize(blank.correctAnswer)) return true
  return blank.acceptedAlternatives.some(alt => normalize(alt) === normalized)
}

export function getBlankStatus(blank: ExerciseBlank, value: string, checked: boolean): BlankStatus {
  if (!checked) return 'idle'
  if (!value.trim()) return 'empty'
  return isBlankCorrect(blank, value) ? 'correct' : 'wrong'
}

export function allBlanks(sentences: ExerciseSentence[]): ExerciseBlank[] {
  return sentences.flatMap(sentence => sentence.blanks)
}

export function computeScore(sentences: ExerciseSentence[], answers: Record<string, string>) {
  const blanks = allBlanks(sentences)
  const correct = blanks.filter(blank => isBlankCorrect(blank, answers[blank.id] ?? '')).length
  return { correct, total: blanks.length }
}
