import 'package:intl/intl.dart';

String dateformat({String format = 'EEEE, HH:mm', DateTime? date}) {
  return DateFormat(format).format(date ?? DateTime.now());
}