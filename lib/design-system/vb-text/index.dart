import 'package:ecommerce_app/design-system/colors/index.dart';
import 'package:ecommerce_app/design-system/vb-text-style/index.dart';
import 'package:ecommerce_app/types/vb_typography_type.dart';
import 'package:flutter/material.dart';


class VBText extends StatelessWidget {
  final String text;
  final VBTypographyType typographyType;
  final Color? color;
  final TextAlign? textAlign;
  const VBText(
      {Key? key,
      required this.text,
      required this.typographyType,
      this.color = VBColors.WHITE,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        VBTextStyle.get(typographyType: typographyType, color: color!);
    return Text(
      text,
      style: style,
      textAlign: textAlign ?? textAlign,
    );
  }
}
