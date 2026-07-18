import { useState } from 'react'
import { useAppendix } from '../hooks/useAppendix'
import AppendixSectionCard from '../components/appendix/AppendixSectionCard'

export default function AppendixPage() {
  const { data: sections, isLoading } = useAppendix()
  const [expanded, setExpanded] = useState<Set<string>>(new Set(['regular-and-irregular-verbs']))

  const toggleSection = (slug: string) => {
    setExpanded(prev => {
      const next = new Set(prev)
      if (next.has(slug)) next.delete(slug)
      else next.add(slug)
      return next
    })
  }

  const jumpToSection = (slug: string) => {
    setExpanded(prev => new Set(prev).add(slug))
    requestAnimationFrame(() => {
      document.getElementById(`appendix-${slug}`)?.scrollIntoView({ behavior: 'smooth', block: 'start' })
    })
  }

  if (isLoading) {
    return (
      <div className="flex-1 flex items-center justify-center bg-[#f8faff] text-gray-400 text-sm">
        Loading appendix…
      </div>
    )
  }

  if (!sections || sections.length === 0) {
    return (
      <div className="flex-1 flex flex-col items-center justify-center gap-1 bg-[#f8faff] text-gray-400 text-sm">
        <span>The appendix is coming soon.</span>
      </div>
    )
  }

  return (
    <div className="flex-1 flex flex-col overflow-hidden bg-[#f8faff]">
      {/* Header */}
      <div className="flex-shrink-0 px-7 py-5 bg-white border-b border-gray-200">
        <div className="flex items-center gap-2 mb-0.5">
          <span className="text-gray-400 text-xs font-medium tracking-wider uppercase">Resources</span>
        </div>
        <h2 className="text-gray-900 font-bold text-xl mb-1">Appendix</h2>
        <p className="text-[13px] text-gray-500">
          Reference material that summarizes grammar across units — irregular verbs, tense forms,
          modal verbs, short forms, spelling rules, and British/American differences.
        </p>
      </div>

      {/* Quick nav */}
      <div className="flex-shrink-0 px-7 py-3 bg-white border-b border-gray-100 overflow-x-auto">
        <div className="flex items-center gap-2 w-max">
          {sections.map(section => (
            <button
              key={section.slug}
              onClick={() => jumpToSection(section.slug)}
              className="flex-shrink-0 px-3 py-1.5 rounded-full text-[12px] font-medium border border-gray-200 text-gray-600 hover:border-blue-300 hover:text-blue-700 hover:bg-blue-50 transition-colors"
            >
              {section.number}. {section.title}
            </button>
          ))}
        </div>
      </div>

      {/* Sections */}
      <div className="flex-1 overflow-y-auto px-7 py-5 space-y-3">
        {sections.map(section => (
          <AppendixSectionCard
            key={section.slug}
            section={section}
            expanded={expanded.has(section.slug)}
            onToggleExpand={() => toggleSection(section.slug)}
          />
        ))}
      </div>
    </div>
  )
}
