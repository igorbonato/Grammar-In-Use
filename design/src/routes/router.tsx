import { createBrowserRouter, Navigate } from 'react-router-dom'
import App from '../App'
import { modules } from '../data/modules'

const firstModule = modules[0]
const firstUnit = firstModule.units[0]

export const router = createBrowserRouter([
  {
    path: '/',
    element: <Navigate to={`/modulo/${firstModule.id}/${firstUnit.id}`} replace />,
  },
  {
    path: '/modulo/:moduleId/:unitId',
    element: <App />,
  },
])
