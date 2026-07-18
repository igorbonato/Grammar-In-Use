import { create } from 'zustand'

type AdditionalExercisesStoreState = {
  answers: Record<string, string>
  showHints: Record<string, boolean>
  checkedGroups: Record<string, boolean>
  setAnswer: (blankId: string, value: string) => void
  showHint: (sentenceId: string) => void
  checkGroup: (sourceRef: string) => void
  resetGroup: (sourceRef: string, blankIds: string[], sentenceIds: string[]) => void
}

export const useAdditionalExercisesStore = create<AdditionalExercisesStoreState>((set) => ({
  answers: {},
  showHints: {},
  checkedGroups: {},

  setAnswer: (blankId, value) =>
    set(state => ({ answers: { ...state.answers, [blankId]: value } })),

  showHint: (sentenceId) =>
    set(state => ({ showHints: { ...state.showHints, [sentenceId]: true } })),

  checkGroup: (sourceRef) =>
    set(state => ({ checkedGroups: { ...state.checkedGroups, [sourceRef]: true } })),

  resetGroup: (sourceRef, blankIds, sentenceIds) =>
    set(state => {
      const answers = { ...state.answers }
      for (const id of blankIds) delete answers[id]
      const showHints = { ...state.showHints }
      for (const id of sentenceIds) delete showHints[id]
      const checkedGroups = { ...state.checkedGroups }
      delete checkedGroups[sourceRef]
      return { answers, showHints, checkedGroups }
    }),
}))
