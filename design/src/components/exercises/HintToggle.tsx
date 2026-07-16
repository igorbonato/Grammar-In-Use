type Props = {
  hint: string
  visible: boolean
  onShow: () => void
}

export default function HintToggle({ hint, visible, onShow }: Props) {
  return (
    <div className="mt-2">
      {!visible ? (
        <button
          onClick={onShow}
          className="text-[11px] text-cambridge-500 hover:text-cambridge-700 font-medium transition-colors"
        >
          Show hint
        </button>
      ) : (
        <div className="inline-flex items-center gap-1.5 text-[12px] text-cambridge-600 bg-cambridge-50 px-2.5 py-1 rounded-full border border-cambridge-100">
          <svg width="11" height="11" viewBox="0 0 11 11" fill="none">
            <circle cx="5.5" cy="5.5" r="5" stroke="#4a8df7" strokeWidth="1.2" />
            <path d="M5.5 4v3.5M5.5 2.5v.5" stroke="#4a8df7" strokeWidth="1.2" strokeLinecap="round" />
          </svg>
          {hint}
        </div>
      )}
    </div>
  )
}
