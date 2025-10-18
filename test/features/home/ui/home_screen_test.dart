import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animals/features/home/domain/entities/breed_entity.dart';
import 'package:animals/features/home/domain/entities/weight_entity.dart';
import 'package:animals/features/home/presentation/cubit/breeds_cubit.dart';
import 'package:animals/features/home/presentation/cubit/breeds_state.dart';
import 'package:animals/features/home/ui/home_screen.dart';

class MockBreedsCubit extends MockCubit<BreedsState> implements BreedsCubit {}

void main() {
  late MockBreedsCubit mockCubit;

  setUp(() {
    mockCubit = MockBreedsCubit();
  });

  final tBreeds = [
    const BreedEntity(
      id: '1',
      name: 'Persian',
      weight: WeightEntity(imperial: '7-10', metric: '3-5'),
      temperament: 'Calm, Gentle',
      origin: 'Iran',
      countryCodes: 'IR',
      countryCode: 'IR',
      description: 'A beautiful cat',
      lifeSpan: '12-15',
      indoor: 1,
      altNames: '',
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
    ),
  ];

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        home: BlocProvider<BreedsCubit>.value(
          value: mockCubit,
          child: Scaffold(
            body: const HomeScreenContent(),
          ),
        ),
      ),
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('shows loading indicator when state is BreedsLoading', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockCubit,
        Stream.fromIterable([const BreedsLoading()]),
        initialState: const BreedsLoading(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows breeds list when state is BreedsLoaded', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockCubit,
        Stream.fromIterable([
          BreedsLoaded(
            breeds: tBreeds,
            hasMore: false,
            currentPage: 0,
            favoriteImageIds: const [],
          ),
        ]),
        initialState: BreedsLoaded(
          breeds: tBreeds,
          hasMore: false,
          currentPage: 0,
          favoriteImageIds: const [],
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Use pump() instead of pumpAndSettle() for widgets with network images

      expect(find.text('Persian'), findsOneWidget);
    });

    testWidgets('shows error message when state is BreedsError', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockCubit,
        Stream.fromIterable([const BreedsError('Network error')]),
        initialState: const BreedsError('Network error'),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('shows empty state when breeds list is empty', (
      WidgetTester tester,
    ) async {
      whenListen(
        mockCubit,
        Stream.fromIterable([
          const BreedsLoaded(
            breeds: [],
            hasMore: false,
            currentPage: 0,
            favoriteImageIds: [],
          ),
        ]),
        initialState: const BreedsLoaded(
          breeds: [],
          hasMore: false,
          currentPage: 0,
          favoriteImageIds: [],
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('No breeds found'), findsOneWidget);
    });

    testWidgets('displays search field', (WidgetTester tester) async {
      whenListen(
        mockCubit,
        Stream.fromIterable([const BreedsInitial()]),
        initialState: const BreedsInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
