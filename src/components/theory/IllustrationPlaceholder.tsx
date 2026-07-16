export default function IllustrationPlaceholder() {
  return (
    <div className="rounded-xl border-2 border-dashed border-gray-200 p-6 text-center mb-6">
      <div className="w-16 h-16 mx-auto mb-3 rounded-full bg-gray-100 flex items-center justify-center">
        <svg width="28" height="28" viewBox="0 0 28 28" fill="none">
          <rect x="3" y="5" width="22" height="18" rx="2" stroke="#9ca3af" strokeWidth="1.5" />
          <circle cx="10" cy="11" r="2.5" stroke="#9ca3af" strokeWidth="1.5" />
          <path d="M3 19l5.5-4 4 3 4-4.5 8 5.5" stroke="#9ca3af" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      </div>
      <p className="text-gray-400 text-sm">Contextual illustration</p>
      <p className="text-gray-300 text-xs mt-1">Visual aid for this grammar point</p>
    </div>
  )
}
