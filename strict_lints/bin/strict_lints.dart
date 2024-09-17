import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:strict_lints/strict_lints.dart';

const libPath = 'lib';
final dartFile = File(path.join(libPath, 'dart.yaml'));
final flutterFile = File(path.join(libPath, 'flutter.yaml'));

const NullableOptions flutterOptions = {
  'always_put_control_body_on_new_line': null, // Might make code ugly.
  // Conflict: avoid_types_on_closure_parameters and omit_local_variable_types.
  'always_specify_types': null,
  'always_use_package_imports': null, // Might make code ugly.
  'prefer_double_quotes': null, // Conflict: prefer_single_quotes.
  'prefer_final_parameters': null, // Conflict: avoid_final_parameters.
  'prefer_relative_imports': null, // Might make code ugly.
  'public_member_api_docs': null, // Might make code complex.
  'unnecessary_final': null, // Conflict: prefer_final_locals.
};

const NullableOptions dartOptions = {
  ...flutterOptions,
  // @immutable annotation is in FlutterSDK.
  'avoid_equals_and_hash_code_on_mutable_classes': null,
};

void main() async {
  final options = (await parseRules()).generateOptions();
  editRules(flutterFile, options.override(flutterOptions));
  editRules(dartFile, options.override(dartOptions));
}
