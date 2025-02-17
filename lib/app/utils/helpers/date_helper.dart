import 'package:intl/intl.dart';

class DateHelper {
  static String dateTimeToStrDate(DateTime date) {
    return DateFormat("dd MMMM yyyy").format(date);
  }

  static String dateTimeToStrDate2(DateTime date) {
    return DateFormat("dd MMMM yyyy HH:mm").format(date);
  }
}
