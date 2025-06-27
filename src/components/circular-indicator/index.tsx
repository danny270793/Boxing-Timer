import type { FC, ReactNode } from 'preact/compat'
import './index.css'

interface CircularIndicatorProps {
  percentage: number
}

export const CircularIndicator: FC<CircularIndicatorProps> = (
  props: CircularIndicatorProps,
): ReactNode => {
  return (
    <div
      class="circular-progress"
      style={{ '--percentage': props.percentage }}
    ></div>
  )
}
