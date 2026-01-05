import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

/// Returns a `hashCode` for [props].
int mapPropsToHashCode(Iterable<Object?>? props) {
  if (props == null) return 0;
  return Object.hashAll(props.map(_computeHashCode));
}

int _computeHashCode(Object? object) {
  if (object is Map) {
    final entries = object.entries
        .sorted((a, b) => a.key.hashCode.compareTo(b.key.hashCode));
    return Object.hashAll(
      entries
          .expand((e) => [_computeHashCode(e.key), _computeHashCode(e.value)]),
    );
  }
  if (object is Set) {
    return Object.hashAll(
      object
          .sorted((a, b) => a.hashCode.compareTo(b.hashCode))
          .map(_computeHashCode),
    );
  }
  if (object is Iterable) {
    return Object.hashAll(object.map(_computeHashCode));
  }
  return object.hashCode;
}

/// Determines whether two lists ([a] and [b]) are equal.
// See https://github.com/felangel/equatable/issues/187.
@pragma('vm:prefer-inline')
bool equals(List<Object?>? a, List<Object?>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  return iterableEquals(a, b);
}

/// Determines whether two iterables are equal.
@pragma('vm:prefer-inline')
bool iterableEquals(Iterable<Object?> a, Iterable<Object?> b) {
  assert(
    a is! Set && b is! Set,
    "iterableEquals doesn't support Sets. Use setEquals instead.",
  );
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (!objectsEquals(a.elementAt(i), b.elementAt(i))) return false;
  }
  return true;
}

/// Determines whether two numbers are equal.
@pragma('vm:prefer-inline')
bool numEquals(num a, num b) => a == b;

/// Determines whether two sets are equal.
bool setEquals(Set<Object?> a, Set<Object?> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final element in a) {
    if (!b.any((e) => objectsEquals(element, e))) return false;
  }
  return true;
}

/// Determines whether two maps are equal.
bool mapEquals(Map<Object?, Object?> a, Map<Object?, Object?> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final key in a.keys) {
    if (!b.containsKey(key) || !objectsEquals(a[key], b[key])) return false;
  }
  return true;
}

/// Determines whether two objects are equal.
@pragma('vm:prefer-inline')
bool objectsEquals(Object? a, Object? b) {
  if (identical(a, b)) return true;
  if (a is num && b is num) {
    return numEquals(a, b);
  } else if (_isEquatable(a) && _isEquatable(b)) {
    return a == b;
  } else if (a is Set && b is Set) {
    return setEquals(a, b);
  } else if (a is Iterable && b is Iterable) {
    return iterableEquals(a, b);
  } else if (a is Map && b is Map) {
    return mapEquals(a, b);
  } else if (a?.runtimeType != b?.runtimeType) {
    return false;
  } else if (a != b) {
    return false;
  }
  return true;
}

@pragma('vm:prefer-inline')
bool _isEquatable(Object? object) {
  return object is Equatable || object is EquatableMixin;
}

/// Returns a string for [props].
String mapPropsToString(Type runtimeType, List<Object?> props) {
  return '$runtimeType(${props.map((prop) => prop.toString()).join(', ')})';
}
