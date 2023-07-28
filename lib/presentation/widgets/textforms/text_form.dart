import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constants/assets_color.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {Key? key,
      required this.formController,
      required this.hint,
      required this.textInputType,
      required this.textInputAction})
      : super(key: key);
  final TextEditingController formController;
  final String hint;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: formController,
      style: GoogleFonts.poppins(),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bidang ini wajib diisi";
        }
        return null;
      },
      decoration: InputDecoration(
          hintStyle: GoogleFonts.poppins(color: AssetsColor.lightGrey),
          hintText: hint),
    );
  }
}
