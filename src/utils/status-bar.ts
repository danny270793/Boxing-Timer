import { Capacitor } from '@capacitor/core'
import { StatusBar as CapacitorStatusBar } from '@capacitor/status-bar'

export const StatusBar = {
  backgroundColorByHexString: (color: string) => {
    const platform: string = Capacitor.getPlatform()
    if (platform === 'android') {
      CapacitorStatusBar.setBackgroundColor({ color })
    }

    let metaTag: HTMLMetaElement | null =
      document.querySelector<HTMLMetaElement>('meta[name="theme-color"]')
    if (!metaTag) {
      metaTag = document.createElement('meta')
      metaTag.name = 'theme-color'
      document.head.appendChild(metaTag)
    }
    metaTag.setAttribute('content', color)
  },
}
