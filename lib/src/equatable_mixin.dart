import './equatable_utils.dart';

/// You must define the [EquatableMixinBase] on the class
/// which you want to make Equatable.
/// `class EquatableDateTime extends DateTime with EquatableMixinBase, EquatableMixin { ... }`
/// This exposes the `props` getter which can then be overridden to include custom props in subclasses.
/// The `props` getter is used to override `==` and `hashCode` in the [EquatableMixin].
mixin EquatableMixinBase on Object {
  List get props => [];

  @override
  String toString() => super.toString();
}

/// You must define the [EquatableMixin] on the class
/// which you want to make Equatable and the class
/// must also be a descendent of [EquatableMixinBase].
/// [EquatableMixin] does the override of the `==` operator as well as `hashCode`.
mixin EquatableMixin on EquatableMixinBase {
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
  String toString() => props.isNotEmpty ? props.toString() : super.toString();
}
