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
  late ButtonAnimationLogic _buttonAnimationLogicMinus;
  late ButtonAnimationLogic _buttonAnimationLogicReset;

  late WidgetRef _ref;

  List<CountDataChangedNotifier> notifiers = [];

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    _ref = ref;

    conditionPlus(CountData oldValue, CountData newValue) {
      return oldValue.countUp + 1 == newValue.countUp;
    }

    _buttonAnimationLogicPlus =
        ButtonAnimationLogic(tickerProvider, conditionPlus);

    _buttonAnimationLogicMinus =
        ButtonAnimationLogic(tickerProvider, (oldValue, newValue) {
      return oldValue.countDown + 1 == newValue.countDown;
    });
    _buttonAnimationLogicReset = ButtonAnimationLogic(
      tickerProvider,
      (oldValue, newValue) => newValue.countUp == 0 && newValue.countDown == 0,
    );

    notifiers = [
      _soundLogic,
      _buttonAnimationLogicPlus,
      _buttonAnimationLogicMinus,
      _buttonAnimationLogicReset
    ];
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp =>
      _ref.watch(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  get animationPlusCombination =>
      _buttonAnimationLogicPlus.animationCombination;

  get animationMinusCombination =>
      _buttonAnimationLogicMinus.animationCombination;

  get animationResetCombination =>
      _buttonAnimationLogicReset.animationCombination;

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

    for (var element in notifiers) {
      element.valueChanged(oldValue, newValue);
    }
  }
}
