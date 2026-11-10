import 'package:collection/collection.dart';
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

  // Custom Set equality can disagree with objectsEquals; validate each
  // native match and use it only once.
  if (!_requiresDeepMatching(a) && !_requiresDeepMatching(b)) {
    final used = Set<Object?>.identity();
    var allMatched = true;
    for (final element in a) {
      final match = b.lookup(element);
      if ((match == null && !b.contains(element)) ||
          !objectsEquals(element, match) ||
          !used.add(match)) {
        allMatched = false;
        break;
      }
    }
    if (allMatched) return true;
  }

  // Deep equality can match distinct objects with different native hashes.
  // Use one-to-one matching when the native fast path cannot prove equality.
  final unmatched = b.toList();
  for (final element in a) {
    final index = unmatched.indexWhere(
      (value) => objectsEquals(element, value),
    );
    if (index == -1) return false;
    // Order is irrelevant; swap with the last candidate to remove in O(1).
    unmatched[index] = unmatched.last;
    unmatched.removeLast();
  }
  return true;
}

bool _requiresDeepMatching(Set<Object?> values) {
  for (final value in values) {
    if (value is Iterable<Object?> || value is Map<Object?, Object?>) {
      return true;
    }
  }
  return false;
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
  if (_isEquatable(a) && _isEquatable(b)) {
    return a == b;
  } else if (a is Set && b is Set) {
    return setEquals(a, b);
  } else if (a is Iterable && b is Iterable) {
    return iterableEquals(a, b);
  } else if (a is Map && b is Map) {
    return mapEquals(a, b);
  } else if (a != b) {
    return false;
  }
  return true;
}

@pragma('vm:prefer-inline')
bool _isEquatable(Object? object) => object is Equatable;

/// Jenkins Hash Functions
/// https://en.wikipedia.org/wiki/Jenkins_hash_function
int _combine(int hash, Object? object) {
  if (object is Map) {
    object.keys
        .sorted((Object? a, Object? b) => a.hashCode - b.hashCode)
        .forEach((Object? key) {
      hash = hash ^ _combine(hash, [key, (object! as Map)[key]]);
    });
    return hash;
  }
  if (object is Set) {
    object = object.sorted((Object? a, Object? b) => a.hashCode - b.hashCode);
  }
  if (object is Iterable) {
    for (final value in object) {
      hash = hash ^ _combine(hash, value);
    }
    return hash ^ object.length;
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
