import 'package:riverpod_practise/logic.dart';
import 'package:test/test.dart';

void main() {
  Logic target = Logic();
  setUp(() async {
    target = Logic();
  });

  test('init', () async {
    expect(target.countDate.count, 0);
    expect(target.countDate.countUp, 0);
    expect(target.countDate.countDown, 0);
  });

  test('increase', () async {
    target.increase();
    expect(target.countDate.count, 1);
    expect(target.countDate.countUp, 1);
    expect(target.countDate.countDown, 0);

    target.increase();
    target.increase();
    target.increase();
    expect(target.countDate.count, 4);
    expect(target.countDate.countUp, 4);
    expect(target.countDate.countDown, 0);
  });

  test('decrease', () async {
    target.decrease();
    expect(target.countDate.count, -1);
    expect(target.countDate.countUp, 0);
    expect(target.countDate.countDown, 1);

    target.decrease();
    target.decrease();
    target.decrease();
    expect(target.countDate.count, -4);
    expect(target.countDate.countUp, 0);
    expect(target.countDate.countDown, 4);
  });

  test('reset', () async {
    expect(target.countDate.count, 0);
    expect(target.countDate.countUp, 0);
    expect(target.countDate.countDown, 0);

    target.increase();
    target.increase();
    target.decrease();
    expect(target.countDate.count, 1);
    expect(target.countDate.countUp, 2);
    expect(target.countDate.countDown, 1);

    target.reset();
    expect(target.countDate.count, 0);
    expect(target.countDate.countUp, 0);
    expect(target.countDate.countDown, 0);
  });
}
