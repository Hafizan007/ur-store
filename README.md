# Simple Product Store App

A Flutter application demonstrating Clean Architecture and BLoC pattern implementation with fakestore API integration.

## Features
- Authentication (Sign In)
- Product Management
  - List Products
  - Search Products
  - Product Details
- Shopping Cart (Local Storage)
- Unit Testing Coverage > 15%

## Architecture Overview
The app follows Clean Architecture principles with three main layers:

- **Domain Layer**: Business logic, use cases, entities
- **Data Layer**: Repository implementations, API integration, local storage
- **Presentation Layer**: UI components, BLoC state management

## Technology Stack
- **State Management**: `flutter_bloc`
- **Dependency Injection**: `get_it` + `injectable`
- **Local Storage**: `sqflite`
- **API Client**: `dio`
- **Navigation**: `auto_route`
- **Code Generation**: `build_runner`, `freezed`

## Project Structure
```
lib/
├── app/
│   ├── config/
│   │   ├── networking/
│   │   └── themes/
│   └── features/
│       ├── auth/
│       ├── product/
│       └── cart/
└── main.dart
```

## Installation
- Add [Flutter](https://flutter.dev/docs/get-started/install 'Flutter') to your machine (Flutter version 3.24.2)
- Open this project folder with Terminal/CMD
- Ensure there's no cache/build leftover by running `flutter clean` in the Terminal
- Run in the Terminal `flutter packages get`


# run this project by command line
```
flutter run \
  --flavor dev \
  -d <deviceId> \
  --target lib/main.dart \
  --debug \
  --hot \
  --dart-define=ENVIRONMENT=development
```

# run this project in vscode 

configure launch.json in .vscode folder
```
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "appmanagement-dev-debug",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "flutterMode": "debug",
      "args": [
        "--flavor",
        "dev",
        "--dart-define",
        "chrome",
        "DEBUG_MODE=DEBUG_ONLY",
      ]
    }
  ]
}
```

## API Integration
Using [Fake Store API](https://fakestoreapi.com/docs) for:
- Authentication: `/auth/login`
- Products: `/products`
- Categories: `/products/categories`

## Installation
1. Add [Flutter](https://flutter.dev/docs/get-started/install) (version 3.24.2)
2. Clone repository
3. Install dependencies:
```bash
flutter pub get
```
4. Generate code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Running the App
```bash
# Development
flutter run --flavor dev -t lib/main.dart
```

## Testing
```bash
# Run all tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
## Testing










