import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = Provider<String>((ref) {
  return 'riverpod demo page';
});

final bodyTextProvider = Provider<String>((ref) {
  return 'How many times did you press the button?';
});

final countProvider = StateProvider<int>((ref) => 0);
