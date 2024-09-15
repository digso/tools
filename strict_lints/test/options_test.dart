import 'package:strict_lints/spider.dart';
import 'package:test/test.dart';
import 'package:yaml_edit/yaml_edit.dart';

void main() {
  test('yaml edit ensure path', () {
    yamlEditEnsureValue(['linter', 'rules']);
    yamlEditEnsureValue(['abc', 123, true]);
  });

  test('override options', () {
    final options = {'a': true, 'b': false, 'c': true};
    final override = {'a': false, 'b': null};
    expect(options.override(override), {'a': false, 'c': true});
  });
}

void yamlEditEnsureValue(Iterable<Object?> path) {
  final editor = YamlEditor('')..ensurePath(path);
  expect(editor.parseAt(path).value, {});
}
