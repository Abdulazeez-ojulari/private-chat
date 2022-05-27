import 'package:intl/intl.dart';

class TimeFormat {
  static String readTimestamp(int timestamp) {
    var format = DateFormat('HH:mm');

    var date =
        DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).toLocal();

    var time = '';

    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      return DateTime(date.year, date.month, date.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;
    }

    if (calculateDifference(date) == 0) {
      if (date.timeZoneOffset.inHours == 1) {
        time = format.format(date.add(const Duration(hours: 1)));
      }
      time = format.format(date);
    } else if (calculateDifference(date) == -1) {
      time = 'Yesterday';
    } else {
      time = DateFormat("dd MMM").format(date);
    }
    return time;
  }
}
