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

/** Resolves a book unit_number (1-145) to its module/unit — every seeded unit's id is `unit-${unit_number}`. */
export function findUnitByNumber(modules: Module[], unitNumber: number): { module: Module; unit: Unit } | null {
  const targetId = `unit-${unitNumber}`
  for (const module of modules) {
    const unit = module.units.find(u => u.id === targetId)
    if (unit) return { module, unit }
  }
  return null
}
