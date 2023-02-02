import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate(String date) {
    final DateFormat formatter = DateFormat('MMM d, y');
    return formatter.format(DateTime.parse(date));
  }
}
