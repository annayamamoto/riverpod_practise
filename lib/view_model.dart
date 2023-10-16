import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practise/data/count_data.dart';
import 'package:riverpod_practise/logic/logic.dart';
import 'package:riverpod_practise/logic/sound_logic.dart';
import 'package:riverpod_practise/provider.dart';

class ViewModel {
  final Logic _logic = Logic();
  final SoundLogic _soundLogic = SoundLogic();

  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  get count =>
      _ref
          .watch(countDataProvider)
          .count
          .toString();

  get countUp =>
      _ref.watch(countDataProvider.select((value) => value.countUp)).toString();

  get countDown =>
      _ref
          .watch(countDataProvider.select((value) => value.countDown))
          .toString();

  void onIncrease() {
    _logic.increase();
    update();
  }

  void onDecrease() {
    _logic.decrease();
    update();
  }

  void onReset() {
    _logic.reset();
    update();
  }

  void update() {
    CountData oldValue = _ref.watch(countDataProvider);

    _ref
        .read(countDataProvider.notifier)
        .state = _logic.countDate;
    CountData newValue = _ref.watch(countDataProvider);

    _soundLogic.valueChanged(oldValue, newValue);
  }
}
