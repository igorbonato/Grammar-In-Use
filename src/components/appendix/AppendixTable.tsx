import { useNavigate } from 'react-router-dom'
import type { AppendixTableRow } from '../../types/grammar'
import { findUnitByNumber } from '../../lib/curriculum'
import { modules } from '../../data/modules'

type Props = {
  columnHeaders: string[]
  rows: AppendixTableRow[]
}

export default function AppendixTable({ columnHeaders, rows }: Props) {
  const navigate = useNavigate()
  const hasColC = rows.some(row => row.colC)
  const hasUnitRefs = rows.some(row => row.unitRefs.length > 0)

  return (
    <div className="overflow-x-auto rounded-xl border border-gray-200">
      <table className="w-full text-[13px] text-left">
        <thead>
          <tr className="bg-gray-50 border-b border-gray-200">
            {columnHeaders.map((header, i) => (
              <th key={i} className="px-4 py-2.5 font-semibold text-gray-600 whitespace-nowrap">
                {header}
              </th>
            ))}
            {hasUnitRefs && <th className="px-4 py-2.5 font-semibold text-gray-600 whitespace-nowrap">Units</th>}
          </tr>
        </thead>
        <tbody>
          {rows.map((row, i) => {
            const found = row.unitRefs
              .map(n => findUnitByNumber(modules, n))
              .filter((u): u is NonNullable<typeof u> => u != null)

            return (
              <tr key={row.id} className={i % 2 === 0 ? 'bg-white' : 'bg-gray-50/50'}>
                <td className="px-4 py-3 align-top text-gray-700">{row.colA}</td>
                <td className="px-4 py-3 align-top text-gray-700">{row.colB}</td>
                {hasColC && <td className="px-4 py-3 align-top text-gray-700">{row.colC}</td>}
                {hasUnitRefs && (
                  <td className="px-4 py-3 align-top">
                    <div className="flex flex-wrap gap-1.5">
                      {found.map(u => (
                        <button
                          key={u.unit.id}
                          onClick={() => navigate(`/modulo/${u.module.id}/${u.unit.id}`)}
                          className="text-[11px] font-semibold text-blue-700 bg-blue-50 px-1.5 py-0.5 rounded border border-blue-100 hover:bg-blue-100 transition-colors whitespace-nowrap"
                        >
                          {u.unit.shortTitle}
                        </button>
                      ))}
                    </div>
                  </td>
                )}
              </tr>
            )
          })}
        </tbody>
      </table>
    </div>
  )
}
