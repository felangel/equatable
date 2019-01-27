/// A class that helps implement equality
/// without needing to explicitly override == and [hashCode].
/// Equatables override their own == and [hashCode] based on
/// the provided `properties`.
abstract class Equatable<T> {
  /// The constructor takes an optional [List] of `props` (properties) which
  /// will be used to determine whether two [Equatables] are equal.
  /// If no properties are provided, `props` will be initialized to
  /// an empty [List].
  const Equatable([this.props = const []]);

  /// The [List] of `props` (properties) which will be used to determine whether
  /// two [Equatables] are equal.
  final List<T> props;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Equatable &&
          runtimeType == other.runtimeType &&
          _equals(props, other.props);

  @override
  int get hashCode => runtimeType.hashCode ^ _propsHashCode;

  int get _propsHashCode {
    int hashCode = 0;

    props.forEach((T prop) {
      hashCode = hashCode ^ prop.hashCode;
    });

    return hashCode;
  }

  bool _equals(dynamic list1, dynamic list2) {
    if (identical(list1, list2)) {
      return true;
    }
    if (list1 == null || list2 == null) {
      return false;
    }
    final int length = list1?.length as int ?? 0;
    if (length != list2.length) {
      return false;
    }
    for (int i = 0; i < length; i++) {
      if (list1[i] is Iterable) {
        if (!_equals(list1[i], list2[i])) {
          return false;
        }
      } else {
        if (list1[i] != list2[i]) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  String toString() => props.isNotEmpty ? props.toString() : super.toString();
}
