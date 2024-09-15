import 'dart:io';

import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:yaml_edit/yaml_edit.dart';

import 'rule.dart';

typedef Options = Map<String, bool>;

extension GenerateOptions on Iterable<Rule> {
  static bool _defaultFilter(Rule rule) {
    final statusRemoval = {
      Status.deprecated,
      Status.removed,
      Status.unreleased,
    }.contains(rule.status);

    final tagsRemoval = rule.tags.any((element) {
      return {
        Tag.core,
        Tag.flutter,
        Tag.recommended,
      }.contains(element);
    });

    return statusRemoval || tagsRemoval;
  }

  Options generateOptions({bool Function(Rule rule)? remove}) => {
        for (final rule in this)
          if (!(remove ?? _defaultFilter).call(rule)) rule.name: true
      };
}

final officialSite = Uri.https('dart.dev', '/tools/linter-rules');

Future<List<Rule>> parseRules({Uri? site}) async {
  final response = await http.get(site ?? officialSite);
  final document = Document.html(response.body);
  final entries = document.querySelectorAll(
    'body > main#page-content > article > div.content > p',
  );
  final handler = <Rule>[];
  for (final entry in entries) {
    final rule = Rule.parse(entry);
    if (rule != null) handler.add(rule);
  }
  return handler;
}

void editRules(File file, Options options) {
  const path = ['linter', 'rules'];
  if (!file.existsSync()) file.createSync(recursive: true);
  file.writeAsStringSync((YamlEditor(file.readAsStringSync())
        ..ensurePath(path)
        ..update(path, options))
      .toString());
}

extension EnsurePath on YamlEditor {
  void ensurePath(Iterable<Object?> path) {
    final pathList = path.toList();
    for (int i = 0; i < pathList.length; i++) {
      final path = pathList.sublist(0, i);
      final key = pathList[i];
      if (parseAt(path).value is! Map || parseAt(path).value[key] == null) {
        update(path, {key: {}});
      }
    }
  }
}
