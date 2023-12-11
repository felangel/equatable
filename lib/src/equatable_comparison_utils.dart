import 'package:equatable/src/equatable.dart';
import 'package:equatable/src/equatable_mixin.dart';

/// Determines whether [list1] and [list2] are equal.
bool equals(List<Object?> list1, List<Object?> list2) {
  return _iterableEquals(list1, list2);
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
