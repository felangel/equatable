import 'package:equatable/src/equatable_utils.dart';
import 'package:test/test.dart';

void main() {
  group('iterableEquals collection kinds', () {
    test('compares sets independent of insertion order', () {
      expect(iterableEquals({1, 2, 3}, {3, 2, 1}), isTrue);
      expect(iterableEquals({1, 2, 3}, {1, 2, 4}), isFalse);
    });

    test('accepts identical and empty sets without an assertion', () {
      final sameSet = <Object?>{1, 2};
      expect(iterableEquals(sameSet, sameSet), isTrue);
      expect(iterableEquals(<int>{}, <int>{}), isTrue);
    });

    test('never equates a set with an ordered list', () {
      expect(iterableEquals(<int>{1, 2}, [1, 2]), isFalse);
      expect(iterableEquals([1, 2], <int>{1, 2}), isFalse);
    });

    test('never equates a set with a lazy iterable', () {
      final lazy = Iterable<int>.generate(2, (i) => i + 1);
      expect(iterableEquals(<int>{1, 2}, lazy), isFalse);
      expect(
        iterableEquals(Iterable<int>.generate(2, (i) => i + 1), <int>{1, 2}),
        isFalse,
      );
    });

    test('nested mixed sets and lists return false, not an assertion', () {
      expect(
        objectsEquals([
          <int>{1, 2},
        ], [
          [1, 2],
        ]),
        isFalse,
      );
      expect(
        objectsEquals([
          [1, 2],
        ], [
          <int>{1, 2},
        ]),
        isFalse,
      );
    });

    test('retains ordered equality between lists and lazy iterables', () {
      expect(
        iterableEquals([1, 2], Iterable<int>.generate(2, (i) => i + 1)),
        isTrue,
      );
      expect(
        iterableEquals(Iterable<int>.generate(2, (i) => i + 1), [2, 1]),
        isFalse,
      );
    });
  });
}
