# Country Explorer App

A Flutter application that allows users to explore countries, view their details, and save favorites for offline access.

## Features

- Browse countries with their flags and basic information
- Search countries by name
- View detailed information about each country:
    - Capital
    - Population
    - Currencies
    - Languages
- Save favorite countries for offline access
- View list of favorite countries
- Clean Architecture implementation
- Error handling for API and database operations

## Screenshots

[Add screenshots of your app here]

## Setup Instructions

1. Clone the repository:
```bash
git clone https://github.com/yourusername/country-explorer.git
```

2. Navigate to the project directory:
```bash
cd country-explorer
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.0
  http: ^1.1.0
  sqflite: ^2