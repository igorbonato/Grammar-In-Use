import type { Module, Unit } from '../types/grammar'

export function findModuleAndUnit(
  modules: Module[],
  moduleId: string | undefined,
  unitId: string | undefined,
): { module: Module; unit: Unit } | null {
  const module = modules.find(m => m.id === moduleId)
  const unit = module?.units.find(u => u.id === unitId)
  if (!module || !unit) return null
  return { module, unit }
}
