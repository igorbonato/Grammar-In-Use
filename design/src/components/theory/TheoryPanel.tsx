import type { Unit } from '../../types/grammar'
import { useUnitContent } from '../../hooks/useUnitContent'
import StructureTable from './StructureTable'
import GrammarRuleBox from './GrammarRuleBox'
import SpellingNotes from './SpellingNotes'
import IllustrationPlaceholder from './IllustrationPlaceholder'

type Props = {
  unit: Unit
  moduleTitle: string
}

export default function TheoryPanel({ unit, moduleTitle }: Props) {
  const content = useUnitContent(unit.id)

  return (
    <div className="flex-1 flex flex-col overflow-hidden border-r border-gray-200/80">
      {/* Header */}
      <div className="flex-shrink-0 px-8 py-5"
        style={{ background: 'linear-gradient(135deg, #1e50c4 0%, #2d6de6 60%, #4a8df7 100%)' }}>
        <div className="flex items-center gap-2 mb-1">
          <span className="text-blue-200/70 text-xs font-medium tracking-wider uppercase">{moduleTitle}</span>
          <span className="text-blue-200/40 text-xs">›</span>
          <span className="text-blue-200/70 text-xs font-medium">{unit.shortTitle}</span>
        </div>
        <h1 className="text-white font-bold text-2xl leading-tight">
          {unit.shortTitle}: {content.title}
        </h1>
        <p className="text-blue-200/80 text-base mt-1 font-medium">({content.subtitle})</p>
      </div>

      {/* Content */}
      <div className="flex-1 overflow-y-auto bg-white">
        <div className="px-8 py-6 max-w-[640px]">
          <p className="text-gray-600 text-[15px] leading-relaxed mb-6">{content.intro}</p>

          <StructureTable structure={content.structure} />

          {content.sections.map(section => (
            <GrammarRuleBox key={section.id} section={section} />
          ))}

          <SpellingNotes notes={content.spellingNotes} />

          <IllustrationPlaceholder />
        </div>
      </div>
    </div>
  )
}
