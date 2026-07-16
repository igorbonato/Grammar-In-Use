import type { TheoryStructure } from '../../types/grammar'

export default function StructureTable({ structure }: { structure: TheoryStructure }) {
  if (structure.positive.length === 0) return null

  return (
    <div className="mb-7 rounded-xl overflow-hidden border border-cambridge-100"
      style={{ boxShadow: '0 1px 4px rgba(45, 109, 230, 0.08)' }}>
      <div className="px-4 py-2.5 text-[11px] font-semibold uppercase tracking-widest text-cambridge-700 bg-cambridge-50">
        Structure
      </div>
      <table className="w-full text-sm">
        <thead>
          <tr className="border-b border-cambridge-100 bg-cambridge-50/50">
            <th className="text-left px-4 py-2 text-[11px] uppercase tracking-wider font-semibold text-gray-400">Subject</th>
            <th className="text-left px-4 py-2 text-[11px] uppercase tracking-wider font-semibold text-gray-400">Be</th>
            <th className="text-left px-4 py-2 text-[11px] uppercase tracking-wider font-semibold text-gray-400">Verb + -ing</th>
          </tr>
        </thead>
        <tbody>
          {structure.positive.map((row, i) => (
            <tr key={i} className="border-b border-gray-100 last:border-0">
              <td className="px-4 py-2.5 text-gray-700 font-medium">{row.pronoun}</td>
              <td className="px-4 py-2.5">
                <span className="font-bold text-cambridge-600">{row.form}</span>
              </td>
              <td className="px-4 py-2.5 text-gray-500 font-mono text-[13px]">{row.example}</td>
            </tr>
          ))}
        </tbody>
      </table>
      <div className="px-4 py-2.5 text-[13px] text-gray-500 border-t border-cambridge-100 bg-gray-50/50">
        <span className="font-medium text-gray-600">Negative: </span>{structure.negative}
      </div>
      <div className="px-4 py-2.5 text-[13px] text-gray-500 border-t border-cambridge-100 bg-gray-50/50">
        <span className="font-medium text-gray-600">Question: </span>{structure.question}
      </div>
    </div>
  )
}
