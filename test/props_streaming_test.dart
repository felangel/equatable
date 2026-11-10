import 'dart:collection';

import 'package:equatable/src/equatable_utils.dart';
import 'package:test/test.dart';

class _StringifiedProps {}

class _ObservedValue {
  _ObservedValue(this.text);

  final String text;
  int calls = 0;

  @override
  String toString() {
    calls++;
    return text;
  }
}

class _MutatingValue {
  _MutatingValue(this.values);

  final List<Object?> values;

  @override
  String toString() {
    values.removeLast();
    return 'changed';
  }
}

class _SingleTraversal extends IterableBase<Object?> {
  _SingleTraversal(this.values);

  final List<Object?> values;
  int iteratorRequests = 0;

  @override
  Iterator<Object?> get iterator {
    iteratorRequests++;
    if (iteratorRequests != 1) {
      throw StateError('More than one props traversal');
    }
    return values.iterator;
  }
}

void main() {
  group('props hash traversal', () {
    test('null props and empty props retain the same hash', () {
      expect(mapPropsToHashCode(null), mapPropsToHashCode([]));
    });

    test('reads a generic props iterable only once', () {
      final props = _SingleTraversal([1, 'two', true, null]);
      final expected = mapPropsToHashCode([1, 'two', true, null]);

      expect(mapPropsToHashCode(props), expected);
      expect(props.iteratorRequests, 1);
    });

    test('preserves nested list and map hashing', () {
      final left = <Object?>[
        [1, 2, 3],
        {
          'a': [4, 5],
        },
      ];
      final right = <Object?>[
        [1, 2, 3],
        {
          'a': [4, 5],
        },
      ];
      expect(mapPropsToHashCode(left), mapPropsToHashCode(right));
    });
  });

  group('props stringify', () {
    test('preserves exact spacing, null and nested collection output', () {
      expect(
        mapPropsToString(_StringifiedProps, [
          1,
          null,
          'abc',
          [2, 3],
        ]),
        '_StringifiedProps(1, null, abc, [2, 3])',
      );
      expect(mapPropsToString(_StringifiedProps, []), '_StringifiedProps()');
    });

    test('calls custom toString exactly once for each prop', () {
      final first = _ObservedValue('first');
      final second = _ObservedValue('second');

      expect(
        mapPropsToString(_StringifiedProps, [first, second]),
        '_StringifiedProps(first, second)',
      );
      expect(first.calls, 1);
      expect(second.calls, 1);
    });

    test('supports large props without intermediate joined strings', () {
      final values = List<int>.generate(2000, (i) => i);
      final result = mapPropsToString(_StringifiedProps, values);

      expect(result.startsWith('_StringifiedProps(0, 1, 2, '), isTrue);
      expect(result.endsWith(', 1999)'), isTrue);
      expect(result.split(', ').length, 2000);
    });

    test('retains concurrent modification detection during toString', () {
      final values = <Object?>[];
      values.addAll([_MutatingValue(values), 'last']);

      expect(
        () => mapPropsToString(_StringifiedProps, values),
        throwsConcurrentModificationError,
      );
    });
  });
}
