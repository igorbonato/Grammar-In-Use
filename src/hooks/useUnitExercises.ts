import type { Exercise } from '../types/grammar'
import { unit1Exercises } from '../data/units/unit-1'
import { genericExercises } from '../data/units/generic'

export function useUnitExercises(unitId: string): Exercise[] {
  return unitId === 'unit-1' ? unit1Exercises : genericExercises
}
