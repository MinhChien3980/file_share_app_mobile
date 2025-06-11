part of '../core.dart';

extension StringX on String {
  DateTime get toDateTime {
    return DateTime.parse(this);
  }

  String get toDateTimeString {
    return DateTime.parse(this).toLocal().toString();
  }

  String get toDateString {
    return DateTime.parse(this).toLocal().toString().split(' ')[0];
  }

  String get toTimeString {
    return DateTime.parse(this).toLocal().toString().split(' ')[1];
  }
}
