import type { TheoryExample } from '../../types/grammar'

export default function ExampleBox({ sentence, note }: TheoryExample) {
  return (
    <div className="flex items-start gap-3 rounded-lg px-4 py-3"
      style={{ background: 'linear-gradient(135deg, #eef4ff 0%, #f0f6ff 100%)', border: '1px solid #dce9ff' }}>
      <svg width="14" height="14" viewBox="0 0 14 14" fill="none" className="mt-0.5 flex-shrink-0">
        <circle cx="7" cy="7" r="6" fill="#4a8df7" fillOpacity="0.15" />
        <path d="M4.5 7L6.5 9L9.5 5" stroke="#2d6de6" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
      </svg>
      <div className="flex-1">
        <span className="text-[14px] text-gray-700 leading-snug italic">"{sentence}"</span>
      </div>
      <span className="flex-shrink-0 text-[10px] text-cambridge-500 font-medium px-2 py-0.5 rounded-full bg-cambridge-100/60 whitespace-nowrap">
        {note}
      </span>
    </div>
  )
}
