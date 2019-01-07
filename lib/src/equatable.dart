/// A class that helps implement equality
/// without needing to explicitly override == and [hashCode].
/// Equatables override their own == and [hashCode] based on
/// the provided `properties`.
abstract class Equatable {
  /// The [List] of `props` (properties) which will be used to determine whether
  /// two [Equatables] are equal.
  final List props;

  /// The constructor takes an optional [Iterable] of `props` which
  /// will be used to determine whether two [Equatables] are equal.
  /// If no properties are provided, `props` will be initialized to
  /// `Iterable.empty()`.
  Equatable([this.props = const []]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Equatable &&
          runtimeType == other.runtimeType &&
          _propsAreEqual(props, other.props);

  @override
  int get hashCode => runtimeType.hashCode ^ _propsHashCode;

  int get _propsHashCode {
    int hashCode = 0;

    props.forEach((prop) {
      hashCode = hashCode ^ prop.hashCode;
    });

    return hashCode;
  }

  bool _propsAreEqual(List props, List other) {
    if (props.length != other.length) {
      return false;
    }

    for (int i = 0; i < props.length; i++) {
      if (props.elementAt(i) != other.elementAt(i)) {
        return false;
      }
    }

    return true;
  }
}
