import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:equatable/src/equatable_utils.dart';
import 'package:test/test.dart';

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
    return {
      'username': username,
      'password': password,
    };
  }
}

class ComplexStringify extends ComplexEquatable {
  final String name;
  final int age;
  final Color hairColor;

  ComplexStringify({this.name, this.age, this.hairColor});

  @override
  List get props => [name, age, hairColor];

  @override
  bool get stringify => true;
}

class ExplicitStringifyFalse extends ComplexEquatable {
  final String name;
  final int age;
  final Color hairColor;

  ExplicitStringifyFalse({this.name, this.age, this.hairColor});

  @override
  List get props => [name, age, hairColor];

  @override
  bool get stringify => false;
}

class NullProps extends Equatable {
  NullProps();

  @override
  List get props => null;

  @override
  bool get stringify => true;
}

void main() {
  EquatableConfig.stringify = false;
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
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
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
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });

    test('should return different hashCodes when property order has changed',
        () {
      final instance1 = MultipartEquatable("s1", "s2");
      final instance2 = MultipartEquatable("s2", "s1");
      expect(instance1.hashCode == instance2.hashCode, isFalse);
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
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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

    test('should return different hashCode even for empty list', () {
      final instance = ComplexEquatable(
        name: 'Joe',
        age: 40,
        hairColor: Color.black,
        children: [],
      );
      final instance2 = ComplexEquatable(
        name: 'John',
        age: 40,
        hairColor: Color.black,
        children: [],
      );
      expect(instance.hashCode != instance2.hashCode, true);
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
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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

  group('To String Equatable', () {
    test('Complex stringify', () {
      final instanceA = ComplexStringify();
      final instanceB = ComplexStringify(name: "Bob", hairColor: Color.black);
      final instanceC =
          ComplexStringify(name: "Joe", age: 50, hairColor: Color.blonde);
      expect(instanceA.toString(), 'ComplexStringify(, , )');
      expect(instanceB.toString(), 'ComplexStringify(Bob, , Color.black)');
      expect(instanceC.toString(), 'ComplexStringify(Joe, 50, Color.blonde)');
    });

    test('with ExplicitStringifyFalse stringify', () {
      final instanceA = ExplicitStringifyFalse();
      final instanceB =
          ExplicitStringifyFalse(name: "Bob", hairColor: Color.black);
      final instanceC =
          ExplicitStringifyFalse(name: "Joe", age: 50, hairColor: Color.blonde);
      expect(instanceA.toString(), 'ExplicitStringifyFalse');
      expect(instanceB.toString(), 'ExplicitStringifyFalse');
      expect(instanceC.toString(), 'ExplicitStringifyFalse');
    });
  });

  group('Null props Equatable', () {
    test('should not crash invoking equals method', () {
      final instanceA = NullProps();
      final instanceB = NullProps();
      expect(instanceA == instanceB, true);
    });

    test('should not crash invoking hascode method', () {
      final instanceA = NullProps();
      final instanceB = NullProps();
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should not crash invoking toString method', () {
      final instance = NullProps();
      expect(instance.toString(), 'NullProps()');
    });
  });
}
