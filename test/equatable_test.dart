// ignore: lines_longer_than_80_chars
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

import 'custom_list.dart';

class NonEquatable {}

@Equatable()
class EmptyEquatable {
  const EmptyEquatable();
}

@Equatable()
class SimpleEquatable<T extends Object> {
  const SimpleEquatable(this.data);
  final T data;
}

@Equatable()
class MultipartEquatable<T extends Object> {
  MultipartEquatable(this.d1, this.d2);

  final T d1;
  final T d2;
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
      final instance = SimpleEquatable('simple');
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = SimpleEquatable('simple');
      expect(instanceA.hashCode, instanceB.hashCode);
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = SimpleEquatable('simple');
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when compared to different equatable', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = OtherEquatable('simple');
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = SimpleEquatable('Simple');
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (number)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(0);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleEquatable(0);
      final instanceB = SimpleEquatable(0);
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(0);
      final instanceB = SimpleEquatable(0);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(0);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(0);
      final instanceB = SimpleEquatable(1);
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (bool)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(true);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleEquatable(true);
      final instanceB = SimpleEquatable(true);
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(true);
      final instanceB = SimpleEquatable(true);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(true);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(true);
      final instanceB = SimpleEquatable(false);
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (map)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleEquatable({'a': 1, 'b': 2, 'c': 3});
      expect(instance == instance, true);
    });

    test('should have same hashCode when values are equal', () {
      final instanceA = SimpleEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = SimpleEquatable({'b': 2, 'a': 1, 'c': 3});
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode, instanceB.hashCode);
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = SimpleEquatable({'a': 1, 'b': 2, 'c': 3});
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable({'a': 1, 'b': 2, 'c': 3});
      final instanceB = SimpleEquatable({'a': 1, 'b': 2, 'c': 4});
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (map custom key)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      final instanceB = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      expect(instanceA.hashCode, instanceB.hashCode);
    });

    test('should have same hashCode when values are equal', () {
      final instanceA = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      final instanceB = SimpleEquatable(
        {
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('c'): 3,
        },
      );
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode, instanceB.hashCode);
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      final instanceB = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 3,
        },
      );
      final instanceB = SimpleEquatable(
        {
          SimpleEquatable<String>('a'): 1,
          SimpleEquatable<String>('b'): 2,
          SimpleEquatable<String>('c'): 2,
        },
      );
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (Equatable)', () {
    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instanceA = SimpleEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = SimpleEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      expect(instanceA.hashCode, equals(instanceB.hashCode));
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = SimpleEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(
        EquatableData(
          key: 'foo',
          value: 'bar',
        ),
      );
      final instanceB = SimpleEquatable(
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
        final s0 = SimpleEquatable([0, 0]);
        final s1 = SimpleEquatable([0, 0, 0]);
        expect(s0.hashCode != s1.hashCode, true);
      });

      test('should return when values are same', () {
        final instanceA = SimpleEquatable(['A', 'B']);
        final instanceB = SimpleEquatable(['A', 'B']);
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleEquatable(['A', 'B']);
        final instanceB = SimpleEquatable(['a', 'b']);
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleEquatable(['A', 'B']);
        final instanceB = SimpleEquatable(['C', 'D']);
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });
    });

    group('Nested Iterable Equatable', () {
      test('should return when values are same', () {
        final instanceA = SimpleEquatable([
          ['A', 'B', 'C'],
          ['D', 'E', 'F'],
        ]);
        final instanceB = SimpleEquatable([
          ['A', 'B', 'C'],
          ['D', 'E', 'F'],
        ]);
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleEquatable([
          ['A', 'B', 'C'],
          ['D', 'E', 'F'],
        ]);
        final instanceB = SimpleEquatable([
          ['a', 'b', 'c'],
          ['d', 'e', 'f'],
        ]);
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });
    });

    group('List Equatable', () {	
      test('should return when values are same', () {	
        final instanceA = SimpleEquatable(['A', 'B']);	
        final instanceB = SimpleEquatable(['A', 'B']);	
        expect(instanceA == instanceB, true);	
        expect(instanceA.hashCode == instanceB.hashCode, true);	
      });	

      test('should return when values are different', () {	
        final instanceA = SimpleEquatable(['A', 'B']);	
        final instanceB = SimpleEquatable(['a', 'b']);	
        expect(instanceA != instanceB, true);	
        expect(instanceA.hashCode != instanceB.hashCode, true);	
      });	

      test('should return when values are different', () {	
        final instanceA = SimpleEquatable(['A', 'B']);	
        final instanceB = SimpleEquatable(['C', 'D']);	
        expect(instanceA != instanceB, true);	
        expect(instanceA.hashCode != instanceB.hashCode, true);	
      });	

      test('should return when contents are same but different kind of List',	
          () {	
        final instanceA = SimpleEquatable<List<String>>(	
          CustomList<String>(['A', 'B'], growable: true),	
        );	
        final instanceB = SimpleEquatable<List<String>>(['A', 'B']);	
        expect(instanceA == instanceB, true);	
        expect(instanceA.hashCode == instanceB.hashCode, true);	
      });	

      test(	
          'should return different hashCode '	
          'when instance properties are different', () {	
        final instanceA = SimpleEquatable(<String>['A', 'B']);	
        final instanceB = SimpleEquatable(<String>['B']);	

        expect(instanceA != instanceB, true);	
        expect(instanceA.hashCode != instanceB.hashCode, true);	
      });	

      test(	
          'should return different hashCode '	
          'when instance properties are modified', () {	
        final list = ['A', 'B'];	
        final instanceA = SimpleEquatable(list);	
        final hashCodeA = instanceA.hashCode;	
        list.removeLast();	
        final hashCodeB = instanceA.hashCode;	
        expect(hashCodeA != hashCodeB, true);	
      });	
    });	

    group('Map Equatable', () {	
      test('should return true when values are same', () {	
        final instanceA = SimpleEquatable({1: 'A', 2: 'B'});	
        final instanceB = SimpleEquatable({1: 'A', 2: 'B'});	
        expect(instanceA == instanceB, true);	
        expect(instanceA.hashCode == instanceB.hashCode, true);	
      });	

      test('should return false when values are different', () {	
        final instanceA = SimpleEquatable({1: 'A', 2: 'B'});	
        final instanceB = SimpleEquatable({1: 'a', 2: 'b'});	
        expect(instanceA != instanceB, true);	
        expect(instanceA.hashCode != instanceB.hashCode, true);	
      });	

      test('should return false when values are different', () {	
        final instanceA = SimpleEquatable({1: 'A', 2: 'B'});	
        final instanceB = SimpleEquatable({1: 'C', 2: 'D'});	
        expect(instanceA != instanceB, true);	
        expect(instanceA.hashCode != instanceB.hashCode, true);	
      });	

      test(	
          'should return different hashCode '	
          'when instance properties are different', () {	
        final instanceA = SimpleEquatable({1: 'A', 2: 'B'});	
        final instanceB = SimpleEquatable({2: 'B'});	

        expect(instanceA != instanceB, true);	
        expect(instanceA.hashCode != instanceB.hashCode, true);	
      });	

      test(	
          'should return different hashCode '	
          'when instance properties are modified', () {	
        final map = {1: 'A', 2: 'B'};	
        final instanceA = SimpleEquatable(map);	
        final hashCodeA = instanceA.hashCode;	
        map.remove(1);	
        final hashCodeB = instanceA.hashCode;	
        expect(hashCodeA != hashCodeB, true);	
      });	
    });

    group('Set Equatable', () {
      test('should return when values are same', () {
        final instanceA = SimpleEquatable(<String>{'A', 'B'});
        final instanceB = SimpleEquatable(<String>{'A', 'B'});
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when Set values are same but in different order', () {
        final instanceA = SimpleEquatable(<String>{'A', 'B'});
        final instanceB = SimpleEquatable(<String>{'B', 'A'});
        expect(instanceA == instanceB, true);
        expect(instanceA.hashCode == instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleEquatable(<String>{'A', 'B'});
        final instanceB = SimpleEquatable(<String>{'a', 'b'});
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });

      test('should return when values are different', () {
        final instanceA = SimpleEquatable(<String>{'A', 'B'});
        final instanceB = SimpleEquatable(<String>{'C', 'D'});
        expect(instanceA != instanceB, true);
        expect(instanceA.hashCode != instanceB.hashCode, true);
      });

      test('should support non-comparable types', () {
        final instanceA = SimpleEquatable(<Object>{Object()});
        final instanceB = SimpleEquatable(<Object>{Object()});
        expect(instanceA == instanceB, false);
        expect(instanceA.hashCode == instanceB.hashCode, false);
      });
    });
  });
}
