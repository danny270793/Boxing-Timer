import type { FC, ReactNode } from 'preact/compat'
import './index.css'

interface CircularIndicatorProps {
  percentage: number
  children?: ReactNode
  size?: number
  innerSize?: number
}

export const CircularIndicator: FC<CircularIndicatorProps> = (
  props: CircularIndicatorProps,
): ReactNode => {
  return (
    <div
      class="circular-progress"
      style={{
        '--percentage': props.percentage,
        width: props.size ? `${props.size}px` : '100vw',
      }}
    >
      <div
        className="circular-progress-children"
        style={{
          width: props.innerSize ? `${props.innerSize * 0.9}px` : '80vw',
        }}
      >
        {props.children}
      </div>
    </div>
  )
}
