import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/features/hotels/presentation/widgets/widgets.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hotel_booking/main.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/core/di/injectable.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E Tests for Hotel Booking App', () {
    testWidgets('User searches for hotels and adds to favorites, Verifies favorite hotel is in favorites list, Removes favorite hotel from favorites list',
        (tester) async {
      Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
      configureDependencies();
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.hotel_outlined));
      await tester.pumpAndSettle();

      Finder searchField = find.byType(TextField);
      await tester.tap(searchField);
      await tester.enterText(searchField, 'New York');

      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.byType(CustomScrollView), findsOneWidget);

      expect(find.byType(HotelCard), findsWidgets);
      await tester.tap(find.byIcon(Icons.favorite_outline).first);
      await tester.pump(Duration(seconds: 2));
      await tester.pumpAndSettle();

      //cancel search results
      await tester.tap(find.byIcon(Icons.cancel_outlined));
      await tester.pump(Duration(seconds: 2));
      await tester.pumpAndSettle();

      //Verify favorite hotel is in favorites list
      await tester.tap(find.byIcon(Icons.favorite_outline));
      await tester.pumpAndSettle();
      expect(find.byType(HotelCard), findsOneWidget);

      //Remove favorite hotel from favorites list
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle();
      expect(find.byType(HotelCard), findsNothing);
    });
  });
}

