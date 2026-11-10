import 'dart:collection';

import 'package:equatable/src/equatable_utils.dart';
import 'package:test/test.dart';

/// Tracks Map lookups without changing ordinary Map equality semantics.
class _TrackedMap<K, V> extends MapBase<K, V> {
  _TrackedMap(this._inner);

  final Map<K, V> _inner;
  int reads = 0;
  int containsQueries = 0;

  @override
  V? operator [](Object? key) {
    reads++;
    return _inner[key];
  }

  @override
  bool containsKey(Object? key) {
    containsQueries++;
    return _inner.containsKey(key);
  }

  @override
  void operator []=(K key, V value) => _inner[key] = value;

  @override
  void clear() => _inner.clear();

  @override
  Iterable<K> get keys => _inner.keys;

  @override
  V? remove(Object? key) => _inner.remove(key);
}

void main() {
  group('mapEquals lookups', () {
    test('uses one lookup per non-null entry of the other map', () {
      final ordinary = {
        for (var index = 0; index < 200; index++) index: index + 1,
      };
      final tracked = _TrackedMap<int, int>({...ordinary});

      expect(mapEquals(ordinary, tracked), isTrue);
      expect(tracked.reads, ordinary.length);
      expect(tracked.containsQueries, 0);
    });

    test('uses containsKey only for null entries', () {
      final left = <String, int?>{'a': 1, 'b': null, 'c': 3};
      final tracked = _TrackedMap<String, int?>({...left});

      expect(mapEquals(left, tracked), isTrue);
      expect(tracked.reads, left.length);
      expect(tracked.containsQueries, 1);
    });

    test('distinguishes absent keys from present nulls', () {
      expect(mapEquals({'a': null}, {'b': null}), isFalse);
      expect(mapEquals({'b': null}, {'a': null}), isFalse);
      expect(mapEquals({'a': null}, {'a': null}), isTrue);
    });

    test('rejects missing non-null keys', () {
      expect(mapEquals({'a': 1}, {'b': 2}), isFalse);
      expect(mapEquals({'b': 2}, {'a': 1}), isFalse);
    });

    test('preserves deep equality for map values', () {
      final left = {
        'numbers': [1, 2, 3],
        'nested': {'a': 1, 'b': 2},
      };
      final right = {
        'nested': {'b': 2, 'a': 1},
        'numbers': [1, 2, 3],
      };

      expect(mapEquals(left, right), isTrue);
      expect(mapEquals(right, left), isTrue);
      expect(mapEquals(left, {...right, 'extra': 1}), isFalse);
    });
  });
}
