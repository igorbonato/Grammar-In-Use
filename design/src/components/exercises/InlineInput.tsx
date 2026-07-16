import type { ExerciseStatus } from '../../hooks/useExerciseValidation'

type Props = {
  id: number
  value: string
  status: ExerciseStatus
  onChange: (id: number, value: string) => void
}

export default function InlineInput({ id, value, status, onChange }: Props) {
  return (
    <span className="relative inline-flex items-center">
      <input
        type="text"
        value={value}
        onChange={e => onChange(id, e.target.value)}
        placeholder="type here..."
        aria-label={`Answer for exercise ${id}`}
        aria-invalid={status === 'wrong'}
        className="px-2.5 py-1 rounded-lg border text-[14px] font-medium transition-all"
        style={{
          minWidth: '140px',
          width: `${Math.max(140, (value.length || 10) * 9)}px`,
          borderColor: status === 'correct' ? '#4ade80'
            : status === 'wrong' ? '#f87171'
            : '#c7d8ff',
          background: status === 'correct' ? '#f0fdf4'
            : status === 'wrong' ? '#fff5f5'
            : '#f0f5ff',
          color: status === 'correct' ? '#15803d'
            : status === 'wrong' ? '#dc2626'
            : '#1e3a7b',
          outline: 'none',
          boxShadow: status === 'idle' || status === 'empty'
            ? '0 0 0 1px rgba(74, 141, 247, 0.15)'
            : 'none',
        }}
        onFocus={e => {
          if (status === 'idle' || status === 'empty') {
            e.currentTarget.style.borderColor = '#4a8df7'
            e.currentTarget.style.boxShadow = '0 0 0 3px rgba(74, 141, 247, 0.15)'
          }
        }}
        onBlur={e => {
          if (status === 'idle' || status === 'empty') {
            e.currentTarget.style.borderColor = '#c7d8ff'
            e.currentTarget.style.boxShadow = '0 0 0 1px rgba(74, 141, 247, 0.15)'
          }
        }}
      />
      {status === 'correct' && (
        <span className="absolute -right-5 top-1/2 -translate-y-1/2 text-green-500">
          <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
            <path d="M2.5 7L5.5 10L11.5 4" stroke="#22c55e" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
        </span>
      )}
      {status === 'wrong' && (
        <span className="absolute -right-5 top-1/2 -translate-y-1/2 text-red-400">
          <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
            <path d="M3 3L11 11M11 3L3 11" stroke="#f87171" strokeWidth="2" strokeLinecap="round" />
          </svg>
        </span>
      )}
    </span>
  )
}
