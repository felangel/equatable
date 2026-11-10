// Distinct fixtures exercise deep equality instead of identity.
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:equatable/src/equatable_utils.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

class _Box extends Equatable {
  const _Box(this.value);

  final Object? value;

  @override
  List<Object?> get props => [value];
}

@immutable
class _CollidingKey {
  const _CollidingKey(this.id);

  final int id;

  @override
  bool operator ==(Object other) => other is _CollidingKey && other.id == id;

  @override
  int get hashCode => 1;
}

@immutable
class _CollidingIterable extends IterableBase<int> {
  const _CollidingIterable(this.values);

  final List<int> values;

  @override
  Iterator<int> get iterator => values.iterator;

  @override
  bool operator ==(Object other) =>
      other is _CollidingIterable && identical(this, other);

  @override
  int get hashCode => 7;
}

class _FlaggedIterable extends IterableBase<int> with Equatable {
  _FlaggedIterable(this.values, {required this.flag});

  final bool flag;
  final List<int> values;

  @override
  Iterator<int> get iterator => values.iterator;

  @override
  List<Object?> get props => [flag];
}

@immutable
class _NativeEqualityIterable extends IterableBase<int> {
  const _NativeEqualityIterable(this.key, this.values);

  final int key;
  final List<int> values;

  @override
  Iterator<int> get iterator => values.iterator;

  @override
  bool operator ==(Object other) =>
      other is _NativeEqualityIterable && other.key == key;

  @override
  int get hashCode => key.hashCode;
}

@immutable
class _PermissiveValue {
  const _PermissiveValue();

  @override
  bool operator ==(Object other) => other is _Box || other is _PermissiveValue;

  @override
  int get hashCode => 0;
}

void main() {
  test('Equatable vs non-Equatable is false in both directions', () {
    final equatable = _Box('value');
    const other = _PermissiveValue();

    expect(objectsEquals(equatable, other), isFalse);
    expect(objectsEquals(other, equatable), isFalse);
    expect(_Box(equatable), isNot(_Box(other)));
    expect(_Box(other), isNot(_Box(equatable)));
  });

  group('unordered collection hashing', () {
    test('maps with colliding key hashes are insertion-order independent', () {
      final left = _Box({
        const _CollidingKey(1): 'first',
        const _CollidingKey(2): 'second',
      });
      final right = _Box({
        const _CollidingKey(2): 'second',
        const _CollidingKey(1): 'first',
      });

      expect(left, right);
      expect(left.hashCode, right.hashCode);
    });

    test('all insertion-order rotations keep deep Map hashes identical', () {
      final reference = _Box(<_CollidingKey, List<int>>{
        for (var i = 0; i < 6; i++) _CollidingKey(i): [i, i + 1],
      });

      for (var rotation = 0; rotation < 6; rotation++) {
        final values = <_CollidingKey, List<int>>{};
        for (var offset = 0; offset < 6; offset++) {
          final key = (rotation + offset) % 6;
          values[_CollidingKey(key)] = [key, key + 1];
        }
        final candidate = _Box(values);
        expect(candidate, reference);
        expect(candidate.hashCode, reference.hashCode);
      }
    });

    test('records containing equal num values retain hash consistency', () {
      final integer = _Box((value: 1, label: 'record'));
      final decimal = _Box((value: 1.0, label: 'record'));

      expect(integer, decimal);
      expect(integer.hashCode, decimal.hashCode);
    });

    test('sets of structurally equal iterables hash identically', () {
      final left = _Box(<Object>{
        _CollidingIterable([1, 2]),
        _CollidingIterable([3, 4]),
      });
      final right = _Box(<Object>{
        _CollidingIterable([3, 4]),
        _CollidingIterable([1, 2]),
      });

      expect(left, right);
      expect(left.hashCode, right.hashCode);
    });

    test('nested maps and sets preserve equality/hash consistency', () {
      final left = _Box({
        'a': <Object>{
          [1, 2],
          [3, 4],
        },
        'b': {
          'x': [5, 6],
        },
      });
      final right = _Box({
        'b': {
          'x': [5, 6],
        },
        'a': <Object>{
          [3, 4],
          [1, 2],
        },
      });

      expect(left, right);
      expect(left.hashCode, right.hashCode);
    });

    test('native-equal map keys use their native hash, not iterable data', () {
      final left = _Box({
        _NativeEqualityIterable(1, [10]): 'value',
      });
      final right = _Box({
        _NativeEqualityIterable(1, [20]): 'value',
      });

      expect(left, right);
      expect(left.hashCode, right.hashCode);
    });

    test('different map values do not compare equal', () {
      expect(
        _Box({const _CollidingKey(1): 'first'}),
        isNot(_Box({const _CollidingKey(1): 'second'})),
      );
    });
  });

  group('collection kind and Equatable precedence', () {
    test('set is not equal to ordered list even with the same elements', () {
      expect(objectsEquals(<int>{1, 2}, <int>[1, 2]), isFalse);
      expect(objectsEquals(<int>[1, 2], <int>{1, 2}), isFalse);
    });

    test('Equatable iterable honors props, not only iterator values', () {
      final first = _FlaggedIterable([1, 2], flag: true);
      final second = _FlaggedIterable([1, 2], flag: false);

      expect(objectsEquals(first, second), isFalse);
      expect(_Box(first), isNot(_Box(second)));
    });

    test('Equatable iterable vs plain iterable is not structurally equal', () {
      final wrapped = _FlaggedIterable([1, 2], flag: true);
      expect(objectsEquals(wrapped, [1, 2]), isFalse);
      expect(objectsEquals([1, 2], wrapped), isFalse);
    });

    test('Equatable iterables with equal props get equal wrapper hashes', () {
      final first = _FlaggedIterable([1, 2], flag: true);
      final second = _FlaggedIterable([9, 9], flag: true);
      expect(first, second);
      expect(_Box(first), _Box(second));
      expect(_Box(first).hashCode, _Box(second).hashCode);
    });
  });
}
