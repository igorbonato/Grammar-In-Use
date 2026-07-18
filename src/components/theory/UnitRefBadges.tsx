import { useNavigate } from 'react-router-dom'
import { findUnitByNumber } from '../../lib/curriculum'
import { modules } from '../../data/modules'

type Props = {
  unitRefs: number[]
  label?: string
  className?: string
}

export default function UnitRefBadges({ unitRefs, label = 'See:', className = '' }: Props) {
  const navigate = useNavigate()

  const found = unitRefs
    .map(n => ({ n, unit: findUnitByNumber(modules, n) }))
    .filter((entry): entry is { n: number; unit: NonNullable<ReturnType<typeof findUnitByNumber>> } => entry.unit != null)

  if (found.length === 0) return null

  return (
    <div className={`flex items-center flex-wrap gap-2 ${className}`}>
      <span className="text-[12px] text-gray-400">{label}</span>
      {found.map(({ n, unit }) => (
        <button
          key={n}
          onClick={() => navigate(`/modulo/${unit.module.id}/${unit.unit.id}`)}
          className="text-[12px] font-semibold text-blue-700 bg-blue-50 px-2 py-0.5 rounded-md border border-blue-100 hover:bg-blue-100 transition-colors"
        >
          {unit.unit.shortTitle}
        </button>
      ))}
    </div>
  )
}
