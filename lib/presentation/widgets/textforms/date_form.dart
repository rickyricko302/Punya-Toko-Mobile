import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:punyatoko/util/extension.dart';

import '../../../data/constants/assets_color.dart';

class DateForm extends StatelessWidget {
  const DateForm({
    Key? key,
    required this.formController,
    required this.hint,
  }) : super(key: key);
  final TextEditingController formController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: formController,
      style: GoogleFonts.poppins(),
      readOnly: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bidang ini wajib diisi";
        }
        return null;
      },
      onTap: () async {
        final DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 30)),
            lastDate: DateTime.now().add(const Duration(days: 30)));
        if (date != null) {
          formController.value = TextEditingValue(text: date.toNumber());
        }
      },
      decoration: InputDecoration(
          hintStyle: GoogleFonts.poppins(color: AssetsColor.lightGrey),
          hintText: hint),
    );
  }
}
