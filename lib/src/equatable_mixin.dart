import './equatable_utils.dart';

/// You must define the [EquatableMixin] on the class
/// which you want to make Equatable.
///
/// [EquatableMixin] does the override of the `==` operator as well as
/// `hashCode`.
mixin EquatableMixin {
  /// The [List] of `props` (properties) which will be used to determine whether
  /// two [Equatables] are equal.
  List<Object> get props => const [];

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
  String toString() =>
      stringify ? mapPropsToString(runtimeType, props) : '$runtimeType';
}
