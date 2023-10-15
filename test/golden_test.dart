import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_practise/main.dart';
import 'package:riverpod_practise/view_model.dart';

class MockViewModel extends Mock implements ViewModel {}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  const iPhone55 =
      Device(size: Size(414, 736), devicePixelRatio: 3.0, name: 'iPhone55');
  List<Device> devices = [iPhone55];

  testGoldens(
    'nomal',
    (tester) async {
      ViewModel viewModel = ViewModel();
      await tester.pumpWidgetBuilder(
        ProviderScope(
          child: MyHomePage(viewModel),
        ),
      );

      await multiScreenGolden(tester, 'myHomePage_0init', devices: devices);

      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.horizontal_rule));
      await tester.pump();

      await multiScreenGolden(tester, 'myHomePage_1tapped', devices: devices);
    },
  );

  testGoldens('viewModelTest', (tester) async {
    var mock = MockViewModel();
    when(() => mock.count).thenReturn(1123456789.toString());
    when(() => mock.countUp).thenReturn(2123456789.toString());
    when(() => mock.countDown).thenReturn(3123456789.toString());

    // final mockTitleProvider = Provider<String>((ref) => 'mockTitle');
    final mockMessageProvider = Provider<String>((ref) => 'mockMessage');

    await tester.pumpWidgetBuilder(ProviderScope(
      child: MyHomePage(mock),
      overrides: [
        // titleProvider.overrideWithProvider(mockTitleProvider),
        mockMessageProvider.overrideWithValue('mockMessage'),
      ],
    ));

    await multiScreenGolden(tester, 'myHomePage_mock', devices: devices);

    verifyNever(() => mock.onIncrease());
    verifyNever(() => mock.onDecrease());
    verifyNever(() => mock.onReset());

    await tester.tap(find.byIcon(Icons.add));
    verify(() => mock.onIncrease()).called(1);
    verifyNever(() => mock.onDecrease());
    verifyNever(() => mock.onReset());

    await tester.tap(find.byIcon(Icons.horizontal_rule));
    await tester.tap(find.byIcon(Icons.horizontal_rule));
    verifyNever(() => mock.onIncrease());
    verify(() => mock.onDecrease()).called(2);
    verifyNever(() => mock.onReset());

    await tester.tap(find.byIcon(Icons.refresh));
    verifyNever(() => mock.onIncrease());
    verifyNever(() => mock.onDecrease());
    verify(() => mock.onReset()).called(1);
  });
}
