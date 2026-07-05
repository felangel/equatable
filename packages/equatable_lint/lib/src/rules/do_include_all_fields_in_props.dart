import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// @{template do_include_all_fields_in_props}
/// Ensures all non-static fields in an Equatable class are listed in
/// the `props` getter for correct equality comparison.
/// @{endtemplate}
class DoIncludeAllFieldsInPropsRule extends AnalysisRule {
  /// @{macro do_include_all_fields_in_props}
  DoIncludeAllFieldsInPropsRule()
    : super(
        name: 'do_include_all_fields_in_props',
        description:
            'Ensure all fields are included in props when using Equatable.',
      );

  static const LintCode _code = LintCode(
    'do_include_all_fields_in_props',
    'Missing fields in Equatable props.',
    correctionMessage: "Add the missing fields to the 'props' getter: {0}.",
  );

  /// The name of the lint rule.
  static const String rule = 'do_include_all_fields_in_props';

  @override
  LintCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry.addClassDeclaration(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final AnalysisRule rule;
  final RuleContext context;

  static const String _equatableClassName = 'Equatable';
  static const String _equatableMixinName = 'EquatableMixin';
  static const String _propsGetterName = 'props';

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!_isEquatable(node)) return;

    final declaredFields = _extractDeclaredFieldNames(node);
    if (declaredFields.isEmpty) return;

    final propsMethod = _findPropsGetter(node);
    if (propsMethod == null) return;

    final usedProps = _extractPropsNames(propsMethod.body);
    if (usedProps == null) return;

    final missingFields = declaredFields.difference(usedProps);

    if (missingFields.isNotEmpty) {
      rule.reportAtToken(
        propsMethod.name,
        arguments: [missingFields.join(', ')],
      );
    }
  }

  bool _isEquatable(ClassDeclaration node) {
    if (node.extendsClause?.superclass.name.lexeme == _equatableClassName) {
      return true;
    }

    if (node.withClause != null) {
      for (final type in node.withClause!.mixinTypes) {
        if (type.name.lexeme == _equatableMixinName) return true;
      }
    }

    return false;
  }

  Set<String> _extractDeclaredFieldNames(ClassDeclaration node) {
    final fieldNames = <String>{};

    for (final member in node.members) {
      if (member is FieldDeclaration && !member.isStatic) {
        for (final variable in member.fields.variables) {
          fieldNames.add(variable.name.lexeme);
        }
      }
    }

    return fieldNames;
  }

  Set<String>? _extractPropsNames(FunctionBody body) {
    if (body is! ExpressionFunctionBody) return null;

    final expression = body.expression;
    if (expression is! ListLiteral) return null;

    final propNames = <String>{};

    for (final element in expression.elements) {
      if (element is SimpleIdentifier) {
        propNames.add(element.name);
      }
    }

    return propNames;
  }

  MethodDeclaration? _findPropsGetter(ClassDeclaration node) {
    for (final member in node.members) {
      if (member is MethodDeclaration &&
          member.isGetter &&
          member.name.lexeme == _propsGetterName) {
        return member;
      }
    }

    return null;
  }
}
