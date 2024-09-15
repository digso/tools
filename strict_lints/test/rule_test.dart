import 'package:html/dom.dart';
import 'package:strict_lints/spider.dart';
import 'package:test/test.dart';

void main() {
  // <em>(Name)</em>
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

  // <a href="/tools/linter-rules#docs-title">
  //   <img src="/assets/img/tools/linter/filename.svg" alt="xxx">
  // </a>
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

  // <a href="/tools/linter-rules/lint_rule_name">
  //   <code>lint_rule_name</code>
  // </a>
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

  // <p>
  //   <!-- name -->
  //   <a href="/tools/linter-rules/lint_rule_name">
  //     <code>lint_rule_name</code>
  //   </a>
  //
  //   <!-- status -->
  //   <em>(Name)</em>
  //   <br>
  //
  //   <!-- tags -->
  //   <a href="/tools/linter-rules#docs-title-1">
  //     <img src="/assets/img/tools/linter/filename-1.svg" alt="xxx">
  //   </a>
  //   <a href="/tools/linter-rules#docs-title-2">
  //     <img src="/assets/img/tools/linter/filename-2.svg" alt="xxx">
  //   </a>
  // </p>
  test('parse whole rule', () {
    for (final status in Status.values) {
      for (final tags in Tag.values.toSet().allCombinations) {
        const name = 'lint_rule_name';
        const nameHrefPrefix = '/tools/linter-rules/';
        const tagHrefPrefix = '/tools/linter-rules#';
        const tagImgSrcPrefix = '/assets/img/tools/linter/';
        const nameDom = '<a href="$nameHrefPrefix$name"><code>$name</code></a>';
        final statusDom =
            status.isStable ? '' : '<em>(${status.name.capitalCase})</em>';
        final tagsDom = [
          for (final tag in tags)
            '<a href="$tagHrefPrefix${tag.docsTitle}">'
                '<img src="$tagImgSrcPrefix${tag.filename}.svg" alt="xxx">'
                '</a>'
        ].join('\n');

        final result = Rule(name, status: status, tags: tags);
        parseRule('<p>$statusDom<br>$tagsDom</p>', null);
        parseRule('<p>$nameDom$statusDom<br>$tagsDom</p>', result);
        parseRule('<p>$nameDom$nameDom$statusDom<br>$tagsDom</p>', result);
        parseRule('<p>$nameDom$statusDom$statusDom<br>$tagsDom</p>', result);
        parseRule('<p>$nameDom$statusDom<br>$tagsDom$tagsDom</p>', result);
        parseRule('<p>$nameDom$statusDom$tagsDom<br>$tagsDom</p>', result);
        parseRule('<p>$nameDom$statusDom$tagsDom</p>', result);
        parseRule('<p><br>$nameDom$statusDom$tagsDom</p>', result);
      }
    }
  });
}

void parseStatus(String raw, Status? value) => parse(raw, value, Status.parse);

void parseTag(String raw, Tag? value) => parse(raw, value, Tag.parse);

void parseName(String raw, String? value) => parse(raw, value, Rule.parseName);

void parseRule(String raw, Rule? value) => parse(raw, value, Rule.parse);

void parse<T>(String raw, T value, T Function(Element element) parser) =>
    expect(parser.call(Element.html(raw)), value);
