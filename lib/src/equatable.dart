import 'package:meta/meta.dart';
import 'equatable_mixin.dart';

abstract class Equatable with EquatableMixin {
  @protected
  final List<Object> props;

  /// A class that helps implement equality
  /// without needing to explicitly override == and [hashCode].
  /// Equatables override their own == and [hashCode] based on
  /// the provided `properties`.
  ///
  /// The constructor takes an optional [List] of `props` (properties) which
  /// will be used to determine whether two [Equatables] are equal.
  /// If no properties are provided, `props` will be initialized to
  /// an empty [List].
  // `const` can be used after this analyzer bug gets fixed https://github.com/dart-lang/sdk/issues/37810
  /*const*/ Equatable([this.props = const []]);
}
