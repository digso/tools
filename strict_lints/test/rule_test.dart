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
      parseTag('<a href="/tools/linter-rules#${tag.docsTitle}"></a>', null);
      parseTag(
        '<a href="/tools/linter-rules#${tag.docsTitle}">'
        '<img src="/assets/img/tools/linter/${tag.filename}.svg" alt="xxx">'
        '</a>',
        tag,
      );

      // Invalid tags.
      parseTag(
        '<span href="/tools/linter-rules#${tag.docsTitle}">'
        '<img src="/assets/img/tools/linter/${tag.filename}.svg" alt="xxx">'
        '</span>',
        null,
      );
      parseTag(
        '<a href="/tools/linter-rules#${tag.docsTitle}">'
        '<p src="/assets/img/tools/linter/${tag.filename}.svg" alt="xxx"></p>'
        '</a>',
        null,
      );

      // Error names.
      parseTag(
        '<a href="/tools/linter-rules#error-name">'
        '<img src="/assets/img/tools/linter/${tag.filename}.svg" alt="xxx">'
        '</a>',
        null,
      );
      parseTag(
        '<a href="/tools/linter-rules#${tag.docsTitle}">'
        '<img src="/assets/img/tools/linter/error-name.svg" alt="xxx">'
        '</a>',
        null,
      );
    }
  });
}

void parseStatus(String raw, Status? value) => parse(raw, value, Status.parse);

void parseTag(String raw, Tag? value) => parse(raw, value, Tag.parse);

void parse<T>(String raw, T value, T Function(Element element) parser) =>
    expect(parser.call(Element.html(raw)), value);
