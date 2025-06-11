part of 'theme.dart';

const dTextStyle = TextStyle(
  fontSize: 14,
  fontFamily: 'SF UI Display',
  fontWeight: FontWeight.w500,
  color: textColor,
);

final text8 = dTextStyle.copyWith(fontSize: 8);
final text10 = dTextStyle.copyWith(fontSize: 10);
final text12 = dTextStyle.copyWith(fontSize: 12);
final text14 = dTextStyle.copyWith(fontSize: 14);
final text16 = dTextStyle.copyWith(fontSize: 16);
final text18 = dTextStyle.copyWith(fontSize: 18);
final text20 = dTextStyle.copyWith(fontSize: 20);
final text22 = dTextStyle.copyWith(fontSize: 22);
final text24 = dTextStyle.copyWith(fontSize: 24);
final text26 = dTextStyle.copyWith(fontSize: 26);
final text28 = dTextStyle.copyWith(fontSize: 28);
final text30 = dTextStyle.copyWith(fontSize: 30);
final text32 = dTextStyle.copyWith(fontSize: 32);
final text34 = dTextStyle.copyWith(fontSize: 34);
final text36 = dTextStyle.copyWith(fontSize: 36);
final text38 = dTextStyle.copyWith(fontSize: 38);
final text40 = dTextStyle.copyWith(fontSize: 40);
final text42 = dTextStyle.copyWith(fontSize: 42);
final text44 = dTextStyle.copyWith(fontSize: 44);
final text46 = dTextStyle.copyWith(fontSize: 46);
final text48 = dTextStyle.copyWith(fontSize: 48);
final text50 = dTextStyle.copyWith(fontSize: 50);
final text52 = dTextStyle.copyWith(fontSize: 52);
final text54 = dTextStyle.copyWith(fontSize: 54);
final text56 = dTextStyle.copyWith(fontSize: 56);
final text58 = dTextStyle.copyWith(fontSize: 58);
final text60 = dTextStyle.copyWith(fontSize: 60);
final text62 = dTextStyle.copyWith(fontSize: 62);
final text64 = dTextStyle.copyWith(fontSize: 64);
final text66 = dTextStyle.copyWith(fontSize: 66);
final text68 = dTextStyle.copyWith(fontSize: 68);
final text70 = dTextStyle.copyWith(fontSize: 70);
final text72 = dTextStyle.copyWith(fontSize: 72);
final text74 = dTextStyle.copyWith(fontSize: 74);
final text76 = dTextStyle.copyWith(fontSize: 76);
final text78 = dTextStyle.copyWith(fontSize: 78);
final text80 = dTextStyle.copyWith(fontSize: 80);

extension TextStyleExtension on TextStyle {
  TextStyle get primary => copyWith(color: primaryColor);
  TextStyle get secondary => copyWith(color: secondaryColor);
  TextStyle get tertiary => copyWith(color: tertiaryColor);
  TextStyle get quaternary => copyWith(color: quaternaryColor);

  TextStyle get white => copyWith(color: whiteColor);
  TextStyle get black => copyWith(color: blackColor);
  TextStyle get grey => copyWith(color: greyColor);
  TextStyle get greyLight => copyWith(color: greyColorLight);
  TextStyle get greyDark => copyWith(color: greyColorDark);

  TextStyle get waring => copyWith(color: waringColor);
  TextStyle get error => copyWith(color: errorColor);
  TextStyle get success => copyWith(color: successColor);
  TextStyle get info => copyWith(color: infoColor);

  TextStyle get ultraLight => copyWith(fontWeight: FontWeight.w100);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get blackBold => copyWith(fontWeight: FontWeight.w900);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get strikeThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get normal => copyWith(decoration: TextDecoration.none);
  TextStyle get uppercase => copyWith(textBaseline: TextBaseline.alphabetic);
  TextStyle get lowercase => copyWith(textBaseline: TextBaseline.ideographic);
  TextStyle get capitalize => copyWith(textBaseline: TextBaseline.alphabetic);
}

final defaultTextTheme = TextTheme(
  displayLarge: text56,
  displayMedium: text48,
  displaySmall: text40,
  headlineLarge: text36,
  headlineMedium: text32,
  headlineSmall: text28,
  titleLarge: text24,
  titleMedium: text22,
  titleSmall: text20,
  bodyLarge: text18,
  bodyMedium: text16,
  bodySmall: text14,
  labelLarge: text14,
  labelMedium: text12,
  labelSmall: text8,
);
