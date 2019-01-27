import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:equatable/equatable.dart';

class EmptyEquatable extends Equatable {}

class LoginEvent extends Equatable {
  LoginEvent({this.username, this.password}) : super([username, password]);

  final String username;
  final String password;
}

class LoginEventRaw {
  const LoginEventRaw({this.username, this.password});

  final String username;
  final String password;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginEventRaw &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}

void main() {
  print('----Comparison Report----');

  print('RAW:');
  TemplateBenchmarkComparisonRaw().report();

  print('Equatable:');
  TemplateBenchmarkComparison().report();

  print('Empty Equatable:');
  TemplateBenchmarkComparisonEmpty().report();

  print('----Instantiation Report----');

  print('RAW:');
  TemplateBenchmarkInstantiationRaw().report();

  print('Equatable:');
  TemplateBenchmarkInstantiation().report();

  print('Empty Equatable:');
  TemplateBenchmarkInstantiationEmpty().report();
}

class TemplateBenchmarkComparisonRaw extends BenchmarkBase {
  TemplateBenchmarkComparisonRaw() : super("Template");

  LoginEventRaw eventA;
  @override
  void run() {
    eventA == eventA;
  }

  @override
  void setup() {
    eventA = LoginEventRaw(username: 'username', password: 'password');
    super.setup();
  }
}

class TemplateBenchmarkComparison extends BenchmarkBase {
  TemplateBenchmarkComparison() : super("Template");

  LoginEvent eventA;

  @override
  void run() {
    eventA == eventA;
  }

  @override
  void setup() {
    eventA = LoginEvent(username: 'username', password: 'password');
    super.setup();
  }
}

class TemplateBenchmarkComparisonEmpty extends BenchmarkBase {
  TemplateBenchmarkComparisonEmpty() : super("Template");

  EmptyEquatable e;

  @override
  void run() {
    e == e;
  }

  @override
  void setup() {
    e = EmptyEquatable();
    super.setup();
  }
}

class TemplateBenchmarkInstantiationRaw extends BenchmarkBase {
  TemplateBenchmarkInstantiationRaw() : super("Template");

  @override
  void run() {
    LoginEventRaw(username: 'felix', password: 'password');
  }
}

class TemplateBenchmarkInstantiation extends BenchmarkBase {
  TemplateBenchmarkInstantiation() : super("Template");

  @override
  void run() {
    LoginEvent(username: 'felix', password: 'password');
  }
}

class TemplateBenchmarkInstantiationEmpty extends BenchmarkBase {
  TemplateBenchmarkInstantiationEmpty() : super("Template");

  @override
  void run() {
    EmptyEquatable();
  }
}
