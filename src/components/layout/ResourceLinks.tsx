import { useLocation, useNavigate } from 'react-router-dom'

const resources = [
  { label: 'Appendix', icon: '📎', path: '/apendice' },
  { label: 'Additional exercises', icon: '✏️', path: null },
  { label: 'Index', icon: '🗂', path: null },
]

export default function ResourceLinks() {
  const navigate = useNavigate()
  const location = useLocation()

  return (
    <div>
      <div className="px-2 mb-2 text-[10px] font-semibold uppercase tracking-widest text-blue-300/50">
        Resources
      </div>
      <div className="space-y-0.5">
        {resources.map(item => {
          const active = item.path != null && location.pathname === item.path
          return (
            <button
              key={item.label}
              aria-label={item.label}
              aria-current={active ? 'page' : undefined}
              disabled={item.path == null}
              onClick={() => item.path && navigate(item.path)}
              className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-[13px] transition-all disabled:cursor-default disabled:opacity-50"
              style={{
                color: active ? '#7db0ff' : 'rgba(255,255,255,0.45)',
                background: active ? 'rgba(74, 141, 247, 0.15)' : 'transparent',
              }}
            >
              <span aria-hidden="true">{item.icon}</span>
              {item.label}
            </button>
          )
        })}
      </div>
    </div>
  )
}
