import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateFormatGenerator {
  static String getFormattedDateTime(String date, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = DateTime.parse(date);
    return DateFormat(dateFormat).format(docDateTime);
  }

  static String formatFirebaseTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    // Use DateFormat from intl package to format the date as a string
    DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');
    String formatted = formatter.format(dateTime);
    return formatted;
  }
}
