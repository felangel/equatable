import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

class Credentials extends Equatable {
  final String username;
  final String password;
  final bool shouldStringify;

  const Credentials({this.username, this.password, this.shouldStringify});

  @override
  List<Object> get props => [username, password];

  @override
  bool get stringify => shouldStringify;
}

abstract class EquatableBase with EquatableMixin {}

class CredentialsMixin extends EquatableBase {
  final String username;
  final String password;
  final bool shouldStringify;

  CredentialsMixin({this.username, this.password, this.shouldStringify});

  @override
  List get props => [username, password];

  @override
  bool get stringify => shouldStringify;
}

void main() {
  group('EquatableConfig', () {
    tearDown(() {
      EquatableConfig.stringify = false;
    });

    group('stringify', () {
      test('defaults to false', () {
        expect(EquatableConfig.stringify, isFalse);
      });

      test('is used when stringify is not overridden at the instance (false)',
          () {
        EquatableConfig.stringify = false;
        expect(
          Credentials(username: 'joe', password: 'pass').toString(),
          'Credentials',
        );
        expect(
          CredentialsMixin(username: 'joe', password: 'pass').toString(),
          'CredentialsMixin',
        );
      });

      test('is not used when stringify is overridden at the instance (true)',
          () {
        EquatableConfig.stringify = false;
        expect(
          Credentials(
            username: 'joe',
            password: 'pass',
            shouldStringify: true,
          ).toString(),
          'Credentials(joe, pass)',
        );
        expect(
          CredentialsMixin(
            username: 'joe',
            password: 'pass',
            shouldStringify: true,
          ).toString(),
          'CredentialsMixin(joe, pass)',
        );
      });

      test('is used when stringify is not overridden at the instance (true)',
          () {
        EquatableConfig.stringify = true;
        expect(
          Credentials(username: 'joe', password: 'pass').toString(),
          'Credentials(joe, pass)',
        );
        expect(
          CredentialsMixin(username: 'joe', password: 'pass').toString(),
          'CredentialsMixin(joe, pass)',
        );
      });

      test('is not used when stringify is overridden at the instance (true)',
          () {
        EquatableConfig.stringify = true;
        expect(
          Credentials(
            username: 'joe',
            password: 'pass',
            shouldStringify: false,
          ).toString(),
          'Credentials',
        );
        expect(
          CredentialsMixin(
            username: 'joe',
            password: 'pass',
            shouldStringify: false,
          ).toString(),
          'CredentialsMixin',
        );
      });
    });
  });
}
