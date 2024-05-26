// ignore_for_file: avoid_print
import 'package:equatable/equatable.dart';

@Equatable()
class Credentials {
  const Credentials({required this.username, required this.password});

  final String username;
  final String password;
}

@Equatable()
class EquatableDateTime extends DateTime {
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
}

void main() {
  const credentialsA = Credentials(username: 'Joe', password: 'password123');
  const credentialsB = Credentials(username: 'Bob', password: 'password!');
  const credentialsC = Credentials(username: 'Bob', password: 'password!');

  print(credentialsA == credentialsA); // true
  print(credentialsB == credentialsB); // true
  print(credentialsC == credentialsC); // true
  print(credentialsA == credentialsB); // false
  print(credentialsB == credentialsC); // true

  final dateTimeA = EquatableDateTime(2019);
  final dateTimeB = EquatableDateTime(2019, 2, 20, 19, 46);
  final dateTimeC = EquatableDateTime(2019, 2, 20, 19, 46);

  print(dateTimeA == dateTimeA); // true
  print(dateTimeB == dateTimeB); // true
  print(dateTimeC == dateTimeC); // true
  print(dateTimeA == dateTimeB); // false
  print(dateTimeB == dateTimeC); // true
}
