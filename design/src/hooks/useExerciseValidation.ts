import { useState } from 'react'
import type { Exercise } from '../types/grammar'

type FeedbackState = 'idle' | 'checked'
export type ExerciseStatus = 'idle' | 'empty' | 'correct' | 'wrong'

export function useExerciseValidation(exercises: Exercise[]) {
  const [answers, setAnswers] = useState<Record<number, string>>({})
  const [feedback, setFeedback] = useState<FeedbackState>('idle')
  const [score, setScore] = useState<{ correct: number; total: number } | null>(null)
  const [showHints, setShowHints] = useState<Record<number, boolean>>({})

  const handleChange = (id: number, value: string) => {
    setAnswers(prev => ({ ...prev, [id]: value }))
    if (feedback === 'checked') setFeedback('idle')
  }

  const handleCheck = () => {
    setFeedback('checked')
    const correct = exercises.filter(ex =>
      (answers[ex.id] || '').trim().toLowerCase() === ex.answer.toLowerCase()
    ).length
    setScore({ correct, total: exercises.length })
  }

  const handleReset = () => {
    setAnswers({})
    setFeedback('idle')
    setScore(null)
    setShowHints({})
  }

  const showHint = (id: number) => {
    setShowHints(prev => ({ ...prev, [id]: true }))
  }

  const getStatus = (ex: Exercise): ExerciseStatus => {
    if (feedback !== 'checked') return 'idle'
    const val = (answers[ex.id] || '').trim().toLowerCase()
    if (!val) return 'empty'
    return val === ex.answer.toLowerCase() ? 'correct' : 'wrong'
  }

  const completedCount = Object.keys(answers).filter(k => answers[Number(k)]?.trim()).length

  return {
    answers,
    feedback,
    score,
    showHints,
    completedCount,
    handleChange,
    handleCheck,
    handleReset,
    showHint,
    getStatus,
  }
}
