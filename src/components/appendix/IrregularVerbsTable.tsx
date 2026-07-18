import { useState } from 'react'
import type { IrregularVerb } from '../../types/grammar'

export default function IrregularVerbsTable({ verbs }: { verbs: IrregularVerb[] }) {
  const [query, setQuery] = useState('')

  const normalized = query.trim().toLowerCase()
  const filtered = normalized
    ? verbs.filter(v =>
        v.infinitive.toLowerCase().includes(normalized) ||
        v.pastSimple.toLowerCase().includes(normalized) ||
        v.pastParticiple.toLowerCase().includes(normalized),
      )
    : verbs

  return (
    <div>
      <input
        type="text"
        value={query}
        onChange={e => setQuery(e.target.value)}
        placeholder={`Search ${verbs.length} verbs…`}
        className="w-full mb-3 px-3 py-2 rounded-lg border border-gray-200 text-[14px] outline-none transition-all focus:border-blue-400"
        style={{ boxShadow: '0 0 0 1px rgba(74, 141, 247, 0.1)' }}
      />

      <div className="overflow-x-auto rounded-xl border border-gray-200 max-h-[420px] overflow-y-auto">
        <table className="w-full text-[13px] text-left">
          <thead className="sticky top-0">
            <tr className="bg-gray-50 border-b border-gray-200">
              <th className="px-4 py-2.5 font-semibold text-gray-600">Infinitive</th>
              <th className="px-4 py-2.5 font-semibold text-gray-600">Past simple</th>
              <th className="px-4 py-2.5 font-semibold text-gray-600">Past participle</th>
            </tr>
          </thead>
          <tbody>
            {filtered.map((v, i) => (
              <tr key={v.id} className={i % 2 === 0 ? 'bg-white' : 'bg-gray-50/50'}>
                <td className="px-4 py-2 font-medium text-gray-800">{v.infinitive}</td>
                <td className="px-4 py-2 text-gray-700">{v.pastSimple}</td>
                <td className="px-4 py-2 text-gray-700">
                  {v.pastParticiple}
                  {v.note && <span className="ml-2 text-[11px] text-gray-400">({v.note})</span>}
                </td>
              </tr>
            ))}
            {filtered.length === 0 && (
              <tr>
                <td colSpan={3} className="px-4 py-6 text-center text-gray-400">
                  No verbs match "{query}".
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}
