import 'dart:mirrors';

import 'package:equatable/equatable.dart';

/// {@template equatable}
/// A extension class with method fetch all list of properties dynamic.
///
/// ```dart
/// class Person extends Equatable {
///   const Person(this.name);
///
///   final String name;
///
///   @override
///   List<Object?> get props => fetchProperties();
/// }
/// ```
/// {@endtemplate}
extension EquatableExtension on Equatable {
  /// {@template equatable_props}
  /// Fetch all list of properties that will be used to determine whether
  /// two instances are equal.
  /// Note: The dart:mirrors library is unstable.
  /// {@endtemplate}
  List<Object?> fetchProperties() {
    final instanceMirror = reflect(this);
    final classMirror = instanceMirror.type;
    final properties = <Object?>[];

    for (final declarationMirror in classMirror.declarations.values) {
      if (declarationMirror is VariableMirror) {
        final field = instanceMirror.getField(declarationMirror.simpleName);
        if (field.hasReflectee) {
          properties.add(field.reflectee);
        }
      }
    }

    return properties;
  }
}
