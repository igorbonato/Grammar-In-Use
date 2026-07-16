import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import Sidebar from './components/layout/Sidebar'
import TheoryPanel from './components/theory/TheoryPanel'
import ExercisesPanel from './components/exercises/ExercisesPanel'
import { modules } from './data/modules'
import { findModuleAndUnit } from './lib/curriculum'
import type { Unit } from './types/grammar'

export default function App() {
  const { moduleId, unitId } = useParams()
  const navigate = useNavigate()
  const [sidebarOpen, setSidebarOpen] = useState(true)

  const found = findModuleAndUnit(modules, moduleId, unitId)
  const activeModule = found?.module ?? modules[0]
  const activeUnit = found?.unit ?? modules[0].units[0]

  const handleSelectUnit = (targetModuleId: string, unit: Unit) => {
    navigate(`/modulo/${targetModuleId}/${unit.id}`)
  }

  return (
    <div className="flex h-screen overflow-hidden bg-[#f4f7fc] relative">
      <Sidebar
        modules={modules}
        activeUnit={activeUnit}
        onSelectUnit={handleSelectUnit}
        open={sidebarOpen}
        onToggle={() => setSidebarOpen(o => !o)}
      />

      {/* Main content area */}
      <div className="flex flex-1 overflow-hidden">
        <TheoryPanel unit={activeUnit} moduleTitle={activeModule.title} />
        <ExercisesPanel unit={activeUnit} />
      </div>
    </div>
  )
}
