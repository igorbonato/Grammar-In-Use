import { useEffect, useState } from 'react'
import { Outlet, useLocation, useNavigate, useParams } from 'react-router-dom'
import Sidebar from '../components/layout/Sidebar'
import { modules } from '../data/modules'
import { findModuleAndUnit } from '../lib/curriculum'
import { useAuthStore } from '../store/useAuthStore'
import type { Unit } from '../types/grammar'

export default function AppShell() {
  const { moduleId, unitId } = useParams()
  const location = useLocation()
  const navigate = useNavigate()
  const [sidebarOpen, setSidebarOpen] = useState(true)
  const initializeAuth = useAuthStore(state => state.initialize)

  useEffect(() => {
    initializeAuth()
  }, [initializeAuth])

  const found = findModuleAndUnit(modules, moduleId, unitId)
  const activeUnit = found?.unit ?? null

  const handleSelectUnit = (targetModuleId: string, unit: Unit) => {
    navigate(`/modulo/${targetModuleId}/${unit.id}`)
  }

  return (
    <div className="flex h-screen overflow-hidden bg-[#f4f7fc] relative">
      <Sidebar
        modules={modules}
        activeUnit={activeUnit}
        onSelectUnit={handleSelectUnit}
        studyGuideActive={location.pathname === '/guia-de-estudo'}
        onSelectStudyGuide={() => navigate('/guia-de-estudo')}
        open={sidebarOpen}
        onToggle={() => setSidebarOpen(o => !o)}
      />

      {/* Main content area */}
      <div className="flex flex-1 overflow-hidden">
        <Outlet />
      </div>
    </div>
  )
}
