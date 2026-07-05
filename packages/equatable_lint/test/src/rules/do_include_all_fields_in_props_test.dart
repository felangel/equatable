// ignore_for_file: non_constant_identifier_names

import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:equatable_lint/src/rules/do_include_all_fields_in_props.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(DoIncludeAllFieldsInPropsRuleTest);
  });
}

@reflectiveTest
class DoIncludeAllFieldsInPropsRuleTest extends AnalysisRuleTest {
  @override
  String get analysisRule => DoIncludeAllFieldsInPropsRule.rule;

  @override
  void setUp() {
    Registry.ruleRegistry.registerLintRule(DoIncludeAllFieldsInPropsRule());

    // Create a minimal equatable package
    newFile('$packagesRootPath/equatable/lib/equatable.dart', '''
abstract class Equatable {
  const Equatable();

  List<Object?> get props;
}
mixin EquatableMixin {
  List<Object?> get props;
}
''');

    super.setUp();
  }

  @override
  void writeTestPackageConfig(PackageConfigFileBuilder config) {
    config.add(name: 'equatable', rootPath: '$packagesRootPath/equatable');
    super.writeTestPackageConfig(config);
  }

  Future<void> test_equatableExtendsValid_noLint() async {
    await assertNoDiagnostics('''
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final int age;

  const Person(this.name, this.age);

  @override
  List<Object> get props => [name, age];
}
''');
  }

  Future<void> test_equatableExtendsMissingField_reportsLint() async {
    await assertDiagnostics(
      '''
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final int age;

  const Person(this.name, this.age);

  @override
  List<Object> get props => [name];
}
''',
      [lint(185, 5, messageContains: 'Missing fields in Equatable props')],
    );
  }

  Future<void> test_equatableMixinValid_noLint() async {
    await assertNoDiagnostics('''
import 'package:equatable/equatable.dart';

class Person with EquatableMixin {
  final String name;
  final int age;

  const Person(this.name, this.age);

  @override
  List<Object> get props => [name, age];
}
''');
  }

  Future<void> test_equatableMixinMissingField_reportsLint() async {
    await assertDiagnostics(
      '''
import 'package:equatable/equatable.dart';

class Person with EquatableMixin {
  final String name;
  final int age;

  const Person(this.name, this.age);

  @override
  List<Object> get props => [name];
}
''',
      [lint(187, 5, correctionContains: 'age')],
    );
  }

  Future<void> test_ignoresStaticFields_noLint() async {
    await assertNoDiagnostics('''
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;

  static const String species = 'Homo sapiens';

  const Person(this.name);

  @override
  List<Object> get props => [name];
}
''');
  }

  Future<void> test_notEquatable_noLint() async {
    await assertNoDiagnostics('''
class Person {
  final String name;
  final int age;

  const Person(this.name, this.age);

  List<Object> get props => [name];
}
''');
  }
}
