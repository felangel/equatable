import 'package:meta/meta.dart';

import './equatable_config.dart';
import './equatable_utils.dart';

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
  /// The list of properies that will be used to determine whether
  /// two [Equatable]s are equal.
  /// {@endtemplate}
  List<Object> get props;

  /// {@template equatable_stringify}
  /// If set to `true`, the [toString] method will be overridden to output
  /// this [Equatable]'s [props].
  ///
  /// A global default value for [stringify] can be set using
  /// [EquatableConfig.stringify].
  ///
  /// If this [Equatable]'s [stringify] is set to null, the value of
  /// [EquatableConfig.stringify] will be used instead. That value deafults to
  /// `false`.
  /// {@endtemplate}
  // ignore: avoid_returning_null
  bool get stringify => null;

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
