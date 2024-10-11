// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';

class Credentials extends Equatable {
  const Credentials({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];

  @override
  bool get stringify => false;
}

class EquatableDateTime extends DateTime with EquatableMixin {
  EquatableDateTime(
    super.year, [
    super.month,
    super.day,
    super.hour,
    super.minute,
    super.second,
    super.millisecond,
    super.microsecond,
  ]);

  @override
  List<Object> get props {
    return [year, month, day, hour, minute, second, millisecond, microsecond];
  }

  @override
  bool get stringify => true;
}

void main() {
  // Extending Equatable
  const credentialsA = Credentials(username: 'Joe', password: 'password123');
  const credentialsB = Credentials(username: 'Bob', password: 'password!');
  const credentialsC = Credentials(username: 'Bob', password: 'password!');

  print(credentialsA == credentialsA); // true
  print(credentialsB == credentialsB); // true
  print(credentialsC == credentialsC); // true
  print(credentialsA == credentialsB); // false
  print(credentialsB == credentialsC); // true
  print(credentialsA); // Credentials

  // Equatable Mixin
  final dateTimeA = EquatableDateTime(2019);
  final dateTimeB = EquatableDateTime(2019, 2, 20, 19, 46);
  final dateTimeC = EquatableDateTime(2019, 2, 20, 19, 46);

  print(dateTimeA == dateTimeA); // true
  print(dateTimeB == dateTimeB); // true
  print(dateTimeC == dateTimeC); // true
  print(dateTimeA == dateTimeB); // false
  print(dateTimeB == dateTimeC); // true
  print(dateTimeA); // EquatableDateTime(2019, 1, 1, 0, 0, 0, 0, 0)
}
