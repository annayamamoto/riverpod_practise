import 'package:riverpod_practise/data/count_data.dart';

typedef ValueChangedCondition = bool Function(
    CountData oldValue, CountData newValue);

abstract class CountDataChangedNotifier {
  void valueChanged(CountData oldValue, CountData newValue);
}
