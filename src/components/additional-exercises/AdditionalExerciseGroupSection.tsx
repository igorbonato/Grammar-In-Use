import type { AdditionalExerciseGroup } from '../../types/grammar'
import { useAdditionalExercisesStore } from '../../store/useAdditionalExercisesStore'
import { allBlanks, computeScore } from '../../lib/exerciseGrading'
import ScoreBadge from '../exercises/ScoreBadge'
import ExerciseItem from '../exercises/ExerciseItem'
import UnitRefBadges from '../theory/UnitRefBadges'

type Props = {
  group: AdditionalExerciseGroup
  expanded: boolean
  onToggleExpand: () => void
}

export default function AdditionalExerciseGroupSection({ group, expanded, onToggleExpand }: Props) {
  const answers = useAdditionalExercisesStore(state => state.answers)
  const showHints = useAdditionalExercisesStore(state => state.showHints)
  const checked = useAdditionalExercisesStore(state => !!state.checkedGroups[group.sourceRef])
  const setAnswer = useAdditionalExercisesStore(state => state.setAnswer)
  const showHint = useAdditionalExercisesStore(state => state.showHint)
  const checkGroup = useAdditionalExercisesStore(state => state.checkGroup)
  const resetGroup = useAdditionalExercisesStore(state => state.resetGroup)

  const allSentences = group.exercises.flatMap(ex => ex.sentences)
  const blanks = allBlanks(allSentences)
  const score = checked ? computeScore(allSentences, answers) : null

  const handleReset = () => {
    const blankIds = blanks.map(b => b.id)
    const sentenceIds = allSentences.map(s => s.id)
    resetGroup(group.sourceRef, blankIds, sentenceIds)
  }

  return (
    <section id={`additional-${group.sourceRef}`} className="bg-white rounded-2xl border border-gray-200 overflow-hidden scroll-mt-24">
      <button
        onClick={onToggleExpand}
        aria-expanded={expanded}
        className="w-full flex items-center justify-between gap-3 px-6 py-4 hover:bg-gray-50 transition-colors"
      >
        <div className="flex items-center gap-3">
          <ChevronIcon expanded={expanded} />
          <h3 className="text-gray-900 font-bold text-[15px]">{group.sourceRef}</h3>
          <span className="text-[11px] text-gray-400 font-mono">
            {group.exercises.length} {group.exercises.length === 1 ? 'exercise' : 'exercises'}
          </span>
        </div>
        {score && <ScoreBadge correct={score.correct} total={score.total} />}
      </button>

      {expanded && (
        <div className="px-6 pb-6 space-y-6">
          {group.exercises.map(exercise => (
            <div key={exercise.id}>
              <div className="flex items-center gap-2 mb-1">
                <span className="text-[10px] font-semibold uppercase tracking-widest text-gray-400">
                  {exercise.title}
                </span>
              </div>
              {exercise.instruction && (
                <p className="text-[13px] text-gray-500 mb-3">{exercise.instruction}</p>
              )}
              {exercise.unitRefs.length > 0 && (
                <UnitRefBadges unitRefs={exercise.unitRefs} label="Ver:" className="mb-3" />
              )}
              <div className="space-y-4">
                {exercise.sentences.map((sentence, idx) => (
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
            </div>
          ))}

          <div className="flex items-center gap-3 pt-1">
            {checked && (
              <button
                onClick={handleReset}
                className="flex items-center gap-2 px-4 py-2.5 rounded-xl border border-gray-200 text-gray-600 text-sm font-medium hover:bg-gray-50 transition-all"
              >
                Try again
              </button>
            )}
            {!checked && (
              <button
                onClick={() => checkGroup(group.sourceRef)}
                className="flex items-center justify-center gap-2.5 px-5 py-2.5 rounded-xl text-white text-sm font-semibold transition-all active:scale-[0.98]"
                style={{
                  background: 'linear-gradient(135deg, #1e50c4 0%, #2d6de6 60%, #4a8df7 100%)',
                  boxShadow: '0 4px 16px rgba(45, 109, 230, 0.35)',
                }}
              >
                Check answers
              </button>
            )}
          </div>
        </div>
      )}
    </section>
  )
}

function ChevronIcon({ expanded }: { expanded: boolean }) {
  return (
    <svg
      width="12" height="12" viewBox="0 0 12 12" fill="none"
      className="transition-transform flex-shrink-0"
      style={{ transform: expanded ? 'rotate(90deg)' : 'rotate(0deg)' }}
    >
      <path d="M4 2.5L7.5 6L4 9.5" stroke="#6b7280" strokeWidth="1.5" strokeLinecap="round" />
    </svg>
  )
}
