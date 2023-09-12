import 'package:intl/intl.dart';

extension Dates on DateTime {
  ///Fungsi untuk mendapatkan format DateTime => Senin, 12 Januari 2023
  String toDay() {
    return DateFormat("EEEE, d MMMM y", "ID").format(DateTime.now());
  }

  ///Fungsi untuk mendapatkan format DateTime => tahun-bulan-tanggal
  String toNumber() {
    return DateFormat("y-MM-dd").format(this);
  }
}
