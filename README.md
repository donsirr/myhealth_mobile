# MyHealth Mobile 📱

A premium minimalist Flutter mobile health application for Naga City, Philippines.

## Features

### Core Services
- **💓 Heart Health** - CVD risk assessment calculator  
- **🦟 Dengue Radar** - Live outbreak map with hotspot tracking
- **🚨 Emergency Tools** - F.A.S.T. stroke detection, heart attack & child emergency guides
- **🏥 Health Passport** - QR-enabled emergency health information
- **📅 Wellness Screening** - Free screening schedules and eligibility

### Emergency Identification Tools
- **Stroke (F.A.S.T.)** - Interactive symptom checker with persistent timer
- **Heart Attack** - Cardiac emergency sign recognition
- **Dengue Fever** - Warning signs and symptom identification  
- **Child Emergency** - Pediatric alerts and fever guidelines

### Key Features
- ✅ Offline-first with persistent data storage
- ✅ Global stroke timer with cross-screen toast notifications
- ✅ QR code generation for emergency health passports
- ✅ Interactive OpenStreetMap integration for dengue tracking
- ✅ Direct emergency calling (911, dengue hotline)
- ✅ Premium minimalist UI (Apple Health-inspired)

## Tech Stack

- **Framework:** Flutter 3.x
- **State Management:** Provider
- **Navigation:** go_router
- **Persistence:** shared_preferences
- **Maps:** flutter_map (OpenStreetMap)
- **UI:** Custom theme with glassmorphism, no Material 3
- **Typography:** Google Fonts (Plus Jakarta Sans)
- **Icons:** lucide_icons

## Design System

### Premium Minimalist Aesthetic
- **Background:** Off-white (#F8FAFC)
- **Typography:** Plus Jakarta Sans (bold headers, clean body text)
- **Colors:** Medical blue (#0EA5E9), emergency red, dengue orange, stroke purple
- **Components:** Glassmorphism nav dock, soft shadows, gradient accent cards
- **Spacing:** Generous whitespace, 24px standard padding

### Navigation
- Custom floating glassmorphism bottom navigation dock
- Nested routing with persistent layouts
- SafeArea-aware FAB positioning

## Project Structure

```
lib/
├── main.dart                    # App entry, theme config
├── router.dart                  # GoRouter navigation setup
├── providers/
│   ├── passport_provider.dart   # Health passport data + persistence
│   └── stroke_timer_provider.dart # Global timer state
├── screens/
│   ├── home_screen.dart
│   ├── cvd_screen.dart          # CVD risk calculator
│   ├── dengue_screen.dart       # Map + hotspots + prevention
│   ├── identify_hub_screen.dart # Emergency tool selection
│   ├── stroke_screen.dart       # F.A.S.T. + timer
│   ├── heart_attack_screen.dart
│   ├── dengue_identify_screen.dart
│   ├── child_emergency_screen.dart
│   ├── passport_screen.dart     # QR code + edit mode
│   ├── roadmap_screen.dart      # Project timeline
│   └── screening_screen.dart    # Wellness catalog
└── widgets/
    ├── custom_scaffold.dart     # Nav dock + stroke toast
    ├── emergency_guide_screen.dart # Reusable emergency template
    └── risk_result_sheet.dart   # CVD result bottom sheet
```

## Getting Started

### Prerequisites
- Flutter SDK 3.x
- Dart 3.x
- Android SDK / Xcode (for mobile deployment)

### Installation

```bash
# Clone repository
cd myhealth_mobile

# Install dependencies  
flutter pub get

# Run on device/emulator
flutter run

# Build APK
flutter build apk --release
```

### Environment Setup
No API keys required - uses public OpenStreetMap tiles.

## State Management

### PassportProvider
- Stores emergency health data (blood type, allergies, conditions, emergency contacts)
- Persists via `SharedPreferences`
- Generates QR code data for scanning

### StrokeTimerProvider
- Global timer for stroke symptom tracking
- Persists across screens
- Shows floating toast on all pages except `/identify/stroke`
- Auto-starts when F.A.S.T. symptoms detected

## Key Screens

### CVD Risk Calculator
- Multi-step questionnaire (age, gender, smoking, BP, etc.)
- Point-based risk assessment
- Color-coded results with action items

### Dengue Radar
- OpenStreetMap centered on Naga City
- Pulsing animated markers for outbreak hotspots
- Strict bounds to prevent map navigation outside city
- Prevention tips accordion
- Direct hotline calling

### Stroke Detection (F.A.S.T.)
- Interactive symptom cards (Face, Arms, Speech, Time)
- Auto-start timer when symptoms detected
- Large inline timer display
- Educational notes about golden hour
- Emergency call FAB
- Navigation warning if leaving with active timer

### Health Passport
- View/Edit mode toggle
- QR code generation
- Emergency contact management
- Medical history fields

## Developer Notes

### Theme Customization
Material 3 is **disabled** (`useMaterial3: false`). All theming is custom-defined in `main.dart`.

### Navigation Caveats
- Uses `go_router` v14+ with `ShellRoute` for persistent layouts
- Bottom nav dock is part of `CustomScaffold` (ShellRoute wrapper)
- Use `context.go()` for top-level routes, `context.push()` for nested

### State Persistence
`PassportProvider` auto-saves on data changes. `StrokeTimerProvider` is in-memory only.

### Map Bounds
Dengue map is strictly bounded to Naga City coordinates. Modify `LatLngBounds` in `dengue_screen.dart` if needed.

## Roadmap

- ✅ Phase 1: Public Beta (MVP) - **COMPLETED**
- 🔄 Phase 2: Mobile App Launch - **IN PROGRESS**
- 🔜 Phase 3: Hospital Data Integration
- 🔜 Phase 4: PhilSys National ID Sync

## Credits

**Developer:** MyHealth Team  
**Design:** Premium Minimalist (Apple Health-inspired)  
**Location:** Naga City, Camarines Sur, Philippines  
**Emergency Contact:** (054) 473-2326

---

Built with ❤️ for the health of Naga City
