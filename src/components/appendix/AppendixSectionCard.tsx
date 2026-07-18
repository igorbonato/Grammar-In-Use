import type { AppendixSection } from '../../types/grammar'
import AppendixSubsectionBlock from './AppendixSubsectionBlock'

type Props = {
  section: AppendixSection
  expanded: boolean
  onToggleExpand: () => void
}

export default function AppendixSectionCard({ section, expanded, onToggleExpand }: Props) {
  const isMatrix = section.number === 2

  return (
    <section id={`appendix-${section.slug}`} className="bg-white rounded-2xl border border-gray-200 overflow-hidden scroll-mt-24">
      <button
        onClick={onToggleExpand}
        aria-expanded={expanded}
        className="w-full flex items-center justify-between gap-3 px-6 py-4 hover:bg-gray-50 transition-colors"
      >
        <div className="flex items-center gap-3">
          <ChevronIcon expanded={expanded} />
          <span className="flex-shrink-0 w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold text-white"
            style={{ background: 'linear-gradient(135deg, #2d6de6, #4a8df7)' }}>
            {section.number}
          </span>
          <h3 className="text-gray-900 font-bold text-[15px]">{section.title}</h3>
        </div>
      </button>

      {expanded && (
        <div className="px-6 pb-6">
          {isMatrix ? (
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-x-8">
              {section.subsections.map(subsection => (
                <AppendixSubsectionBlock key={subsection.id} subsection={subsection} />
              ))}
            </div>
          ) : (
            section.subsections.map(subsection => (
              <AppendixSubsectionBlock key={subsection.id} subsection={subsection} />
            ))
          )}
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
