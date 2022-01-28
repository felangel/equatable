import 'dart:math';

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

  /// {@template equatable_derived}
  /// A set of classes that this instance is derived from.
  /// {@endtemplate}
  Set<Type> get derived => {runtimeType};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! Equatable) {
      return false;
    }

    final maxPosition = min(props.length, other.props.length);

    final propsMatch = equals(
      props.sublist(0, maxPosition),
      other.props.sublist(0, maxPosition),
    );

    final isDerived = derived.intersection(other.derived).isNotEmpty;

    return propsMatch && isDerived;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

  /// {@template equatable_hash_code_from_super}
  /// Gets the hash code of this instance's [props] using [base]'s
  /// runtimeType's hashCode.
  /// {@endtemplate}
  int hashCodeFromSuper(Object base) {
    if (base is! Equatable) {
      return base.runtimeType.hashCode;
    } else if (derived.intersection(base.derived).isEmpty) {
      return base.runtimeType.hashCode;
    }

    final maxPosition = min(props.length, base.props.length);

    return base.runtimeType.hashCode ^
        mapPropsToHashCode(props.sublist(0, maxPosition));
  }

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
