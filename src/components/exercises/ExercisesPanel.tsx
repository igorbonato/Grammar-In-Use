import { useEffect } from 'react'
import type { Unit } from '../../types/grammar'
import { useUnitExerciseSets } from '../../hooks/useUnitExerciseSets'
import { useUnitProgress } from '../../hooks/useUnitProgress'
import { useAuthStore } from '../../store/useAuthStore'
import { useExerciseStore } from '../../store/useExerciseStore'
import { allBlanks, computeScore } from '../../lib/exerciseGrading'
import ExerciseItem from './ExerciseItem'
import ScoreBadge from './ScoreBadge'
import ActionFooter from './ActionFooter'

export default function ExercisesPanel({ unit }: { unit: Unit }) {
  const { data: exerciseSets, isLoading } = useUnitExerciseSets(unit.id)
  const userId = useAuthStore(state => state.user?.id ?? null)
  const { saveProgress } = useUnitProgress(unit.id, userId)

  const answers = useExerciseStore(state => state.answers)
  const feedback = useExerciseStore(state => state.feedback)
  const showHints = useExerciseStore(state => state.showHints)
  const setAnswer = useExerciseStore(state => state.setAnswer)
  const check = useExerciseStore(state => state.check)
  const resetForm = useExerciseStore(state => state.reset)
  const showHint = useExerciseStore(state => state.showHint)

  useEffect(() => {
    resetForm()
  }, [unit.id, resetForm])

  const mainSet = exerciseSets?.find(set => set.kind === 'main')
  const sentences = mainSet?.sentences ?? []
  const blanks = allBlanks(sentences)
  const checked = feedback === 'checked'
  const score = checked ? computeScore(sentences, answers) : null
  const completedCount = blanks.filter(blank => (answers[blank.id] ?? '').trim()).length

  const handleCheck = () => {
    check()
    const result = computeScore(sentences, answers)
    if (userId) saveProgress({ correct: result.correct, total: result.total })
  }

  if (isLoading) {
    return (
      <div className="flex-1 flex items-center justify-center bg-[#f8faff] text-gray-400 text-sm">
        Loading exercises…
      </div>
    )
  }

  if (sentences.length === 0) {
    return (
      <div className="flex-1 flex flex-col items-center justify-center gap-1 bg-[#f8faff] text-gray-400 text-sm">
        <span>Exercises for this unit are coming soon.</span>
      </div>
    )
  }

  return (
    <div className="flex-1 flex flex-col overflow-hidden bg-[#f8faff] relative">
      {/* Header */}
      <div className="flex-shrink-0 px-7 py-5 bg-white border-b border-gray-200 flex items-center justify-between">
        <div>
          <div className="flex items-center gap-2 mb-0.5">
            <span className="text-gray-400 text-xs font-medium tracking-wider uppercase">{unit.shortTitle}</span>
          </div>
          <h2 className="text-gray-900 font-bold text-xl">Exercises</h2>
        </div>
        <div className="flex items-center gap-3">
          {score && <ScoreBadge correct={score.correct} total={score.total} />}
          <div className="text-xs text-gray-400">
            {completedCount}/{blanks.length} answered
          </div>
          {/* Mini progress ring */}
          <div className="relative w-8 h-8">
            <svg width="32" height="32" viewBox="0 0 32 32" className="-rotate-90">
              <circle cx="16" cy="16" r="12" fill="none" stroke="#e5e7eb" strokeWidth="3" />
              <circle cx="16" cy="16" r="12" fill="none" stroke="#4a8df7" strokeWidth="3"
                strokeDasharray={`${(completedCount / blanks.length) * 75.4} 75.4`}
                strokeLinecap="round" />
            </svg>
          </div>
        </div>
      </div>

      {/* Instruction */}
      {mainSet?.instruction && (
        <div className="px-7 py-3 bg-white border-b border-gray-100">
          <p className="text-[13px] text-gray-500">{mainSet.instruction}</p>
        </div>
      )}

      {/* Exercises list */}
      <div className="flex-1 overflow-y-auto px-7 py-5 pb-24 space-y-4">
        {sentences.map((sentence, idx) => (
          <ExerciseItem
            key={sentence.id}
            sentence={sentence}
            index={idx}
            answers={answers}
            checked={checked}
            hintVisible={!!showHints[sentence.id]}
            onChangeBlank={setAnswer}
            onShowHint={() => showHint(sentence.id)}
          />
        ))}
      </div>

      <ActionFooter checked={checked} onCheck={handleCheck} onReset={resetForm} />
    </div>
  )
}
