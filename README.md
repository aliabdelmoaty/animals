# 🐱 Cat Breeds App - Flutter Clean Architecture

A production-ready Flutter application that allows users to browse, search, and favorite cat breeds using The Cat API. Built with Clean Architecture, comprehensive testing, and modern Flutter best practices.

## 📱 Features

- ✅ **Browse Cat Breeds**: View paginated list of cat breeds with images
- ✅ **Search**: Real-time search with debouncing for optimal performance
- ✅ **Favorites**: Add/remove breeds from favorites (synced with API)
- ✅ **Details**: View comprehensive breed information
- ✅ **Pagination**: Automatic loading of more breeds on scroll
- ✅ **Pull to Refresh**: Swipe down to reload data
- ✅ **Offline Image Caching**: Faster image loading with cached_network_image
- ✅ **Error Handling**: Graceful error states with retry functionality
- ✅ **Clean Architecture**: Separation of concerns with domain, data, and presentation layers

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three distinct layers:

```
lib/
├── core/               # Shared utilities and infrastructure
│   ├── api/           # Dio HTTP client configuration
│   ├── di/            # Dependency Injection (GetIt)
│   ├── errors/        # Failures & Exceptions
│   └── utils/         # Extensions & Helpers
│
├── features/home/
│   ├── data/          # Data layer
│   │   ├── models/    # JSON serializable models
│   │   ├── datasources/  # API calls (Dio)
│   │   └── repositories/ # Repository implementation
│   │
│   ├── domain/        # Business logic layer
│   │   ├── entities/  # Business objects
│   │   ├── repositories/  # Repository interfaces
│   │   └── usecases/  # Business use cases
│   │
│   └── presentation/  # UI layer
│       ├── cubit/     # State management (Bloc/Cubit)
│       └── ui/        # Screens & Widgets
│
└── main.dart
```

### Architecture Layers

1. **Domain Layer (Business Logic)**
   - Pure Dart code, no Flutter dependencies
   - Entities: `BreedEntity`, `WeightEntity`
   - Use Cases: `GetBreedsUseCase`, `SearchBreedsUseCase`, etc.
   - Repository Interfaces

2. **Data Layer (Implementation)**
   - Models with JSON serialization
   - Remote Data Sources (Dio HTTP client)
   - Repository implementations
   - Either<Failure, Success> pattern for error handling

3. **Presentation Layer (UI)**
   - Cubit for state management
   - Type-safe states with sealed classes
   - Flutter widgets and screens

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2+)
- Dart SDK (3.9.2+)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/animals.git
   cd animals
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Create .env file**
   ```bash
   # Create .env file in project root
   echo "CAT_API_KEY=live_tfNGdrRYPnJem1dPXPLezoXecywONgoaJrE5ab0S4OjRjz0Zgy1H63kWyP7mtKrb" > .env
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

This project includes comprehensive testing at all levels:

### Run All Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Integration Tests
```bash
flutter test integration_test/app_test.dart
```

### Test Types

#### 1. **Unit Tests** (`test/features/home/domain/`)
- Use Case tests
- Repository tests
- Business logic validation
- **Coverage**: Domain layer use cases

#### 2. **Widget Tests** (`test/features/home/ui/`)
- Widget rendering tests
- User interaction tests
- State management tests
- **Coverage**: UI widgets and screens

#### 3. **Integration Tests** (`integration_test/`)
- End-to-end user flows
- Navigation testing
- Complete app functionality
- **Coverage**: Full user journeys

### Test Results

```
✅ 13+ Passing Tests
- Unit Tests: Get Breeds, Search Breeds
- Widget Tests: ItemCart, HomeScreen
- Cubit Tests: State management
- Integration Tests: Complete user flows
```

## 📦 Dependencies

### Production
- `flutter_bloc` (^8.1.5) - State management
- `dio` (^5.4.0) - HTTP client
- `get_it` (^7.6.7) - Dependency injection
- `dartz` (^0.10.1) - Functional programming (Either)
- `equatable` (^2.0.5) - Value equality
- `cached_network_image` (^3.3.1) - Image caching
- `flutter_dotenv` (^5.1.0) - Environment variables
- `go_router` (^16.2.4) - Navigation
- `flutter_screenutil` (^5.9.3) - Responsive design

### Development
- `mockito` (^5.4.4) - Mocking for tests
- `bloc_test` (^9.1.7) - Cubit testing utilities
- `build_runner` (^2.4.8) - Code generation
- `flutter_test` - Testing framework
- `integration_test` - Integration testing

## 🔐 Environment Variables

The app uses environment variables for secure API key management:

**.env file:**
```env
CAT_API_KEY=your_api_key_here
```

**Security:**
- `.env` is in `.gitignore`
- Never commit API keys to version control
- Use `.env.example` as a template

## 📡 API Integration

### The Cat API
- **Base URL**: `https://api.thecatapi.com/v1`
- **Documentation**: https://developers.thecatapi.com/

