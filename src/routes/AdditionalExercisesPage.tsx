import { useState } from 'react'
import { useAdditionalExercises } from '../hooks/useAdditionalExercises'
import AdditionalExerciseGroupSection from '../components/additional-exercises/AdditionalExerciseGroupSection'

export default function AdditionalExercisesPage() {
  const { data: groups, isLoading } = useAdditionalExercises()
  const [expanded, setExpanded] = useState<Set<string>>(new Set(groups?.[0] ? [groups[0].sourceRef] : []))

  const toggleGroup = (sourceRef: string) => {
    setExpanded(prev => {
      const next = new Set(prev)
      if (next.has(sourceRef)) next.delete(sourceRef)
      else next.add(sourceRef)
      return next
    })
  }

  const jumpToGroup = (sourceRef: string) => {
    setExpanded(prev => new Set(prev).add(sourceRef))
    requestAnimationFrame(() => {
      document.getElementById(`additional-${sourceRef}`)?.scrollIntoView({ behavior: 'smooth', block: 'start' })
    })
  }

  if (isLoading) {
    return (
      <div className="flex-1 flex items-center justify-center bg-[#f8faff] text-gray-400 text-sm">
        Loading additional exercises…
      </div>
    )
  }

  if (!groups || groups.length === 0) {
    return (
      <div className="flex-1 flex flex-col items-center justify-center gap-1 bg-[#f8faff] text-gray-400 text-sm">
        <span>Additional exercises are coming soon.</span>
      </div>
    )
  }

  const totalExercises = groups.reduce((sum, g) => sum + g.exercises.length, 0)

  return (
    <div className="flex-1 flex flex-col overflow-hidden bg-[#f8faff]">
      {/* Header */}
      <div className="flex-shrink-0 px-7 py-5 bg-white border-b border-gray-200">
        <div className="flex items-center gap-2 mb-0.5">
          <span className="text-gray-400 text-xs font-medium tracking-wider uppercase">Assessment</span>
        </div>
        <h2 className="text-gray-900 font-bold text-xl mb-1">Additional Exercises</h2>
        <p className="text-[13px] text-gray-500">
          {totalExercises} extra exercises across {groups.length} topics, grouped the way the book groups them.
        </p>
      </div>

      {/* Quick nav */}
      <div className="flex-shrink-0 px-7 py-3 bg-white border-b border-gray-100 overflow-x-auto">
        <div className="flex items-center gap-2 w-max">
          {groups.map((group, i) => (
            <button
              key={group.sourceRef}
              onClick={() => jumpToGroup(group.sourceRef)}
              className="flex-shrink-0 px-3 py-1.5 rounded-full text-[12px] font-medium border border-gray-200 text-gray-600 hover:border-blue-300 hover:text-blue-700 hover:bg-blue-50 transition-colors"
            >
              {i + 1}. {group.sourceRef}
            </button>
          ))}
        </div>
      </div>

      {/* Groups */}
      <div className="flex-1 overflow-y-auto px-7 py-5 space-y-3">
        {groups.map(group => (
          <AdditionalExerciseGroupSection
            key={group.sourceRef}
            group={group}
            expanded={expanded.has(group.sourceRef)}
            onToggleExpand={() => toggleGroup(group.sourceRef)}
          />
        ))}
      </div>
    </div>
  )
}
