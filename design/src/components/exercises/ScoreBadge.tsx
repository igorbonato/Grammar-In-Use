type Props = {
  correct: number
  total: number
}

export default function ScoreBadge({ correct, total }: Props) {
  return (
    <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-semibold"
      style={{
        background: correct === total
          ? 'linear-gradient(135deg, #dcfce7, #bbf7d0)'
          : correct >= total * 0.6
          ? 'linear-gradient(135deg, #fef9c3, #fef08a)'
          : 'linear-gradient(135deg, #fee2e2, #fecaca)',
        color: correct === total ? '#15803d'
          : correct >= total * 0.6 ? '#854d0e' : '#dc2626',
      }}>
      {correct === total ? '🎉' : correct >= total * 0.6 ? '👍' : '💪'}
      <span>{correct}/{total} correct</span>
    </div>
  )
}
