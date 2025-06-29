import type { FC, ReactNode } from 'preact/compat'
import './index.css'

interface CircularIndicatorProps {
  percentage: number
  background?: string
  children?: ReactNode
}

export const CircularIndicator: FC<CircularIndicatorProps> = (
  props: CircularIndicatorProps,
): ReactNode => {
  return (
    <div style={{ display: 'flex', justifyContent: 'center' }}>
      <div
        className="circular-progress"
        style={{
          '--percentage': props.percentage,
        }}
      >
        <div
          className="circular-progress-children"
          style={{ background: props.background }}
        >
          {props.children}
        </div>
      </div>
    </div>
  )
}
