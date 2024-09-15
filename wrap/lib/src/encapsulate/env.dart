import 'package:flutter/widgets.dart';

extension EncapsulateMedia on Widget {
  MediaQuery media(MediaQueryData data) => MediaQuery(data: data, child: this);

  Widget ensureMedia(BuildContext context, {MediaQueryData? defaultValue}) =>
      MediaQuery.maybeOf(context) == null
          ? media(defaultValue ?? MediaQueryData.fromView(View.of(context)))
          : this;
}

extension EncapsulateTextDirection on Widget {
  Directionality textDirection(TextDirection direction) => Directionality(
        textDirection: direction,
        child: this,
      );

  Widget ensureTextDirection(
    BuildContext context, {
    TextDirection defaultValue = TextDirection.ltr,
  }) =>
      Directionality.maybeOf(context) == null
          ? textDirection(defaultValue)
          : this;
}
