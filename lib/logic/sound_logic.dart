import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_practise/data/count_data.dart';

class SoundLogic {
  static const soundDataUp = 'assets/sounds/bo-tto hidamari.mp3';
  static const soundDataDown = 'assets/sounds/husigityan o-ra.mp3';
  static const soundDataReset = 'assets/sounds/komorebi no nakade.mp3';

  // final AudioCache _cache = AudioCache();
  final player = AudioPlayer();

  // void load() {
  //   _cache.loadAll([soundDataUp, soundDataDown, soundDataReset]);
  // }

  void valueChanged(CountData oldValue, CountData newValue) {
    if (newValue.count == 0 &&
        newValue.countUp == 0 &&
        newValue.countDown == 0) {
      playResetSound();
    } else if (oldValue.countUp + 1 == newValue.countUp) {
      playUpSound();
    } else if (oldValue.countDown + 1 == newValue.countDown) {
      playDownSound();
    }
  }

  void playUpSound() {
    player.play(AssetSource("sounds/Onoma-Inspiration10-1(High).mp3"));
  }

  void playDownSound() {
    player.play(AssetSource("sounds/Onoma-Flash10-4(High-2).mp3"));
  }

  void playResetSound() {
    player.play(AssetSource("sounds/Onoma-Inspiration11-1(Low).mp3"));
  }
}
