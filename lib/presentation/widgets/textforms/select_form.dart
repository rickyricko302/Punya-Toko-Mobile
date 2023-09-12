import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:punyatoko/data/constants/status.dart';

import '../../../data/constants/assets_color.dart';

class SelectForm extends StatelessWidget {
  const SelectForm(
      {Key? key,
      required this.formController,
      required this.hint,
      required this.onClick,
      required this.onRefresh,
      required this.status})
      : super(key: key);
  final TextEditingController formController;
  final String hint;
  final VoidCallback onClick;
  final VoidCallback onRefresh;
  final Status status;
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
          suffixIcon: status == Status.LOADING
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                )
              : status == Status.SUCCESS
                  ? Icon(
                      Icons.arrow_drop_down,
                      color: AssetsColor.grey,
                    )
                  : InkWell(
                      onTap: onRefresh,
                      child: Icon(
                        Icons.refresh,
                        color: AssetsColor.red,
                      ),
                    ),
          suffixIconConstraints:
              const BoxConstraints(maxWidth: 24, maxHeight: 24)),
    );
  }
}
