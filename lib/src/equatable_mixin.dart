import 'dart:math';

import 'equatable.dart';
import 'equatable_config.dart';
import 'equatable_utils.dart';

/// A mixin that helps implement equality
/// without needing to explicitly override [operator ==] and [hashCode].
///
/// Like with extending [Equatable], the [EquatableMixin] overrides the
/// [operator ==] as well as the [hashCode] based on the provided [props].
mixin EquatableMixin {
  /// {@macro equatable_props}
  List<Object?> get props;

  /// {@macro equatable_stringify}
  // ignore: avoid_returning_null
  bool? get stringify => null;

  /// {@macro equatable_derived}
  Set<Type> get derived => {runtimeType};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! EquatableMixin) {
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

  /// {@macro equatable_hash_code_from_super}
  int hashCodeFromSuper(Object base) {
    if (base is! EquatableMixin) {
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
