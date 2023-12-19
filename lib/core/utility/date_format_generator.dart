import 'package:intl/intl.dart';

class DateFormatGenerator {
  static String getFormattedDateTime(String date, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = DateTime.parse(date);
    return DateFormat(dateFormat).format(docDateTime);
  }
}
