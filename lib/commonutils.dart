import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension Responsive on BuildContext {
  T responsive<T>(
    T defaultValue, {
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final w = MediaQuery.of(this).size.width;
    return w >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultValue)
        : w >= 1024
            ? (lg ?? md ?? sm ?? defaultValue)
            : w >= 768
                ? (md ?? sm ?? defaultValue)
                : w >= 648
                    ? (sm ?? defaultValue)
                    : defaultValue;
  }
}

extension StringExtension on String {
  String get titleCase {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension CurrentTime on int {
  String get currentTime {
    DateTime now = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    String difference = '';
    if (now.difference(date).inDays > 0) {
      difference = '${now.difference(date).inDays} days ago';
      if (now.difference(date).inDays > 7) {
        DateFormat format = DateFormat.yMEd(difference);
        difference = format.format(date);
      }
    } else if (now.difference(date).inHours > 0) {
      difference = '${now.difference(date).inHours} hrs ago';
    } else if (now.difference(date).inMinutes > 0) {
      difference = '${now.difference(date).inMinutes} mins ago';
    } else if (now.difference(date).inSeconds > 0) {
      difference = '${now.difference(date).inSeconds} sec ago';
    }
    return difference;
  }
}
