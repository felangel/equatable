import 'package:equatable/equatable.dart';

class Credentials extends Equatable {
  final String username;
  final String password;

  Credentials({this.username, this.password}) : super([username, password]);
}

void main() {
  final credentialsA = Credentials(username: 'Joe', password: 'password123');
  final credentialsB = Credentials(username: 'Bob', password: 'password!');
  final credentialsC = Credentials(username: 'Bob', password: 'password!');

  print(credentialsA == credentialsA); // true
  print(credentialsB == credentialsB); // true
  print(credentialsA == credentialsB); // false
  print(credentialsB == credentialsC); // true
}
