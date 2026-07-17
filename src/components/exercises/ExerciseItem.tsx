import type { ExerciseSentence } from '../../types/grammar'
import { parseTemplate } from '../../lib/exerciseTemplate'
import { getBlankStatus, isBlankCorrect, type BlankStatus } from '../../lib/exerciseGrading'
import InlineInput from './InlineInput'
import HintToggle from './HintToggle'

type Props = {
  sentence: ExerciseSentence
  index: number
  answers: Record<string, string>
  checked: boolean
  hintVisible: boolean
  onChangeBlank: (blankId: string, value: string) => void
  onShowHint: () => void
}

function worstStatus(statuses: BlankStatus[]): BlankStatus {
  if (statuses.includes('wrong')) return 'wrong'
  if (statuses.includes('empty')) return 'empty'
  if (statuses.length > 0 && statuses.every(s => s === 'correct')) return 'correct'
  return 'idle'
}

export default function ExerciseItem({ sentence, index, answers, checked, hintVisible, onChangeBlank, onShowHint }: Props) {
  const segments = parseTemplate(sentence.template)
  const blankByIndex = new Map(sentence.blanks.map(blank => [blank.blankIndex, blank]))
  const statuses = sentence.blanks.map(blank => getBlankStatus(blank, answers[blank.id] ?? '', checked))
  const status = worstStatus(statuses)
  const wrongBlanks = checked ? sentence.blanks.filter(blank => !isBlankCorrect(blank, answers[blank.id] ?? '')) : []

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
              {segments.map((segment, i) => {
                if (segment.type === 'text') {
                  return <span key={i}>{segment.value}</span>
                }
                const blank = blankByIndex.get(segment.blankIndex)
                if (!blank) return null
                return (
                  <InlineInput
                    key={blank.id}
                    id={blank.id}
                    value={answers[blank.id] ?? ''}
                    status={getBlankStatus(blank, answers[blank.id] ?? '', checked)}
                    label={sentence.blanks.length > 1
                      ? `Answer ${index + 1}.${blank.blankIndex + 1}`
                      : `Answer ${index + 1}`}
                    onChange={onChangeBlank}
                  />
                )
              })}
            </div>

            {wrongBlanks.length > 0 && (
              <div className="mt-2 flex items-center gap-2">
                <span className="text-[12px] text-gray-400">Correct answer:</span>
                <span className="text-[13px] font-semibold text-green-700 bg-green-50 px-2 py-0.5 rounded-md border border-green-100">
                  {sentence.blanks.map(blank => blank.correctAnswer).join(' / ')}
                </span>
              </div>
            )}

            {sentence.hint && (
              <HintToggle hint={sentence.hint} visible={hintVisible} onShow={onShowHint} />
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
