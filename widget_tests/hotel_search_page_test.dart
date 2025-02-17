import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/core/models/paginated_response.dart';
import 'package:hotel_booking/features/hotels/domain/entities/hotel.dart';
import 'package:hotel_booking/features/hotels/domain/entities/location.dart';
import 'package:hotel_booking/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:hotel_booking/features/hotels/domain/usecases/fetch_hotels_usecase.dart';
import 'package:hotel_booking/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:hotel_booking/features/hotels/presentation/pages/hotels_page.dart';
import 'package:hotel_booking/core/di/injectable.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hotel_booking/features/hotels/domain/entities/search_params.dart';

class MockHotelsRepository extends Mock implements HotelsRepository {}

void main() {
  late MockHotelsRepository mockHotelsRepository;

  setUp(() async {
    mockHotelsRepository = MockHotelsRepository();

    when(() => mockHotelsRepository.fetchHotels(params: any(named: 'params')))
        .thenAnswer((_) =>
            Future.value(PaginatedResponse(items: [], nextPageToken: null)));

    getIt.registerSingleton<HotelsRepository>(mockHotelsRepository);

    when(() => mockHotelsRepository.fetchHotels(
            params: SearchParams(
          query: 'New York',
          checkInDate: DateTime.now(),
          checkOutDate: DateTime.now().add(const Duration(days: 1)),
        ))).thenAnswer((_) async {
      return PaginatedResponse<Hotel>(
        items: [
          Hotel(
            name: 'Hotel 1',
            location: Location(
              latitude: 1.0,
              longitude: 1.0,
            ),
            description: "testing",
          ),
          Hotel(
            name: 'Hotel 2',
            location: Location(
              latitude: 2.0,
              longitude: 2.0,
            ),
            description: "testing",
          ),
        ],
        nextPageToken: null,
      );
    });
  });

  setUpAll(() {
    registerFallbackValue(
      SearchParams(
        checkInDate: DateTime.now(),
        checkOutDate: DateTime.now().add(const Duration(days: 1)),
        query: 'New York',
      ),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  group('HotelSearchPage Widget Tests', () {
    testWidgets('Search field should update on input',
        (WidgetTester tester) async {
      Hive.defaultDirectory =
          '/data/user/0/com.iffat.hotel_booking/app_flutter';

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HotelsBloc(
                  fetchHotelsUseCase: FetchHotelsUseCase(
                hotelsRepository: mockHotelsRepository,
              )),
            ),
          ],
          child: const MaterialApp(
            home: HotelsPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);

      await tester.enterText(searchField, 'New York');
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 10));
      expect(find.text('Hotel 1'), findsNothing);
    });

    testWidgets(
        'Verify that search results display correctly with hotels names',
        (WidgetTester tester) async {
      Hive.defaultDirectory =
          '/data/user/0/com.iffat.hotel_booking/app_flutter';

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HotelsBloc(
                  fetchHotelsUseCase: FetchHotelsUseCase(
                hotelsRepository: mockHotelsRepository,
              )),
            ),
          ],
          child: const MaterialApp(
            home: HotelsPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final searchField = find.byType(TextField);

      await tester.enterText(searchField, 'New York');
      await tester.pumpAndSettle();

      // Verify hotel names appear in results
      expect(find.text('Hotel 1'), findsOneWidget);
      expect(find.text('Hotel 2'), findsOneWidget);
    });
  });
}
