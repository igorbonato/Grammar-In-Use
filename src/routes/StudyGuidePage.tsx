import { useState } from 'react'
import { useStudyGuide } from '../hooks/useStudyGuide'
import { modules } from '../data/modules'
import StudyGuideGroupSection from '../components/study-guide/StudyGuideGroupSection'

export default function StudyGuidePage() {
  const { data: groups, isLoading } = useStudyGuide()
  const [expanded, setExpanded] = useState<Set<string>>(new Set([modules[0].id]))

  const toggleGroup = (moduleId: string) => {
    setExpanded(prev => {
      const next = new Set(prev)
      if (next.has(moduleId)) next.delete(moduleId)
      else next.add(moduleId)
      return next
    })
  }

  const jumpToGroup = (moduleId: string) => {
    setExpanded(prev => new Set(prev).add(moduleId))
    requestAnimationFrame(() => {
      document.getElementById(`group-${moduleId}`)?.scrollIntoView({ behavior: 'smooth', block: 'start' })
    })
  }

  if (isLoading) {
    return (
      <div className="flex-1 flex items-center justify-center bg-[#f8faff] text-gray-400 text-sm">
        Loading study guide…
      </div>
    )
  }

  if (!groups || groups.length === 0) {
    return (
      <div className="flex-1 flex flex-col items-center justify-center gap-1 bg-[#f8faff] text-gray-400 text-sm">
        <span>The study guide is coming soon.</span>
      </div>
    )
  }

  const totalQuestions = groups.reduce((sum, g) => sum + g.questions.length, 0)

  return (
    <div className="flex-1 flex flex-col overflow-hidden bg-[#f8faff]">
      {/* Header */}
      <div className="flex-shrink-0 px-7 py-5 bg-white border-b border-gray-200">
        <div className="flex items-center gap-2 mb-0.5">
          <span className="text-gray-400 text-xs font-medium tracking-wider uppercase">Assessment</span>
        </div>
        <h2 className="text-gray-900 font-bold text-xl mb-1">Study Guide</h2>
        <p className="text-[13px] text-gray-500">
          {totalQuestions} questions across {groups.length} topics — some questions have more than one correct answer.
          Get one wrong and we'll point you to the unit to study.
        </p>
      </div>

      {/* Quick nav */}
      <div className="flex-shrink-0 px-7 py-3 bg-white border-b border-gray-100 overflow-x-auto">
        <div className="flex items-center gap-2 w-max">
          {groups.map((group, i) => (
            <button
              key={group.moduleId}
              onClick={() => jumpToGroup(group.moduleId)}
              className="flex-shrink-0 px-3 py-1.5 rounded-full text-[12px] font-medium border border-gray-200 text-gray-600 hover:border-blue-300 hover:text-blue-700 hover:bg-blue-50 transition-colors"
            >
              {i + 1}. {group.moduleTitle}
            </button>
          ))}
        </div>
      </div>

      {/* Groups */}
      <div className="flex-1 overflow-y-auto px-7 py-5 space-y-3">
        {groups.map(group => (
          <StudyGuideGroupSection
            key={group.moduleId}
            group={group}
            expanded={expanded.has(group.moduleId)}
            onToggleExpand={() => toggleGroup(group.moduleId)}
          />
        ))}
      </div>
    </div>
  )
}
