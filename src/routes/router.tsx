import { createBrowserRouter, Navigate } from 'react-router-dom'
import AppShell from './AppShell'
import UnitPage from './UnitPage'
import StudyGuidePage from './StudyGuidePage'
import { modules } from '../data/modules'

const firstModule = modules[0]
const firstUnit = firstModule.units[0]

export const router = createBrowserRouter([
  {
    element: <AppShell />,
    children: [
      {
        path: '/',
        element: <Navigate to={`/modulo/${firstModule.id}/${firstUnit.id}`} replace />,
      },
      {
        path: '/modulo/:moduleId/:unitId',
        element: <UnitPage />,
      },
      {
        path: '/guia-de-estudo',
        element: <StudyGuidePage />,
      },
    ],
  },
])
