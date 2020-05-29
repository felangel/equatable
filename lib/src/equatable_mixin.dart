import 'equatable_config.dart';
import 'equatable_utils.dart';

/// You must define the [EquatableMixin] on the class
/// which you want to make Equatable.
///
/// [EquatableMixin] does the override of the `==` operator as well as
/// `hashCode`.
mixin EquatableMixin {
  /// The [List] of `props` (properties) which will be used to determine whether
  /// two [Equatables] are equal.
  List<Object> get props;

  /// If the value is [true], the `toString` method will be overrided to print
  /// the equatable `props`.
  bool get stringify => false;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EquatableMixin &&
            runtimeType == other.runtimeType &&
            equals(props, other.props);
  }

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
