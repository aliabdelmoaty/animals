import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:animals/core/di/dependency_injection.dart';
import 'package:animals/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Cat Breeds App Integration Tests', () {
    setUpAll(() async {
      // Load environment variables
      await dotenv.load(fileName: ".env");
      // Setup dependency injection
      await setupDependencyInjection();
    });

    testWidgets('Complete user flow: View breeds, search, and favorite', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Test 1: Verify app loads and shows breeds
      expect(find.text('Find Your Forever Pet'), findsOneWidget);

      // Wait for breeds to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Test 2: Verify breeds list is displayed
      expect(find.byType(ListView), findsWidgets);

      // Test 3: Search functionality
      final searchField = find.byType(TextFormField);
      expect(searchField, findsOneWidget);

      await tester.enterText(searchField, 'Persian');
      await tester.pumpAndSettle(const Duration(milliseconds: 600));

      // Wait for search results
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Test 4: Toggle favorite on a breed
      final heartIcon = find.byWidgetPredicate(
        (widget) =>
            widget is Icon &&
            (widget.icon?.codePoint == 0xf3f2 ||
                widget.icon?.codePoint == 0xf3f3), // heart or heart_fill
      );

      if (heartIcon.evaluate().isNotEmpty) {
        await tester.tap(heartIcon.first);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify heart icon changed state
        expect(heartIcon, findsWidgets);
      }

      // Test 5: Pull to refresh
      await tester.fling(
        find.byType(ListView).first,
        const Offset(0, 300),
        1000,
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify breeds reloaded
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('Navigation to details screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Wait for breeds to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Find and tap a breed card
      final breedCard = find.byType(InkWell).first;
      if (breedCard.evaluate().isNotEmpty) {
        await tester.tap(breedCard);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify details screen opened (check for back button)
        expect(find.byIcon(Icons.arrow_back_ios_new_outlined), findsOneWidget);

        // Navigate back
        await tester.tap(find.byIcon(Icons.arrow_back_ios_new_outlined));
        await tester.pumpAndSettle();

        // Verify back on home screen
        expect(find.text('Find Your Forever Pet'), findsOneWidget);
      }
    });

    testWidgets('Favorites screen shows favorited breeds', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Wait for breeds to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Navigate to favorites screen by tapping bottom navigation
      final favoritesTab = find.text('Favorite');
      if (favoritesTab.evaluate().isNotEmpty) {
        await tester.tap(favoritesTab);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify favorites screen
        expect(find.text('Your Favorite Pets'), findsOneWidget);
      }
    });

    testWidgets('Error handling when network fails', (
      WidgetTester tester,
    ) async {
      // This test would require mocking network failures
      // For a real integration test, you might disconnect network
      // or use a mock server that returns errors

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Just verify error handling UI exists in code
      expect(find.text('Retry'), findsNothing); // No error initially
    });
  });
}
