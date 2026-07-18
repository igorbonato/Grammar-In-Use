import { useLocation, useNavigate } from 'react-router-dom'

export default function ResourceLinks() {
  const navigate = useNavigate()
  const location = useLocation()
  const active = location.pathname === '/apendice'

  return (
    <div>
      <div className="px-2 mb-2 text-[10px] font-semibold uppercase tracking-widest text-blue-300/50">
        Resources
      </div>
      <div className="space-y-0.5">
        <button
          aria-label="Appendix"
          aria-current={active ? 'page' : undefined}
          onClick={() => navigate('/apendice')}
          className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-[13px] transition-all"
          style={{
            color: active ? '#7db0ff' : 'rgba(255,255,255,0.45)',
            background: active ? 'rgba(74, 141, 247, 0.15)' : 'transparent',
          }}
        >
          <span aria-hidden="true">📎</span>
          Appendix
        </button>
      </div>
    </div>
  )
}
