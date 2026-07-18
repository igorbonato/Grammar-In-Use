import type { AppendixSubsection } from '../../types/grammar'
import GrammarRuleBox from '../theory/GrammarRuleBox'
import ExampleBox from '../theory/ExampleBox'
import AppendixTable from './AppendixTable'
import IrregularVerbsTable from './IrregularVerbsTable'

export default function AppendixSubsectionBlock({ subsection }: { subsection: AppendixSubsection }) {
  if (subsection.irregularVerbs.length > 0) {
    return (
      <div className="mb-8">
        <h3 className="font-semibold text-gray-900 text-base leading-tight mb-3">{subsection.heading}</h3>
        <IrregularVerbsTable verbs={subsection.irregularVerbs} />
      </div>
    )
  }

  if (subsection.columnHeaders) {
    return (
      <div className="mb-8">
        <div className="mb-3">
          <h3 className="font-semibold text-gray-900 text-base leading-tight">{subsection.heading}</h3>
          {subsection.explanation && (
            <p className="text-gray-500 text-[14px] leading-relaxed mt-1">{subsection.explanation}</p>
          )}
        </div>
        <AppendixTable columnHeaders={subsection.columnHeaders} rows={subsection.tableRows} />
        {subsection.examples.length > 0 && (
          <div className="mt-3 space-y-2">
            {subsection.examples.map((ex, i) => (
              <ExampleBox key={i} sentence={ex.sentence} note={ex.note} />
            ))}
          </div>
        )}
      </div>
    )
  }

  return (
    <GrammarRuleBox
      section={{
        id: subsection.id,
        label: subsection.label ?? '',
        heading: subsection.heading,
        explanation: subsection.explanation ?? '',
        examples: subsection.examples,
      }}
      unitRefs={subsection.unitRefs}
    />
  )
}
