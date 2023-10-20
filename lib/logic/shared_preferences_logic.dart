import 'package:riverpod_practise/data/count_data.dart';
import 'package:riverpod_practise/logic/count_data_changed_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLogic extends CountDataChangedNotifier {
  static const kayCount = 'COUNT';
  static const kayCountDown = 'COUNT_DOWN';
  static const kayCountUp = 'COUNT_UP';

  @override
  void valueChanged(CountData oldValue, CountData newValue) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(kayCount, newValue.count);
    sharedPreferences.setInt(kayCountDown, newValue.countDown);
    sharedPreferences.setInt(kayCountUp, newValue.countUp);
  }

  static Future<CountData> read() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return CountData(
        count: sharedPreferences.getInt(kayCount) ?? 0,
        countUp: sharedPreferences.getInt(kayCountUp) ?? 0,
        countDown: sharedPreferences.getInt(kayCountDown) ?? 0);
  }
}
