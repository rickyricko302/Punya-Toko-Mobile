import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:punyatoko/presentation/widgets/icons/icon_with_press.dart';

import '../../../data/constants/assets_color.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm(
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
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.formController,
      style: GoogleFonts.poppins(),
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bidang ini wajib diisi";
        } else if (value.length < 8) {
          return "Minimal 8 karakter";
        }
        return null;
      },
      obscureText: isObsecure,
      decoration: InputDecoration(
          hintStyle: GoogleFonts.poppins(color: AssetsColor.lightGrey),
          hintText: widget.hint,
          suffixIconConstraints:
              const BoxConstraints(minHeight: 24, maxHeight: 24),
          suffixIcon: IconWithPress(
              callback: () {
                setState(() {
                  isObsecure = !isObsecure;
                });
              },
              icon: isObsecure
                  ? "ic_password_show.svg"
                  : "ic_password_hide.svg")),
    );
  }
}
