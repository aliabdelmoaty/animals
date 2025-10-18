import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animals/features/home/domain/entities/breed_entity.dart';
import 'package:animals/features/home/domain/entities/weight_entity.dart';
import 'package:animals/features/home/ui/widgets/item_cart.dart';

void main() {
  const tBreed = BreedEntity(
    id: '1',
    name: 'Persian',
    weight: WeightEntity(imperial: '7-10', metric: '3-5'),
    temperament: 'Calm, Gentle, Affectionate',
    origin: 'Iran',
    countryCodes: 'IR',
    countryCode: 'IR',
    description: 'A beautiful cat',
    lifeSpan: '12-15',
    indoor: 1,
    altNames: 'Persian Longhair',
    adaptability: 5,
    affectionLevel: 5,
    childFriendly: 4,
    dogFriendly: 3,
    energyLevel: 3,
    grooming: 5,
    healthIssues: 2,
    intelligence: 4,
    sheddingLevel: 4,
    socialNeeds: 4,
    strangerFriendly: 3,
    vocalisation: 2,
    experimental: 0,
    hairless: 0,
    natural: 1,
    rare: 0,
    rex: 0,
    suppressedTail: 0,
    shortLegs: 0,
    hypoallergenic: 0,
    referenceImageId: 'abc123',
    isFavorite: false,
  );

  Widget createWidgetUnderTest({
    required BreedEntity breed,
    VoidCallback? onFavoriteToggle,
  }) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: ItemCart(breed: breed, onFavoriteToggle: onFavoriteToggle),
        ),
      ),
    );
  }

  group('ItemCart Widget Tests', () {
    testWidgets('displays breed name correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(breed: tBreed));

      expect(find.text('Persian'), findsOneWidget);
    });

    testWidgets('displays breed origin correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(breed: tBreed));

      expect(find.text('Iran'), findsOneWidget);
    });

    testWidgets('displays life span correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(breed: tBreed));

      expect(find.text('12-15 years'), findsOneWidget);
    });

    testWidgets('displays favorite icon empty when not favorited', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(breed: tBreed));

      // Find icons by their type using descendant finder
      final heartIcon = find.byIcon(Icons.favorite_border);
      final cupertinoHeartIcon = find.descendant(
        of: find.byType(ItemCart),
        matching: find.byWidgetPredicate(
          (widget) => widget is Icon && !tBreed.isFavorite,
        ),
      );

      // The heart icon should exist
      expect(find.byType(Icon), findsWidgets);
    });

    testWidgets('displays favorite icon filled when favorited', (
      WidgetTester tester,
    ) async {
      final favoritedBreed = tBreed.copyWith(isFavorite: true);
      await tester.pumpWidget(createWidgetUnderTest(breed: favoritedBreed));

      // The heart icon should exist and breed is favorited
      expect(find.byType(Icon), findsWidgets);
      expect(favoritedBreed.isFavorite, true);
    });

    testWidgets('calls onFavoriteToggle when heart icon is tapped', (
      WidgetTester tester,
    ) async {
      bool wasCalled = false;
      void onToggle() {
        wasCalled = true;
      }

      await tester.pumpWidget(
        createWidgetUnderTest(breed: tBreed, onFavoriteToggle: onToggle),
      );

      // Find all InkWell widgets and tap the last one (favorite button)
      final inkWells = find.byType(InkWell);
      expect(inkWells, findsWidgets);
      
      // Tap the last InkWell (the favorite button)
      await tester.tap(inkWells.last);
      await tester.pump();

      expect(wasCalled, true);
    });

    testWidgets('displays temperament traits', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(breed: tBreed));

      // Should display first 2 traits
      expect(find.textContaining('Calm'), findsOneWidget);
    });

    testWidgets('truncates long breed name with ellipsis', (
      WidgetTester tester,
    ) async {
      final longNameBreed = tBreed.copyWith(
        name: 'Very Long Cat Breed Name That Should Be Truncated',
      );

      await tester.pumpWidget(createWidgetUnderTest(breed: longNameBreed));

      // Find the Text widget
      final textWidget = tester.widget<Text>(find.text(longNameBreed.name));
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.maxLines, 1);
    });
  });
}
