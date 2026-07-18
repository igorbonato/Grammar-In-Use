import { useState } from 'react'
import { useAuthStore } from '../../store/useAuthStore'

export default function EmailPasswordForm() {
  const [mode, setMode] = useState<'signin' | 'signup'>('signin')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [confirmationSent, setConfirmationSent] = useState(false)

  const authError = useAuthStore(state => state.authError)
  const signInWithPassword = useAuthStore(state => state.signInWithPassword)
  const signUpWithPassword = useAuthStore(state => state.signUpWithPassword)
  const clearAuthError = useAuthStore(state => state.clearAuthError)

  const switchMode = (next: 'signin' | 'signup') => {
    setMode(next)
    setConfirmationSent(false)
    clearAuthError()
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsSubmitting(true)
    setConfirmationSent(false)

    if (mode === 'signin') {
      await signInWithPassword(email, password)
    } else {
      const { needsEmailConfirmation } = await signUpWithPassword(email, password)
      if (needsEmailConfirmation) setConfirmationSent(true)
    }

    setIsSubmitting(false)
  }

  if (confirmationSent) {
    return (
      <div className="text-center py-4">
        <p className="text-sm text-gray-600">
          Enviamos um link de confirmação para <strong>{email}</strong>. Verifique sua caixa de
          entrada para ativar a conta.
        </p>
        <button
          type="button"
          onClick={() => switchMode('signin')}
          className="mt-4 text-sm font-semibold text-blue-600 hover:text-blue-700"
        >
          Voltar para o login
        </button>
      </div>
    )
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-3">
      <div>
        <label className="block text-[13px] font-medium text-gray-600 mb-1">Email</label>
        <input
          type="email"
          required
          value={email}
          onChange={e => setEmail(e.target.value)}
          placeholder="voce@exemplo.com"
          className="w-full px-3 py-2.5 rounded-lg border border-gray-200 text-[14px] outline-none transition-all focus:border-blue-400"
          style={{ boxShadow: '0 0 0 1px rgba(74, 141, 247, 0.1)' }}
        />
      </div>

      <div>
        <label className="block text-[13px] font-medium text-gray-600 mb-1">Senha</label>
        <input
          type="password"
          required
          minLength={6}
          value={password}
          onChange={e => setPassword(e.target.value)}
          placeholder="••••••••"
          className="w-full px-3 py-2.5 rounded-lg border border-gray-200 text-[14px] outline-none transition-all focus:border-blue-400"
          style={{ boxShadow: '0 0 0 1px rgba(74, 141, 247, 0.1)' }}
        />
      </div>

      {authError && (
        <p className="text-[13px] text-red-600 bg-red-50 border border-red-100 rounded-lg px-3 py-2">
          {authError}
        </p>
      )}

      <button
        type="submit"
        disabled={isSubmitting}
        className="w-full flex items-center justify-center gap-2 py-2.5 rounded-xl text-white text-sm font-semibold transition-all active:scale-[0.98] disabled:opacity-60"
        style={{
          background: 'linear-gradient(135deg, #1e50c4 0%, #2d6de6 60%, #4a8df7 100%)',
          boxShadow: '0 4px 16px rgba(45, 109, 230, 0.35)',
        }}
      >
        {mode === 'signin' ? 'Entrar' : 'Criar conta'}
      </button>

      <p className="text-center text-[13px] text-gray-500">
        {mode === 'signin' ? (
          <>Não tem conta? <button type="button" onClick={() => switchMode('signup')} className="font-semibold text-blue-600 hover:text-blue-700">Criar conta</button></>
        ) : (
          <>Já tem conta? <button type="button" onClick={() => switchMode('signin')} className="font-semibold text-blue-600 hover:text-blue-700">Entrar</button></>
        )}
      </p>
    </form>
  )
}
