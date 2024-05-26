// ignore: lines_longer_than_80_chars
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

class NonEquatable {}

@Equatable()
class EmptyEquatable {
  const EmptyEquatable();
}

@Equatable()
class SimpleStringEquatable {
  const SimpleStringEquatable(this.data);

  final String data;
}

@Equatable()
class SimpleNumEquatable {
  const SimpleNumEquatable(this.data);

  final num data;
}

@Equatable()
class SimpleBoolEquatable {
  // ignore: avoid_positional_boolean_parameters
  const SimpleBoolEquatable(this.data);

  final bool data;
}

@Equatable()
class SimpleMapEquatable {
  const SimpleMapEquatable(this.data);

  final Map<String, dynamic> data;
}

@Equatable()
class SimpleObjectEquatable {
  const SimpleObjectEquatable(this.data);

  final Object data;
}

@Equatable()
class SimpleIterableEquatable {
  const SimpleIterableEquatable(this.data);

  final Iterable<Object> data;
}

@Equatable()
class MultipartEquatable {
  MultipartEquatable(this.d1, this.d2);

  final String d1;
  final String d2;
}

@Equatable()
class OtherEquatable {
  const OtherEquatable(this.data);

  final String data;
}

enum Color { blonde, black, brown }

@Equatable()
class ComplexEquatable {
  const ComplexEquatable({this.name, this.age, this.hairColor, this.children});

  final String? name;
  final int? age;
  final Color? hairColor;
  final List<String>? children;
}

@Equatable()
class EquatableData {
  const EquatableData({required this.key, required this.value});

  final String key;
  final Object value;
}

@Equatable()
class Credentials {
  const Credentials({required this.username, required this.password});

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  final String username;
  final String password;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }
}

