import 'package:collection/collection.dart';

int mapPropsToHashCode(List props) {
  int hashCode = 0;

  props.forEach((prop) {
    final propHashCode =
        prop is List ? mapPropsToHashCode(prop) : prop.hashCode;
    hashCode = hashCode ^ propHashCode;
  });

  return hashCode;
}

const DeepCollectionEquality _equality = DeepCollectionEquality();

bool equals(List list1, List list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  int length = list1.length;
  if (length != list2.length) return false;

  for (int i = 0; i < length; i++) {
    final unit1 = list1[i];
    final unit2 = list2[i];

    if (unit1?.runtimeType != unit2?.runtimeType) return false;

    if (unit1 is Iterable || unit1 is List || unit1 is Map || unit1 is Set ) {
      if (!_equality.equals(unit1, unit2)) return false;
    } else {
      if (unit1 != unit2) return false;
    }
  }
  return true;
}
