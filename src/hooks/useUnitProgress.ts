import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { supabase } from '../lib/supabaseClient'

type UnitProgress = {
  status: 'not_started' | 'in_progress' | 'completed'
  lastScore: number | null
  lastTotal: number | null
  completedAt: string | null
}

async function resolveUnitId(unitSlug: string): Promise<string> {
  const { data, error } = await supabase.from('units').select('id').eq('slug', unitSlug).single()
  if (error) throw error
  return data.id
}

async function fetchUnitProgress(unitSlug: string, userId: string): Promise<UnitProgress | null> {
  const unitId = await resolveUnitId(unitSlug)
  const { data, error } = await supabase
    .from('user_unit_progress')
    .select('status, last_score, last_total, completed_at')
    .eq('user_id', userId)
    .eq('unit_id', unitId)
    .maybeSingle()

  if (error) throw error
  if (!data) return null

  return {
    status: data.status,
    lastScore: data.last_score,
    lastTotal: data.last_total,
    completedAt: data.completed_at,
  }
}

async function saveUnitProgress(unitSlug: string, userId: string, correct: number, total: number) {
  const unitId = await resolveUnitId(unitSlug)
  const status = correct === total ? 'completed' : 'in_progress'

  const { error } = await supabase.from('user_unit_progress').upsert(
    {
      user_id: userId,
      unit_id: unitId,
      status,
      last_score: correct,
      last_total: total,
      completed_at: status === 'completed' ? new Date().toISOString() : null,
    },
    { onConflict: 'user_id,unit_id' },
  )

  if (error) throw error
}

export function useUnitProgress(unitSlug: string, userId: string | null) {
  const queryClient = useQueryClient()
  const queryKey = ['unit-progress', unitSlug, userId]

  const query = useQuery({
    queryKey,
    queryFn: () => fetchUnitProgress(unitSlug, userId!),
    enabled: !!userId,
  })

  const mutation = useMutation({
    mutationFn: ({ correct, total }: { correct: number; total: number }) =>
      saveUnitProgress(unitSlug, userId!, correct, total),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey })
      queryClient.invalidateQueries({ queryKey: ['overall-progress', userId] })
    },
  })

  return {
    progress: query.data ?? null,
    isLoading: query.isLoading,
    saveProgress: mutation.mutate,
    isSaving: mutation.isPending,
  }
}
