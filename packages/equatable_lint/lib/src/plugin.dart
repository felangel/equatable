import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:equatable_lint/src/rules/rules.dart';

/// Equatable Lint Plugin
class EquatableLintPlugin extends Plugin {
  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(DoIncludeAllFieldsInPropsRule());
  }

  @override
  String get name => 'equatable_lint';
}
