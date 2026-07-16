import type { Exercise } from '../../types/grammar'
import type { ExerciseStatus } from '../../hooks/useExerciseValidation'
import InlineInput from './InlineInput'
import HintToggle from './HintToggle'

type Props = {
  exercise: Exercise
  index: number
  status: ExerciseStatus
  value: string
  hintVisible: boolean
  onChange: (id: number, value: string) => void
  onShowHint: (id: number) => void
}

export default function ExerciseItem({ exercise, index, status, value, hintVisible, onChange, onShowHint }: Props) {
  return (
    <div
      className="bg-white rounded-xl border transition-all duration-200"
      style={{
        borderColor: status === 'correct' ? '#86efac'
          : status === 'wrong' ? '#fca5a5'
          : status === 'empty' ? '#fde68a'
          : '#e5e7eb',
        boxShadow: status === 'correct'
          ? '0 0 0 1px #86efac, 0 2px 8px rgba(134, 239, 172, 0.2)'
          : status === 'wrong'
          ? '0 0 0 1px #fca5a5, 0 2px 8px rgba(252, 165, 165, 0.15)'
          : '0 1px 3px rgba(0,0,0,0.04)',
      }}
    >
      <div className="px-5 py-4">
        <div className="flex items-start gap-3">
          <span className="flex-shrink-0 mt-0.5 w-6 h-6 rounded-full flex items-center justify-center text-[11px] font-bold"
            style={{
              background: status === 'correct' ? '#dcfce7' : status === 'wrong' ? '#fee2e2' : '#f3f4f6',
              color: status === 'correct' ? '#16a34a' : status === 'wrong' ? '#dc2626' : '#6b7280',
            }}>
            {index + 1}
          </span>

          <div className="flex-1">
            <div className="flex flex-wrap items-center gap-1.5 text-[15px] text-gray-700 leading-relaxed">
              {exercise.prefix && <span>{exercise.prefix}</span>}
              <InlineInput id={exercise.id} value={value} status={status} onChange={onChange} />
              {exercise.suffix && <span>{exercise.suffix}</span>}
            </div>

            {status === 'wrong' && (
              <div className="mt-2 flex items-center gap-2">
                <span className="text-[12px] text-gray-400">Correct answer:</span>
                <span className="text-[13px] font-semibold text-green-700 bg-green-50 px-2 py-0.5 rounded-md border border-green-100">
                  {exercise.answer}
                </span>
              </div>
            )}

            {exercise.hint && (
              <HintToggle hint={exercise.hint} visible={hintVisible} onShow={() => onShowHint(exercise.id)} />
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
