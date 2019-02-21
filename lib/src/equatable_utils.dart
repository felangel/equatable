int mapPropsToHashCode(List props) {
  int hashCode = 0;

  props.forEach((prop) {
    hashCode = hashCode ^ prop.hashCode;
  });

  return hashCode;
}

bool equals(dynamic list1, dynamic list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  int length = list1.length;
  if (length != list2.length) return false;
  for (int i = 0; i < length; i++) {
    if (list1[i] is Iterable) {
      if (!equals(list1[i], list2[i])) return false;
    } else {
      if (list1[i] != list2[i]) return false;
    }
  }
  return true;
}
