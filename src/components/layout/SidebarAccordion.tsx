import { useState } from 'react'
import type { Module, Unit } from '../../types/grammar'

type Props = {
  modules: Module[]
  activeUnit: Unit | null
  onSelectUnit: (moduleId: string, unit: Unit) => void
}

export default function SidebarAccordion({ modules, activeUnit, onSelectUnit }: Props) {
  const [expandedModules, setExpandedModules] = useState<Set<string>>(new Set(['present-past']))

  const toggleModule = (id: string) => {
    setExpandedModules(prev => {
      const next = new Set(prev)
      if (next.has(id)) next.delete(id)
      else next.add(id)
      return next
    })
  }

  return (
    <div className="mb-5">
      <div className="px-2 mb-2 text-[10px] font-semibold uppercase tracking-widest text-blue-300/50">
        Study Modules
      </div>
      <div className="space-y-1">
        {modules.map(mod => (
          <div key={mod.id}>
            <button
              onClick={() => toggleModule(mod.id)}
              aria-expanded={expandedModules.has(mod.id)}
              className="w-full flex items-center gap-2 px-3 py-2.5 rounded-lg text-sm font-medium text-white/70 hover:text-white hover:bg-white/5 transition-all"
            >
              <ChevronIcon expanded={expandedModules.has(mod.id)} />
              <span className="text-left flex-1">{mod.title}</span>
              <span className="text-[10px] text-white/30 font-mono">{mod.units.length}</span>
            </button>

            {expandedModules.has(mod.id) && (
              <div className="ml-3 mt-0.5 border-l border-white/10 pl-3 space-y-0.5">
                {mod.units.map(unit => {
                  const isActive = activeUnit?.id === unit.id
                  return (
                    <button
                      key={unit.id}
                      onClick={() => onSelectUnit(mod.id, unit)}
                      aria-current={isActive ? 'page' : undefined}
                      className="w-full text-left px-3 py-2 rounded-md text-[13px] transition-all"
                      style={isActive ? {
                        background: 'rgba(74, 141, 247, 0.2)',
                        color: '#7db0ff',
                        fontWeight: 500,
                      } : {
                        color: 'rgba(255,255,255,0.45)',
                      }}
                    >
                      <span className="text-[10px] font-mono mr-2"
                        style={{ color: isActive ? '#4a8df7' : 'rgba(255,255,255,0.2)' }}>
                        {unit.shortTitle.replace('Unit ', '')}
                      </span>
                      {unit.title}
                    </button>
                  )
                })}
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  )
}

function ChevronIcon({ expanded }: { expanded: boolean }) {
  return (
    <svg
      width="12" height="12" viewBox="0 0 12 12" fill="none"
      className="transition-transform flex-shrink-0"
      style={{ transform: expanded ? 'rotate(90deg)' : 'rotate(0deg)' }}
    >
      <path d="M4 2.5L7.5 6L4 9.5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
    </svg>
  )
}
