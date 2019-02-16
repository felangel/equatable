import 'package:equatable/equatable.dart';

class Credentials extends Equatable {
  final String username;
  final String password;

  Credentials({this.username, this.password}) : super([username, password]);
}

class EquatableDateTime extends DateTime
    with EquatableMixinBase, EquatableMixin {
  EquatableDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : super(year, month, day, hour, minute, second, millisecond, microsecond);

  @override
  List get props {
    return [year, month, day, hour, minute, second, millisecond, microsecond];
  }
}

void main() {
  // Extending Equatable
  final credentialsA = Credentials(username: 'Joe', password: 'password123');
  final credentialsB = Credentials(username: 'Bob', password: 'password!');
  final credentialsC = Credentials(username: 'Bob', password: 'password!');

  print(credentialsA == credentialsA); // true
  print(credentialsB == credentialsB); // true
  print(credentialsC == credentialsC); // true
  print(credentialsA == credentialsB); // false
  print(credentialsB == credentialsC); // true

  print(credentialsA); // [Joe, password123]
  print(credentialsB); // [Bob, password!]
  print(credentialsC); // [Bob, password!]

  // Equatable Mixin
  final dateTimeA = EquatableDateTime(2019);
  final dateTimeB = EquatableDateTime(2019, 2, 20, 19, 46);
  final dateTimeC = EquatableDateTime(2019, 2, 20, 19, 46);

  print(dateTimeA == dateTimeA); // true
  print(dateTimeB == dateTimeB); // true
  print(dateTimeC == dateTimeC); // true
  print(dateTimeA == dateTimeB); // false
  print(dateTimeB == dateTimeC); // true

  print(dateTimeA); // 2019-01-01 00:00:00.000
  print(dateTimeB); // 2019-02-20 19:46:00.000
  print(dateTimeC); // 2019-02-20 19:46:00.000
}
