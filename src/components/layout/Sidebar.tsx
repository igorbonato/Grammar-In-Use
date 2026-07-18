import type { Module, Unit } from '../../types/grammar'
import { useAuthStore } from '../../store/useAuthStore'
import { useOverallProgress } from '../../hooks/useOverallProgress'
import SidebarAccordion from './SidebarAccordion'
import SidebarProgress from './SidebarProgress'
import ResourceLinks from './ResourceLinks'
import UserMenu from './UserMenu'

type Props = {
  modules: Module[]
  activeUnit: Unit | null
  onSelectUnit: (moduleId: string, unit: Unit) => void
  studyGuideActive: boolean
  onSelectStudyGuide: () => void
  open: boolean
  onToggle: () => void
}

export default function Sidebar({ modules, activeUnit, onSelectUnit, studyGuideActive, onSelectStudyGuide, open, onToggle }: Props) {
  const userId = useAuthStore(state => state.user?.id ?? null)
  const { percent, completedUnits, totalUnits } = useOverallProgress(userId)

  return (
    <>
      {/* Sidebar */}
      <aside
        className="flex flex-col flex-shrink-0 overflow-hidden transition-all duration-300"
        style={{
          width: open ? '272px' : '0px',
          background: 'linear-gradient(180deg, #1c2d4f 0%, #152240 100%)',
          borderRight: '1px solid rgba(255,255,255,0.06)',
        }}
      >
        <div className="flex flex-col h-full min-w-[272px]">
          {/* Logo */}
          <div className="flex items-center gap-3 px-5 py-5 border-b border-white/10">
            <div
              className="w-8 h-8 rounded-lg flex items-center justify-center flex-shrink-0"
              style={{ background: 'linear-gradient(135deg, #4a8df7 0%, #2d6de6 100%)' }}
            >
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <path d="M3 4h10M3 8h7M3 12h5" stroke="white" strokeWidth="1.8" strokeLinecap="round" />
              </svg>
            </div>
            <div>
              <div className="text-white font-semibold text-sm leading-tight">Grammar in Use</div>
              <div className="text-blue-300/60 text-[11px] font-medium tracking-wide uppercase mt-0.5">Interactive</div>
            </div>
          </div>

          <div className="flex-1 overflow-y-auto py-4 px-3">
            {/* Study Guide */}
            <div className="mb-5">
              <div className="px-2 mb-2 text-[10px] font-semibold uppercase tracking-widest text-blue-300/50">
                Assessment
              </div>
              <button
                onClick={onSelectStudyGuide}
                aria-current={studyGuideActive ? 'page' : undefined}
                className="w-full flex items-center gap-2.5 px-3 py-2.5 rounded-lg text-sm font-medium text-white/80 hover:text-white transition-all group"
                style={{
                  background: studyGuideActive ? 'rgba(74, 141, 247, 0.3)' : 'rgba(74, 141, 247, 0.15)',
                  border: studyGuideActive ? '1px solid rgba(74, 141, 247, 0.6)' : '1px solid rgba(74, 141, 247, 0.3)',
                }}>
                <span className="text-cambridge-400 group-hover:scale-110 transition-transform">
                  <svg width="15" height="15" viewBox="0 0 15 15" fill="none">
                    <path d="M7.5 1.5L9.5 5.5L14 6.18L10.75 9.32L11.5 13.82L7.5 11.77L3.5 13.82L4.25 9.32L1 6.18L5.5 5.5L7.5 1.5Z"
                      stroke="#4a8df7" strokeWidth="1.4" strokeLinejoin="round" />
                  </svg>
                </span>
                Study Guide
              </button>
            </div>

            <SidebarAccordion modules={modules} activeUnit={activeUnit} onSelectUnit={onSelectUnit} />
            <ResourceLinks />
          </div>

          <UserMenu />
          <SidebarProgress percent={percent} completedUnits={completedUnits} totalUnits={totalUnits} />
        </div>
      </aside>

      {/* Toggle button */}
      <button
        onClick={onToggle}
        aria-label={open ? 'Collapse sidebar' : 'Expand sidebar'}
        className="absolute left-0 top-1/2 -translate-y-1/2 z-50 w-5 h-10 flex items-center justify-center rounded-r-md transition-all"
        style={{
          left: open ? '272px' : '0px',
          background: '#1c2d4f',
          border: '1px solid rgba(255,255,255,0.1)',
          borderLeft: 'none',
          color: 'rgba(255,255,255,0.4)',
        }}
      >
        <svg width="10" height="10" viewBox="0 0 10 10" fill="none" className="transition-transform"
          style={{ transform: open ? 'rotate(0deg)' : 'rotate(180deg)' }}>
          <path d="M6.5 2L3.5 5L6.5 8" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
        </svg>
      </button>
    </>
  )
}
