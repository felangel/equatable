import 'package:equatable/equatable.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

class EmptyEquatable extends Equatable {
  const EmptyEquatable();

  @override
  List<Object> get props => null;
}

class LoginEvent extends Equatable {
  final String username;
  final String password;

  const LoginEvent({this.username, this.password});

  @override
  List get props => [username, password];
}

class LoginEventRaw {
  final String username;
  final String password;

  const LoginEventRaw({this.username, this.password});

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

  void run() {
    LoginEventRaw(username: 'felix', password: 'password');
  }
}

class TemplateBenchmarkInstantiation extends BenchmarkBase {
  TemplateBenchmarkInstantiation() : super("Template");

  void run() {
    LoginEvent(username: 'felix', password: 'password');
  }
}

class TemplateBenchmarkInstantiationEmpty extends BenchmarkBase {
  TemplateBenchmarkInstantiationEmpty() : super("Template");

  void run() {
    EmptyEquatable();
  }
}
