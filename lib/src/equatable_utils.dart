import 'package:equatable/equatable.dart';

/// Returns a `hashCode` for [props].
int mapPropsToHashCode(Iterable<Object?>? props) {
  return _finish(props == null ? 0 : props.fold(0, _combine));
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
  // Equatable's own == must take precedence even when a subtype is
  // iterable. Comparing it structurally would ignore its custom props.
  if (a is Equatable || b is Equatable) {
    return a is Equatable && b is Equatable && a == b;
  }
  // Sets are unordered: never compare a Set as an ordered Iterable.
  if (a is Set<Object?> || b is Set<Object?>) {
    return a is Set<Object?> && b is Set<Object?> && setEquals(a, b);
  }
  if (a is Iterable<Object?> && b is Iterable<Object?>) {
    return iterableEquals(a, b);
  }
  if (a is Map<Object?, Object?> && b is Map<Object?, Object?>) {
    return mapEquals(a, b);
  }
  return a == b;
}

/// Jenkins Hash Functions
/// https://en.wikipedia.org/wiki/Jenkins_hash_function
int _combine(int hash, Object? object) {
  // Equatable objects can also implement Iterable. Their value semantics
  // come from props, not from their iterator.
  if (object is Equatable) {
    return _combine(hash, object.hashCode);
  }
  if (object is Map<Object?, Object?>) {
    var unorderedHash = 0;
    for (final entry in object.entries) {
      // Map keys are compared by native ==/hashCode (containsKey), unlike
      // map values, which are compared structurally by objectsEquals.
      final entryHash = _finish(
        _combine(_combine(0, entry.key.hashCode), entry.value),
      );
      unorderedHash = 0x1fffffff & (unorderedHash + entryHash);
    }
    return _combine(hash, unorderedHash ^ object.length);
  }
  if (object is Set<Object?>) {
    var unorderedHash = 0;
    for (final element in object) {
      unorderedHash =
          0x1fffffff & (unorderedHash + _finish(_combine(0, element)));
    }
    return _combine(hash, unorderedHash ^ object.length);
  }
  if (object is Iterable<Object?>) {
    var length = 0;
    for (final value in object) {
      hash = hash ^ _combine(hash, value);
      length++;
    }
    return hash ^ length;
  }

  hash = 0x1fffffff & (hash + object.hashCode);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _finish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

/// Returns a string for [props].
String mapPropsToString(Type runtimeType, List<Object?> props) {
  return '$runtimeType(${props.map((prop) => prop.toString()).join(', ')})';
}
