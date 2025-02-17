import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking/core/di/injectable.dart';
import 'package:hotel_booking/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:hotel_booking/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:hotel_booking/features/favorites/presentation/pages/favorites_page.dart';
import 'package:hotel_booking/features/hotels/domain/entities/hotel.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late MockFavoritesRepository mockFavoritesRepository;

  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoritesPage Widget Tests', () {
    setUp(() async {
      mockFavoritesRepository = MockFavoritesRepository();
      getIt.registerSingleton<FavoritesRepository>(mockFavoritesRepository);

      mockMethodChannel();
      Hive.defaultDirectory = '/data/user/0/com.example.hotel_booking/cache';
    });

    testWidgets('Favorites page should render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => FavoritesBloc(
                getFavoritesUseCase: getIt(),
                watchFavoritesUseCase: getIt(),
                addFavoriteUseCase: getIt(),
                removeFavoriteUseCase: getIt(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: FavoritesPage(),
          ),
        ),
      );

      expect(find.byType(FavoritesPage), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });
    testWidgets(
        'Verify that favorited hotels appear in the users favorites list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => FavoritesBloc(
                getFavoritesUseCase: getIt(),
                watchFavoritesUseCase: getIt(),
                addFavoriteUseCase: getIt(),
                removeFavoriteUseCase: getIt(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: FavoritesPage(),
          ),
        ),
      );

      // Initially empty
      expect(find.byType(ListView), findsNothing);

      // Add a favorite hotel by tapping the icon
      await tester.tap(find.byIcon(Icons.favorite_outline).first);
      await tester.pumpAndSettle();

      // Verify hotel appears in list
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('Verify ability to favorite multiple hotels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => FavoritesBloc(
                getFavoritesUseCase: getIt(),
                watchFavoritesUseCase: getIt(),
                addFavoriteUseCase: getIt(),
                removeFavoriteUseCase: getIt(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: FavoritesPage(),
          ),
        ),
      );

      // Initially empty
      expect(find.byType(ListView), findsNothing);

      // Add multiple favorite hotels by tapping icons
      await tester.tap(find.byIcon(Icons.favorite_outline).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.favorite_outline).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.favorite_outline).first);
      await tester.pumpAndSettle();

      // Verify multiple hotels appear
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNWidgets(3));
    });

    testWidgets(
        'Verify that unfavorited hotels no longer show favorite indication',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => FavoritesBloc(
                getFavoritesUseCase: getIt(),
                watchFavoritesUseCase: getIt(),
                addFavoriteUseCase: getIt(),
                removeFavoriteUseCase: getIt(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: FavoritesPage(),
          ),
        ),
      );

      // Add a favorite hotel by tapping icon
      await tester.tap(find.byIcon(Icons.favorite_outline).first);
      await tester.pumpAndSettle();

      // Verify hotel is favorited
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);

      // Remove from favorites by tapping favorite icon
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle();

      // Verify hotel is removed
      expect(find.byType(ListView), findsNothing);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}
