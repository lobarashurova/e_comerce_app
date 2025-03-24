import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
extension TextStringExtensions on String {
  Text s(double size) => Text(this).s(size);

  Text w(int weight) => Text(this).w(weight);

  Text c(Color color) => Text(this).c(color);

  Text h(double height) => Text(this).h(height);

  Text sfText() => Text(this).sfText();

  Text sfDisplay() => Text(this).sfDisplay();

  Text text({TextAlign? textAlign, int? maxLines}) => Text(
    this,
    textAlign: textAlign,
    maxLines: maxLines,
  );
}

extension TextStyleExtensions on TextStyle {
  TextStyle copyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      TextStyle(
        inherit: inherit ?? this.inherit,
        color: this.foreground == null && foreground == null
            ? color ?? this.color
            : null,
        backgroundColor: this.background == null && background == null
            ? backgroundColor ?? this.backgroundColor
            : null,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        wordSpacing: wordSpacing ?? this.wordSpacing,
        textBaseline: textBaseline ?? this.textBaseline,
        height: height ?? this.height,
        locale: locale ?? this.locale,
        foreground: foreground ?? this.foreground,
        background: background ?? this.background,
        decoration: decoration ?? this.decoration,
        decorationColor: decorationColor ?? this.decorationColor,
        decorationStyle: decorationStyle ?? this.decorationStyle,
        decorationThickness: decorationThickness ?? this.decorationThickness,
        fontFamily: fontFamily ?? this.fontFamily,
        fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
        overflow: overflow ?? this.overflow,
      );
}

extension TextExtensions on Text {
  Text copyWith({
    String? data,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) =>
      Text(
        data ?? this.data!,
        style: style ?? this.style ?? TextStyle(),
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? this.textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaler: textScaler ?? this.textScaler,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
        selectionColor: selectionColor ?? this.selectionColor,
      );

  Text s(double size) => copyWith(
    style: (style ?? TextStyle()).copyWith(fontSize: size.sp),
  );

  Text c(Color color) => copyWith(
    style: (style ?? TextStyle()).copyWith(color: color),
  );

  Text h(double height) => copyWith(
    style: (style ?? TextStyle()).copyWith(height: height.sp),
  );

  Text sfText() => copyWith(
    style: (style ?? TextStyle()).copyWith(fontFamily: 'SF Pro Text'),
  );

  Text sfDisplay() => copyWith(
    style: (style ?? TextStyle()).copyWith(fontFamily: 'SF Pro Display'),
  );

  Text a(TextAlign textAlign) => copyWith(
    style: (style ?? TextStyle()),
    textAlign: textAlign,
  );

  Text o(TextOverflow textOverflow) => copyWith(
    style: (style ?? TextStyle()),
    overflow: textOverflow,
  );

  Text w(int fontWeight) {
    final weight = FontWeight.values[fontWeight ~/ 100 - 1];
    return copyWith(style: (style ?? TextStyle()).copyWith(fontWeight: weight));
  }

  Text m(int maxLines) {
    return copyWith(style: (style ?? TextStyle()), maxLines: maxLines);
  }

  Text styles({TextOverflow? overflow}) => Text(
    data ?? '',
    style: TextStyle(
      fontSize: style?.fontSize,
      fontWeight: style?.fontWeight,
      color: style?.color,
      fontFamily: style?.fontFamily,
      height: style?.height,
      overflow: overflow,
    ),
  );
}