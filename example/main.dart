// ignore_for_file: avoid_print
import 'package:equatable/equatable.dart';

@Equatable()
class Person {
  Person({required this.name});
  final String name;
}

void main() {
  print(Person(name: 'Dash') == Person(name: 'Dash')); // true
  print(Person(name: 'Dash') == Person(name: 'Sparky')); // false
}
