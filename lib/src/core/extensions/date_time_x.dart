part of '../core.dart';

extension DateTimeX on DateTime {
  /// Returns the date in 'yyyy-MM-dd' format.
  String get dateString => toIso8601String().split('T').first;

  /// Returns the time in 'HH:mm:ss' format.
  String get timeString => toIso8601String().split('T').last.split('.').first;

  /// Returns the date and time in 'yyyy-MM-dd HH:mm:ss' format.
  String get dateTimeString => '$dateString $timeString';

  String formatData(String format) {
    return DateFormat(format).format(this);
  }
}
