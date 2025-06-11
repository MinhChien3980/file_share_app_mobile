part of '../core.dart';

extension BuildContextX on BuildContext {
  /// Returns the [ThemeData] for the current context.
  ThemeData get theme => Theme.of(this);

  /// Returns the [TextTheme] for the current context.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the [ColorScheme] for the current context.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the [Brightness] for the current context.
  Brightness get brightness => Theme.of(this).brightness;

  /// Returns the [MediaQueryData] for the current context.
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Returns the [MediaQueryData] for the current context.
  double get paddingTop => MediaQuery.of(this).padding.top;
  double get paddingBottom => MediaQuery.of(this).padding.bottom;
  double get paddingLeft => MediaQuery.of(this).padding.left;
  double get paddingRight => MediaQuery.of(this).padding.right;
}
