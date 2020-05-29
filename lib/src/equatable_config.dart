// ignore: avoid_classes_with_only_static_members
/// Global [Equatable] configuration settings
class EquatableConfig {
  /// Global [stringify] setting for all [Equatable] instances.
  /// If [stringify] is overridden for a particular [Equatable] instance,
  /// then the local [stringify] value takes precedence
  /// over `EquatableConfig.stringify`.
  /// This value defaults to false.
  static bool stringify = false;
}
