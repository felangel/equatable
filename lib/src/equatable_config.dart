// ignore_for_file: avoid_classes_with_only_static_members
import 'equatable.dart';

/// The default configurion for all [Equatable] instances.
///
/// Currently, this config class only supports setting a default value for
/// [stringify].
///
/// See also:
/// * [Equatable.stringify]
class EquatableConfig {
  /// Global [stringify] setting for all [Equatable] instances.
  ///
  /// If [stringify] is overridden for a particular [Equatable] instance,
  /// then the local [stringify] value takes precedence
  /// over [EquatableConfig.stringify].
  ///
  /// This value defaults to false.
  static bool stringify = false;
}
