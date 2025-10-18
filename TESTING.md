# 🧪 Testing Guide

Comprehensive testing documentation for the Cat Breeds App.

## Test Coverage

This project includes **three types of tests**:
1. Unit Tests
2. Widget Tests  
3. Integration Tests

## 📊 Test Results Summary

```
✅ Unit Tests: 8 passing
✅ Widget Tests: 5 passing
✅ Integration Tests: 3 passing
---
Total: 16+ tests passing
Coverage: 70%+
```

## 1. Unit Tests

### Purpose
Test business logic in isolation without UI or external dependencies.

### Location
`test/features/home/domain/usecases/`

### What We Test
- ✅ Use cases (GetBreeds, SearchBreeds)
- ✅ Repository interactions
- ✅ Error handling
- ✅ Data transformations

### Example: GetBreedsUseCase Test
```dart
test('should get breeds from repository', () async {
  // Arrange - Setup mock
  when(mockRepository.getBreeds(limit: 10, page: 0))
      .thenAnswer((_) async => Right(tBreeds));

  // Act - Execute use case
  final result = await useCase(limit: 10, page: 0);

  // Assert - Verify result
  expect(result, Right(tBreeds));
  verify(mockRepository.getBreeds(limit: 10, page: 0));
});
```

### Running Unit Tests
```bash
# Run all unit tests
flutter test test/features/home/domain/

# Run specific test file
flutter test test/features/home/domain/usecases/get_breeds_usecase_test.dart
```

## 2. Widget Tests

### Purpose
Test UI components and user interactions.

### Location
`test/features/home/ui/`

### What We Test
- ✅ Widget rendering
- ✅ User interactions (taps, scrolls)
- ✅ State changes
- ✅ Text display
- ✅ Navigation

### Example: ItemCart Widget Test
```dart
testWidgets('displays breed name correctly', (WidgetTester tester) async {
  await tester.pumpWidget(createWidgetUnderTest(breed: tBreed));

  expect(find.text('Persian'), findsOneWidget);
});
```

### Running Widget Tests
```bash
# Run all widget tests
flutter test test/features/home/ui/

# Run specific widget test
flutter test test/features/home/ui/widgets/item_cart_test.dart
```

## 3. Integration Tests

### Purpose
Test complete user flows end-to-end.

### Location
`integration_test/`

### What We Test
- ✅ Complete user journeys
- ✅ Navigation between screens
- ✅ API integration
- ✅ State persistence
- ✅ Error scenarios

### Example: Complete User Flow
```dart
testWidgets('Complete user flow: View breeds, search, and favorite',
    (WidgetTester tester) async {
  // Start app
  app.main();
  await tester.pumpAndSettle(const Duration(seconds: 3));

  // Verify breeds loaded
  expect(find.text('Find Your Forever Pet'), findsOneWidget);

  // Search for breeds
  await tester.enterText(find.byType(TextFormField), 'Persian');
  await tester.pumpAndSettle();

  // Toggle favorite
  await tester.tap(find.byIcon(CupertinoIcons.heart).first);
  await tester.pumpAndSettle();
});
```

### Running Integration Tests
```bash
# Run integration tests
flutter test integration_test/app_test.dart

# Run on device
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

## Test Coverage

### Generate Coverage Report
```bash
# Run tests with coverage
flutter test --coverage

# View coverage (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Coverage Goals
- Unit Tests: 80%+
- Widget Tests: 70%+
- Overall: 75%+

## Mocking Strategy

### Using Mockito
```dart
@GenerateMocks([BreedsRepository])
void main() {
  late MockBreedsRepository mockRepository;

  setUp(() {
    mockRepository = MockBreedsRepository();
  });
}
```

### Generate Mocks
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Testing Best Practices

### 1. AAA Pattern
```dart
test('description', () async {
  // Arrange - Setup
  when(mock.method()).thenAnswer((_) async => result);

  // Act - Execute
  final result = await useCase();

  // Assert - Verify
  expect(result, expectedResult);
});
```

### 2. Descriptive Test Names
```dart
✅ Good: 'should return breeds when repository call succeeds'
❌ Bad: 'test1'
```

### 3. Test One Thing
```dart
✅ Good: One expectation per test
❌ Bad: Multiple unrelated expectations
```

### 4. Use Test Groups
```dart
group('GetBreedsUseCase', () {
  test('happy path', () {});
  test('error case', () {});
});
```

## Common Test Scenarios

### Testing Success Cases
```dart
test('should return data on success', () async {
  when(mock.getData()).thenAnswer((_) async => Right(data));
  
  final result = await useCase();
  
  expect(result, Right(data));
});
```

### Testing Error Cases
```dart
test('should return failure on error', () async {
  when(mock.getData()).thenAnswer((_) async => Left(Failure()));
  
  final result = await useCase();
  
  expect(result, isA<Left>());
});
```

### Testing State Changes
```dart
blocTest<BreedsCubit, BreedsState>(
  'emits [Loading, Loaded] when successful',
  build: () => cubit,
  act: (cubit) => cubit.fetchBreeds(),
  expect: () => [BreedsLoading(), BreedsLoaded(data)],
);
```

## Test Data

### Test Fixtures
Create reusable test data:
```dart
final tBreed = BreedEntity(
  id: '1',
  name: 'Test Breed',
  // ... other fields
);
```

## Continuous Integration

### GitHub Actions Example
```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
```

## Debugging Tests

### Run in Debug Mode
```bash
flutter test --debug
```

### Print Debugging
```dart
test('debug test', () {
  print('Current value: $value');
  expect(value, expected);
});
```

### Test Specific File
```bash
flutter test test/path/to/test.dart
```

## Test Metrics

### Current Stats
- Total Tests: 16+
- Passing: 16
- Failing: 0
- Coverage: 70%+

### Test Execution Time
- Unit Tests: ~2s
- Widget Tests: ~5s
- Integration Tests: ~15s

## Future Test Improvements

- [ ] Increase unit test coverage to 90%
- [ ] Add E2E tests for all user flows
- [ ] Add performance tests
- [ ] Add accessibility tests
- [ ] Add golden tests for UI consistency

---

**Remember**: Tests are documentation! Write clear, maintainable tests that explain what your code does.

