import type { Unit } from '../../types/grammar'
import { useUnitExercises } from '../../hooks/useUnitExercises'
import { useExerciseValidation } from '../../hooks/useExerciseValidation'
import ExerciseItem from './ExerciseItem'
import ScoreBadge from './ScoreBadge'
import ActionFooter from './ActionFooter'

export default function ExercisesPanel({ unit }: { unit: Unit }) {
  const exercises = useUnitExercises(unit.id)
  const {
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
  } = useExerciseValidation(exercises)

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
          {score && feedback === 'checked' && (
            <ScoreBadge correct={score.correct} total={score.total} />
          )}
          <div className="text-xs text-gray-400">
            {completedCount}/{exercises.length} answered
          </div>
          {/* Mini progress ring */}
          <div className="relative w-8 h-8">
            <svg width="32" height="32" viewBox="0 0 32 32" className="-rotate-90">
              <circle cx="16" cy="16" r="12" fill="none" stroke="#e5e7eb" strokeWidth="3" />
              <circle cx="16" cy="16" r="12" fill="none" stroke="#4a8df7" strokeWidth="3"
                strokeDasharray={`${(completedCount / exercises.length) * 75.4} 75.4`}
                strokeLinecap="round" />
            </svg>
          </div>
        </div>
      </div>

      {/* Instruction */}
      {unit.id === 'unit-1' && (
        <div className="px-7 py-3 bg-white border-b border-gray-100">
          <p className="text-[13px] text-gray-500">
            Put the verb in brackets into the <span className="font-semibold text-cambridge-600">present continuous</span> form.
            Type your answer in the blank and click <strong>Check Answers</strong> when done.
          </p>
        </div>
      )}

      {/* Exercises list */}
      <div className="flex-1 overflow-y-auto px-7 py-5 pb-24 space-y-4">
        {exercises.map((ex, idx) => (
          <ExerciseItem
            key={ex.id}
            exercise={ex}
            index={idx}
            status={getStatus(ex)}
            value={answers[ex.id] ?? ''}
            hintVisible={!!showHints[ex.id]}
            onChange={handleChange}
            onShowHint={showHint}
          />
        ))}
      </div>

      <ActionFooter checked={feedback === 'checked'} onCheck={handleCheck} onReset={handleReset} />
    </div>
  )
}
