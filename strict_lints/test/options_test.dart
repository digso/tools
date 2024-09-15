import 'package:strict_lints/spider.dart';
import 'package:test/test.dart';
import 'package:yaml_edit/yaml_edit.dart';

void main() {
  test('yaml edit ensure path', () {
    yamlEditEnsureValue(['linter', 'rules']);
    yamlEditEnsureValue(['abc', 123, true]);
  });
}

void yamlEditEnsureValue(Iterable<Object?> path) {
  final editor = YamlEditor('')..ensurePath(path);
  expect(editor.parseAt(path).value, {});
}
