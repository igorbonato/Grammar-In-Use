import type { SpellingNote } from '../../types/grammar'

export default function SpellingNotes({ notes }: { notes: SpellingNote[] }) {
  if (notes.length === 0) return null

  return (
    <div className="mt-2 mb-8">
      <div className="flex items-center gap-2 mb-3">
        <span className="flex-shrink-0 w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold text-white"
          style={{ background: 'linear-gradient(135deg, #f59e0b, #f97316)' }}>
          📝
        </span>
        <h3 className="font-semibold text-gray-900 text-base">Spelling: -ing forms</h3>
      </div>
      <div className="ml-10 rounded-xl overflow-hidden border border-amber-100"
        style={{ boxShadow: '0 1px 4px rgba(245, 158, 11, 0.08)' }}>
        {notes.map((note, i) => (
          <div key={i} className="flex items-start gap-4 px-4 py-3 border-b border-amber-100/70 last:border-0"
            style={{ background: i % 2 === 0 ? '#fffbf0' : '#fffdf5' }}>
            <span className="text-[13px] font-medium text-amber-800 w-40 flex-shrink-0">{note.rule}</span>
            <span className="text-[13px] text-amber-700 font-mono">{note.example}</span>
          </div>
        ))}
      </div>
    </div>
  )
}