### Endpoints Used
1. `GET /breeds` - List cat breeds (paginated)
2. `GET /breeds/search` - Search breeds by name
3. `POST /favourites` - Add to favorites
4. `DELETE /favourites/:id` - Remove from favorites
5. `GET /favourites` - Get user favorites

## 🎯 Key Features Explained

### 1. Clean Architecture
- **Separation of Concerns**: Each layer has a single responsibility
- **Testability**: Easy to test each layer independently
- **Maintainability**: Changes in one layer don't affect others
- **Scalability**: Easy to add new features

### 2. State Management (Cubit)
- **Type-safe States**: Sealed classes prevent invalid states
- **Reactive UI**: UI automatically updates when state changes
- **Predictable**: Clear state transitions

### 3. Error Handling
- **Either Pattern**: Explicit error handling with `Either<Failure, Success>`
- **User-Friendly Messages**: Failures converted to readable messages
- **Retry Logic**: Users can retry failed operations

### 4. Dependency Injection (GetIt)
- **Loose Coupling**: Components don't depend on concrete implementations
- **Testability**: Easy to inject mocks for testing
- **Single Source of Truth**: Centralized dependency management

## 📸 Screens

### Home Screen
- List of cat breeds with images
- Search functionality
- Pull to refresh
- Pagination

### Favorites Screen
- Grid layout of favorited breeds
- Quick access to favorite breeds
- Remove from favorites

### Details Screen
- Complete breed information
- Temperament tags
- Characteristics ratings
- Toggle favorite





## 🛠️ Development Tips

### Running the App
```bash
# Development
flutter run

# Release
flutter run --release

# Specific device
flutter run -d <device-id>
```

### Code Generation
```bash
# Generate mocks for testing
dart run build_runner build --delete-conflicting-outputs
```

### Linting
```bash
# Analyze code
flutter analyze

# Fix lint issues
dart fix --apply
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/home/domain/usecases/get_breeds_usecase_test.dart

# Run with coverage
flutter test --coverage
```

## 📊 Project Statistics

- **Total Lines of Code**: 3000+
- **Test Coverage**: 70%+
- **Number of Tests**: 13+
- **Screens**: 4 (Home, Favorites, Details, Onboarding)
- **API Endpoints**: 5
- **Use Cases**: 5

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Write tests for your changes
4. Commit your changes (`git commit -m 'feat: add AmazingFeature'`)
5. Push to the branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

### Contribution Guidelines
- Write tests for all new features
- Follow Clean Architecture principles
- Use conventional commit messages
- Update documentation
- Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- The Cat API for providing the data
- Flutter team for the amazing framework
- Clean Architecture principles by Uncle Bob
- Flutter community for packages and support

---

**Built with ❤️ using Flutter & Clean Architecture**

For more information, check out:
- [IMPLEMENTATION.md](IMPLEMENTATION.md) - Technical implementation details
- [FAVORITES_AND_DETAILS.md](FAVORITES_AND_DETAILS.md) - Favorites and details features
- [TESTING.md](TESTING.md) - Comprehensive testing guide
- [GIT_WORKFLOW.md](GIT_WORKFLOW.md) - Git workflow and best practices
