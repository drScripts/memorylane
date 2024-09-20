import 'package:intl/intl.dart';

String formatCustomDate(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  DateTime now = DateTime.now();

  // Time format
  String timeFormat = DateFormat('HH:mm').format(dateTime);

  // Check if the date is the same day
  if (now.year == dateTime.year &&
      now.month == dateTime.month &&
      now.day == dateTime.day) {
    return timeFormat; // Only show time if it's today
  }

  // Check if the date is the same year but different day
  if (now.year == dateTime.year) {
    String dateFormat = DateFormat('dd/MM').format(dateTime);
    return "$timeFormat  $dateFormat"; // Show time and day/month
  }

  // Otherwise, show time and full date
  String fullDateFormat = DateFormat('dd/MM/yyyy').format(dateTime);
  return "$timeFormat  $fullDateFormat";
}

String dateISOString() {
  DateTime now = DateTime.now();
  String isoString = now.toIso8601String();
  return isoString;
}
