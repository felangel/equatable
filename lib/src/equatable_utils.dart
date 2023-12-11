import 'package:collection/collection.dart';
import 'package:equatable/src/equatable.dart';
import 'package:equatable/src/equatable_mixin.dart';

/// Returns a `hashCode` for [props].
int mapPropsToHashCode(Iterable<Object?>? props) {
  return _finish(props == null ? 0 : props.fold(0, _combine));
}

/// Determines whether [list1] and [list2] are equal.
// This method is optimized for comparing properties
// from primitive types like int, double, String, bool.
// Using the _iterableEquals method instead of this code
// can degrade performance by ~ 20%.
bool equals(List<Object?> list1, List<Object?> list2) {
  if (identical(list1, list2)) return true;
  final length = list1.length;
  if (length != list2.length) return false;

  for (var i = 0; i < length; i++) {
    final unit1 = list1[i];
    final unit2 = list2[i];

    if (_isEquatable(unit1) && _isEquatable(unit2)) {
      if (unit1 != unit2) return false;
    } else if (unit1 is Set && unit2 is Set) {
      return _setEquals(unit1, unit2);
    } else if (unit1 is Iterable && unit2 is Iterable) {
      return _iterableEquals(unit1, unit2);
    } else if (unit1 is Map && unit2 is Map) {
      return _mapEquals(unit1, unit2);
    } else if (unit1?.runtimeType != unit2?.runtimeType) {
      return false;
    } else if (unit1 != unit2) {
      return false;
    }
  }
  return true;
}

bool _objectsEquals(Object? object1, Object? object2) {
  if (identical(object1, object2)) {
    return true;
  } else if (_isEquatable(object1) && _isEquatable(object2)) {
    if (object1 != object2) return false;
  } else if (object1 is List && object2 is List) {
    return _iterableEquals(object1, object2);
  } else if (object1 is Set && object2 is Set) {
    return _setEquals(object1, object2);
  } else if (object1 is Map && object2 is Map) {
    return _mapEquals(object1, object2);
  } else if (object1?.runtimeType != object2?.runtimeType) {
    return false;
  } else if (object1 != object2) {
    return false;
  }
  return true;
}

bool _isEquatable(Object? object) {
  return object is Equatable || object is EquatableMixin;
}

bool _setEquals(Set<Object?> a, Set<Object?> b) {
  if (a.length != b.length) return false;
  if (identical(a, b)) return true;
  for (final element in a) {
    if (!b.contains(element)) return false;
  }
  return true;
}

bool _iterableEquals(Iterable<Object?> a, Iterable<Object?> b) {
  if (identical(a, b)) return true;
  final aLength = a.length;
  if (aLength != b.length) return false;
  for (var i = 0; i < aLength; i++) {
    if (!_objectsEquals(a.elementAt(i), b.elementAt(i))) return false;
  }
  return true;
}

bool _mapEquals(Map<Object?, Object?> a, Map<Object?, Object?> b) {
  if (a.length != b.length) return false;
  if (identical(a, b)) return true;
  for (final key in a.keys) {
    if (!_objectsEquals(a[key], b[key])) return false;
  }
  return true;
}

/// Jenkins Hash Functions
/// https://en.wikipedia.org/wiki/Jenkins_hash_function
int _combine(int hash, Object? object) {
  if (object is Map) {
    object.keys.sorted((Object? a, Object? b) => a.hashCode - b.hashCode).forEach((Object? key) {
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
