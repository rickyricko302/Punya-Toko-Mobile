import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constants/assets_color.dart';

class SelectForm extends StatelessWidget {
  const SelectForm(
      {Key? key,
      required this.formController,
      required this.hint,
      required this.onClick})
      : super(key: key);
  final TextEditingController formController;
  final String hint;
  final VoidCallback onClick;
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
      onTap: onClick,
      decoration: InputDecoration(
          hintStyle: GoogleFonts.poppins(color: AssetsColor.lightGrey),
          hintText: hint,
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: AssetsColor.grey,
          )),
    );
  }
}
