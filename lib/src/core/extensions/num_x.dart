part of '../core.dart';

extension NumX on num {
  /// Check if the number is even.
  bool get isEven => this % 2 == 0;

  /// Check if the number is odd.
  bool get isOdd => this % 2 != 0;

  /// Check if the number is positive.
  bool get isPositive => this > 0;

  /// Check if the number is negative.
  bool get isNegative => this < 0;

  /// Check if the number is zero.
  bool get isZero => this == 0;
}
