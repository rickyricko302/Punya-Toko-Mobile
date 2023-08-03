import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';

import '../../../data/constants/assets_color.dart';

class RupiahForm extends StatelessWidget {
  const RupiahForm(
      {Key? key,
      required this.formController,
      required this.hint,
      required this.textInputAction})
      : super(key: key);
  final TextEditingController formController;
  final String hint;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: formController,
      style: GoogleFonts.poppins(),
      keyboardType: TextInputType.number,
      textInputAction: textInputAction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bidang ini wajib diisi";
        }
        return null;
      },
      inputFormatters: [
        CurrencyTextInputFormatter(locale: "id", name: "", decimalDigits: 0)
      ],
      decoration: InputDecoration(
          hintStyle: GoogleFonts.poppins(color: AssetsColor.lightGrey),
          prefixIcon: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PoppinsText(
                text: "Rp",
                fontSize: 15,
                color: AssetsColor.grey,
              ),
            ],
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 30),
          hintText: hint),
    );
  }
}
