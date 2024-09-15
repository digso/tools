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
}

void parseStatus(String raw, Status? value) => parse(raw, value, Status.parse);

void parseTag(String raw, Tag? value) => parse(raw, value, Tag.parse);

void parse<T>(String raw, T value, T Function(Element element) parser) =>
    expect(parser.call(Element.html(raw)), value);
