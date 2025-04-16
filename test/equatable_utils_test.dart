import 'package:equatable/equatable.dart';
import 'package:equatable/src/equatable_utils.dart';
import 'package:test/test.dart' hide equals;

class Person with EquatableMixin {
  Person({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

extension IterableConverter<T> on Iterable<T> {
  Iterable<T> toIterable() => map((e) => e);
}

void main() {
  final bob = Person(name: 'Bob');
  final alice = Person(name: 'Alice');
  final aliceCopy = Person(name: 'Alice');

  group('equals', () {
    test('returns true when both are null', () {
      expect(equals(null, null), isTrue);
    });

    test('returns false when one is null', () {
      expect(equals(null, []), isFalse);
      expect(equals([], null), isFalse);
    });
  });

  group('iterableEquals', () {
    test('returns true for identical props', () {
      final value = [Object()];
      expect(iterableEquals(value, value), isTrue);
      expect(iterableEquals(value.toSet(), value.toSet()), isTrue);
      expect(iterableEquals(value.toIterable(), value.toIterable()), isTrue);
      expect(equals(value, value), isTrue);
    });

    test('returns true for empty iterables', () {
      expect(iterableEquals([], []), isTrue);
      expect(iterableEquals({}, {}), isTrue);
      // ignore: prefer_const_constructors
      expect(iterableEquals(Iterable.empty(), Iterable.empty()), isTrue);
      expect(equals([], []), isTrue);
    });

    test('returns false when props differ in length', () {
      final object = Object();
      expect(iterableEquals([object], [object, object]), isFalse);
      expect(iterableEquals({object}, {object, null}), isFalse);
      expect(
        iterableEquals([object].toIterable(), [object, object].toIterable()),
        isFalse,
      );
      expect(equals([object], [object, object]), isFalse);
    });

    test('returns false when comparing a List to a non-List Iterable', () {
      final list = [Object()];
      expect(iterableEquals(list, list.toSet()), isFalse);
      expect(iterableEquals(list, list.toIterable()), isFalse);
    });

    test('returns false when comparing a Set to a non-Set Iterable', () {
      final set = {Object()};
      expect(iterableEquals(set, set.toList()), isFalse);
      expect(iterableEquals(set, set.toIterable()), isFalse);
    });

    test('returns false when comparing a Iterable to a Set or a List', () {
      final iterable = Iterable.generate(1, (_) => Object());
      expect(iterableEquals(iterable, iterable.toList()), isFalse);
      expect(iterableEquals(iterable, iterable.toSet()), isFalse);
    });

    test('returns false when comparing a List to a non-List Iterable', () {
      final object = Object();
      expect(iterableEquals([object], {object}), isFalse);
      expect(iterableEquals([object], [object].toIterable()), isFalse);
    });

    test('uses == when props are equatable', () {
      expect(iterableEquals([alice], [aliceCopy]), isTrue);
      expect(iterableEquals([bob], [bob]), isTrue);
      expect(iterableEquals([alice], [bob]), isFalse);
      expect(iterableEquals([bob], [alice]), isFalse);
      expect(iterableEquals([alice, null], [alice, -1]), isFalse);

      expect(equals([alice], [aliceCopy]), isTrue);
      expect(equals([bob], [bob]), isTrue);
      expect(equals([alice], [bob]), isFalse);
      expect(equals([bob], [alice]), isFalse);
      expect(equals([alice, null], [alice, -1]), isFalse);
    });

    test('returns false for iterables with different elements', () {
      final iterable1 = [1, 2, 3];
      final iterable2 = [1, 2, 4];
      expect(iterableEquals(iterable1, iterable2), isFalse);
      expect(iterableEquals(iterable1.toSet(), iterable2.toSet()), isFalse);
      expect(
        iterableEquals(iterable1.toIterable(), iterable2.toIterable()),
        isFalse,
      );
      expect(equals(iterable1, iterable2), isFalse);
    });

    test('returns false for iterable with same elements '
        'but different order', () {
      final iterable1 = [1, 2, 3];
      final iterable2 = [1, 3, 2];
      expect(iterableEquals(iterable1, iterable2), isFalse);
      expect(equals(iterable1, iterable2), isFalse);
    });

    test('returns true for nested identical iterables', () {
      final list1 = [
        [bob, alice],
        [alice, bob],
      ];
      final list2 = [
        [bob, alice],
        [alice, bob],
      ];
      expect(iterableEquals(list1, list2), isTrue);
      expect(iterableEquals(list1.toSet(), list2.toSet()), isTrue);
      expect(iterableEquals(list1.toIterable(), list2.toIterable()), isTrue);
      expect(equals(list1, list2), isTrue);
    });

    test('returns false for nested iterables with different elements', () {
      final list1 = [
        [bob, 2],
        [3, 4],
      ];
      final list2 = [
        [bob, 2],
        [3, 5],
      ];
      expect(iterableEquals(list1, list2), isFalse);
      expect(iterableEquals(list1.toSet(), list2.toSet()), isFalse);
      expect(iterableEquals(list1.toIterable(), list2.toIterable()), isFalse);
      expect(equals(list1, list2), isFalse);
    });
  });

  group('setEquals', () {
    test('returns true for identical sets', () {
      final set1 = {1, 2, 3};
      final set2 = {1, 2, 3};
      expect(setEquals(set1, set2), isTrue);
    });

    test(
      'returns true for identical sets with elements in different order',
      () {
        final set1 = {1, 3, 2};
        final set2 = {1, 2, 3};
        expect(setEquals(set1, set2), isTrue);
      },
    );

    test('returns false for sets of different lengths', () {
      final set1 = {1, 2, 3};
      final set2 = {1, 2};
      expect(setEquals(set1, set2), isFalse);
    });

    test('returns false for sets with different elements', () {
      final set1 = {1, 2, 3};
      final set2 = {1, 2, 4};
      expect(setEquals(set1, set2), isFalse);
    });

    test('uses == when props are equatable', () {
      expect(setEquals({alice}, {aliceCopy}), isTrue);
      expect(setEquals({bob}, {bob}), isTrue);
      expect(setEquals({alice}, {bob}), isFalse);
      expect(setEquals({bob}, {alice}), isFalse);
      expect(setEquals({alice, null}, {alice, -1}), isFalse);
    });

    test('returns true for nested identical sets', () {
      final set1 = {
        {alice, bob},
        {alice, bob},
      };
      final set2 = {
        {alice, bob},
        {alice, bob},
      };
      expect(setEquals(set1, set2), isTrue);
    });

    test('returns false for nested sets with different elements', () {
      final set1 = {
        {bob, 2},
        {3, 4},
      };
      final set2 = {
        {bob, 2},
        {3, 5},
      };
      expect(setEquals(set1, set2), isFalse);
    });

    test('returns true for empty sets', () {
      expect(setEquals({}, {}), isTrue);
    });

    test('returns false for sets with different types', () {
      final set1 = {1, '2', 3};
      final set2 = {1, 2, 3};
      expect(setEquals(set1, set2), isFalse);
    });
  });

  group('mapEquals', () {
    test('returns true for identical maps', () {
      final map1 = {'a': 1, 'b': 2, 'c': 3};
      final map2 = {'a': 1, 'b': 2, 'c': 3};
      expect(mapEquals(map1, map2), isTrue);
    });

    test(
      'returns true for identical maps with elements in different order',
      () {
        final map1 = {'a': 1, 'c': 3, 'b': 2};
        final map2 = {'a': 1, 'b': 2, 'c': 3};
        expect(mapEquals(map1, map2), isTrue);
      },
    );

    test('uses == when props are equatable', () {
      expect(mapEquals({'a': alice}, {'a': aliceCopy}), isTrue);
      expect(mapEquals({alice: 'a'}, {aliceCopy: 'a'}), isTrue);
      expect(mapEquals({'a': bob}, {'a': bob}), isTrue);
    });

    test('returns false for maps of different lengths', () {
      final map1 = {'a': 1, 'b': 2, 'c': 3};
      final map2 = {'a': 1, 'b': 2};
      expect(mapEquals(map1, map2), isFalse);
    });

    test('returns false for maps with different keys', () {
      final map1 = {'a': 1, 'b': 2, 'c': 3};
      final map2 = {'a': 1, 'b': 2, 'd': 3};
      expect(mapEquals(map1, map2), isFalse);
    });

    test('returns false for maps with different values', () {
      final map1 = {'a': 1, 'b': 2, 'c': 3};
      final map2 = {'a': 1, 'b': 2, 'c': 4};
      expect(mapEquals(map1, map2), isFalse);
    });

    test('returns true for nested identical maps', () {
      final map1 = {
        'a': {'x': 1, 'y': 2},
        'b': {'z': 3},
      };
      final map2 = {
        'a': {'x': 1, 'y': 2},
        'b': {'z': 3},
      };
      expect(mapEquals(map1, map2), isTrue);
    });

    test('returns false for nested maps with different elements', () {
      final map1 = {
        'a': {'x': 1, 'y': 2},
        'b': {'z': 3},
      };
      final map2 = {
        'a': {'x': 1, 'y': 2},
        'b': {'z': 4},
      };
      expect(mapEquals(map1, map2), isFalse);
    });

    test('returns true for empty maps', () {
      expect(mapEquals({}, {}), isTrue);
    });

    test('returns false for maps with same keys but different values', () {
      final map1 = {'a': 1, 'b': '2', 'c': 3};
      final map2 = {'a': 1, 'b': 2, 'c': 3};
      expect(mapEquals(map1, map2), isFalse);
    });
  });

  group('objectsEquals', () {
    test('returns true for identical objects', () {
      final object = Object();
      expect(objectsEquals(object, object), isTrue);
    });

    test('returns true for same objects', () {
      const object1 = 'object';
      // ignore: prefer_const_declarations
      final object2 = 'object';
      expect(objectsEquals(object1, object2), isTrue);
    });

    test('returns true for equatable objects', () {
      expect(objectsEquals(alice, aliceCopy), isTrue);
      expect(objectsEquals(bob, bob), isTrue);
    });

    test('returns false for different objects', () {
      expect(objectsEquals(alice, bob), isFalse);
      expect(objectsEquals(bob, alice), isFalse);
    });

    test('returns true for same lists', () {
      expect(objectsEquals([1, 2, 3], [1, 2, 3]), isTrue);
    });

    test('returns true for same sets', () {
      expect(objectsEquals({1, 2, 3}, {1, 2, 3}), isTrue);
      expect(objectsEquals({1, 3, 2}, {1, 2, 3}), isTrue);
    });

    test('returns true for same maps', () {
      expect(objectsEquals({'a': 1, 'b': 2}, {'a': 1, 'b': 2}), isTrue);
      expect(objectsEquals({'c': 3, 'b': 2}, {'b': 2, 'c': 3}), isTrue);
    });

    test('returns false for different types', () {
      expect(objectsEquals(1, '1'), isFalse);
    });

    test('returns true when two nums have the same value (int and double)', () {
      const num a = 0;
      const num b = 0.0;
      expect(objectsEquals(a, b), isTrue);
    });

    test('returns true when two nums are identical', () {
      const num a = 0;
      expect(objectsEquals(a, a), isTrue);
    });

    test('returns false when two nums have different values', () {
      const num a = 0;
      const num b = 1;
      expect(objectsEquals(a, b), isFalse);
    });
  });
}
