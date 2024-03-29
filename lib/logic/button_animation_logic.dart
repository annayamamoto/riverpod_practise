import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:riverpod_practise/logic/count_data_changed_notifier.dart';

import '../data/count_data.dart';

class ButtonAnimationLogic extends CountDataChangedNotifier {
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<double> _animationRotation;

  late AnimationCombination _animationCombination;

  get animationScale => _animationScale;

  get animationRotation => _animationRotation;

  get animationCombination => _animationCombination;

  ValueChangedCondition startCondition;

  ButtonAnimationLogic(TickerProvider tickerProvider, this.startCondition) {
    _animationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 500));

    _animationScale = _animationController
        .drive(CurveTween(curve: const Interval(0.1, 0.7)))
        .drive(Tween(begin: 1.0, end: 1.8));

    _animationRotation = _animationController
        .drive(
            CurveTween(curve: Interval(0.4, 0.8, curve: ButtonRotateCurve())))
        .drive(Tween(begin: 0.0, end: 1.0));

    _animationCombination =
        AnimationCombination(animationRotation, animationScale);
  }

  @override
  void dispose() {
    _animationController.dispose();
  }

  void start() {
    _animationController.forward().whenComplete(
          () => _animationController.reset(),
        );
  }

  @override
  void valueChanged(CountData oldValue, CountData newValue) {
    if (startCondition(oldValue, newValue)) {
      start();
    }
  }
}

class ButtonRotateCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(2 * math.pi * t) / 8;
  }
}

class AnimationCombination {
  late final Animation<double> animationScale;
  late final Animation<double> animationRotation;

  AnimationCombination(this.animationRotation, this.animationScale);
}
