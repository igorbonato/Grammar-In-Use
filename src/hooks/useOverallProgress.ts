import { useQuery } from '@tanstack/react-query'
import { supabase } from '../lib/supabaseClient'
import { modules } from '../data/modules'

const totalUnits = modules.reduce((sum, mod) => sum + mod.units.length, 0)

async function fetchCompletedCount(userId: string): Promise<number> {
  const { count, error } = await supabase
    .from('user_unit_progress')
    .select('id', { count: 'exact', head: true })
    .eq('user_id', userId)
    .eq('status', 'completed')

  if (error) throw error
  return count ?? 0
}

export function useOverallProgress(userId: string | null) {
  const query = useQuery({
    queryKey: ['overall-progress', userId],
    queryFn: () => fetchCompletedCount(userId!),
    enabled: !!userId,
  })

  const completedUnits = query.data ?? 0
  const percent = totalUnits > 0 ? Math.round((completedUnits / totalUnits) * 100) : 0

  return { completedUnits, totalUnits, percent, isLoading: query.isLoading }
}
