import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practise/data/count_data.dart';

final titleProvider = Provider<String>((ref) {
  return 'riverpod demo page';
});

final bodyTextProvider = Provider<String>((ref) {
  return 'How many times did you press the button?';
});

final countProvider = StateProvider<int>((ref) => 0);

final countDataProvider = StateProvider<CountData>(
    (ref) => const CountData(count: 0, countUp: 0, countDown: 0));
