import 'dart:convert';

import 'package:test/test.dart';
import 'package:equatable/equatable.dart';

class NonEquatable {}

abstract class EquatableBase with EquatableMixin {}

class EmptyEquatable extends EquatableBase {
  @override
  List<Object> get props => const [];
}

class SimpleEquatable<T> extends EquatableBase {
  final T data;

  SimpleEquatable(this.data);

  @override
  List get props => [data];
}

class MultipartEquatable<T> extends EquatableBase {
  final T d1;
  final T d2;

  MultipartEquatable(this.d1, this.d2);

  @override
  List get props => [d1, d2];
}

class OtherEquatable extends EquatableBase {
  final String data;

  OtherEquatable(this.data);

  @override
  List get props => [data];
}

enum Color { blonde, black, brown }

class ComplexEquatable extends EquatableBase {
  final String name;
  final int age;
  final Color hairColor;
  final List<String> children;

  ComplexEquatable({this.name, this.age, this.hairColor, this.children});

  @override
  List get props => [name, age, hairColor, children];
}

class EquatableData extends EquatableBase {
  final String key;
  final dynamic value;

  EquatableData({this.key, this.value});

  @override
  List get props => [key, value];
}

class Credentials extends EquatableBase {
  final String username;
  final String password;

  Credentials({this.username, this.password});

  @override
  List get props => [username, password];

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

void main() {
  group('Empty Equatable', () {
    test('should correct toString', () {
      final instance = EmptyEquatable();
      expect(instance.toString(), 'EmptyEquatable');
    });

    test('should return true when instance is the same', () {
      final instance = EmptyEquatable();
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = EmptyEquatable();
      expect(instance.hashCode, instance.runtimeType.hashCode);
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
    test('should correct toString', () {
      final instance = SimpleEquatable('simple');
      expect(instance.toString(), 'SimpleEquatable<String>');
    });

    test('should return true when instance is the same', () {
      final instance = SimpleEquatable('simple');
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable('simple');
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
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
    test('should correct toString', () {
      final instance = SimpleEquatable(0);
      expect(instance.toString(), 'SimpleEquatable<int>');
    });

    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(0);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable(0);
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
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
    test('should correct toString', () {
      final instance = SimpleEquatable(true);
      expect(instance.toString(), 'SimpleEquatable<bool>');
    });

    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(true);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable(true);
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
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

  group('Simple Equatable (Equatable)', () {
    test('should correct toString', () {
      final instance = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(instance.toString(), 'SimpleEquatable<EquatableData>');
    });
    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      final instanceB = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      final instanceB = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'barz',
      ));
      expect(instanceA == instanceB, false);
    });
  });

  group('Multipart Equatable', () {
    test('should correct toString', () {
      final instance = MultipartEquatable("s1", "s2");
      expect(instance.toString(), 'MultipartEquatable<String>');
    });
    test('should return true when instance is the same', () {
      final instance = MultipartEquatable("s1", "s2");
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = MultipartEquatable("s1", "s2");
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^
            instance.d1.hashCode ^
            instance.d2.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = MultipartEquatable("s1", "s2");
      final instanceB = MultipartEquatable("s1", "s2");
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = MultipartEquatable("s1", "s2");
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = MultipartEquatable("s1", "s2");
      final instanceB = MultipartEquatable("s2", "s1");
      expect(instanceA == instanceB, false);

      final instanceC = MultipartEquatable("s1", "s1");
      final instanceD = MultipartEquatable("s2", "s1");
      expect(instanceC == instanceD, false);
    });
  });

  group('Complex Equatable', () {
    test('should correct toString', () {
      final instance = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      expect(instance.toString(), 'ComplexEquatable');
    });
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
      final instance = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: ['Bob'],
      );
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^
            instance.name.hashCode ^
            instance.age.hashCode ^
            instance.hairColor.hashCode ^
            instance.children[0].hashCode,
      );
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
  });

  group('Json Equatable', () {
    test('should correct toString', () {
      final instance = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instance.toString(), 'Credentials');
    });

    test('should return true when instance is the same', () {
      final instance = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^
            instance.username.hashCode ^
            instance.password.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      final instanceB = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      final instanceB = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"password"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instanceA == instanceB, false);
    });
  });
}
