export type PillStatus = 'idle' | 'correct' | 'wrong' | 'missed'

type Props = {
  letter: string
  text: string
  selected: boolean
  status: PillStatus
  disabled: boolean
  onClick: () => void
}

export default function OptionPill({ letter, text, selected, status, disabled, onClick }: Props) {
  const palette = {
    idle: {
      background: selected ? '#e8f0ff' : '#ffffff',
      borderColor: selected ? '#4a8df7' : '#d8e2f5',
      color: selected ? '#1e3a7b' : '#4b5563',
    },
    correct: {
      background: '#f0fdf4',
      borderColor: '#4ade80',
      color: '#15803d',
    },
    wrong: {
      background: '#fff5f5',
      borderColor: '#f87171',
      color: '#dc2626',
    },
    missed: {
      background: '#ffffff',
      borderColor: '#4ade80',
      color: '#15803d',
    },
  }[status]

  return (
    <button
      type="button"
      onClick={onClick}
      disabled={disabled}
      aria-pressed={selected}
      className="flex items-center gap-2 px-3 py-1.5 rounded-full border text-[13px] font-medium transition-all disabled:cursor-default"
      style={{
        background: palette.background,
        borderColor: palette.borderColor,
        color: palette.color,
        borderStyle: status === 'missed' ? 'dashed' : 'solid',
      }}
    >
      <span
        className="flex-shrink-0 w-5 h-5 rounded-full flex items-center justify-center text-[10px] font-bold"
        style={{
          background: selected || status === 'correct' || status === 'missed' ? palette.borderColor : '#f3f4f6',
          color: selected || status !== 'idle' ? '#ffffff' : '#6b7280',
        }}
      >
        {letter}
      </span>
      {text}
      {status === 'correct' && <CheckIcon />}
      {status === 'wrong' && <CrossIcon />}
    </button>
  )
}

function CheckIcon() {
  return (
    <svg width="12" height="12" viewBox="0 0 14 14" fill="none">
      <path d="M2.5 7L5.5 10L11.5 4" stroke="#22c55e" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  )
}

function CrossIcon() {
  return (
    <svg width="12" height="12" viewBox="0 0 14 14" fill="none">
      <path d="M3 3L11 11M11 3L3 11" stroke="#f87171" strokeWidth="2" strokeLinecap="round" />
    </svg>
  )
}
