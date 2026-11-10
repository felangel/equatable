// ignore_for_file: prefer_const_constructors
// Identity-Set tests require fresh, noncanonical object instances.
import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:equatable/src/equatable_utils.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

@immutable
class _MeasuredValue {
  const _MeasuredValue(this.value);

  final int value;
  static int comparisons = 0;

  @override
  bool operator ==(Object other) {
    comparisons++;
    return other is _MeasuredValue && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

class _SetBox extends Equatable {
  const _SetBox(this.contents);

  final Set<Object?> contents;

  @override
  List<Object?> get props => [contents];
}

void main() {
  group('set equality', () {
    test('checks flat sets with native hash lookups', () {
      final a = <_MeasuredValue>{
        for (var i = 0; i < 200; i++) _MeasuredValue(i),
      };
      final b = <_MeasuredValue>{
        for (var i = 199; i >= 0; i--) _MeasuredValue(i),
      };
      _MeasuredValue.comparisons = 0;

      expect(setEquals(a, b), isTrue);
      expect(_MeasuredValue.comparisons, lessThan(1000));
    });

    test('rejects different flat sets without quadratic matching', () {
      final a = <_MeasuredValue>{
        for (var i = 0; i < 200; i++) _MeasuredValue(i),
      };
      final b = <_MeasuredValue>{
        for (var i = 1; i <= 200; i++) _MeasuredValue(i),
      };
      _MeasuredValue.comparisons = 0;

      expect(setEquals(a, b), isFalse);
      expect(_MeasuredValue.comparisons, lessThan(1000));
    });

    test('preserves value equality for identity-based sets', () {
      final left = <_MeasuredValue>{
        _MeasuredValue(1),
        _MeasuredValue(2),
      };
      // Distinct non-const instances make identity lookup miss, exercising
      // the required structural fallback.
      final right = Set<_MeasuredValue>.identity()
        ..addAll([
          _MeasuredValue(2),
          _MeasuredValue(1),
        ]);

      expect(setEquals(left, right), isTrue);
      expect(setEquals(right, left), isTrue);
    });

    test('does not reuse a native-lookup match from an identity set', () {
      final left = Set<_MeasuredValue>.identity()
        ..addAll([
          _MeasuredValue(1),
          _MeasuredValue(1),
        ]);
      final right = <_MeasuredValue>{
        _MeasuredValue(1),
        _MeasuredValue(2),
      };

      expect(setEquals(left, right), isFalse);
      expect(setEquals(right, left), isFalse);
    });

    test('does not accept matches from a broader custom comparator', () {
      final left = <String>{'a', 'b'};
      final right = SplayTreeSet<String>(
        (a, b) => a.toLowerCase().compareTo(b.toLowerCase()),
      )..addAll(['A', 'B']);

      expect(setEquals(left, right), isFalse);
      expect(setEquals(right, left), isFalse);
    });

    test('falls back when a narrower comparator rejects equal values', () {
      final left = <num>{1, 2};
      final right = SplayTreeSet<num>((a, b) {
        final byValue = a.compareTo(b);
        return byValue != 0
            ? byValue
            : a.runtimeType.toString().compareTo(b.runtimeType.toString());
      })
        ..addAll([1.0, 2.0]);

      expect(setEquals(left, right), isTrue);
      expect(setEquals(right, left), isTrue);
    });

    test('does not match the same structural list twice', () {
      final left = <Object>{
        [1],
        [1],
      };
      final right = <Object>{
        [1],
        [2],
      };
      expect(setEquals(left, right), isFalse);
      expect(setEquals(right, left), isFalse);
      expect(_SetBox(left) == _SetBox(right), isFalse);
    });

    test('supports duplicate-looking nested collections bijectively', () {
      final left = <Object>{
        [1],
        [1],
      };
      final right = <Object>{
        [1],
        [1],
      };
      expect(setEquals(left, right), isTrue);
      expect(setEquals(right, left), isTrue);
    });

    test('compares nested sets and maps regardless of insertion order', () {
      final left = <Object>{
        {
          'a': [1, 2],
          'b': 3,
        },
        <Object>{
          [4],
          [5],
        },
      };
      final right = <Object>{
        <Object>{
          [5],
          [4],
        },
        {
          'b': 3,
          'a': [1, 2],
        },
      };
      expect(setEquals(left, right), isTrue);
      expect(setEquals(right, left), isTrue);
    });

    test('empty and different-size sets still use fast exits', () {
      expect(setEquals(<Object>{}, <Object>{}), isTrue);
      expect(setEquals(<Object>{1}, <Object>{}), isFalse);
    });
  });
}
