import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practise/data/count_data.dart';
import 'package:riverpod_practise/logic/button_animation_logic.dart';
import 'package:riverpod_practise/logic/count_data_changed_notifier.dart';
import 'package:riverpod_practise/logic/logic.dart';
import 'package:riverpod_practise/logic/sound_logic.dart';
import 'package:riverpod_practise/provider.dart';

class ViewModel {
  final Logic _logic = Logic();
  final SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _buttonAnimationLogicPlus;

  late WidgetRef _ref;

  List<CountDataChangedNotifier> notifiers = [];

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    _ref = ref;

    _buttonAnimationLogicPlus = ButtonAnimationLogic(tickerProvider);

    notifiers = [_soundLogic, _buttonAnimationLogicPlus];
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp =>
      _ref.watch(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  get animationPlus => _buttonAnimationLogicPlus.animationScale;

  void onIncrease() {
    _logic.increase();
    _buttonAnimationLogicPlus.start();
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

    _ref.read(countDataProvider.notifier).state = _logic.countDate;
    CountData newValue = _ref.watch(countDataProvider);

    notifiers.forEach((element) => element.valueChanged(oldValue, newValue));
  }
}
