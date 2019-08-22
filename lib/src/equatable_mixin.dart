import './equatable_utils.dart';

/// You must define the [EquatableMixin] on the class
/// which you want to make Equatable.
///
/// [EquatableMixin] does the override of the `==` operator as well as `hashCode`.
mixin EquatableMixin {
  List<Object> get props;

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
  String toString() => '$runtimeType';
}
