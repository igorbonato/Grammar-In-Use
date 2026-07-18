import { useAuthStore } from '../../store/useAuthStore'

export default function UserMenu() {
  const user = useAuthStore(state => state.user)
  const signOut = useAuthStore(state => state.signOut)

  if (!user) return null

  const meta = user.user_metadata as { full_name?: string; name?: string; avatar_url?: string; picture?: string }
  const displayName = meta.full_name ?? meta.name ?? user.email ?? 'Aluno'
  const avatarUrl = meta.avatar_url ?? meta.picture ?? null
  const initial = displayName.charAt(0).toUpperCase()

  return (
    <div className="flex items-center gap-2.5 px-4 py-3 border-t border-white/10">
      {avatarUrl ? (
        <img src={avatarUrl} alt="" className="w-8 h-8 rounded-full flex-shrink-0 object-cover" />
      ) : (
        <div
          className="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-white text-[13px] font-semibold"
          style={{ background: 'linear-gradient(135deg, #4a8df7 0%, #2d6de6 100%)' }}
        >
          {initial}
        </div>
      )}
      <div className="flex-1 min-w-0">
        <div className="text-white text-[13px] font-medium truncate">{displayName}</div>
        {user.email && <div className="text-white/40 text-[11px] truncate">{user.email}</div>}
      </div>
      <button
        onClick={signOut}
        aria-label="Sair"
        title="Sair"
        className="flex-shrink-0 w-7 h-7 rounded-lg flex items-center justify-center text-white/40 hover:text-white hover:bg-white/10 transition-all"
      >
        <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
          <path d="M5.5 12.5H2.5a1 1 0 0 1-1-1v-9a1 1 0 0 1 1-1h3M9.5 9.5L12.5 6.5 9.5 3.5M12.5 6.5H4.5"
            stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      </button>
    </div>
  )
}
