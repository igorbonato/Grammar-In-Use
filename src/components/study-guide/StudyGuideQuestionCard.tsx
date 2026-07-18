import type { StudyGuideQuestion } from '../../types/grammar'
import { parseTemplate } from '../../lib/exerciseTemplate'
import { correctLetters, isQuestionCorrect } from '../../lib/studyGuideGrading'
import { findUnitByNumber } from '../../lib/curriculum'
import { modules } from '../../data/modules'
import OptionPill, { type PillStatus } from './OptionPill'

type Props = {
  question: StudyGuideQuestion
  selected: string[]
  checked: boolean
  onToggleOption: (letter: string) => void
  onNavigateToUnit: (moduleId: string, unitId: string) => void
}

export default function StudyGuideQuestionCard({ question, selected, checked, onToggleOption, onNavigateToUnit }: Props) {
  const segments = parseTemplate(question.template)
  const correct = new Set(correctLetters(question))
  const correctAnswer = checked && !isQuestionCorrect(question, selected)

  const pillStatus = (letter: string): PillStatus => {
    if (!checked) return 'idle'
    const isSelected = selected.includes(letter)
    const isCorrect = correct.has(letter)
    if (isCorrect && isSelected) return 'correct'
    if (isCorrect && !isSelected) return 'missed'
    if (!isCorrect && isSelected) return 'wrong'
    return 'idle'
  }

  const studyUnits = question.studyUnits
    .map(n => ({ n, found: findUnitByNumber(modules, n) }))
    .filter((entry): entry is { n: number; found: NonNullable<ReturnType<typeof findUnitByNumber>> } => entry.found != null)

  return (
    <div
      className="bg-white rounded-xl border transition-all duration-200 px-5 py-4"
      style={{
        borderColor: !checked ? '#e5e7eb' : correctAnswer ? '#fca5a5' : '#86efac',
        boxShadow: !checked
          ? '0 1px 3px rgba(0,0,0,0.04)'
          : correctAnswer
          ? '0 0 0 1px #fca5a5, 0 2px 8px rgba(252, 165, 165, 0.15)'
          : '0 0 0 1px #86efac, 0 2px 8px rgba(134, 239, 172, 0.2)',
      }}
    >
      <div className="flex items-start gap-3">
        <span
          className="flex-shrink-0 mt-0.5 px-2 py-0.5 rounded-full text-[11px] font-bold font-mono"
          style={{
            background: !checked ? '#f3f4f6' : correctAnswer ? '#fee2e2' : '#dcfce7',
            color: !checked ? '#6b7280' : correctAnswer ? '#dc2626' : '#16a34a',
          }}
        >
          {question.questionNumber}
        </span>

        <div className="flex-1">
          <div className="text-[15px] text-gray-700 leading-relaxed mb-3">
            {segments.map((segment, i) =>
              segment.type === 'text' ? (
                <span key={i}>{segment.value}</span>
              ) : (
                <span key={i} className="inline-block mx-1 px-3 border-b-2 border-dashed border-blue-300 text-transparent select-none">
                  ____
                </span>
              ),
            )}
          </div>

          <div className="flex flex-wrap gap-2">
            {question.options.map(option => (
              <OptionPill
                key={option.id}
                letter={option.letter}
                text={option.text}
                selected={selected.includes(option.letter)}
                status={pillStatus(option.letter)}
                disabled={checked}
                onClick={() => onToggleOption(option.letter)}
              />
            ))}
          </div>

          {correctAnswer && studyUnits.length > 0 && (
            <div className="mt-3 flex items-center flex-wrap gap-2">
              <span className="text-[12px] text-gray-400">Study:</span>
              {studyUnits.map(({ n, found }) => (
                <button
                  key={n}
                  onClick={() => onNavigateToUnit(found.module.id, found.unit.id)}
                  className="text-[12px] font-semibold text-blue-700 bg-blue-50 px-2 py-0.5 rounded-md border border-blue-100 hover:bg-blue-100 transition-colors"
                >
                  {found.unit.shortTitle}
                </button>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
