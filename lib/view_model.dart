import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practise/logic.dart';
import 'package:riverpod_practise/provider.dart';

class ViewModel {
  final Logic _logic = Logic();

  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp =>
      _ref.watch(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  void onIncrease() {
    _logic.increase();
    _ref.read(countDataProvider.notifier).state = _logic.countDate;
  }

  void onDecrease() {
    _logic.decrease();
    _ref.read(countDataProvider.notifier).state = _logic.countDate;
  }

  void onReset() {
    _logic.reset();
    _ref.read(countDataProvider.notifier).state = _logic.countDate;
  }
}
