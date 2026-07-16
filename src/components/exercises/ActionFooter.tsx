type Props = {
  checked: boolean
  onCheck: () => void
  onReset: () => void
}

export default function ActionFooter({ checked, onCheck, onReset }: Props) {
  return (
    <div className="absolute bottom-0 right-0 left-0 flex-shrink-0 px-7 py-4 border-t border-gray-200 bg-white/95 backdrop-blur-sm"
      style={{ boxShadow: '0 -4px 24px rgba(0,0,0,0.06)' }}>
      <div className="flex items-center gap-3 max-w-full">
        {checked && (
          <button
            onClick={onReset}
            className="flex items-center gap-2 px-4 py-2.5 rounded-xl border border-gray-200 text-gray-600 text-sm font-medium hover:bg-gray-50 transition-all"
          >
            <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
              <path d="M12 7A5 5 0 1 1 7 2" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
              <path d="M7 2l2-2v4L7 2z" fill="currentColor" />
            </svg>
            Try again
          </button>
        )}

        <button
          onClick={onCheck}
          className="flex-1 flex items-center justify-center gap-2.5 py-3 rounded-xl text-white text-sm font-semibold transition-all active:scale-[0.98]"
          style={{
            background: 'linear-gradient(135deg, #1e50c4 0%, #2d6de6 60%, #4a8df7 100%)',
            boxShadow: '0 4px 16px rgba(45, 109, 230, 0.35)',
          }}
        >
          <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
            <path d="M2 8l4 4 8-8" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
          Check Answers
        </button>

        <button className="flex items-center gap-2 px-4 py-2.5 rounded-xl border border-gray-200 text-gray-600 text-sm font-medium hover:bg-gray-50 transition-all">
          Next unit
          <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
            <path d="M5 3l4 4-4 4" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
          </svg>
        </button>
      </div>
    </div>
  )
}