void main() {
  group('Empty Equatable', () {
    test('should return true when instance is the same', () {
      final instance = EmptyEquatable();
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = EmptyEquatable();
      final instanceB = EmptyEquatable();
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = EmptyEquatable();
      final instanceB = EmptyEquatable();
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = EmptyEquatable();
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (string)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleStringEquatable('simple');
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleStringEquatable('simple');
      final instanceB = SimpleStringEquatable('simple');
      expect(instanceA.hashCode, instanceB.hashCode);
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleStringEquatable('simple');
      final instanceB = SimpleStringEquatable('simple');
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleStringEquatable('simple');
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when compared to different equatable', () {
      final instanceA = SimpleStringEquatable('simple');
      final instanceB = OtherEquatable('simple');
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleStringEquatable('simple');
      final instanceB = SimpleStringEquatable('Simple');
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (number)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleNumEquatable(0);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleNumEquatable(0);
      final instanceB = SimpleNumEquatable(0);
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleNumEquatable(0);
      final instanceB = SimpleNumEquatable(0);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleNumEquatable(0);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleNumEquatable(0);
      final instanceB = SimpleNumEquatable(1);
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (bool)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleBoolEquatable(true);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleBoolEquatable(true);
      final instanceB = SimpleBoolEquatable(true);
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleBoolEquatable(true);
      final instanceB = SimpleBoolEquatable(true);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleBoolEquatable(true);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleBoolEquatable(true);
      final instanceB = SimpleBoolEquatable(false);
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (map)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleMapEquatable({'a': 1, 'b': 2, 'c': 3});
      expect(instance == instance, true);
    });

    test('should have same hashCode when values are equal', () {
      final instanceA = SimpleMapEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = SimpleMapEquatable({'b': 2, 'a': 1, 'c': 3});
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode, instanceB.hashCode);
    });

    test('should return true when instances are the same', () {
      final instanceA = SimpleMapEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = SimpleMapEquatable({'a': 1, 'b': 2, 'c': 3});
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleMapEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleMapEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = SimpleMapEquatable({'a': 1, 'b': 2, 'c': 4});
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (Equatable)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = SimpleObjectEquatable(
        EquatableData(
          key: 'foo',
          value: 'barz',
        ),
      );
      expect(instanceA == instanceB, false);
    });
  });

  group('Multipart Equatable', () {
    test('should return true when instance is the same', () {
      final instance = MultipartEquatable('s1', 's2');
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = MultipartEquatable('s1', 's2');
      final instanceB = MultipartEquatable('s1', 's2');
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test(
        'should return different hashCodes '
        'when property order has changed', () {
      final instance1 = MultipartEquatable('s1', 's2');
      final instance2 = MultipartEquatable('s2', 's1');
      expect(instance1.hashCode == instance2.hashCode, isFalse);
    });

    test('should return true when instances are different', () {
      final instanceA = MultipartEquatable('s1', 's2');
      final instanceB = MultipartEquatable('s1', 's2');
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = MultipartEquatable('s1', 's2');
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = MultipartEquatable('s1', 's2');
      final instanceB = MultipartEquatable('s2', 's1');
      expect(instanceA == instanceB, false);

      final instanceC = MultipartEquatable('s1', 's1');
      final instanceD = MultipartEquatable('s2', 's1');
      expect(instanceC == instanceD, false);
    });
  });

  group('Complex Equatable', () {
    test('should return true when instance is the same', () {
      final instance = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      final instanceB = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      final instanceB = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      final instanceB = ComplexEquatable(
        name: 'John',
        age: 40,
        hairColor: Color.brown,
        children: ['Bobby'],
      );
      expect(instanceA == instanceB, false);
    });

    test('should return false when values only differ in list', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      final instanceB = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bobby'],
      );
      expect(instanceA == instanceB, false);
    });

    test('should return false when values only differ in single property', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      final instanceB = ComplexEquatable(
        name: 'Joe',
        age: 41,
        hairColor: Color.black,
        children: ['Bob'],
      );
      expect(instanceA == instanceB, false);
    });
  });

  group('Json Equatable', () {
    test('should return true when instance is the same', () {
      final instance = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"admin"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"admin"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      final instanceB = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"admin"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"admin"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      final instanceB = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"admin"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"admin"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"admin"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      final instanceB = Credentials.fromJson(
        json.decode(
          '''
        {
          "username":"Admin",
          "password":"password"
        }
        ''',
        ) as Map<String, dynamic>,
      );
      expect(instanceA == instanceB, false);
    });
  });

  group('Collection Equatable', () {
    group('Iterable Equatable', () {
      test('list of zeros same hashcode check', () {
        final s0 = SimpleIterableEquatable([0, 0]);
        final s1 = SimpleIterableEquatable([0, 0, 0]);
        expect(s0.hashCode != s1.hashCode, true);
      });

      test('should return when values are same', () {
        final instanceA = SimpleIterableEquatable(['A', 'B']);
        final instanceB = SimpleIterableEquatable(['A', 'B']);
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleIterableEquatable(['A', 'B']);
        final instanceB = SimpleIterableEquatable(['a', 'b']);
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleIterableEquatable(['A', 'B']);
        final instanceB = SimpleIterableEquatable(['C', 'D']);
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });
    });

    group('Nested Iterable Equatable', () {
      test('should return when values are same', () {
        final instanceA = SimpleIterableEquatable([
          ['A', 'B', 'C'],
          ['D', 'E', 'F'],
        ]);
        final instanceB = SimpleIterableEquatable([
          ['A', 'B', 'C'],
          ['D', 'E', 'F'],
        ]);
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleIterableEquatable([
          ['A', 'B', 'C'],
          ['D', 'E', 'F'],
        ]);
        final instanceB = SimpleIterableEquatable([
          ['a', 'b', 'c'],
          ['d', 'e', 'f'],
        ]);
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });
    });

    group('Set Equatable', () {
      test('should return when values are same', () {
        final instanceA = SimpleIterableEquatable(<String>{'A', 'B'});
        final instanceB = SimpleIterableEquatable(<String>{'A', 'B'});
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when Set values are same but in different order', () {
        final instanceA = SimpleIterableEquatable(<String>{'A', 'B'});
        final instanceB = SimpleIterableEquatable(<String>{'B', 'A'});
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleIterableEquatable(<String>{'A', 'B'});
        final instanceB = SimpleIterableEquatable(<String>{'a', 'b'});
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleIterableEquatable(<String>{'A', 'B'});
        final instanceB = SimpleIterableEquatable(<String>{'C', 'D'});
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });

      test('should support non-comparable types', () {
        final instanceA = SimpleIterableEquatable(<Object>{Object()});
        final instanceB = SimpleIterableEquatable(<Object>{Object()});
        expect(instanceA == instanceB, false);
        expect(instanceA.hashCode == instanceB.hashCode, false);
      });
    });
  });
}
