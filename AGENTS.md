# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

WhosIn is a mobile application built to bring back spontaneous and casual hangouts. This is a SwiftUI-based iOS application using SwiftData for data persistence and targeting iOS 26.2+.

## Build and Test Commands

### Building
```bash
# Build the main app target
xcodebuild -project WhosIn/WhosIn.xcodeproj -scheme WhosIn -configuration Debug build

# Build for a specific destination (e.g., iPhone simulator)
xcodebuild -project WhosIn/WhosIn.xcodeproj -scheme WhosIn -destination 'platform=iOS Simulator,name=iPhone 16' build
```

### Testing
```bash
# Run all tests (unit + UI tests)
xcodebuild -project WhosIn/WhosIn.xcodeproj -scheme WhosIn -destination 'platform=iOS Simulator,name=iPhone 16' test

# Run only unit tests
xcodebuild -project WhosIn/WhosIn.xcodeproj -scheme WhosIn -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:WhosInTests test

# Run only UI tests
xcodebuild -project WhosIn/WhosIn.xcodeproj -scheme WhosIn -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:WhosInUITests test

# Run a specific test
xcodebuild -project WhosIn/WhosIn.xcodeproj -scheme WhosIn -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:WhosInTests/WhosInTests/example test
```

### Opening in Xcode
```bash
open WhosIn/WhosIn.xcodeproj
```

## Architecture

### Data Layer
- **SwiftData**: The app uses SwiftData (Apple's modern persistence framework) as the primary data persistence layer
- **ModelContainer**: Configured in `WhosIn/WhosIn/WhosInApp.swift` with schema definition
- **Models**: Data models are decorated with `@Model` macro (see `WhosIn/WhosIn/Item.swift`)

### Key Characteristics
- **SwiftUI App Lifecycle**: Uses the `@main` app struct pattern (`WhosInApp`)
- **MainActor Isolation**: The project uses `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` for UI safety
- **Testing Framework**: Uses Swift Testing framework (with `@Test` macro) for unit tests and XCTest for UI tests

### Project Structure
```
WhosIn/
├── WhosIn/              # Main app target
│   ├── WhosInApp.swift      # App entry point with ModelContainer setup
│   ├── ContentView.swift    # Main view (currently template code)
│   ├── Item.swift            # SwiftData model example
│   ├── Assets.xcassets/      # Asset catalog
│   ├── Info.plist            # App configuration (background modes)
│   └── WhosIn.entitlements   # CloudKit and push notification entitlements
├── WhosInTests/         # Unit tests
└── WhosInUITests/       # UI tests
```

## Important Configuration Details

### Capabilities
The app is configured with the following capabilities:
- **CloudKit**: Enabled for potential cloud sync (currently no container identifiers configured)
- **Push Notifications**: Configured for remote notifications (background mode enabled)
- **Development Team**: PRMW66U6FZ

### Build Settings
- **Bundle Identifier**: `evelynxiao.WhosIn`
- **iOS Deployment Target**: iOS 26.2
- **Swift Version**: 5.0
- **Device Support**: iPhone and iPad (TARGETED_DEVICE_FAMILY = "1,2")
- **Swift Concurrency**: Approachable concurrency enabled
- **Previews**: SwiftUI previews enabled

## Development Patterns

### SwiftData Usage
When working with data models:
- Mark model classes with `@Model` macro
- Use `@Query` property wrapper in views to fetch data
- Access `modelContext` via `@Environment(\.modelContext)` to insert/delete items
- The ModelContainer is injected at the app level via `.modelContainer()` modifier

### Testing Patterns
- Unit tests use the Swift Testing framework with `@Test` functions
- UI tests use XCTest with `XCTestCase` classes
- For SwiftData testing, use in-memory containers: `.modelContainer(for: Item.self, inMemory: true)`
