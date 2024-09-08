import 'package:ecommerce_app/design-system/colors/index.dart';
import 'package:ecommerce_app/types/vb_typography_type.dart';
import 'package:flutter/material.dart';

class VBTextStyle {
  static TextStyle get({
    required VBTypographyType typographyType,
    Color color = VBColors.WHITE,
  }) {
    TextStyle? style;
    if (typographyType == VBTypographyType.HEADING_XL) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w400,
        fontSize: 30,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_L) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_M) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_S) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_XL_MEDIUM) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 30,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_L_MEDIUM) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_M_MEDIUM) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_S_MEDIUM) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_XL_BOLD) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w700,
        fontSize: 30,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_L_BOLD) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_M_BOLD) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: color,
      );
    } else if (typographyType == VBTypographyType.HEADING_S_BOLD) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_M) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_S) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_XS) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w400,
        fontSize: 10,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_M_MEDIUM) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_S_MEDIUM) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_XS_MEDIUM) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 10,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_M_BOLD) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_S_BOLD) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w700,
        fontSize: 12,
        color: color,
      );
    } else if (typographyType == VBTypographyType.BODY_XS_BOLD) {
      style = TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w700,
        fontSize: 10,
        color: color,
      );
    }

    return style!;
  }
}
