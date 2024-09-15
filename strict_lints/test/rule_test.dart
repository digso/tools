import 'package:html/dom.dart';
import 'package:strict_lints/spider.dart';
import 'package:test/test.dart';

void main() {
  test('parse status', () {
    for (final status in Status.values) {
      parseStatus('<em>(${status.name.capitalCase})</em>', status);
      parseStatus('<em> (${status.name.capitalCase}) </em>', status);
      parseStatus('<em> ( ${status.name.capitalCase} ) </em>', status);
      parseStatus('<em>( ${status.name.capitalCase} )</em>', status);
      parseStatus('<span>(${status.name.capitalCase})</span>', null);
      parseStatus('<em>(${status.name})</em>', null);
    }
    parseStatus('<em>(ErrorName)</em>', null);
  });

  test('parse tags', () {
    for (final tag in Tag.values) {
      final correctOuter = '<a href="/tools/linter-rules#${tag.docsTitle}">';
      final spaceOuter = '<a href=" /tools/linter-rules#${tag.docsTitle} ">';
      final errorOuterTag = '<div href="/tools/linter-rules#${tag.docsTitle}">';
      const errorOuterName = '<a href="/tools/linter-rules#error-name">';
      const outerEnd = '</a>';
      const errorOuterEnd = '</div>';

      final correctInner =
          '<img src="/assets/img/tools/linter/${tag.filename}.svg" '
          'alt="xxx">';
      final spaceInner =
          '<img src=" /assets/img/tools/linter/${tag.filename}.svg " '
          'alt="xxx">';
      const errorInnerName =
          '<img src="/assets/img/tools/linter/error-name.svg" alt="xxx">';
      final errorInnerTag =
          '<input src="/assets/img/tools/linter/${tag.filename}.svg" '
          'alt="xxx">';

      parseTag('$correctOuter$outerEnd', null);
      parseTag('$spaceOuter$outerEnd', null);
      parseTag('$correctOuter$correctInner$outerEnd', tag);
      parseTag('$spaceOuter$correctInner$outerEnd', tag);
      parseTag('$correctOuter$spaceInner$outerEnd', tag);
      parseTag('$spaceOuter$spaceInner$outerEnd', tag);

      // Invalid tags or name.
      parseTag('$errorOuterName$correctInner$outerEnd', null);
      parseTag('$errorOuterTag$correctInner$errorOuterEnd', null);
      parseTag('$correctOuter$errorInnerName$outerEnd', null);
      parseTag('$correctOuter$errorInnerTag$outerEnd', null);
    }
  });

  test('parse name', () {
    const name = 'lint_rule_name';
    const correctHrefPrefix = '/tools/linter-rules/';
    const correctOuter = '<a href="$correctHrefPrefix$name">';
    const correctInner = '<code>$name</code>';
    const spaceOuter = '<a href=" $correctHrefPrefix$name ">';
    const spaceInner = '<code> $name </code>';
    const errorOuterName = '<div href="error/$name">';
    const errorInnerName = '<code>error-name</code>';
    const errorOuterTag = '<span href="$correctHrefPrefix$name">';
    const errorInnerTag = '<em href="$name"></em>';
    const outerEnd = '</a>';
    const errorOuterEnd = '</span>';

    parseName('$correctOuter$outerEnd', null);
    parseName('$spaceOuter$outerEnd', null);
    parseName('$correctOuter$correctInner$outerEnd', name);
    parseName('$spaceOuter$correctInner$outerEnd', name);
    parseName('$correctOuter$spaceInner$outerEnd', name);
    parseName('$spaceOuter$spaceInner$outerEnd', name);

    // Invalid tags or name.
    parseName('$errorOuterName$correctInner$outerEnd', null);
    parseName('$errorOuterTag$correctInner$errorOuterEnd', null);
    parseName('$correctOuter$errorInnerName$outerEnd', null);
    parseName('$correctOuter$errorInnerTag$outerEnd', null);
  });
}

void parseStatus(String raw, Status? value) => parse(raw, value, Status.parse);

void parseTag(String raw, Tag? value) => parse(raw, value, Tag.parse);

void parseName(String raw, String? value) => parse(raw, value, Rule.parseName);

void parse<T>(String raw, T value, T Function(Element element) parser) =>
    expect(parser.call(Element.html(raw)), value);
