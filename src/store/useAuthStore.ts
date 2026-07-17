import { create } from 'zustand'
import type { Session, User } from '@supabase/supabase-js'
import { supabase } from '../lib/supabaseClient'

type AuthState = {
  session: Session | null
  user: User | null
  isLoading: boolean
  initialize: () => void
}

let initialized = false

export const useAuthStore = create<AuthState>((set) => ({
  session: null,
  user: null,
  isLoading: true,

  initialize: () => {
    if (initialized) return
    initialized = true

    supabase.auth.onAuthStateChange((_event, session) => {
      set({ session, user: session?.user ?? null, isLoading: false })
    })

    supabase.auth.getSession().then(async ({ data: { session } }) => {
      if (session) {
        set({ session, user: session.user, isLoading: false })
        return
      }

      const { data, error } = await supabase.auth.signInAnonymously()
      if (error) {
        console.error('Anonymous sign-in failed:', error.message)
        set({ isLoading: false })
        return
      }
      set({ session: data.session, user: data.user, isLoading: false })
    })
  },
}))
