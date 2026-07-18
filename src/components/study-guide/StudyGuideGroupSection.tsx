import { useNavigate } from 'react-router-dom'
import type { StudyGuideGroup } from '../../types/grammar'
import { useStudyGuideStore } from '../../store/useStudyGuideStore'
import { computeGroupScore } from '../../lib/studyGuideGrading'
import ScoreBadge from '../exercises/ScoreBadge'
import StudyGuideQuestionCard from './StudyGuideQuestionCard'

type Props = {
  group: StudyGuideGroup
  expanded: boolean
  onToggleExpand: () => void
}

export default function StudyGuideGroupSection({ group, expanded, onToggleExpand }: Props) {
  const navigate = useNavigate()
  const selections = useStudyGuideStore(state => state.selections)
  const checked = useStudyGuideStore(state => !!state.checkedGroups[group.moduleId])
  const toggleOption = useStudyGuideStore(state => state.toggleOption)
  const checkGroup = useStudyGuideStore(state => state.checkGroup)
  const resetGroup = useStudyGuideStore(state => state.resetGroup)

  const questionIds = group.questions.map(q => q.id)
  const score = checked ? computeGroupScore(group.questions, selections) : null

  const handleNavigateToUnit = (moduleId: string, unitId: string) => {
    navigate(`/modulo/${moduleId}/${unitId}`)
  }

  return (
    <section id={`group-${group.moduleId}`} className="bg-white rounded-2xl border border-gray-200 overflow-hidden scroll-mt-24">
      <button
        onClick={onToggleExpand}
        aria-expanded={expanded}
        className="w-full flex items-center justify-between gap-3 px-6 py-4 hover:bg-gray-50 transition-colors"
      >
        <div className="flex items-center gap-3">
          <ChevronIcon expanded={expanded} />
          <h3 className="text-gray-900 font-bold text-[15px]">{group.moduleTitle}</h3>
          <span className="text-[11px] text-gray-400 font-mono">{group.questions.length} questions</span>
        </div>
        {score && <ScoreBadge correct={score.correct} total={score.total} />}
      </button>

      {expanded && (
        <div className="px-6 pb-6 space-y-3">
          {group.questions.map(question => (
            <StudyGuideQuestionCard
              key={question.id}
              question={question}
              selected={selections[question.id] ?? []}
              checked={checked}
              onToggleOption={letter => toggleOption(question.id, letter)}
              onNavigateToUnit={handleNavigateToUnit}
            />
          ))}

          <div className="flex items-center gap-3 pt-1">
            {checked && (
              <button
                onClick={() => resetGroup(group.moduleId, questionIds)}
                className="flex items-center gap-2 px-4 py-2.5 rounded-xl border border-gray-200 text-gray-600 text-sm font-medium hover:bg-gray-50 transition-all"
              >
                Try again
              </button>
            )}
            {!checked && (
              <button
                onClick={() => checkGroup(group.moduleId)}
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
