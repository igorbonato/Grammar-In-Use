import { useParams } from 'react-router-dom'
import TheoryPanel from '../components/theory/TheoryPanel'
import ExercisesPanel from '../components/exercises/ExercisesPanel'
import { modules } from '../data/modules'
import { findModuleAndUnit } from '../lib/curriculum'

export default function UnitPage() {
  const { moduleId, unitId } = useParams()
  const found = findModuleAndUnit(modules, moduleId, unitId)
  const activeModule = found?.module ?? modules[0]
  const activeUnit = found?.unit ?? modules[0].units[0]

  return (
    <>
      <TheoryPanel unit={activeUnit} moduleTitle={activeModule.title} />
      <ExercisesPanel unit={activeUnit} />
    </>
  )
}
