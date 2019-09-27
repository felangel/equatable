import 'package:meta/meta.dart';
import './equatable_utils.dart';

/// A base class to facilitate [operator==] and [hashCode] overrides.
///
/// const constructors are possible, but must be performed by overriding
/// [props] instead of using the super constructor:
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

  /// A class that helps implement equality
  /// without needing to explicitly override == and [hashCode].
  /// Equatables override their own `==` operator and [hashCode] based on their `props`.
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
  String toString() => '$runtimeType';
}
