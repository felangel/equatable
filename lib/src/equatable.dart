import 'package:collection/collection.dart';
import 'package:macros/macros.dart';

/// {@template equatable}
/// An experimental macro which implements value-equality.
/// 
/// ```dart
/// @Equatable()
/// class Person {
///   const Person({required this.name});
///   final String name;
/// }
/// 
/// void main() {
///   // Generated `hashCode` and `operator==` for value based equality.
///   print(Person(name: 'Dash') == Person(name: 'Dash')); // true
///   print(Person(name: 'Dash') == Person(name: 'Sparky')); // false
/// }
/// ```
/// {@endtemplate}
macro class Equatable implements ClassDeclarationsMacro, ClassDefinitionMacro {
  /// {@macro equatable}
  const Equatable();

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  )  {
    return [
      _declareEquals(clazz, builder),
      _declareHashCode(clazz, builder),
    ].wait;
  }

  @override
  Future<void> buildDefinitionForClass(
    ClassDeclaration clazz,
    TypeDefinitionBuilder builder,
  ) {
    return [
      _buildEquals(clazz, builder),
      _buildHashCode(clazz, builder),
    ].wait;
  }

  Future<void> _declareEquals(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final (object, boolean) = await (
      builder.codeFrom(_dartCore, 'Object'),
      builder.codeFrom(_dartCore, 'bool'),      
    ).wait;
    return builder.declareInType(
      DeclarationCode.fromParts(
        ['external ', boolean, ' operator==(', object, ' other);'],
      ),
    );
  }

  Future<void> _declareHashCode(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final integer = await builder.codeFrom(_dartCore, 'int');
    return builder.declareInType(
      DeclarationCode.fromParts(['external ', integer, ' get hashCode;']),
    );
  }

  Future<void> _buildEquals(
    ClassDeclaration clazz,
    TypeDefinitionBuilder builder,
  ) async {
    final methods = await builder.methodsOf(clazz);
    final equality = methods.firstWhereOrNull(
      (m) => m.identifier.name == '==',
    );
    if (equality == null) return;
    
    final (equalsMethod, deepEquals, identical, fields) = await (
      builder.buildMethod(equality.identifier),
      builder.codeFrom(_equatable, 'deepEquals'),
      builder.codeFrom(_dartCore, 'identical'),
      builder.allFieldsOf(clazz),
    ).wait;

    if (fields.isEmpty) {
      return equalsMethod.augment(
        FunctionBodyCode.fromParts(
          [
            '{',
            'if (', identical,' (this, other)',')', 'return true;',
            'return other is ${clazz.identifier.name} && ',
            'other.runtimeType == runtimeType;',
            '}',
          ],
        ),      
      );
    }

    final fieldNames = fields.map((f) => f.identifier.name);
    final lastField = fieldNames.last;
    return equalsMethod.augment(
      FunctionBodyCode.fromParts(
        [
          '{',
          'if (', identical,' (this, other)',')', 'return true;',
          'return other is ${clazz.identifier.name} && ',
          'other.runtimeType == runtimeType && ',
          for (final field in fieldNames)
            ...[deepEquals, '($field, other.$field)', if (field != lastField) ' && '],
          ';',
          '}',
        ],
      ),      
    );
  }

  Future<void> _buildHashCode(
    ClassDeclaration clazz,
    TypeDefinitionBuilder builder,
  ) async {
    final methods = await builder.methodsOf(clazz);
    final hashCode = methods.firstWhereOrNull(
      (m) => m.identifier.name == 'hashCode',
    );
    if (hashCode == null) return;

    final (hashCodeMethod, jenkinsHash, fields) = await (
      builder.buildMethod(hashCode.identifier),
      builder.codeFrom(_equatable, 'jenkinsHash'),
      builder.allFieldsOf(clazz),
    ).wait;

    final fieldNames = fields.map((f) => f.identifier.name);

    return hashCodeMethod.augment(
      FunctionBodyCode.fromParts(
        [
          '=> ',
          jenkinsHash,
          '([',
          fieldNames.join(', '),
          ']);',
        ],
      ),
    );
  }
}

extension on DeclarationBuilder {
  Future<NamedTypeAnnotationCode> codeFrom(Uri library, String name) async {
    // ignore: deprecated_member_use
    return _codeFrom(library, name, resolveIdentifier);
  }   
}

extension on DefinitionBuilder {
   Future<List<FieldDeclaration>> allFieldsOf(ClassDeclaration clazz) async {
    final allFields = <FieldDeclaration>[...await fieldsOf(clazz)];
    var superclass = await superclassOf(clazz);
    while (superclass != null && superclass.identifier.name != 'Object') {
      allFields.addAll(await fieldsOf(superclass));
      superclass = await superclassOf(superclass);
    }
    return allFields;
  }

  Future<NamedTypeAnnotationCode> codeFrom(Uri library, String name) async {
    // ignore: deprecated_member_use
    return _codeFrom(library, name, resolveIdentifier);
  }

   Future<ClassDeclaration?> superclassOf(ClassDeclaration clazz) async {
    final superclassType = clazz.superclass != null
      ? await typeDeclarationOf(clazz.superclass!.identifier)
      : null;
    return superclassType is ClassDeclaration ? superclassType : null;
  }
}

Future<NamedTypeAnnotationCode> _codeFrom(
  Uri library,
  String name,
  Future<Identifier> Function(Uri library, String name) resolveIdentifier,
) async {
  final identifier = await resolveIdentifier(library, name);
  return NamedTypeAnnotationCode(name: identifier);
}

// Used libraries
final _dartCore = Uri.parse('dart:core');
final _equatable = Uri.parse(
  'package:equatable/equatable.dart',
);
