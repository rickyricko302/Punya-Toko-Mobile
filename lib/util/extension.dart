import 'package:intl/intl.dart';

extension Dates on DateTime {
  String toDay() {
    return DateFormat("EEEE, d MMMM y", "ID").format(DateTime.now());
  }
}
