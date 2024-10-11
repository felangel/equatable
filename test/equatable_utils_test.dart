import 'package:equatable/equatable.dart';
import 'package:equatable/src/equatable_utils.dart';
import 'package:test/test.dart';

class Person with EquatableMixin {
  Person({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

void main() {
  group('iterableEquals', () {
    test('returns true for identical props', () {
      final value = [Object()];
      expect(iterableEquals(value, value), isTrue);
    });

    test('returns false when props differ in length', () {
      final object = Object();
      expect(iterableEquals([object], [object, object]), isFalse);
    });

    test('uses == when props are equatable', () {
      final bob = Person(name: 'Bob');
      final alice = Person(name: 'Alice');
      expect(iterableEquals([alice], [alice]), isTrue);
      expect(iterableEquals([bob], [bob]), isTrue);
      expect(iterableEquals([alice], [bob]), isFalse);
      expect(iterableEquals([bob], [alice]), isFalse);
      expect(iterableEquals([alice, null], [alice, -1]), isFalse);
    });
  });
}
