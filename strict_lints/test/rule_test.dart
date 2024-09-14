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
}

void parseStatus(String raw, Status? value) => parse(raw, value, Status.parse);

void parse<T>(String raw, T value, T Function(Element element) parser) =>
    expect(parser.call(Element.html(raw)), value);
