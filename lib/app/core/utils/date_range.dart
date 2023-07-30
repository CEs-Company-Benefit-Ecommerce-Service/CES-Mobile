import 'package:intl/intl.dart';

class DateRange {
  final String startDate;
  final String endDate;

  DateRange(this.startDate, this.endDate);
}

DateTime getToday() {
  return DateTime.now();
}

DateTime getDaysAgo(int days) {
  return DateTime.now().subtract(Duration(days: days));
}

DateTime getYearsAgo(int years) {
  return DateTime.now().subtract(Duration(days: years * 365));
}

DateRange getDateRange(int statusCode) {
  final DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  switch (statusCode) {
    case 0:
      return DateRange(
        dateFormat.format(getYearsAgo(1)),
        dateFormat.format(getToday()),
      );
    case 1:
      return DateRange(
          dateFormat.format(getToday()), dateFormat.format(getToday()));
    case 2:
      return DateRange(
          dateFormat.format(getDaysAgo(7)), dateFormat.format(getToday()));
    case 3:
      return DateRange(
          dateFormat.format(getDaysAgo(30)), dateFormat.format(getToday()));
    case 4:
      return DateRange(
          dateFormat.format(getDaysAgo(60)), dateFormat.format(getToday()));
    case 5:
      return DateRange(
          dateFormat.format(getDaysAgo(90)), dateFormat.format(getToday()));
    default:
      return DateRange(
        dateFormat.format(getYearsAgo(1)),
        dateFormat.format(getToday()),
      );
  }
}

String dateRangeCodeToString(int statusCode) {
  switch (statusCode) {
    case 0:
      return "All date";
    case 1:
      return "Today";
    case 2:
      return "7 days ago";
    case 3:
      return "30 days ago";
    case 4:
      return "60 days ago";
    case 5:
      return "90 days ago";
    default:
      return "";
  }
}
