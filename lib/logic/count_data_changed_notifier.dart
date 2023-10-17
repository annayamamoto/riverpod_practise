import 'package:riverpod_practise/data/count_data.dart';

abstract class CountDataChangedNotifier {
  void valueChanged(CountData oldValue, CountData newValue);
}
