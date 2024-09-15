import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wrap/src/encapsulate/env.dart';

void main() {
  testWidgets('text without material env', (t) async {
    const text = 'demo text';
    await t.pumpWidget(
      Builder(builder: (context) {
        return const Text(text)
            .ensureTextDirection(context)
            .ensureMedia(context);
      }),
    );
    expect(find.text(text), findsOneWidget);
  });
}
