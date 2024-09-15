import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:strict_lints/spider.dart';

const libPath = 'lib';
final dartFile = File(path.join(libPath, 'dart.yaml'));
final flutterFile = File(path.join(libPath, 'flutter.yaml'));

const dartOptions = {};

const flutterOptions = {...dartOptions};

void main() async {
  final rules = await parseRules();
  editRules(dartFile, {...rules.generateOptions(), ...dartOptions});
  editRules(flutterFile, {...rules.generateOptions(), ...flutterOptions});
}
