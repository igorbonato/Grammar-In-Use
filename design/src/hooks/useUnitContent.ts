import type { TheoryContent } from '../types/grammar'
import { unit1Content } from '../data/units/unit-1'
import { genericContent } from '../data/units/generic'

export function useUnitContent(unitId: string): TheoryContent {
  return unitId === 'unit-1' ? unit1Content : genericContent
}
