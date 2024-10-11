import 'package:equatable/equatable.dart';
import 'package:equatable/src/equatable_utils.dart' as utils;
import 'package:test/test.dart';

class Person with EquatableMixin {
  Person({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

void main() {
  group('equals', () {
    test('returns true for identical props', () {
      final value = [Object()];
      expect(utils.equals(value, value), isTrue);
    });

    test('returns false when props differ in length', () {
      final object = Object();
      expect(utils.equals([object], [object, object]), isFalse);
    });

    test('uses == when props are equatable', () {
      final bob = Person(name: 'Bob');
      final alice = Person(name: 'Alice');
      expect(utils.equals([alice], [alice]), isTrue);
      expect(utils.equals([bob], [bob]), isTrue);
      expect(utils.equals([alice], [bob]), isFalse);
      expect(utils.equals([bob], [alice]), isFalse);
      expect(utils.equals([alice, null], [alice, -1]), isFalse);
    });
  });
}
