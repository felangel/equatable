import 'package:equatable/src/equatable_config.dart';
import 'package:equatable/src/equatable_utils.dart';
import 'package:meta/meta.dart';

/// {@template equatable}
/// A base class to facilitate [operator ==] and [hashCode] overrides.
///
/// ```dart
/// class Person extends Equatable {
///   const Person(this.name);
///
///   final String name;
///
///   @override
///   List<Object> get props => [name];
/// }
/// ```
/// {@endtemplate}
@immutable
abstract class Equatable {
  /// {@macro equatable}
  const Equatable();

  /// {@template equatable_props}
  /// The list of properties that will be used to determine whether
  /// two instances are equal.
  /// {@endtemplate}
  List<Object?> get props;

  /// {@template equatable_stringify}
  /// If set to `true`, the [toString] method will be overridden to output
  /// this instance's [props].
  ///
  /// A global default value for [stringify] can be set using
  /// `EquatableConfig.stringify`.
  ///
  /// If this instance's [stringify] is set to null, the value of
  /// `EquatableConfig.stringify` will be used instead. This defaults to
  /// `false`.
  /// {@endtemplate}
  // ignore: avoid_returning_null
  bool? get stringify => null;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Equatable &&
            runtimeType == other.runtimeType &&
            iterableEquals(props, other.props);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

  @override
  String toString() {
    if (stringify ?? EquatableConfig.stringify) {
      return mapPropsToString(runtimeType, props);
    }
    return '$runtimeType';
  }
}
