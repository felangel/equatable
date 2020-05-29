import 'package:meta/meta.dart';

import './equatable_config.dart';
import './equatable_utils.dart';

/// A base class to facilitate [operator==] and [hashCode] overrides.
///
/// ```dart
/// class ConstTest extends Equatable {
///   const ConstTest(this.a);
///
///   final int a;
///
///   @override
///   List<Object> get props => [a];
/// }
/// ```
@immutable
abstract class Equatable {
  /// The [List] of `props` (properties) which will be used to determine whether
  /// two [Equatables] are equal.
  List<Object> get props;

  /// If the value is [true], the `toString` method will be overrided to print
  /// the equatable `props`.
  // ignore: avoid_returning_null
  bool get stringify => null;

  /// A class that helps implement equality
  /// without needing to explicitly override == and [hashCode].
  /// Equatables override their own `==` operator and [hashCode] based on their
  /// `props`.
  const Equatable();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Equatable &&
          runtimeType == other.runtimeType &&
          equals(props, other.props);

  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

  @override
  String toString() {
    switch (stringify) {
      case true:
        return mapPropsToString(runtimeType, props);
      case false:
        return '$runtimeType';
      default:
        return EquatableConfig.stringify == true
            ? mapPropsToString(runtimeType, props)
            : '$runtimeType';
    }
  }
}
