import { create } from 'zustand'

type FeedbackState = 'idle' | 'checked'

type ExerciseStoreState = {
  answers: Record<string, string>
  feedback: FeedbackState
  showHints: Record<string, boolean>
  setAnswer: (blankId: string, value: string) => void
  check: () => void
  reset: () => void
  showHint: (sentenceId: string) => void
}

export const useExerciseStore = create<ExerciseStoreState>((set) => ({
  answers: {},
  feedback: 'idle',
  showHints: {},

  setAnswer: (blankId, value) =>
    set(state => ({
      answers: { ...state.answers, [blankId]: value },
      feedback: state.feedback === 'checked' ? 'idle' : state.feedback,
    })),

  check: () => set({ feedback: 'checked' }),

  reset: () => set({ answers: {}, feedback: 'idle', showHints: {} }),

  showHint: (sentenceId) =>
    set(state => ({ showHints: { ...state.showHints, [sentenceId]: true } })),
}))
