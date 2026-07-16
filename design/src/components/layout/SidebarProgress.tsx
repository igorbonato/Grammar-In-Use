type Props = {
  percent: number
  completedUnits: number
  totalUnits: number
}

export default function SidebarProgress({ percent, completedUnits, totalUnits }: Props) {
  return (
    <div className="px-4 py-4 border-t border-white/10">
      <div className="flex items-center justify-between mb-2">
        <span className="text-[11px] text-white/40 font-medium">Your progress</span>
        <span className="text-[11px] text-cambridge-400 font-semibold">{percent}%</span>
      </div>
      <div className="h-1.5 rounded-full bg-white/10 overflow-hidden">
        <div className="h-full rounded-full" style={{ width: `${percent}%`, background: 'linear-gradient(90deg, #4a8df7, #7db0ff)' }} />
      </div>
      <div className="mt-2 text-[10px] text-white/25">{completedUnits} of {totalUnits} units completed</div>
    </div>
  )
}
