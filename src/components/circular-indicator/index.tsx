import type { FC, ReactNode } from 'preact/compat'
import './index.css'

interface CircularIndicatorProps {
  percentage: number
  children?: ReactNode
}

export const CircularIndicator: FC<CircularIndicatorProps> = (
  props: CircularIndicatorProps,
): ReactNode => {
  return (
    <div class="circular-progress" style={{ '--percentage': props.percentage }}>
      <div className="circular-progress-children">{props.children}</div>
    </div>
  )
}
