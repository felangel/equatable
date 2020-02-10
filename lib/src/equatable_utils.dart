import 'package:collection/collection.dart';

/// Retuns a hash code for [props].
int mapPropsToHashCode(Iterable props) =>
    _finish(props?.fold(0, _combine) ?? 0);

const DeepCollectionEquality _equality = DeepCollectionEquality();

/// Determines an equality between [list1] and [list2].
bool equals(List list1, List list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  final length = list1.length;
  if (length != list2.length) return false;

  for (var i = 0; i < length; i++) {
    final unit1 = list1[i];
    final unit2 = list2[i];

    if (unit1 is Iterable || unit1 is Map) {
      if (!_equality.equals(unit1, unit2)) return false;
    } else if (unit1?.runtimeType != unit2?.runtimeType) {
      return false;
    } else if (unit1 != unit2) {
      return false;
    }
  }
  return true;
}

/// Jenkins Hash Functions
/// https://en.wikipedia.org/wiki/Jenkins_hash_function
int _combine(int hash, dynamic object) {
  if (object is Map) {
    object.forEach((key, value) {
      hash = hash ^ _combine(hash, [key, value]);
    });
    return hash;
  }
  final objectHashCode =
      object is Iterable ? mapPropsToHashCode(object) : object.hashCode;
  hash = 0x1fffffff & (hash + objectHashCode);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _finish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

/// Returns a string for [props].
String mapPropsToString(Type runtimeType, List<Object> props) =>
    '$runtimeType${props?.map((prop) => prop?.toString() ?? '') ?? '()'}';
