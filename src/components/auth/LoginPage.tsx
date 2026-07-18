import { useAuthStore } from '../../store/useAuthStore'
import GoogleButton from './GoogleButton'
import EmailPasswordForm from './EmailPasswordForm'

export default function LoginPage() {
  const signInWithGoogle = useAuthStore(state => state.signInWithGoogle)

  return (
    <div className="flex-1 flex items-center justify-center bg-[#f4f7fc] p-6">
      <div className="w-full max-w-[380px]">
        <div className="flex flex-col items-center mb-8">
          <div
            className="w-12 h-12 rounded-xl flex items-center justify-center mb-4"
            style={{ background: 'linear-gradient(135deg, #4a8df7 0%, #2d6de6 100%)' }}
          >
            <svg width="22" height="22" viewBox="0 0 16 16" fill="none">
              <path d="M3 4h10M3 8h7M3 12h5" stroke="white" strokeWidth="1.8" strokeLinecap="round" />
            </svg>
          </div>
          <h1 className="text-gray-900 font-bold text-xl">Grammar in Use</h1>
          <p className="text-gray-400 text-[13px] mt-1">Entre para acompanhar seu progresso</p>
        </div>

        <div className="bg-white rounded-2xl border border-gray-200 p-6" style={{ boxShadow: '0 4px 24px rgba(0,0,0,0.04)' }}>
          <GoogleButton onClick={signInWithGoogle} />

          <div className="flex items-center gap-3 my-5">
            <div className="flex-1 h-px bg-gray-200" />
            <span className="text-[12px] text-gray-400">ou</span>
            <div className="flex-1 h-px bg-gray-200" />
          </div>

          <EmailPasswordForm />
        </div>
      </div>
    </div>
  )
}
