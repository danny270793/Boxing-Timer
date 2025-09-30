# 🥊 Boxing Timer

A modern, responsive boxing timer application built with Preact and TypeScript. Perfect for boxing workouts with customizable rounds, rest periods, and a beautiful glassmorphism UI.

![Boxing Timer](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![TypeScript](https://img.shields.io/badge/TypeScript-5.8.3-blue.svg)
![Preact](https://img.shields.io/badge/Preact-10.26.5-purple.svg)

## ✨ Features

### 🎯 Core Functionality

- **12-Round Timer**: Standard boxing workout with 3-minute rounds and 1-minute rest periods
- **Visual Progress**: Beautiful circular progress indicator with real-time updates
- **Audio Alerts**: Bell sounds for round transitions and 10-second countdown warnings
- **State Persistence**: Resume workouts across browser sessions using localStorage
- **Responsive Design**: Works perfectly on desktop, tablet, and mobile devices

### 🌍 Internationalization

- **Multi-language Support**: English and Spanish translations
- **Auto-detection**: Automatically detects browser language preference
- **Complete Coverage**: All UI text is translatable
- **Easy Extension**: Simple to add new languages

### 🎨 Modern UI/UX

- **Glassmorphism Design**: Beautiful frosted glass effects and gradients
- **Smooth Animations**: Elegant transitions and micro-interactions
- **Dark Theme**: Eye-friendly dark color scheme
- **Accessibility**: Full ARIA support and keyboard navigation
- **Auto-scroll**: Automatically scrolls to top on page navigation

### 📱 Cross-Platform

- **Web App**: Runs in any modern browser
- **Mobile App**: Capacitor-powered iOS and Android apps
- **PWA Ready**: Can be installed as a Progressive Web App
- **Offline Support**: Works without internet connection

## 🚀 Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn
- For mobile development: Android Studio (Android) or Xcode (iOS)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/boxing-timer.git
   cd boxing-timer
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Start development server**

   ```bash
   npm run dev
   ```

4. **Open in browser**
   Navigate to `http://localhost:5173`

### Building for Production

```bash
# Build web app
npm run build

# Preview production build
npm run preview
```

### Mobile App Development

```bash
# Android
npm run android

# iOS
npm run ios

# Generate app icons
npm run icons:generate
```

## 🛠️ Tech Stack

### Frontend

- **Preact 10.26.5** - Fast, lightweight React alternative
- **TypeScript 5.8.3** - Type-safe JavaScript
- **Vite 6.3.5** - Fast build tool and dev server
- **React Router DOM 7.9.3** - Client-side routing

### Styling

- **Custom CSS** - Modern CSS with variables and animations
- **Glassmorphism** - Frosted glass design effects
- **Responsive Design** - Mobile-first approach

### Internationalization

- **i18next 25.5.2** - Internationalization framework
- **react-i18next 16.0.0** - React integration
- **i18next-browser-languagedetector 8.2.0** - Language detection

### Mobile

- **Capacitor 6.2.1** - Cross-platform native runtime
- **Status Bar Plugin** - Dynamic status bar styling

### Icons & Assets

- **Font Awesome 6.7.2** - Icon library
- **Custom Audio** - Boxing bell and countdown sounds

## 📁 Project Structure

```
src/
├── components/          # Reusable UI components
│   └── circular-indicator/
├── hooks/              # Custom React hooks
│   ├── useLocalStorage.ts
│   └── useScrollToTop.ts
├── i18n/               # Internationalization
│   ├── index.ts
│   ├── types.ts
│   └── translations.ts
├── pages/              # Page components
│   ├── home/
│   ├── settings/
│   ├── licenses/
│   ├── privacy/
│   └── terms/
├── styles/             # Global styles
│   └── index.css
├── utils/              # Utility functions
│   ├── time.ts
│   └── status-bar.ts
├── assets/             # Audio files
├── app.tsx            # Main app component
└── main.tsx           # Entry point
```

## 🎮 Usage

### Basic Timer

1. **Start Workout**: Click the "Start" button to begin
2. **Round Active**: 3-minute rounds with visual progress
3. **Rest Period**: 1-minute rest between rounds
4. **Audio Alerts**: Bell sounds at round transitions
5. **Pause/Resume**: Pause anytime and resume where you left off

### Settings

- **Language**: Switch between English and Spanish
- **App Info**: View version and app details
- **Legal Pages**: Access privacy policy and terms

### Persistence

- **Auto-save**: Timer state automatically saved to localStorage
- **Resume**: Close browser and reopen to continue workout
- **Reset**: Stop button clears all saved state

## 🎨 Customization

### Adding New Languages

1. Add language to `src/i18n/types.ts`
2. Add translations to `src/i18n/translations.ts`
3. Update `SUPPORTED_LANGUAGES` array

### Styling

- Modify CSS variables in `src/styles/index.css`
- Colors, fonts, and animations are easily customizable
- Glassmorphism effects can be adjusted

### Timer Configuration

- Modify constants in `src/pages/home/index.tsx`:
  - `SECONDS_BY_ROUND`: Round duration
  - `REST_SECONDS`: Rest duration
  - `ROUNDS`: Total number of rounds

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Use TypeScript for type safety
- Follow Preact best practices
- Add translations for new text
- Test on multiple devices
- Maintain responsive design

## 📱 Mobile App

### Android

- Minimum SDK: 22 (Android 5.1)
- Target SDK: 34 (Android 14)
- Architecture: arm64-v8a, armeabi-v7a, x86, x86_64

### iOS

- Minimum iOS: 13.0
- Target iOS: 17.0
- Architecture: arm64, x86_64 (simulator)

## 🔧 Scripts

```bash
# Development
npm run dev              # Start dev server
npm run build           # Build for production
npm run preview         # Preview production build

# Mobile
npm run android         # Run on Android
npm run ios            # Run on iOS
npm run build:appbundle # Build Android APK

# Utilities
npm run format         # Format code with Prettier
npm run icons:generate # Generate app icons
```

## 🐛 Troubleshooting

### Common Issues

**Timer not persisting**

- Check if localStorage is enabled in browser
- Clear browser cache and try again

**Audio not playing**

- Ensure browser allows autoplay
- Check if audio files are loaded correctly

**Mobile app not building**

- Run `npm run build` before mobile commands
- Ensure Android Studio/Xcode is properly configured

**Styling issues**

- Clear browser cache
- Check CSS variable definitions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Preact Team** - For the amazing lightweight React alternative
- **Capacitor Team** - For cross-platform mobile development
- **Font Awesome** - For the beautiful icon set
- **i18next** - For internationalization support
- **Boxing Community** - For inspiration and feedback

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/boxing-timer/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/boxing-timer/discussions)
- **Email**: danny270793@icloud.com

---

**Made with ❤️ for the boxing community**

_Keep fighting, keep training! 🥊_
