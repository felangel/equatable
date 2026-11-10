import 'dart:collection';

import 'package:equatable/src/equatable_utils.dart';
import 'package:test/test.dart';

/// An Iterable that can only be traversed once and cannot use indexed access.
class _SinglePassIterable extends IterableBase<int> {
  _SinglePassIterable(this.values);

  final List<int> values;
  int iteratorRequests = 0;

  @override
  Iterator<int> get iterator {
    iteratorRequests++;
    if (iteratorRequests != 1) {
      throw StateError('Iterable was traversed more than once');
    }
    return values.iterator;
  }

  @override
  int get length => throw StateError('length must not be requested');

  @override
  int elementAt(int index) => throw StateError('elementAt must not be called');
}

void main() {
  group('generic Iterable traversal', () {
    test('compares non-list iterables in one pass', () {
      final left = _SinglePassIterable([1, 2, 3, 4]);
      final right = _SinglePassIterable([1, 2, 3, 4]);

      expect(iterableEquals(left, right), isTrue);
      expect(left.iteratorRequests, 1);
      expect(right.iteratorRequests, 1);
    });

    test('detects longer and shorter non-list iterables', () {
      expect(
        iterableEquals(
          _SinglePassIterable([1, 2]),
          _SinglePassIterable([1, 2, 3]),
        ),
        isFalse,
      );
      expect(
        iterableEquals(
          _SinglePassIterable([1, 2, 3]),
          _SinglePassIterable([1, 2]),
        ),
        isFalse,
      );
    });

    test('detects mismatched values before the end', () {
      expect(
        iterableEquals(
          _SinglePassIterable([1, 2, 3]),
          _SinglePassIterable([1, 9, 3]),
        ),
        isFalse,
      );
    });

    test('preserves list equality and ordered semantics', () {
      expect(iterableEquals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(iterableEquals([1, 2, 3], [3, 2, 1]), isFalse);
      expect(iterableEquals([1, 2, 3], [1, 2]), isFalse);
    });

    test('hashing does not traverse lazy Iterables twice', () {
      final iterable = _SinglePassIterable([1, 2, 3]);
      expect(
        mapPropsToHashCode([iterable]),
        mapPropsToHashCode([
          [1, 2, 3],
        ]),
      );
      expect(iterable.iteratorRequests, 1);
    });
  });
}
