const resources = [
  { label: 'Appendix', icon: '📎' },
  { label: 'Additional exercises', icon: '✏️' },
  { label: 'Index', icon: '🗂' },
]

export default function ResourceLinks() {
  return (
    <div>
      <div className="px-2 mb-2 text-[10px] font-semibold uppercase tracking-widest text-blue-300/50">
        Resources
      </div>
      <div className="space-y-0.5">
        {resources.map(item => (
          <button
            key={item.label}
            aria-label={item.label}
            className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-[13px] text-white/45 hover:text-white/75 hover:bg-white/5 transition-all"
          >
            <span aria-hidden="true">{item.icon}</span>
            {item.label}
          </button>
        ))}
      </div>
    </div>
  )
}
