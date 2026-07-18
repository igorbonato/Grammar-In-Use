import { create } from 'zustand'

type StudyGuideStoreState = {
  selections: Record<string, string[]>
  checkedGroups: Record<string, boolean>
  toggleOption: (questionId: string, letter: string) => void
  checkGroup: (moduleId: string) => void
  resetGroup: (moduleId: string, questionIds: string[]) => void
}

export const useStudyGuideStore = create<StudyGuideStoreState>((set) => ({
  selections: {},
  checkedGroups: {},

  toggleOption: (questionId, letter) =>
    set((state) => {
      const current = state.selections[questionId] ?? []
      const next = current.includes(letter)
        ? current.filter((l) => l !== letter)
        : [...current, letter]
      return { selections: { ...state.selections, [questionId]: next } }
    }),

  checkGroup: (moduleId) =>
    set((state) => ({ checkedGroups: { ...state.checkedGroups, [moduleId]: true } })),

  resetGroup: (moduleId, questionIds) =>
    set((state) => {
      const selections = { ...state.selections }
      for (const id of questionIds) delete selections[id]
      const checkedGroups = { ...state.checkedGroups }
      delete checkedGroups[moduleId]
      return { selections, checkedGroups }
    }),
}))
