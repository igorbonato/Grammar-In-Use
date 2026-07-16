import type { TheorySection } from '../../types/grammar'
import ExampleBox from './ExampleBox'

export default function GrammarRuleBox({ section }: { section: TheorySection }) {
  return (
    <div className="mb-8">
      <div className="flex items-start gap-3 mb-3">
        <span className="flex-shrink-0 w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold text-white"
          style={{ background: 'linear-gradient(135deg, #2d6de6, #4a8df7)' }}>
          {section.label}
        </span>
        <div>
          <h3 className="font-semibold text-gray-900 text-base leading-tight">{section.heading}</h3>
          <p className="text-gray-500 text-[14px] leading-relaxed mt-1">{section.explanation}</p>
        </div>
      </div>

      <div className="ml-10 space-y-2">
        {section.examples.map((ex, i) => (
          <ExampleBox key={i} sentence={ex.sentence} note={ex.note} />
        ))}
      </div>
    </div>
  )
}
